# Bastion setup with Ansible

This folder installs and configures the DevBoard bastion host.

## Simple flow

1. Create the bastion host with Terraform.
2. SSH into the bastion.
3. Install Ansible on the bastion.
4. Run the playbooks from this folder.
5. Verify the installed tools.

The bastion uses its IAM instance profile for AWS access, so no static AWS keys are needed.

## Files

- `site.yml` runs everything in order
- `01-install-tools.yml` installs Terraform, AWS CLI, kubectl, Helm, Docker, and common tools
- `02-configure-aws.yml` sets AWS region and shell settings
- `03-clone-repo.yml` downloads the repository
- `04-verify.yml` checks that the tools are installed correctly

## Run it

```bash
cd ansible
ansible-playbook -i inventory.ini site.yml
```

## Verify only

```bash
ansible-playbook -i inventory.ini 04-verify.yml
```

## Important values

The variables are defined in `group_vars/devboard.yml`.

- `aws_region`
- `login_user`
- `repo_url`
- `repo_branch`
