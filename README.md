# **README.md**

# ****Lab Structure and Navigation Guide****

## **Introduction**

Welcome to the lab! This guide is designed to help you navigate through the lab effectively, understanding each section's purpose and what to expect. Here’s how the lab is structured:

## **Overview**

The overview provides a brief introduction to the lab's objectives. You'll learn about deploying a secure web application on AWS using Terraform and Ansible, setting up Node.js and Nginx, and implementing security practices.

## **Prerequisites**

This section lists everything you need to set up before starting the lab. Make sure you have all the required tools and accounts ready.

## **Step-by-Step Instructions**

Each step in the lab is laid out in a structured format. Here's what you'll find in each step:

### **Overview**

- **Technical Aspect**: Provides a technical breakdown of what you'll be doing in the step.
- **Conceptual Understanding**: Explains the concepts behind the tasks, helping you grasp the 'why' along with the 'how'.

### **Tasks**

- **Commands and Code**: Each step includes specific commands or code snippets. Ensure you understand each command before executing.
- **Expected Output**: After each task, there’s a description of the expected output. This helps you verify if the task was completed successfully.

### **Images and Diagrams**

- Visual aids are provided to help you better understand the tasks and expected outcomes.

## **Tips for Navigating the Lab**

- **Read Before You Act**: Always read the entire step before executing any commands. This ensures you understand the context and expected outcomes.
- **Understand, Don’t Just Copy-Paste**: Try to understand what each command or piece of code does instead of just copying and pasting. This will enhance your learning experience.
- **Verify Outputs**: Check the 'Expected Output' section after completing a task to ensure everything is going as planned.
- **Take Breaks**: Don't rush through the lab. Take breaks to absorb information and avoid information overload.

## **Clean Up Resources**

At the end of the lab, there’s a step to clean up and delete the resources you created. This is important to prevent unnecessary costs.

## **Final Notes and Conclusion**

The final notes reiterate important points and provide a conclusion to the lab. It's a wrap-up of what you've learned and accomplished.

## **Competition**

For those interested, there’s an opportunity to compete by fulfilling a specific lab objective. Details are provided in this section.

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

## **Step-by-Step Instructions (explain terminal)**

### **Step 0: Generate SSH Key Pair**

### Overview

**Step 0** is foundational and crucial for the rest of the lab. It involves generating an SSH key pair, which will be used to securely access the AWS EC2 instances created later in the lab. SSH keys are a pair of cryptographic keys that can be used to authenticate to an SSH server as an alternative to password-based logins.

- **Technical Aspect**: This step uses the **`ssh-keygen`** command to create a 2048-bit RSA key pair. The **`t rsa`** specifies the type of key to create (RSA in this case), and **`b 2048`** sets the key length. The **`f ~/.ssh/id_rsa`** argument specifies the filename of the key. The process creates two files: a private key (**`id_rsa`**) and a public key (**`id_rsa.pub`**).
- **Conceptual Understanding**:
    - **SSH Key Importance**: SSH keys provide a more secure way of logging into a server with SSH than using a password alone. While a password can eventually be cracked with enough time and computing power, SSH keys are nearly impossible to decipher by brute force.
    - **Public and Private Keys**: The public key is placed on the server and the private key is what you keep secure and use to authenticate yourself.
    - **Security Best Practices**: Not using a passphrase for the key in this context is a choice made for simplicity, as this is a controlled lab environment. In a real-world scenario, especially in production, it's recommended to secure your private key with a passphrase for an additional layer of security.

By the end of this step, you will have generated a secure method to authenticate to your AWS EC2 instances, setting the stage for the rest of the activities in the lab.

Before running Terraform, generate an SSH key pair to be used with your EC2 instances:

