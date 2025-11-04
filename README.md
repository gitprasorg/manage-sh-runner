# manage-sh-runner
manage selfhosted runners


Create a GitHub App in your Enterprise org:
Permissions: Actions: Read & Write (or Admin if you manage runner groups)
Subscribe the app to all repos (or selected repos)

Generate a private key (PEM file)
Note the App ID and Installation ID (for each org)
Store credentials in Vault:
app_id
installation_id (per org)
private_key (PEM content)

JWT auth method can be used to access Vault securely

Generate JWT to authenticate with GitHub:

Use the private key + app ID to create a JWT

JWT is valid for 10 minutes

This JWT is used to request an installation token