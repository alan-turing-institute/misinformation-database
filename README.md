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
#### Project KeyVault
There should be a KeyVault named `misinformation-admin` in the
`misinformation-common` Azure subscription. In this KeyVault there should be
a secret named `database-admin` containing a strong password in its "value"
field. This will only ever be accessed programatically so can be as random and
complex as you like. It is recommended to randomly generate a long (16+
characters) password that uses at lower case letters, upper case letters and
numbers. If supported by the random generator, you should also include special
characters (e.g. £$%^& etc). All users who are authorised to deploy the
database server should be added as principals in the "Access policies" section
of the KeyVault. The KeyVault should also be set to enable access to Azure
Resource Manager for template deployment in "Advanced access policies" part of
the "Access policies" section.

**TODO:** Script creation of the KeyVault. This should securely generate a
strong secret and add the necessary users (ideally using a security group).

## Deploy the Azure PaaS database server
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
4. Deploy the database server using the template in this repository.
```
az group deployment create \
    --resource-group misinformation-database \
    --template-file database-server.json \
    --parameters @database-server.parameters.json
```
If you get the error `No module named 'msrest.polling'` then manually install
the missing package using `pip install msrestazure`.

## Create the database
