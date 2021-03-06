# Misinformation database

Deployment scripts for the database supporting the misinformation project.

See [main project](https://github.com/alan-turing-institute/misinformation) for
project board and issues.

## Pre-requisites
#### Azure CLI
Ensure you have the [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/) is
installed. This is a command line client for administering Azure resources. The
easiest way to install it if you have Python available is using the Python
package manger PIP. If this doesn't work for you, try one of the [alternative
installation methods](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).
```
pip install azure-cli
```

#### Project admin KeyVault
There should be a KeyVault named `misinformation-admin` in the
`misinformation-common` Azure subscription. All users who are authorised to
deploy and administer the database server should be added as principals in the
"Access policies" section of the KeyVault. The KeyVault should be set to enable
access to Azure Resource Manager for template deployment in "Advanced access
policies" part of the "Access policies" section.

The KeyVault should contain the following sensitive secrets.

1. A **Secret** named `database-admin` containing a strong password in its
"value" field. This will only ever be accessed programatically so can be as
random and complex as you like. It is recommended to randomly generate a long
(16+ characters) password that uses at lower case letters, upper case letters
and numbers. If supported by the random generator, you should also include
special characters (e.g. £$%^& etc).

2. A **Certificate** named `misinformation-admin-sp`. This certificate should be
self-signed, have a **Subject** set to `CN=admin-sp.misinformation.turing.ac.uk`
a validity of 12 months and an auto-renewal trigger set to 90% of the validity
period.

#### Project user KeyVault
There should be a KeyVault named `misinformation-user` in the
`misinformation-common` Azure subscription. All users who are authorised to
deploy and administer the database server should be added as principals in the
"Access policies" section of the KeyVault. The KeyVault should be set to enable
access to Azure Resource Manager for template deployment in "Advanced access
policies" part of the "Access policies" section.

The KeyVault should contain the following sensitive secrets.

1. A **Secret** named `database-crawler-user` containing a strong password in
its "value" field. This will only ever be accessed programatically so can be as
random and complex as you like. It is recommended to randomly generate a long
(16+ characters) password that uses at lower case letters, upper case letters
and numbers. If supported by the random generator, you should also include
special characters (e.g. £$%^& etc).

2. A **Secret** named `database-annotation-user` containing a strong password in
its "value" field. This will only ever be accessed programatically so can be as
random and complex as you like. It is recommended to randomly generate a long
(16+ characters) password that uses at lower case letters, upper case letters
and numbers. If supported by the random generator, you should also include
special characters (e.g. £$%^& etc).

3. A **Secret** named `database-crawl-storage-read` containing an SAS token with
read-only access to the https://misinformation.blob.core.windows.net/crawl
Azure blob storage container in its "value" field. This SAS token should be
bound to a policy to allow it to be revoked. You can create policies and
SAS tokens bound to them by right-clicking on the storage container in Azure
Storage Explorer.

