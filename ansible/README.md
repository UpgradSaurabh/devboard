# Phase 1 - Bastion Ansible

This Ansible setup is adapted from the DevBoard mega-project Ansible structure.

It is intended for the Bastion host in Phase 1.

## Flow

1. Create Bastion using Terraform.
2. SSH into Bastion.
3. Install Ansible on Bastion using `bootstrap-ansible.sh`.
4. Run `site.yml` locally on the Bastion.
5. Verify the required DevOps tools.

AWS access uses the IAM Instance Profile attached to the Bastion. No AWS access keys are required.

## Run

```bash
cd ansible
ansible-playbook -i inventory.ini site.yml
```

For verification only:

```bash
ansible-playbook -i inventory.ini 04-verify.yml
```
