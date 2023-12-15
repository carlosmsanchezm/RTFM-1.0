# **README.md**

## **Overview**

This lab guides you through the process of deploying a secure web application on AWS using Terraform and Ansible. It includes setting up an infrastructure with a Node.js application and an Nginx reverse proxy, implementing security baselines, conducting security assessments with OpenSCAP, and practicing change management with Git.

## **Prerequisites**

Before starting this lab, ensure you have the following installed and set up:

1. **Terraform:** Download and install [Terraform](https://www.terraform.io/downloads).
2. **AWS CLI:** Install the [AWS CLI](https://aws.amazon.com/cli/) and configure it with your AWS account credentials.
3. **Ansible:** Install [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html).
4. **Git:** Install [Git](https://git-scm.com/downloads) for version control.
5. **AWS Account:** Ensure you have an [AWS account](https://aws.amazon.com/free/).
6. **GitHub Account:** Create a [GitHub account](https://github.com/) if you don't have one.

## **Step-by-Step Instructions**

### **Step 0: Clone and Set Up Your Own Repository**

1. **Clone the Git Repository**:
    
    ```bash
    git clone <your-repository-url>
    cd your-repository-directory
    ```
    
2. **Create a New Repository on GitHub**:
    - Go to [GitHub](https://github.com/) and sign in.
    - Click the "+" icon in the top right corner and select "New repository".
    - Fill out the details for the new repository and create it.
3. **Change the Remote Repository URL**:
    - Point your local repository to your new GitHub repository:
    
    ```bash
    git remote set-url origin https://github.com/your-username/your-new-repository.git
    ```
    
    - Replace **`https://github.com/your-username/your-new-repository.git`** with your new repository's URL.

### **Step 1: Infrastructure Setup with Terraform**

1. **Initialize Terraform**:
    
    ```bash
    cd terraform
    terraform init
    ```
    
    Expected Output:
    
    ```
    Terraform has been successfully initialized!
    ```
    
2. **Plan Terraform Deployment**:
    
    ```bash
    terraform plan
    ```
    
    Expected Output:
    
    ```bash
    Plan: 7 to add, 0 to change, 0 to destroy.
    ```
    
3. **Apply Terraform Plan**:
    
    ```bash
    terraform apply
    ```
    
    When prompted, type **`yes`** to proceed.
    
    Expected Output:
    
    ```makefile
    Apply complete! Resources: 7 added, 0 changed, 0 destroyed.
    Outputs:
    instance_details = ...
    ```
    

### **Step 2: Application and Reverse Proxy Deployment with Ansible**

1. **Deploy Node.js Application and Nginx Reverse Proxy**:
    
    ```bash
    ansible-playbook -i inventory.ini infra.yaml
    ```
    
    - This playbook deploys the Node.js application and sets up the Nginx server as a reverse proxy.
    
    Expected Output:
    
    ```
    PLAY RECAP ******************************************************************
    ```
    
2. **Access the Web Application**:
    - Use a web browser to access the application through the public IP of the Nginx server, provided by Terraform output.

### **Step 3: Security Baseline Setup and OpenSCAP Installation**

1. **Run the Security Baseline Playbook**:
    
    ```bash
    ansible-playbook -i inventory.ini security_baseline.yaml
    ```
    
    - This includes setting up the security baseline and installing OpenSCAP on the instances.

### **Step 4: Running Security Assessment with OpenSCAP**

1. **SSH into an EC2 Instance**:
    - Use SSH to connect to either the Node.js or Nginx instance (whichever is specified for the scan):
    
    ```bash
    ssh -i "your-key.pem" ec2-user@<instance-ip>
    ```
    
2. **Run the OpenSCAP Scan**:
    
    ```bash
    oscap xccdf eval --profile xccdf_org.ssgproject.content_profile_standard --report /tmp/report.html /usr/share/xml/scap/ssg/content/ssg-amzn2-ds.xml
    ```
    
3. **Retrieve and View the Report**:
    - Transfer and open the report:
    
    ```bash
    scp -i "your-key.pem" ec2-user@<instance-ip>:/tmp/report.html .
    ```
    
    - Open **`report.html`** in a web browser.

### **Step 5: Code and Configuration Change**

1. **Update the deploy.yaml File**:
    - Open the **`deploy.yaml`** file and set the **`git_repo`** variable to your new GitHub repository URL.
    - Example:
        
        ```yaml
        git_repo: https://github.com/your-username/your-new-repository.git
        ```
        
2. **Make a Code Change**:
    - Edit **`app.js`** or another file, then save your changes.
3. **Commit and Push Changes to Git**:
    
    ```bash
    git add .
    git commit -m "Your commit message"
    git push
    ```
    
4. **Deploy the Changes**:
    
    ```bash
    ansible-playbook -i inventory.ini deploy.yml
    ```
    
5. **Run the OpenSCAP Correction Playbook**:
    
    ```bash
    ansible-playbook -i inventory.ini openscap_correction.yaml
    ```
    
6. **Re-run the OpenSCAP Scan**:
    - Repeat Step 4 to validate the corrections.

### **Final Step: Clean Up Resources**

Once you have completed the lab and no longer need the AWS resources, it's important to clean up to avoid incurring unnecessary costs.

1. **Destroy Terraform Resources**:
    - Navigate back to the Terraform directory:
        
        ```bash
        cd terraform
        ```
        
    - Run the following command:
        
        ```bash
        terraform destroy
        ```
        
    - Confirm the destruction of the resources when prompted. This command will remove all resources that Terraform has created for this lab.
        
        Expected Output:
        
        ```yaml
        Destroy complete! Resources: 7 destroyed.
        ```
        
2. **Check AWS Console**:
    - Optionally, log in to the AWS Console and verify that the resources have been properly terminated.

### **Final Notes**

- Make sure to run **`terraform destroy`** after you're finished with the lab to clean up the resources and avoid unnecessary costs.
- The provided output snippets give you an idea of what to expect. If your output significantly differs, review the steps to identify any issues.

## **Conclusion**

This lab provides a comprehensive, hands-on experience in deploying and securing a web application in AWS. It covers setting up a Node.js application and an Nginx reverse proxy using Terraform and Ansible, conducting security assessments, and practicing version control and change management with Git.

**README.md for Your Lab**