#### Azure SQL Data Studio
We use [Azure SQL Data Studio](https://docs.microsoft.com/en-gb/sql/azure-data-studio/download)
to run SQL queries against the Misinformation database we create. We use these SQL
queries to create and update tables within the Misinformation database.

### Database admin service account

```
az ad sp create-for-rbac --name misinformation-admin \
     --cert misinformation-admin-sp --keyvault misinformation-admin
```

**TODO:** Script creation of the KeyVault. This should securely generate a
strong secret and add the necessary users (ideally using a security group).

## Deploy the database
1. Ensure you are logged into the Azure CLI.
```
az login
```
2. Ensure the active subscription is `misinformation`
```
az account set --subscription misinformation
```
3. Ensure the `misinformation-database` resource group exists in the
`southcentralus` region.
```
az group create --name misinformation-database --location southcentralus
```
4. Deploy the database using the template in this repository.
```
az group deployment create \
    --resource-group misinformation-database \
    --template-file database-server.json \
    --parameters @database-server.parameters.json
```
If you get the error `No module named 'msrest.polling'` then manually install
the missing package using `pip install msrestazure`.

## Create users for the crawler and the annotation tool
1. Browse to the Misinformation database in the Azure portal.
2. Click on the "Query editor" option in the menu sidebar and log in with  
"SQL server authentication" option, with user `dbadmin` and the password you
created earlier and stored in the `database-admin` KeyVault secret.
3. Run the following commands to create database users for the crawler and
   annotator apps, using `database-crawler-user` and
   `database-annotation-user` as the usernames and the corresponding
   KeyVault secrets created earlier as the passwords.
```
CREATE USER [user_name] WITH PASSWORD = 'STRONG_PASSWORD_GOES_HERE';
```
4. Run the following commands to give the above users write access to the
   Misinformation database.
```
EXEC sp_addrolemember 'db_datareader', 'database-crawler-user';
EXEC sp_addrolemember 'db_datawriter', 'database-crawler-user';
EXEC sp_addrolemember 'db_datareader', 'database-annotation-user';
EXEC sp_addrolemember 'db_datawriter', 'database-annotation-user';
```

## Add storage credentials to the database
Add the `database-crawl-storage-read` SAS token created earlier to the database
so it can access the Azure blob storage container that is currently used to
store article data generated by the crawler. Replace `SAS_TOKEN_GOES_HERE`
with the value of the `database-crawl-storage-read` secret stored in the
project user KeyVault created earlier.
```
CREATE MASTER KEY
GO
CREATE DATABASE SCOPED CREDENTIAL [database-crawl-storage-read]   
WITH IDENTITY = 'SHARED ACCESS SIGNATURE',
SECRET = 'SAS_TOKEN_GOES_HERE';
GO
CREATE EXTERNAL DATA SOURCE misinformation_crawl_container
    WITH  (
        TYPE = BLOB_STORAGE,
        LOCATION = 'https://misinformation.blob.core.windows.net/crawl',
        CREDENTIAL = [database-crawl-storage-read]  
    );
```

**TODO:** Add instructions for enabling and using AAD SSO once Service Principal
creation by AAD members works.

## Create the required tables
The following steps will ensure the required tables exist in the Misinformation
database. None of the `create_*_table.sql` scripts will overwrite or delete any
existing tables, so they are safe to re-run. corresponding `delete_*_table.sql`
scripts are provided to delete tables if this is required, though **this will
result in all the data stored in those tables being deleted**.

Set up and save the connection details for the Misinformation database within
[Azure SQL Data Studio](https://docs.microsoft.com/en-gb/sql/azure-data-studio/download).

- **Server**: `misinformation.database.windows.net`
- **User name**: `dbadmin`
- **Pasword**: Use the command below to retrieve the database admin password
from the `misinformation-admin` KeyVault. It will be displayed in the "value"
field of the JSON output to the console.
```
az keyvault secret show --vault-name misinformation-admin \
    --name database-admin
```
- If you have not connected to the Misinformation database from your current IP
address before, you will be prompted to login with an Azure account and add a
firewall rule to allow access from your current IP address. To do this you will
need to follow the prompts to authenticate the Azure SQL Data Studio app in the
same way as you did when logging into the Azure CLI.
- Double click on the `misinformation` database
- Click on the sheet of paper "Explorer" icon in the thin panel on the left of
the application.
- Open the folder for this repository.
  - Open the `create_raw_crawl_table.sql` file
  - Connect to the Misinformation database using the saved
`misinformation.database.windows.net` connection listed above the connection
details form.
  - Run the `create_raw_crawl_table.sql` query.
- Repeat for the following queries
  - `create_raw_crawl_indexes.sql`
  - `create_articles_tables.sql`
  - `create_articles_indexes.sql`
  - `create_annotations_tables.sql`
  - `create_annotations_indexes.sql`
- Load the crawl data from the files on Azure blob storage
  - Run `import_articles_data.sql` once for each `<site_name>_extracted.txt`
    file in the `crawl` container of the `misinformation` storage account. You
    will need to replace the filename immediately following the `BULK` keyword
    for each new file.

## Useful queries
- `select_n_articles_per_site.sql`: Select N articles for each site. The
  ordering of articles within each site grouping is fixed (determined by the
    auto incremented ID column), regardless of the chosen N, so increasing N
    will always result in a strict superset of the previously selected articles
    and reducing N will always result in a strict subset of previously selected
    articles.
- `articles_per_site`: Lists all unique sites in articles table, along with the
  number of articles for each site.