1. **Open a local Terminal**.
2. **Generate SSH Key Pair**:
    - Generate a key-pair:
        
        ```bash
        ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa
        ```
        
    - When prompted for a passphrase, press Enter for no passphrase.
    - Two files will be created: **`id_rsa`** (private key) and **`id_rsa.pub`** (public key) in your **`~/.ssh/`** directory.
    
    Expected Output:
    
    ```bash
    The key's randomart image is:
    +---[RSA 2048]----+
    |..=o+*@=*+o      |
    |.+ o=B+O+  .     |
    |  . o==o .       |
    |    .. .         |
    |     ..oS        |
    |      .E+        |
    |      o.+.       |
    |     .o*o.       |
    |   .o+++o.       |
    +----[SHA256]-----+
    ```
    
3. **Verify Key Creation**:
    - Ensure the keys exist in the **`~/.ssh/`** directory:
        
        ```bash
        ls ~/.ssh/id_rsa*
        ```
        

### **Step 1: Clone and Set Up Your Own Repository**

### Overview

**Step 1** introduces you to Git, a distributed version control system, and GitHub, a cloud-based hosting service that lets you manage Git repositories. This step is about cloning an existing repository, removing its Git history, initializing a new Git repository, and pushing it to your own GitHub account.

- **Technical Aspect**:
    - **Cloning a Repository**: You start by cloning an existing repository from GitHub. This action creates a local copy of the repository on your machine.
    - **Removing Existing Git History**: By deleting the **`.git`** folder, you remove the existing version control history. This step is necessary because you'll be creating a new repository based on the contents of the cloned one.
    - **Initializing a New Repository**: Using **`git init`** starts a new Git repository in your current directory, allowing you to track changes to these files independently.
    - **Changing the Remote Repository URL**: **`git remote add origin`** points your local repository to your new GitHub repository. This step is essential for pushing your local changes to the remote repository.
    - **Committing and Pushing Changes**: The **`git add`**, **`git commit`**, and **`git push`** commands are used to add changes to the local Git index, commit these changes with a message, and then push them to the remote repository on GitHub.
- **Conceptual Understanding**:
    - **Version Control**: Understanding how Git tracks changes to files and why this is beneficial is crucial. It allows multiple people to work on the same project without conflicting changes, and it tracks history so changes can be reverted if needed.
    - **Repository Management**: Learning how to handle repositories on GitHub - creating, pushing, and managing them - is an essential skill for collaborative software development.
    - **Importance of Clean Slate**: Starting with a new Git history is important when you fork or clone a project to make it your own. It allows you to start fresh and keep track of your modifications from the beginning.

By completing Step 1, you will have a solid foundation in managing and versioning your code using Git and GitHub. This step is critical as it sets the stage for all the subsequent development and change management you will do in this lab.

1. **Clone the Git Repository**:
    
    ```bash
    git clone https://github.com/carlosmsanchezm/RFTM-1.0.git
    cd RFTM-1.0
    ```
    
    **Remove the Existing Git History**:
    
    ```bash
    rm -rf .git
    ```
    
    **Initialize a New Git Repository**:
    
    ```bash
    git init
    ```
    
