import subprocess

# Azure CLI imports
from azure.cli.core import get_default_cli

SUBSCRIPTION = 'misinformation'
ADMIN_KEYVAULT_NAME = 'misinformation-admin'
DBADMIN_USER = 'dbadmin'
DBADMIN_PASSWORD_SECRET_NAME = 'database-admin'

# We use the Azure CLI object to let us call functionality in a very similar
# manner as calling the 'az' app from the terminal. We pass an array of
# arguments to AZURE_CLI.invoke(), get the output from the 'result' field
# and assign it to a variable for further processing
# e.g. subscriptions = AZURE_CLI.invoke(['account, 'list']).result

# Get an Azure CLI object to use across functions
AZURE_CLI = get_default_cli()

def is_authenticated():
    # Get subscriptions. This returns an empty list if user is not authenticated.
    subscriptions = AZURE_CLI.invocation_cls().execute(['account','list']).result
    if not(subscriptions):
        return False
    else:
        return True

def main():
    # Check if user has already authenticated. If not, get user to interactively authenticate
    if not(is_authenticated()):
        login()

    ## Ensure we are using the right subscription
    AZURE_CLI.invoke(['account', 'set', '--subscription', SUBSCRIPTION])

    # Get the database admin password to creaate
    db_admin_password = AZURE_CLI.invocation_cls().execute(['keyvault','secret', 'download',
                        '--vault-name', ADMIN_KEYVAULT_NAME, '--name',
                        DBADMIN_PASSWORD_SECRET_NAME]).result

if __name__ == "__main__":
    main()
