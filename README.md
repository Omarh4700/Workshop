# DevOps & Cloud Infrastructure Projects

Welcome to my DevOps projects repository. This repository serves as a central hub for various infrastructure, automation, and deployment projects. 

Each project is maintained in its own dedicated **branch** to ensure isolation and modularity. I regularly update the `main` branch to reflect the latest additions to my portfolio.

## Project Catalog

Here are the projects currently available in this repository:

### 1. Source Code for All Projects
- **Branch**: `code`
- **Description**: Contains the raw source code for the applications used across all other projects.
  - Includes the Java application source, build scripts, and configuration files.
  - Useful for understanding the application logic before deployment.

### 2. Automated VM Deployment with Vagrant
- **Branch**: `Vagrant`
- **Description**: A local production-grade environment simulation using Vagrant and VirtualBox.
  - Automatically provisions 5 Virtual Machines.
  - Configures the full stack (Web, App, DB, Cache, Queue) using shell scripts.
  - Ideal for local testing of distributed systems.

### 3. AWS Infrastructure with Terraform
- **Branch**: `aws-terraform`
- **Description**: A comprehensive Infrastructure as Code (IaC) solution for AWS. It provisions a highly available, secure, and scalable 3-tier architecture including:
  - Custom VPC with Public/Private subnets across multiple AZs.
  - Managed services: RDS (MySQL), ElastiCache (Memcached), and Amazon MQ (RabbitMQ).
  - EC2 instances for Application (Tomcat) and Load Balancing (CLB).

### 4. Dockerized Multi-Tier Application
- **Branch**: `docker-app`
- **Description**: A fully containerized deployment of the multi-tier web application.
  - Orchestrates **Nginx**, **Tomcat**, **MySQL**, **Memcached**, and **RabbitMQ** containers.
  - Uses `docker-compose` for easy setup and teardown.
  - Includes custom Dockerfiles and service linking.

### 5. Production-Ready Microservices on Kubernetes
- **Branch**: `vProfile-Microservices`
- **Description**: A complete enterprise-grade microservices deployment on AWS with self-managed Kubernetes cluster.
  - **Infrastructure**: Terraform-provisioned VPC, 5 EC2 instances, Classic Load Balancers, IAM roles, Route53.
  - **CI/CD**: Jenkins pipeline with automated Docker builds, AWS ECR registry, Ansible-driven deployments.
  - **Kubernetes**: Self-managed kubeadm cluster (1 master, 2 workers) with Tomcat, MySQL, RabbitMQ, Memcached.
  - **Monitoring**: Prometheus + Grafana stack via Helm for complete observability.
  - **Security**: Encrypted secrets, Bastion host, IAM instance profiles, least privilege security groups.
  - Single-command deployment (`./deploy.sh`) for full infrastructure and application provisioning.

---

## How to Access

To work with a specific project, you can clone the repository directly into the desired branch.

### 1. Source Code for All Projects
```bash
git clone -b code https://github.com/Omarh4700/Workshop.git
```

### 2. Automated VM Deployment with Vagrant
```bash
git clone -b Vagrant https://github.com/Omarh4700/Workshop.git
```

### 3. Dockerized Multi-Tier Application
```bash
git clone -b docker-app https://github.com/Omarh4700/Workshop.git
```

### 4. AWS Infrastructure with Terraform
```bash
git clone -b aws-terraform https://github.com/Omarh4700/Workshop.git
```

### 5. Production-Ready Microservices on Kubernetes
```bash
git clone -b vProfile-Microservices https://github.com/Omarh4700/Workshop.git
```

---

## Updates

I continuously add new projects and improvements. Check the `main` branch regularly for the updated list of projects.
