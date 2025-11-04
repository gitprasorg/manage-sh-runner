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

## Importing Existing Runner Groups

If you have runner groups that already exist in your GitHub organization, you must import them into Terraform's state to bring them under management. This is a one-time operation for each group.

The recommended method is to use a declarative `import` block in your root `main.tf` file.

**Workflow:**

1.  **Add the `import` Block:** Add the following block to your root `main.tf`. You will need to get the Runner Group ID from the URL in your GitHub organization's settings (`organizations/<your-org>/settings/actions/runner_groups/<GROUP_ID>`).

    ```hcl
    # Add this block to your root main.tf
    import {
      # The ID of the runner group as it exists in GitHub
      id = "<PASTE_YOUR_RUNNER_GROUP_ID_HERE>"

      # The address of the resource as defined in your Terraform code
      # Replace "your-group-name" with the name of the group from your .tfvars file
      to = module.runner_group.github_actions_runner_group.group["your-group-name"]
    }
    ```

2.  **Plan the Import:** Run `terraform plan`. The output will show that one resource will be imported into the state.

3.  **Apply the Import:** Run `terraform apply` to execute the import.

4.  **Remove the `import` Block:** This is a critical step. After the import is successful, you **must remove the `import` block** from your `main.tf` file. The import block describes a one-time action, not a permanent part of your configuration.

After completing these steps, the runner group is fully managed by Terraform.