Terraform multi-AZ architecture with CI pipeline.



A **production-ready AWS architecture** deployed using Terraform with:

* ✅ Multi-AZ High Availability
* ✅ Private Subnet Compute
* ✅ Application Load Balancer
* ✅ Auto Scaling Group
* ✅ NAT Gateways
* ✅ Remote Terraform Backend (S3 + Locking)
* ✅ IAM Roles (No SSH Required)
* ✅ GitHub Actions CI Pipeline
* ✅ Infrastructure as Code Best Practices


# 🏗 Architecture Overview



## 🌍 Region

`us-west-2` (Multi-AZ deployment)


## 🧭 Infrastructure Components

### 🌐 Networking

* VPC (`10.0.0.0/16`)
* 2 Public Subnets
* 2 Private Subnets
* Internet Gateway
* NAT Gateways (per AZ)
* Route Tables (public + private)


### ⚖️ Load Balancing

* Application Load Balancer (ALB)
* Target Group
* Health Checks
* HTTP Listener (HTTPS-ready)


### 💻 Compute Layer

* Launch Template
* Auto Scaling Group (min 2, max 4)
* EC2 instances in **private subnets**
* IAM Instance Profile
* SSM access (no public SSH)

### 🗄 Remote State Backend

* S3 Bucket (state storage)
* Native state locking (`use_lockfile = true`)
* Encryption enabled

# 📁 Project Structure

```
terraform-production/
│
├── backend.tf
├── versions.tf
├── variables.tf
├── main.tf
├── networking.tf
├── security.tf
├── alb.tf
├── compute.tf
├── outputs.tf
└── user_data.sh
```

# 🔐 Security Architecture

| Layer   | Security Control                |
| ------- | ------------------------------- |
| ALB     | Allows 80/443 from internet     |
| EC2     | Only allows traffic from ALB SG |
| SSH     | Disabled (SSM used instead)     |
| IAM     | Least privilege role            |
| Backend | Encrypted S3 state              |
| Locking | Native state lockfile           |


# 🚀 Deployment Guide

## 1️⃣ Configure AWS Credentials

Recommended: **AWS SSO**

```bash
aws configure sso
aws sso login
export AWS_PROFILE=your-profile
```

Verify:

```bash
aws sts get-caller-identity
```

## 2️⃣ Initialize Terraform

```bash
terraform init
```

If backend changes:

```bash
terraform init -reconfigure
```

## 3️⃣ Plan

```bash
terraform plan
``

## 4️⃣ Apply

```bash
terraform apply
```

## 5️⃣ Access Application

After deployment:

```
http://<ALB_DNS_NAME>
```

(Output provided by Terraform.)


# 🔄 GitHub Actions CI Pipeline

This repository includes a CI workflow that:

* Runs `terraform fmt`
* Runs `terraform validate`
* Runs `terraform plan`
* Uploads plan artifact

## Workflow Location

```
.github/workflows/terraform.yml
```

---

## Required GitHub Secrets

If using static credentials:

* `AWS_ACCESS_KEY_ID`
* `AWS_SECRET_ACCESS_KEY`

⚠ Recommended: Use **OIDC federation instead of static keys**.


# 🏆 Production Best Practices Implemented

| Feature         | Status |
| --------------- | ------ |
| Multi-AZ        | ✅      |
| Private Compute | ✅      |
| Auto Scaling    | ✅      |
| Load Balancer   | ✅      |
| Remote State    | ✅      |
| State Locking   | ✅      |
| IAM Roles       | ✅      |
| No Public SSH   | ✅      |
| CI Validation   | ✅      |



# 🎯 Learning Outcomes

This project demonstrates:

* Infrastructure as Code (IaC)
* Production-grade AWS architecture
* Secure networking patterns
* CI/CD integration
* Terraform state management
* DevOps automation best practices


# 🧹 Destroy Infrastructure

```bash
terraform destroy
```
