# Application Deployment to AWS EKS using Terraform

This repository contains the Terraform infrastructure code and deployment workflow for deploying an application to AWS Elastic Kubernetes Service (EKS). The Terraform code provisions all the necessary AWS resources which are listed below

## Infrastructure Image

![Infrastructure Architecture](../assets/aws.gif)

## Terraform Backend Configuration (aws-backend)

The `terraform/aws-backend` directory contains the Terraform code used to create the backend resources required for storing Terraform state. The following resources are created:

- S3 Bucket: An S3 bucket is created to store the Terraform state files securely.
- DynamoDB Table: A DynamoDB table is provisioned to enable state locking for safe and consistent Terraform operations.

Before deploying the main Terraform infrastructure, you should deploy the backend resources first. This ensures that the Terraform state is stored safely and allows collaboration among multiple team members.

### Deploying the Backend Resources

To deploy the backend resources, follow these steps:

1. Navigate to the `terraform/aws-backend` directory:

```bash
cd terraform/aws-backend
# 1. Initialize Terraform and install the required providers:

terraform init

# Plan the Terraform configuration to view the resources that will be created:
terraform plan

# Apply the Terraform configuration to create the backend resources:
terraform apply

```

## Terraform Infrastructure

The `terraform` directory contains all the Terraform code required to provision the AWS resources. The following resources are created:

- VPC: A Virtual Private Cloud is set up to isolate the Kubernetes cluster. It contains public and private subnets spread across multiple availability zones for high availability.
- NAT Gateway: A NAT Gateway is provisioned to allow private subnets to access the internet for updates and package installations.
- Elastic IP: An Elastic IP is attached to the NAT Gateway for a static public IP address.
- Internet Gateway: An Internet Gateway is created and attached to the VPC to enable communication between the VPC and the internet.
- EKS Cluster: An Elastic Kubernetes Service (EKS) cluster is provisioned to manage containerized applications using Kubernetes.
- EKS Node Group: A node group is created to provision and manage worker nodes for the EKS cluster.
- Route Table: A Route Table is created and associated with the subnets to control the routing of traffic.
- Subnets: Public and private subnets are created and associated with the Route Table and the VPC to manage network traffic.
- RDS Instance: A Relational Database Service (RDS) instance is set up to host the application's database. The database credentials are securely stored using AWS Secrets Manager, and the secret keys are attached to the RDS instance.

Before deploying, ensure that you have installed Terraform on your local machine and have configured AWS credentials with the appropriate permissions.

### Pre-commit Workflow

A GitHub pre-commit workflow has been set up to automatically validate the Terraform code before any changes are committed to the repository. This ensures that only valid and properly formatted Terraform code is pushed to the repository.

## Deployment Workflow

The deployment workflow is triggered automatically when changes are pushed to the `Infra` branch. The workflow uses GitHub Actions to deploy the application to the EKS cluster.

The deployment workflow performs the following steps:

1. Runs the pre-commit checks to ensure the Terraform code is valid.
2. Initializes Terraform and sets up the required backend configurations.
3. Plans the Terraform infrastructure changes to determine what resources will be created, modified, or destroyed.
4. Deploys the Terraform infrastructure by applying the changes to AWS.
5. Deploys the application to the EKS cluster using Kubernetes manifests.
6. Sends a notification to a Microsoft Teams channel to notify about the success or failure of the deployment.

### Microsoft Teams Notification

The Microsoft Teams notification is integrated into the deployment workflow to provide real-time updates about the deployment status. When the workflow is triggered, it sends a notification message to a designated Microsoft Teams channel, informing the team about the progress of the deployment.

To use the Microsoft Teams notification feature, you need to set up a webhook URL in your Microsoft Teams channel and add it as a secret in the GitHub repository settings with the name `MICROSOFT_TEAMS_WEBHOOK_URL`. The GitHub Actions workflow will then use this secret to send notifications to the specified channel.

## How to Use This Repository

To use this repository and deploy the application to AWS EKS, follow these steps:

1. Clone the repository to your local machine:
2. Install Terraform on your local machine.

3. Configure AWS credentials on your local machine using the AWS CLI.

4. Set up the required secrets in the GitHub repository settings for Terraform backend configuration, AWS credentials, and the Microsoft Teams webhook URL (MICROSOFT_TEAMS_WEBHOOK_URL).

5. Make necessary changes to the Terraform code (if needed) and commit your changes.

6. Push your changes to the main branch.

The deployment workflow will automatically trigger, and your application will be deployed to the AWS EKS cluster. You will receive notifications in the designated Microsoft Teams channel about the success or failure of the deployment.

Please ensure that you have reviewed and tested the changes locally before deploying to production environments.

For any issues or questions, feel free to open an issue in the repository.

Happy Reading! 🚀
