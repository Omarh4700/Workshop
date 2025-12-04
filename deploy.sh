#!/bin/bash

set -e

echo "Starting Deployment..."

# Terraform
echo "Applying Terraform configuration..."
cd terraform
terraform init
terraform apply -auto-approve

# Ansible
echo "Running Ansible Playbook..."
cd ../ansible
ansible-playbook install.yml

echo "Deployment Completed Successfully!"
