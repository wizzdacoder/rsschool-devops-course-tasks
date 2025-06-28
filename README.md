# K3s Kubernetes Cluster Deployment on AWS (Task 3)

This README describes the step-by-step process for setting up a K3s Kubernetes cluster on AWS using Terraform and a bastion host for access. It is part of the DevOps task_3 assignment.

---

## Objective

- Provision infrastructure on AWS using Terraform.
- Deploy a K3s Kubernetes cluster with one master and one worker node.
- Use a bastion host to securely access the private instances.
- Verify the cluster using `kubectl`.
- Deploy a test workload.

---

## Technologies Used

- AWS (Free Tier)
- Terraform
- EC2
- K3s
- SSH
- GitHub + GitHub Actions

---

## Project Structure

```
.
├── bastion.tf
├── k3s-master.tf
├── k3s-worker.tf
├── nat.tf
├── networking/
│   ├── vpc.tf
│   ├── subnets.tf
│   ├── routes.tf
│   ├── internet_gateway.tf
│   └── security.tf
├── backend.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
├── .gitignore
└── README.md
```

---

## Step-by-Step Guide

### 1. Set Up the Git Branch

```bash
git checkout -b task_3
```

### 2. Create Key Pair

- Manually created in AWS EC2 console.
- Downloaded `.pem` file placed in project root.
- `.gitignore` updated to exclude key.

```
task3keypair.pem
```

### 3. Provision Infrastructure with Terraform

```bash
terraform init
terraform plan -out tfplan
terraform apply -auto-approve tfplan
```

Resources created:
- VPC, Subnets (public and private)
- Internet Gateway
- NAT Instance
- Bastion Host (public subnet)
- EC2 Instances for K3s master and worker (private subnet)

### 4. Connect to Bastion Host

```bash
ssh -i task3keypair.pem ec2-user@<bastion-public-ip>
```

### 5. Connect from Bastion to K3s Master

```bash
ssh -i task3keypair.pem ec2-user@<private-ip-of-master>
```

### 6. Install K3s on Master

```bash
curl -sfL https://get.k3s.io | sh -
```

### 7. Retrieve Node Token and Master IP

```bash
sudo cat /var/lib/rancher/k3s/server/node-token
hostname -I
```

### 8. Install K3s on Worker Node

On the worker node:

```bash
curl -sfL https://get.k3s.io | K3S_URL=https://<master-private-ip>:6443 K3S_TOKEN=<copied-token> sh -
```

### 9. Verify Cluster from Master

```bash
sudo k3s kubectl get nodes
```

Expected output:
- Two nodes (master and worker) with `STATUS = Ready`

### 10. Deploy a Test Pod

```bash
sudo k3s kubectl apply -f https://k8s.io/examples/pods/simple-pod.yaml
```

### 11. Check All Resources

```bash
sudo k3s kubectl get all --all-namespaces
```

Ensure the pod named `nginx` is running.

---

## Final Tasks

- Commit all Terraform code to `task_3` branch.
- Push to GitHub.
- Open Pull Request (PR) to `main`.

---

## Screenshots to Provide

- `kubectl get nodes` output (2 nodes visible).
- `kubectl get all --all-namespaces` output (nginx pod running).

---

## Notes

- Ensure `.terraform` and `.pem` files are excluded from Git.
- Use GitHub Actions workflow for `terraform validate`, `plan` and `apply`.
- Infrastructure uses Free Tier EC2 instances.

---

## Author

Alan Demian Beltramo

