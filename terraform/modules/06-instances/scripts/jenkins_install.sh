#!/bin/bash
set -e

# Update system
sudo apt update -y && sudo apt install -y fontconfig openjdk-21-jre 

# Add Jenkins repository and key
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update -y && sudo apt install -y jenkins

# Install Docker

## Add Docker's official GPG key:
sudo apt update -y && sudo apt install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

## Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update -y && sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Install AWS CLI
sudo apt install -y awscli

# Add jenkins user to docker group
sudo usermod -aG docker jenkins

# Wait for EBS volume to be attached (device will be /dev/xvdf) # /dev/xvdf 
DEVICE="/dev/xvdf"
while [ ! -b $DEVICE ]; do
  echo "Waiting for EBS volume to be attached..."
  sleep 5
done

# Check if volume has a filesystem, if not create one
if ! blkid $DEVICE; then
  mkfs -t ext4 $DEVICE
fi

# Stop Jenkins to move data
sudo systemctl stop jenkins

# Create mount point and mount volume
sudo mkdir -p /var/lib/jenkins
sudo mount $DEVICE /var/lib/jenkins

# Add to fstab for persistence
UUID=$(blkid -s UUID -o value $DEVICE)
echo "UUID=$UUID /var/lib/jenkins ext4 defaults,nofail 0 2" >> /etc/fstab

# Set correct ownership
sudo chown -R jenkins:jenkins /var/lib/jenkins

# Start and enable services
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl start docker
sudo systemctl enable docker

echo "Jenkins installation complete!"

# print the initial admin password
echo "Initial admin password: $(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)" > /home/ubuntu/jenkins_initial_admin_password.txt