2. **Create a New Repository on GitHub**:
    - Go to [GitHub](https://github.com/) and sign in.
    - Click the "+" icon in the top right corner and select "New repository".
    
    ![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/a734f6e6-6232-40c2-9ad1-d3f6e5102145/9318387d-fa1c-4071-a976-dd7e3aee04c3/Untitled.png)
    
    - For `Repository name` write **RFTM-1-TEST**. Do not fill any other field. Click `Create Repository`
    
    ![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/a734f6e6-6232-40c2-9ad1-d3f6e5102145/cb0d498f-289a-442a-baf4-dcf06a9a7a89/Untitled.png)
    
3. **Change the Remote Repository URL**:
    - Point your local repository to your new GitHub repository:
        
        ```bash
        git remote add origin https://github.com/your-username/your-new-repository.git
        ```
        
    - Replace **`https://github.com/your-username/your-new-repository.git`** with your new repository's URL.
    
    ![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/a734f6e6-6232-40c2-9ad1-d3f6e5102145/03354a4b-e256-4a85-b12e-288424c73350/Untitled.png)
    
4. **Initialize New Repo**
    
    **Add Files to the New Repository**:
    
    ```bash
    git add .
    ```
    
    **Commit the Changes**:
    
    ```bash
    git commit -m "Initial commit"
    ```
    
    **Push to the New Repository**:
    
    ```bash
    git push -u origin main
    ```
    
    Refresh github repo page and see your repo updated with directory:
    
    ![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/a734f6e6-6232-40c2-9ad1-d3f6e5102145/3de779cb-c915-4fe1-874c-b54164529032/Untitled.png)
    

**Pre-Step 2: Configure AWS CLI**

Before starting with `terraform`, ensure your AWS CLI is configured with the necessary credentials. This is essential for Terraform to interact with your AWS account. Run the following command and follow the prompts:

```bash
aws configure --profile userprod
```

Enter your AWS credentials as follows:

- **AWS Access Key ID**: Enter your access key ID.
- **AWS Secret Access Key**: Enter your secret access key.
- **Default region name**: Enter your preferred AWS region (e.g., **`us-east-1`**).
- **Default output format**: Enter the output format (e.g., **`json`**).

These credentials are necessary for Terraform to authenticate and manage resources in your AWS account.

### **Step 2: Infrastructure Setup with Terraform**

### Overview

**Step 2** is all about using Terraform to set up your cloud infrastructure on AWS. Terraform is an open-source infrastructure as code (IaC) tool that allows you to build, change, and version infrastructure efficiently.

- **Technical Aspect**:
    - **Initializing Terraform**: The **`terraform init`** command initializes a Terraform working directory by installing the necessary plugins. It's the first command that should be run after writing new Terraform configurations.
    - **Planning Terraform Deployment**: **`terraform plan`** creates an execution plan. It's a way to check whether the execution plan for a set of changes matches your expectations without making any changes to real resources or the state.
    - **Applying Terraform Plan**: By running **`terraform apply`**, you apply the changes required to reach the desired state of the configuration, or the pre-determined set of actions generated by a Terraform plan execution plan.
- **Conceptual Understanding**:
    - **Infrastructure as Code (IaC)**: This step will help you understand the concept of IaC, which is crucial for automating the setup, configuration, and management of infrastructure using code instead of manual processes.
    - **Importance of Planning in IaC**: The plan step in Terraform is crucial for predicting changes, ensuring that the infrastructure deployment happens as expected, and reducing the likelihood of surprises.
    - **Applying Changes Safely**: Understanding the significance of applying changes in a controlled manner helps in maintaining the stability and reliability of infrastructure environments.

By the end of Step 2, you will gain practical experience with Terraform in setting up infrastructure, reinforcing the principles of IaC. This step is critical in the lab as it lays the groundwork for deploying the web application in a secure and repeatable manner.

Before initializing `terraform` 

1. **Initialize Terraform**:
    
    ```bash
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
    

### **Step 3: Application and Reverse Proxy Deployment with Ansible**

### Overview

In **Step 3**, the focus is on deploying a Node.js application and setting up Nginx as a reverse proxy using Ansible. This step is crucial for understanding how application deployment and web traffic management work in tandem in a cloud environment.

- **Technical Aspect**:
    - **SSL/TLS Setup**: The lab configures SSL/TLS for secure communication between clients and the Nginx reverse proxy. Self-signed SSL certificates are generated for Nginx, enabling HTTPS. This is a critical step for securing data in transit.
    - **Nginx as a Reverse Proxy**: Nginx, deployed on one EC2 instance, acts as a reverse proxy to the Node.js app on another EC2 instance. This setup centralizes client requests, providing a single point of entry for improved security and traffic management.
- **Security Implications**:
    - **Data Encryption**: The use of SSL/TLS encrypts data between the client and the server, protecting sensitive information from eavesdropping and tampering.
    - **Reduced Attack Surface**: By positioning Nginx as the only exposed entity to the internet, the Node.js application's exposure to potential attacks is minimized.
    - **Trust Issues with Self-Signed Certificates**: While self-signed certificates encrypt data, they lack third-party validation, which may trigger browser security warnings. This aspect is acceptable in a lab environment but not recommended for production.
- **Container and EC2 Integration**:
    - **Containerized Applications**: Both Node.js and Nginx are deployed as Docker containers. This encapsulates their environments, ensuring consistency and isolation from the underlying EC2 instances.
    - **Interplay Between Containers and EC2 Instances**: The configuration underscores how containerized applications can be efficiently deployed and managed across different cloud resources. It illustrates how separate components (Node.js app and Nginx reverse proxy) can work in harmony to deliver a seamless web service.

### In-Depth Technical Details

1. **SSL/TLS Configuration for Nginx**: The playbook generates SSL certificates using OpenSSL and mounts them into the Nginx container. This step equips Nginx to handle HTTPS requests.
2. **Nginx Configuration for Reverse Proxying**: The playbook uses a Jinja2 template to configure Nginx. This configuration directs HTTP and HTTPS traffic to the Node.js application, ensuring secure and efficient request handling.
3. **Docker Containers for Application and Proxy**: Both the Node.js app and Nginx are containerized. The playbook builds the Node.js Docker image and pulls the Nginx image from a registry. Containers are then run with the necessary configurations and port bindings.
4. **Inter-Container Networking**: Nginx needs to know the Node.js app's IP address. This is managed through Ansible's dynamic inventory, showcasing the dynamic nature of cloud environments and the importance of flexible configurations.
1. **Deploy Node.js Application and Nginx Reverse Proxy**:
    
    ```bash
    ansible-playbook infra.yaml -i inventory.ini
    ```
    
    - This playbook deploys the Node.js application and sets up the Nginx server as a reverse proxy.
    
    Expected Output:
    
    ```
    TASK [Congratulatory Message] **************************************************
    ok: [localhost] => {
        "msg": "C0n9r47z! Y0u'v3 d3pl0y3d y0ur f1r57 m1cr0-s3rv1c3 4ppl1c47i0n 0n 7h3 cl0ud! Pl3453 pu7 7h15 1n y0ur URL: https://<instance-public-ip>"
    }
    
    PLAY RECAP ******************************************************************
    ```
    
2. **Access the Web Application**:
    - Use a web browser to access the application through the public IP of the Nginx server which will appear under the `TASK [Congratulatory Message]` above `PLAY RECAP`. You can also find it in the generated `inventory.ini` file in the working directory.
    
    Expected Outcome:
    
    ![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/a734f6e6-6232-40c2-9ad1-d3f6e5102145/79d16850-8b0b-4d0c-b684-359c1039f08b/Untitled.png)
    

- Click on `Proceed to https://<instance-public-ip>`. Since this we are using a self-signed certificate this warning is being triggered but you can ignore.

### **Step 4: Security Baseline Setup and OpenSCAP Installation**

### Overview

In **Step 4** of the lab, participants focus on enhancing the security of their cloud infrastructure through the establishment of a security baseline and the installation of OpenSCAP on the AWS EC2 instances. This step is pivotal in illustrating how to enforce security best practices and conduct automated security assessments in a cloud environment.

- **Security Baseline Configuration**:
    - The process involves configuring the EC2 instances to adhere to predefined security standards. This typically includes settings for system security, user permissions, and firewall configurations.
    - The security baseline ensures that the servers are protected against known vulnerabilities and are in line with industry-standard security practices.
- **Automated Security with OpenSCAP**:
    - OpenSCAP (Open Security Content Automation Protocol) is integrated into the setup. It's an open-source tool for automating the enforcement and auditing of security compliance.
    - The tool is instrumental in performing security compliance checks and vulnerability assessments, enabling a proactive approach to identifying and mitigating potential security risks.
- **Ansible's Role in Security**:
    - Ansible is employed to automate the deployment of security configurations and the installation of OpenSCAP. This showcases the efficiency and effectiveness of using automation in security practices.
    - By using Ansible, consistency and repeatability in applying security measures are ensured across all instances, which is crucial in maintaining a strong and unified security posture.
- **Security Implications in Cloud Infrastructure**:
    - Implementing a robust security baseline fortifies the cloud infrastructure against potential security threats.
    - Regular and automated security assessments with OpenSCAP aid in maintaining compliance with security standards and in the early detection of vulnerabilities.
    - The setup underscores the importance of integrating security practices within the cloud infrastructure lifecycle, demonstrating how security is a continuous and integral part of cloud management.

Completing Step 4, you will gain insights into establishing security baselines and conducting security assessments using OpenSCAP. This step underscores the significance of proactive security measures in cloud environments. You'll learn about the importance of setting a strong foundation for security and the benefits of using automated tools to regularly assess and ensure compliance with security best practices.

1. **Run the Security Baseline Playbook**:
    
    ```bash
    ansible-playbook security_baseline.yaml -i inventory.ini 
    ```
    
    - This includes setting up the security baseline and installing OpenSCAP on the instances.
    
    Expected Output:
    
    ```
    PLAY RECAP ******************************************************************
    ```
    

### **Step 5: Running Security Assessment with OpenSCAP**

### Overview

**Step 5** is about conducting a security assessment using OpenSCAP, a tool for automated vulnerability scanning and compliance checking. This step illustrates the practical aspects of identifying and mitigating vulnerabilities within cloud-based infrastructure.

- **Conducting the OpenSCAP Scan**:
    - Participants SSH into the EC2 instance configured in earlier steps to run the OpenSCAP scan. This action mirrors real-world practices of remote server management and security assessment.
    - The scan, through the **`oscap`** command, evaluates the instance against a specified profile, such as the "Standard System Security Profile for Amazon Linux 2". This profile includes various security checks and benchmarks designed for Amazon Linux environments.
- **Understanding Security Reports**:
    - The OpenSCAP tool generates a detailed report in HTML format, providing insights into the security posture of the instance.
    - This report is essential for understanding the security strengths and weaknesses of the system. It categorizes findings and offers recommendations for remediation, crucial for maintaining a secure and compliant infrastructure.
- **SSH and SCP for Data Retrieval**:
    - Secure Shell (SSH) is used for secure remote access to the EC2 instance. This reflects a key practice in secure system administration.
    - Secure Copy Protocol (SCP) is then used to transfer the generated security report from the EC2 instance to the local machine. This demonstrates secure file transfer techniques in a networked environment.
- **Practical Implications**:
    - This step emphasizes the importance of regular security assessments in identifying and addressing vulnerabilities in a timely manner.
    - It also highlights the role of tools like OpenSCAP in automating security compliance checks, making it easier for organizations to maintain high security standards.

By accomplishing Step 5, you will have experienced firsthand the process of performing security assessments in a cloud environment using OpenSCAP. This step is vital as it demonstrates the practical application of security tools in identifying vulnerabilities and ensuring the security of your cloud infrastructure. You'll appreciate the necessity of regular security audits and the value they add in maintaining a robust and secure cloud ecosystem.

1. **SSH into an EC2 Instance**:
    - Use SSH to connect to the Nginx instance by using its public ip address found in the `inventory.ini` file, `TASK [Congratulatory Message]`  or in the url you connected to:
        
        ```bash
        ssh -i ~/.ssh/id_rsa ec2-user@<instance-public-ip>
        ```
        
2. **Run the OpenSCAP Scan**:
    
    ```bash
    oscap xccdf eval --profile xccdf_org.ssgproject.content_profile_standard --report /tmp/report.html /usr/share/xml/scap/ssg/content/ssg-amzn2-ds.xml
    ```
    
    Expected Output:
    
    ```bash
    Title   Add nodev Option to /dev/shm
    Rule    xccdf_org.ssgproject.content_rule_mount_option_dev_shm_nodev
    Result  pass
    ```
    
    Wait until you are able to see your command line input line: `[ec2-user@<instance-public-ip> ~]$`
    
3. **Retrieve and View the Report**:
    - Once scan is complete exit the SSH session in your EC2 instance by **running the `exit` command.** Once on your local terminal transfer and open the report:
        
        ```bash
        scp -i ~/.ssh/id_rsa ec2-user@<instance-ip>:/tmp/report.html /tmp/
        ```
        
    
    Expected Output:
    
    ```bash
    report.html                      100%  897KB   7.7MB/s   00:00
    ```
    
- Open **`report.html`** in a web browser using `file:///tmp/report.html`.
    
    Expected Outcome:
    
    ![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/a734f6e6-6232-40c2-9ad1-d3f6e5102145/70223a41-4366-4ff5-95e9-30f285020269/Untitled.png)
    

### **Step 6: Configuration Change**

### Overview

**Step 6** introduces the concept of making configuration changes to enhance security, showcasing how automated tools like Ansible can efficiently manage and apply such changes across a cloud environment.

- **Addressing Security Findings**:
    - The lab participants create an Ansible playbook to correct a specific security issue identified by the OpenSCAP scan. This task involves disabling and stopping the 'atd' service, a common security recommendation.
    - This step illustrates the practical approach to remediating vulnerabilities identified in security audits, emphasizing the agility and efficiency provided by automation tools.
- **Git Version Control Integration**:
    - Changes are committed and pushed to a Git repository. This practice demonstrates the integration of version control in configuration management, a crucial aspect of maintaining consistency and trackability in software and infrastructure development.
- **Ansible for Configuration Management**:
    - Participants use Ansible to deploy the changes across the cloud infrastructure. This highlights Ansible's role in automating and standardizing the deployment of configuration changes, ensuring that security enhancements are uniformly applied across all instances.
- **Validating Security Improvements**:
    - The step concludes with a re-run of the OpenSCAP scan to validate the effectiveness of the changes. This mirrors real-world practices where security measures are continuously evaluated and improved upon.

Upon completing Step 6, you will have practiced how to effectively manage and implement configuration changes to enhance security, using Ansible. This step is integral in illustrating the agility of cloud computing and the importance of quick response to security vulnerabilities. You'll understand the need for continuous monitoring and improvement in cloud security, as well as the role of automation in efficiently managing these changes across your infrastructure.

1. Create a file named `openscap_corrections.yaml` in the directory and paste this ansible task:
    
    ```bash
    - name: Ensure 'atd' service is disabled and stopped
      ansible.builtin.systemd:
        name: atd
        enabled: no
        state: stopped
    ```
    
2. **Commit and Push Changes to Git**:
    
    ```bash
    git status
    git add -u
    git commit -m "app.js deployment"
    git push
    ```
    
3. **Deploy the Changes**:
    
    ```bash
    ansible-playbook -i inventory.ini openscap_correction.yaml
    ```
    
4. **Re-run the OpenSCAP Scan**:
    - Repeat Step 5.1 and 5.2 to validate the corrections. You will see how atd is now passing since we have made configuration changes.

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
        
        ```bash
        Destroy complete! Resources: 7 destroyed.
        ```
        
2. **Check AWS Console**:
    - Optionally, log in to the AWS Console and verify that the resources have been properly terminated.

### **Final Notes**

- Make sure to run **`terraform destroy`** after you're finished with the lab to clean up the resources and avoid unnecessary costs.
- The provided output snippets give you an idea of what to expect. If your output significantly differs, review the steps to identify any issues.

## **Conclusion**

This lab provides a comprehensive, hands-on experience in deploying and securing a web application in AWS. It covers setting up a Node.js application and an Nginx reverse proxy using Terraform and Ansible, conducting security assessments, and practicing version control and change management with Git.

## Competition

pass the Openscap assessment 100% for a chance to win a MacBook Pro!

Submit your assessment screenshot with the ansible code and complete the review form to enter the competition!
