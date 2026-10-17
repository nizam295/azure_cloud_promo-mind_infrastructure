# Enterprise Multi-Tier Cloud Infrastructure Automation via Terraform (Azure Blueprint)

An enterprise-grade, fully automated infrastructure network topology provisioned entirely through Infrastructure-as-Code (IaC) using Terraform. This blueprint establishes a highly secure, zero-touch deployment framework inside the Microsoft Azure Central India (Pune) region data centers, designed to scale and isolate production web applications like the PromoMind AI engine.

## 🏗️ System Architecture & Isolated Tiers
The infrastructure is decoupled into isolated layers to eliminate single points of failure and establish hard security boundaries:
1. **🌐 Public-Facing Web Tier (Subnet 1):** Houses ingress traffic entry points including a static public IP mapping and a Standard External Public Load Balancer to distribute concurrent user workloads smoothly.
2. **🔒 Private Application Tier (Subnet 2):** A completely isolated, locked-down subnet environment hosting core compute and application microservices, hidden away from direct public internet exposure.

## 🛡️ Enterprise Network Security Controls (NSG Firewall)
The network boundary is locked down using a customized Network Security Group (NSG) acting as a production-grade perimeter firewall:
* **Rule 100 (Allow-HTTP-Inbound):** Permits standard HTTP browser communication over port 80.
* **Rule 110 (Allow-HTTPS-Inbound):** Permits encrypted, highly secure browser sessions over port 443.
* **Rule 1000 (Deny-All-Internet-Default):** Enforces a strict zero-trust drop matrix, programmatically blocking all malicious public internet hacking attempts from reaching private tiers.

---

## 🛠️ Local Installation & Automated Deployment Manual

### Prerequisites
- [Terraform CLI](https://hashicorp.com) (>= 1.5.0) installed locally.
- [Azure CLI](https://microsoft.com) tool installed on your computer.
- An active Microsoft Azure Account.

### Step 1: Clone the Repository
```bash
git clone https://github.com
cd azure_cloud_promo-mind_infrastructure
```

### Step 2: Authenticate with the Microsoft Azure Cloud
Run the login command in your terminal. A browser window will automatically open to verify your account authorization:
```bash
az login
```

### Step 3: Initialize the Project Workspace
Pull down the official Microsoft Azure Resource Manager (`azurerm`) plug-in providers:
```bash
terraform init
```

### Step 4: Preview the Cloud Construction Blueprint
Compile a dry-run evaluation plan to verify the resources mapping configuration before spending any trial credits:
```bash
terraform plan
```

### Step 5: Launch the Infrastructure Live
Instantly scale up your secure network resources, subnets, firewalls, and load balancers inside the live Azure portal registry:
```bash
terraform apply --auto-approve
```

### Step 6: Graceful Resource Teardown
When finished taking screenshots or running system checks, wipe your testing sandbox completely clean to preserve free tier credit balances:
```bash
terraform destroy --auto-approve
```

---

## 📂 Repository File Directory Configuration Map
* `providers.tf` - Declares required Terraform versions and hooks into the Azure RM lifecycle engine.
* `variables.tf` - Groups structural parameters like IP addresses and data center location blocks (`Central India`).
* `main.tf` - The primary logical routing script provisioning VNets, subnets, firewalls, and traffic distribution configurations.
* `outputs.tf` - Extracts unique system-generated resource IDs and prints them live to the terminal pane.
