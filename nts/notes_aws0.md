-   <details><summary style="font-size:25px;color:Orange">AWS Profile Management</summary>

    Maintaining multiple AWS accounts from a local machine involves managing credentials and configurations effectively. Here's a general approach to achieve this:

    1. **AWS CLI Configuration**:

        - `Install AWS CLI`: Ensure that you have the AWS Command Line Interface (CLI) installed on your local machine.

            - `$ brew install awscli`

        - `Configure AWS CLI Profiles`:

            - Use the aws configure command to set up AWS CLI profiles for each AWS account.
            - Run the command and follow the prompts to provide **Access Ke ID**, **Secret Access Key**, default region, and output format for each profile.
            - Specify a unique profile name for each account (e.g., `personal`, `work`, `testing`, etc.).

        - `Verify Profiles`: Use the `aws configure list` command to verify that the profiles have been configured correctly.

    2. **~/.aws/config**:

        - `Purpose`: The `~/.aws/config` file is used to specify AWS CLI configurations, such as the default region, output format, and additional named profiles.
        - `Format`: It is formatted as an INI file with sections for each named profile and configuration options within each section.
        - `Sample Configuration:`

            ```ini
            # ~/.aws/config
            [default]
            region = us-west-2
            output = json

            [profile personal] # Add a profile by the name of 'personal'
            region = us-east-1
            output = json
            ```

    3. **~/.aws/credentials**:

        - `Purpose`: The `~/.aws/credentials` file is used to store **aws_access_key_id**s and **aws_secret_access_key**s for named profiles.
        - `Format`: It is also formatted as an INI file with sections for each named profile and credential options within each section.
        - `Sample Configuration`:

            ```ini
            # ~/.aws/credentials
            [default]
            aws_access_key_id = YOUR_ACCESS_KEY_ID
            aws_secret_access_key = YOUR_SECRET_ACCESS_KEY

            [personal]
            aws_access_key_id = PERSONAL_ACCESS_KEY_ID
            aws_secret_access_key = PERSONAL_SECRET_ACCESS_KEY
            ```

    4. **config vs credentials**:

        - The `config` file stores configuration settings like the default region and output format, while the `credentials` file stores access keys and secret access keys for each profile.
        - The `config` file contains configuration options, whereas the `credentials` file contains sensitive authentication credentials.
        - The `~/.aws/config` and `~/.aws/credentials` files are both used by the AWS Command Line Interface (CLI) to manage AWS configurations and credentials, but they serve different purposes:

    5. **IAM Role Assumption (Optional)**:

        - `Cross-Account Access`:
            - If you need to access resources in one AWS account from another account, you can set up IAM roles and use role assumption.
            - Configure role assumption in the AWS CLI configuration or use temporary credentials obtained via the aws sts assume-role command.

    #### AWS CLI

    -   `$ aws configure list`
    -   `$ aws configure set output json` -> Set the output format: `json`, `text`, or `table`
    -   `$ aws configure get property_name [--profile profile_name]`
    -   `$ aws configure get aws_access_key_id`
    -   `$ aws configure get region --profile ht`
    -   `$ aws configure get output --profile ht`
    -   `$ aws configure set property_name value [--profile profile_name]`
    -   `$ aws configure set aws_access_key_id YOUR_ACCESS_KEY`
    -   `$ aws configure set default.region us-east-2` -> aws configure set <varname> <value> [--profile profile-name]
    -   `$ aws iam list-users` -> If you've just one profile set locally
    -   `$ aws iam list-users --profile <profile-name>` -> If you've multiple profiles set locally
    -   `$ `
    -   `$ aws s3 ls --profile personal` -> specify the desired profile using the `--profile` option.
    -   `$ export AWS_PROFILE=personal` -> Change the default profile by setting the `AWS_PROFILE` environment variable

    -   `$ aws configure set <option-name> "" --profile <profile-name>` -> Remove a specific configuration key

    1. **Configure MFA (Multi-Factor Authentication)**: Use the `--serial-number` flag to configure MFA for a session:

        ```bash
        aws sts get-session-token --serial-number arn:aws:iam::<account-id>:mfa/<user-name> --token-code <mfa-code>
        ```

    2. **Rotate Access Keys**: If your keys are compromised or need rotation, delete the old ones and add new ones:
        ```bash
        aws iam delete-access-key --access-key-id <old-key-id>
        aws iam create-access-key
        ```

    -   <details><summary style="font-size:20px;color:Tomato">How to Configure MFA for AWS Accounts Using AWS CLI (NOT TESTED YET)</summary>

        You can enable **Multi-Factor Authentication (MFA)** for your AWS account and IAM users using the AWS CLI. This ensures an extra layer of security by requiring both a password and a temporary authentication code.

        -   **Prerequisites**

            -   `Install AWS CLI`: If not already installed, download and install AWS CLI.
            -   `Configure AWS CLI`: Ensure you have the necessary credentials configured using:
            -   `IAM Permissions`: You must have permissions to manage MFA devices (`iam:CreateVirtualMFADevice`, `iam:EnableMFADevice`, etc.).

        -   **List Available MFA Devices**: Before setting up a new MFA device, you can check if one is already enabled:

            -   `$ aws iam list-mfa-devices --user-name <USERNAME>`

        -   **Create and Enable an MFA Device**

            -   **Option 1: Virtual MFA Device (TOTP-based)**

                1. **Create a virtual MFA device** (e.g., Google Authenticator or Authy):

                    - `$ aws iam create-virtual-mfa-device --virtual-mfa-device-name <MFA_DEVICE_NAME>`
                    - This command generates a **QR code** or a **Base32 secret key**, which can be used to set up MFA in an authenticator app.

                2. **Activate MFA for a User**: You need to enter two consecutive MFA codes generated by your app:
                    ```bash
                    aws iam enable-mfa-device --user-name <USERNAME> \
                        --serial-number arn:aws:iam::<ACCOUNT_ID>:mfa/<MFA_DEVICE_NAME> \
                        --authentication-code-1 <FIRST_MFA_CODE> \
                        --authentication-code-2 <SECOND_MFA_CODE>
                    ```
                    - `Replace`:
                    - `<USERNAME>` with your IAM user.
                    - `<MFA_DEVICE_NAME>` with your MFA device name.
                    - `<ACCOUNT_ID>` with your AWS account ID.
                    - `<FIRST_MFA_CODE>` and `<SECOND_MFA_CODE>` with codes from your authenticator app.

            -   **Option 2: Hardware MFA Device**: If using a physical **YubiKey or other hardware device**, first **attach the MFA device**:

                ```bash
                aws iam enable-mfa-device --user-name <USERNAME> \
                    --serial-number <SERIAL_NUMBER> \
                    --authentication-code-1 <FIRST_CODE> \
                    --authentication-code-2 <SECOND_CODE>
                ```

                -   `<SERIAL_NUMBER>` can be found on the device itself.

        -   **Set MFA as Required for CLI and Console Access**: Once MFA is enabled, you should enforce MFA for high-privilege actions by requiring users to use an MFA session.

            1. **Get a Session Token with MFA**

                - `$ aws sts get-session-token --serial-number arn:aws:iam::<ACCOUNT_ID>:mfa/<MFA_DEVICE_NAME> --token-code <MFA_CODE>`

            2. **Use Temporary Credentials**

            -   The command above will return:
                ```json
                {
                    "Credentials": {
                        "AccessKeyId": "AKIA....",
                        "SecretAccessKey": "wJalrXUtn...",
                        "SessionToken": "IQoJb3Jp..."
                    }
                }
                ```
            -   Configure CLI with these temporary credentials:
                ```bash
                export AWS_ACCESS_KEY_ID=<AccessKeyId>
                export AWS_SECRET_ACCESS_KEY=<SecretAccessKey>
                export AWS_SESSION_TOKEN=<SessionToken>
                ```

        -   **Remove or Deactivate MFA**: If you need to remove MFA for a user:

            -   `$ aws iam deactivate-mfa-device --user-name <USERNAME> --serial-number arn:aws:iam::<ACCOUNT_ID>:mfa/<MFA_DEVICE_NAME>`

        -   **Enforce MFA in IAM Policies**: To ensure MFA is always used for sensitive actions, attach a policy that denies access unless MFA is enabled:
            ```json
            {
                "Version": "2012-10-17",
                "Statement": [
                    {
                        "Effect": "Deny",
                        "Action": "*",
                        "Resource": "*",
                        "Condition": {
                            "BoolIfExists": {
                                "aws:MultiFactorAuthPresent": "false"
                            }
                        }
                    }
                ]
            }
            ```
            -   Apply this policy to IAM users or roles.

        </details>

        </details>

---

-   <details><summary style="font-size:25px;color:Orange">Terminology</summary>

    -   [The Most Important AWS Core Services That You NEED To Know About!](https://www.youtube.com/watch?v=B08iQQhXG1Y)

    -   **Services**: AWS Services refer to the various offerings and capabilities provided by Amazon Web Services, such as Amazon S3 (Simple Storage Service), Amazon EC2 (Elastic Compute Cloud), AWS Lambda, Amazon RDS (Relational Database Service), Amazon SQS (Simple Queue Service), and many others. Each of these services provides specific functionality, and customers can choose which services they want to use and in what combination, depending on their needs.
    -   **Resources**: AWS Resources, on the other hand, refer to specific instances of AWS services that have been created by customers or by other AWS services on their behalf. For example, if a customer creates an EC2 instance, that instance is an AWS resource. Similarly, if a customer creates an S3 bucket, that bucket is an AWS resource.
    -   **Components**: The building blocks or essential parts of an AWS service that are required for it to function (e.g., **Listeners** and **Target Groups** in an ELB).
    -   **Features**: Optional capabilities or enhancements that add extra functionality or flexibility to an AWS service (e.g., **Sticky Sessions**, **Host-based Routing** in ALB).
    -   **Configurations**: The settings or parameters applied to control how an AWS service or resource behaves (e.g., **Scheme = internet-facing** or **health check settings** in an ELB).
    -   **permission**: A permission is a statement that grants or denies access to a specific AWS resource or operation. Permissions are attached to an identity, such as a user, group, or role, and specify what actions that identity can perform on the resource. For example, a permission might allow a user to read objects from a specific S3 bucket, but not delete them.
    -   **policy**: A policy is a set of permissions that can be attached to an identity to define its overall access to AWS resources. A policy can include one or more permissions and can be attached to multiple identities. For example, a policy might allow all members of a certain group to access a specific set of EC2 instances.
    -   **Provisioning**: Provisioning refers to the process of setting up and allocating the necessary infrastructure and resources required for an application to run. This includes computing power, storage, networking, and other cloud services.
    -   **Deploying**: Deploying refers to the process of releasing and running an application or service on the provisioned infrastructure. It involves pushing code, configuring runtime environments, and ensuring the application is available to users.
    -   **Stack** in AWS refers to a collection of AWS resources that are provisioned and managed as a single unit. This is typically done using AWS CloudFormation, AWS's Infrastructure-as-Code (IaC) service.
    -   **Infrastructure** refers to the overall computing, networking, storage, and security resources required to support an application or workload in AWS. It includes everything that makes up the environment in which applications run.

    ##### Rehydration

    > In the context of AWS, **rehydration** typically refers to the process of **restoring or reinitializing data or resources** that were previously "dried out" or removed. This can apply to various AWS services where data or configurations might have been removed, suspended, or cached, and now need to be **reloaded or reactivated**. Common contexts where **rehydration** might be used in AWS:

    1. **Elastic Load Balancer (ELB)**: If an application or service experiences changes or updates, **rehydration** can refer to **restoring the configuration** or applying the latest configuration to resources like load balancers or target groups.

    2. **Amazon S3 Glacier (and Glacier Deep Archive)**:

        - **Rehydration** in this context refers to **retrieving archived data** from long-term storage (like Glacier or Glacier Deep Archive) back to more accessible storage (such as S3 standard or S3 infrequent access) before it can be used or processed.
        - `Example`: A file is archived in S3 Glacier for long-term storage. When the file needs to be used again, it undergoes "rehydration" to restore it to a more accessible state.

    3. **Elasticache**: For services like **Amazon ElastiCache**, **rehydration** may refer to **restoring the cache** after it is invalidated or cleared, either automatically or through manual intervention.
    4. **Data Pipelines**: In cases where there are **data transformations or ETL (Extract, Transform, Load) processes** in AWS (e.g., with AWS Glue), **rehydration** might refer to **reloading or refreshing data** from the source system back into the pipeline after a failure or cleanup event.
    5. **General Example**: If a **serverless function** was previously paused or removed and then restarted, rehydration would be the process of bringing the function back into a working state.

    ##### Pave/Repave

    > In the world of DevOps, AWS, and Terraform, **"Pave"** and **"Repave"** are concepts deeply tied to **Infrastructure as Code (IaC)** and the philosophy of **Immutable Infrastructure**. Instead of fixing servers or infrastructure when they drift or break, you completely tear them down and rebuild them from scratch.

    -   **Paving (The Initial Build)**: **Paving** is the act of provisioning your infrastructure for the very first time. You are laying down the foundation, much like paving a brand-new road.

        * **In Terraform:** This is when you write your initial `.tf` files (defining VPCs, EC2 instances, RDS databases, etc.) and run `terraform apply`. Terraform talks to the AWS APIs to build your environment from nothing.
        * **The Outcome:** You get a pristine, known, and version-controlled environment in AWS.

    -   **Repaving (The Lifecycle & Healing)**: **Repaving** is the practice of periodically destroying existing infrastructure and replacing it with a brand-new copy generated from your code.

        > Instead of patching an EC2 instance that has an outdated OS or a misconfigured setting, you kill it and let Terraform/AWS spin up a fresh one. There are two main reasons to repave in AWS:

        -   **Fixing Configuration Drift (Self-Healing)**: If someone logs into the AWS Console and manually changes a security group rule (known as **Configuration Drift**), your infrastructure is no longer in sync with your code.

            * **The Repave:** Running `terraform apply` will detect the manual change and revert the AWS infrastructure back to exactly what is defined in your code.

        -   **Routine Maintenance & Security (Immutable Infrastructure)**: Many advanced engineering teams repave their entire application infrastructure on a schedule (e.g., every week or even every deployment).

            * **The Repave:** Triggering a CI/CD pipeline that runs `terraform destroy` (or uses rolling updates like AWS Auto Scaling Blue/Green deployments) and then `terraform apply`.
            * **Why do this?** It guarantees that no unauthorized changes, malware, or "temporary fixes" survive. If a server is compromised or leaking memory, a repave wipes the slate clean.


    ##### Bastion Host (Jump Box)

    A bastion host is a specially designed server that acts as a secure gateway for accessing private network resources from an external network, typically the internet. It is commonly used in AWS and other cloud environments to provide controlled access to private infrastructure.

    -   **Key Characteristics of a Bastion Host**:

        -   `Publicly Accessible` – The bastion host has a public IP address or is accessible from a trusted external network.
        -   `Hardened Security` – It is configured with strict security policies, such as minimal open ports, strong authentication, and logging.
        -   `Single Entry Point` – Instead of exposing multiple private servers, only the bastion host is exposed, reducing attack surfaces.
        -   `Jump Server` – It serves as an intermediary, allowing users to connect securely to private instances within a **Virtual Private Cloud (VPC)** or **on-premises network**.

    -   **Common Use Cases**:
        -   `Secure Remote Access` – Admins use bastion hosts to access instances in private subnets.
        -   `Limiting Attack Surfaces` – Instead of exposing all private instances, only the bastion host is accessible.
        -   `Audit and Logging` – Activity on the bastion host can be logged for security audits.

    ##### Whitelisting

    A whitelist in AWS refers to a security mechanism where specific IP addresses, CIDR ranges, users, or resources are explicitly allowed access to AWS services while blocking all others. This is commonly used to enhance security by restricting access to only trusted entities.

    -   **Whitelisting IPs in AWS WAF (Web Application Firewall)**:

        -   Protects applications by allowing requests only from approved IPs.
        -   Example: Creating an IP set in AWS WAF for a whitelist.

    -   **Whitelisting Domains in AWS API Gateway**:

        -   Restricts API access to specific domains.
        -   Example: Using CORS (Cross-Origin Resource Sharing) to allow only requests from example.com.

    -   **Whitelisting IAM Users & Roles**:

        -   Allows only specific IAM users, groups, or roles to perform actions on AWS services.
        -   Example: Restricting S3 bucket access to a specific IAM role.

    -   **Whitelisting Email Addresses in Amazon SES**:

        -   Ensures that only approved email senders can send messages.

    ##### Drift

    In AWS WAF, **drift** refers to unintended changes in web ACLs, rules, or rule groups that differ from the expected or deployed configuration. Drift can occur due to manual updates, automated processes, or infrastructure changes outside of IaC tools like AWS CloudFormation. AWS Config can help detect and manage drift in WAF settings.

    -   **How Does Drift Happen in AWS WAF?**:

        1. `Manual Changes`: Someone modifies AWS WAF settings directly via the AWS Management Console, CLI, or SDK instead of using the IaC tool.
        2. `Untracked Updates`: Changes made outside the control of CloudFormation or Terraform, leading to a mismatch between declared and actual state.
        3. `Policy or Rule Updates`: AWS-managed rules may get updated, affecting how requests are evaluated.
        4. `Resource Deletion`: If a WAF rule, ACL, or condition is deleted manually but still referenced in CloudFormation, it results in drift.

    -   **1. AWS CloudFormation Drift Detection**:

        -   If AWS WAF is managed via **CloudFormation**, you can use **Drift Detection** to compare the stack's configuration with the actual state.
        -   Run drift detection:
            ```sh
            aws cloudformation detect-stack-drift --stack-name my-waf-stack
            ```
        -   View drift results in the AWS Management Console under **CloudFormation > Stack Details**.

    -   **2. AWS Config Rules for Compliance**:

        -   AWS Config can track configuration changes in AWS WAF resources.
        -   Set up AWS Config rules to detect drift in WAF ACLs, rules, and policies.

    -   **3. AWS WAF Logging & Monitoring**:

        -   Enable AWS WAF logs to track rule changes over time.
        -   Use **AWS CloudTrail** to audit who made modifications.

    -   **How to Remediate Drift in AWS WAF?**:

        1. `Revert Manual Changes`: If drift is detected, revert the manual changes to match the CloudFormation/Terraform template.
        2. `Update Infrastructure Code`: If changes were intentional, update the CloudFormation stack or Terraform state to reflect the new configuration.
        3. `Use AWS Config Auto-Remediation`: Set up AWS Config auto-remediation to automatically correct drift.

    ##### Stateful vs. Stateless Firewalls

    -   Stateful Firewall (Security Groups): Tracks the state of connections. If an incoming request is allowed, the return traffic is automatically allowed.
    -   Stateless Firewall (Network ACLs): Does not track connections. Rules must explicitly allow both inbound and outbound traffic.

    -   Consider a client connecting to a web server:

        -   Inbound Traffic: Client to Web Server
            -   Source Port: Dynamic high number (e.g., 65123)
            -   Destination Port: 80 (HTTP)
        -   Outbound Traffic: Web Server to Client
            -   Source Port: 80 (HTTP)
            -   Destination Port: Dynamic high number (e.g., 65123)

    -   In a stateful firewall (Security Group): Only an inbound rule for port 80 is needed. Return traffic is automatically allowed.
    -   In a stateless firewall (Network ACL): Both an inbound rule for port 80 and an outbound rule for the dynamic port are needed.

    ##### Provision vs Deploy

    While people often use Deploy and Provision interchangeably in everyday team chatter, they mean distinct stages in the software and cloud lifecycle—especially when working with AWS and Terraform. Here is the cleanest way to think about the difference:

    -   **Provisioning** is setting up the hardware, platforms, and infrastructure.
        -   Example: You are using AWS APIs to spin up a Virtual Private Cloud (VPC), configure Security Groups, provision a MySQL Amazon RDS database, or request an S3 bucket.
    -   **Deploying** is putting your application code, configuration, or software workload onto that infrastructure. Deployment happens after (or on top of) provisioning. It is the process of taking compiled application code, microservices, container images, or server settings and publishing them so they can run.
        -   Example: You push a new version of a Node.js zip file to an AWS Lambda function, perform a rolling update of Docker containers on ECS/EKS using AWS CodeDeploy, or deploy a React build to S3/CloudFront.


    </details>

---

-   <details><summary style="font-size:25px;color:Orange">AWS Identity</summary>

    AWS Identity refers to the **authentication and authorization** framework used in AWS to manage **users, roles, groups, and permissions**. It ensures **secure access control** to AWS resources using various identity management services. AWS provides multiple identity and access management solutions, including **IAM , AWS Organizations, AWS SSO (IAM Identity Center), Cognito, and AWS STS**.

    -   **AWS IAM**: IAM is the core AWS service for managing **users, groups, roles, and policies** that define access permissions.

        -   **IAM Users**: Represents an individual identity in AWS (e.g., a developer or administrator).

            -   Can be assigned **access keys** and **passwords** for authentication.
            -   Can have **permissions** defined by **IAM policies**.

        -   **IAM Groups**: A collection of **IAM users** that share the same permissions.
        -   **IAM Roles**: A temporary identity assigned to **AWS services or external users**.
        -   **IAM Policies**: Policies are attached to **users, groups, or roles** to control access.
        -   **IAM Authentication Methods**:
            -   **Access Keys** → Used for programmatic access (e.g., AWS CLI, SDKs).
            -   **Password** → Used for AWS Management Console login.
            -   **MFA (Multi-Factor Authentication)** → Enhances security by requiring an additional authentication step (e.g., TOTP, SMS, hardware MFA).

    -   **AWS Organizations**: AWS Organizations is a service for managing **multiple AWS accounts centrally**. It enables:

        -   **Consolidated Billing**

            -   Allows all accounts under the organization to share a single billing method.

        -   **Service Control Policies (SCPs)**

            -   Organization-wide policies that restrict permissions across all AWS accounts.
            -   Example: Preventing any user from deleting S3 buckets across all accounts.

        -   **Account Management**
            -   Enables grouping AWS accounts into **Organizational Units (OUs)**.
            -   Example: Separating accounts for **Development, Testing, and Production**.

    -   **AWS IAM Identity Center (Formerly AWS SSO)**: IAM Identity Center provides **single sign-on (SSO)** access to AWS accounts and business applications.

        -   **Centralized User Management**: Users log in once and gain access to **multiple AWS accounts** and **third-party applications**.
        -   **Integration with Active Directory (AD) & External Identity Providers**: Supports **Microsoft AD, Okta, Google Workspace, and SAML 2.0 providers**.

    -   **AWS Cognito**: AWS Cognito is a managed identity service for **user authentication** in web and mobile applications.

        -   **User Pools** → Used for managing authentication (e.g., sign-up, sign-in, and user profiles).
        -   **Identity Pools** → Grants temporary AWS credentials to authenticated users.
        -   **Federation Support** → Supports **Google, Facebook, Apple, and SAML authentication**.
        -   **Example**: A mobile app authenticates users via Cognito and grants them access to an S3 bucket.

    -   **AWS STS (Security Token Service)**: AWS STS issues **temporary credentials** for users and applications.

        -   **Federated Access**: Allows external users (e.g., from Active Directory) to assume AWS roles.

        -   **Assume Role**: Enables cross-account access without sharing permanent credentials.

        -   **Session Tokens**: Temporary credentials expire after a configurable duration (e.g., 1 hour).

        Example: An **on-premises developer assumes an IAM role** to access an AWS account securely.

    #### Federated User in AWS

    A **federated user** in AWS refers to a user who does not have a permanent IAM user account in an AWS account but **gains temporary access** through an external identity provider (IdP), such as **Active Directory, Okta, Google Workspace, or AWS IAM Identity Center (formerly AWS SSO)**.

    -   **How It Works**:

        1. **User Authentication via IdP**:
            - The user logs in through an external identity provider (e.g., Active Directory, Okta, or a corporate SSO system).
        2. **Federation with AWS STS (Security Token Service)**:
            - The identity provider validates the user and provides authentication tokens (SAML, OIDC, or AWS Cognito tokens).
            - AWS STS issues **temporary security credentials** with specific permissions.
        3. **Access to AWS Resources**:
            - The federated user can then interact with AWS services just like an IAM user but without a long-term IAM user account.

    -   **Key Benefits of Federated Users**:

        1. **No need to create IAM users for every employee.**
        2. **Enhances security** by avoiding static IAM credentials.
        3. **Supports single sign-on (SSO)** for seamless access across cloud and on-prem systems.
        4. **Reduces management overhead** by leveraging corporate identity systems.

    -   **Common Federation Methods in AWS**:

        1. **SAML Federation (Enterprise SSO)**
            - Example: Use **Active Directory (ADFS), Okta, or Google Workspace** to authenticate users and grant AWS access.
            - AWS STS issues temporary credentials for IAM roles mapped to the SAML assertion.
        2. **OIDC Federation (Web & Mobile Apps)**

            - Example: Use **Amazon Cognito, Google, or Facebook** as an OIDC IdP to authenticate users.
            - Commonly used in mobile/web apps that need access to AWS resources.

        3. **AWS IAM Identity Center (Formerly AWS SSO)**
            - Centralized access management across multiple AWS accounts.
            - Supports integration with external identity providers.

    -   **Example: SAML Federation Process**

        -   **User logs into Okta (or another IdP).**
        -   **Okta generates a SAML assertion with AWS role mappings.**
        -   **User is redirected to AWS with a SAML token.**
        -   **AWS STS assumes an IAM role and issues temporary credentials.**
        -   **User accesses AWS services (e.g., S3, EC2) with the temporary credentials.**

    -   **Example: Assume Role for a Federated User via AWS CLI**

        ```sh
        aws sts assume-role-with-saml \
            --role-arn arn:aws:iam::123456789012:role/FederatedAccessRole \
            --principal-arn arn:aws:iam::123456789012:saml-provider/Okta \
            --saml-assertion file://saml_response.xml
        ```

    -   **Use Case Scenarios**

        -   **Enterprise users accessing AWS via Okta/ADFS**
        -   **Developers using Google authentication for an AWS-hosted app**
        -   **Employees accessing AWS via AWS IAM Identity Center**

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Tags & Tagging Strategy</summary>

    AWS tags are the "metadata backbone" of your cloud infrastructure. They are simple key-value pairs that help you manage, identify, organize, search, and filter resources. As of 2026, tagging has evolved from a simple "labeling" task to a critical component of **Attribute-Based Access Control (ABAC)** and **FinOps** (Cost Optimization).

    1. **Core Facts & Technical Quotas**: These are the hard rules that apply to almost every AWS service:

        - **Max Tags per Resource:** You can assign a maximum of **50 user-defined tags** to a single resource.
        - **Case Sensitivity:** Tags are **case-sensitive**. `Environment=Prod` and `environment=prod` are treated as two entirely different tags.
        - **Character Limits:**
        - **Keys:** Maximum 128 Unicode characters.
        - **Values:** Maximum 256 Unicode characters.

        - **Reserved Prefix:** The prefix **`aws:`** is strictly reserved for AWS internal use. You cannot create, edit, or delete tags starting with this prefix (e.g., `aws:cloudformation:stack-name`).
        - **Allowed Characters:** Letters, numbers, spaces, and the following symbols: `_ . : / = + - @`.

    2. **Key Limitations & Warning Notes**: Even though tags are flexible, they have specific architectural boundaries:

        - **No PII/Sensitive Data:** Tags are not encrypted and are visible in many API calls (e.g., `DescribeTags`) and billing reports. **Never** put passwords, secrets, or Personally Identifiable Information (PII) in tag values.
        - **Latency in Propagation:** While tagging is generally fast, it is **asynchronously applied**. When you tag a resource, it may take a few seconds or even minutes to reflect in the Billing Console or Resource Groups.
        - **Not All Resources Support Tagging:** While 95%+ of AWS resources support tags, some older or specialized resources (like certain legacy network interfaces or specific IoT components) may not.
        - **"Invisible" Untagged Resources:** If a resource has never been tagged, it will not appear in "Non-compliant" reports for Tag Policies. You must use **Service Control Policies (SCPs)** to prevent the creation of untagged resources in the first place.

    3. **The 4 Pillars of Tagging Strategy**: A professional tagging strategy categorizes labels into four distinct buckets to serve different stakeholders.

        | Category       | Purpose                                              | Example Keys                                    |
        | -------------- | ---------------------------------------------------- | ----------------------------------------------- |
        | **Technical**  | Identify the application, environment, or version.   | `AppID`, `Env` (Dev/Prod), `Version`            |
        | **Business**   | Track costs and assign financial accountability.     | `CostCenter`, `BusinessUnit`, `Project`         |
        | **Security**   | Control access (ABAC) and data classification.       | `DataConfidentiality`, `Compliance` (PCI/HIPAA) |
        | **Automation** | Trigger automated actions like backups or shutdowns. | `OptOut-AutoStop`, `BackupSchedule`             |

    4. **Advanced Features (New in 2025/2026)**

        - **Attribute-Based Access Control (ABAC)**: ABAC is a major shift from traditional IAM. Instead of writing a policy for every user, you write one policy that says: _"Allow users to access resources only if the user's `Project` tag matches the resource's `Project` tag."_

            - **S3 ABAC (Recent Update):** As of late 2025, S3 now fully supports native ABAC, allowing you to govern access to millions of objects via bucket and user tags rather than complex bucket policies.

        - **Tag Policies (AWS Organizations)**: You can enforce "Tag Governance" across your entire organization.

            - **Standardization:** Forces a specific case (e.g., only `CostCenter`, not `costcenter`).
            - **Compliance Reports:** Generates a list of all resources across all accounts that violate your naming standards.

    5. **Best Practices Checklist**

        - **Use Lowercase with Hyphens:** While CamelCase is popular, many DevOps teams prefer `my-org:cost-center` to avoid case-sensitivity mistakes.
        - **Standardize Prefixes:** Use a company prefix (e.g., `corp:env`) to distinguish your tags from AWS-generated ones.
        - **Automate via IaC:** Never manually tag in the console. Define your tags in **Terraform**, **CloudFormation**, or **Pulumi** to ensure 100% coverage.
        - **Compound Tags:** If you are hitting the 50-tag limit, use a "compound value" like `Contact=Name:John|Email:j@corp.com`.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">CloudFormation</summary>

    > AWS CloudFormation is AWS’s native **Infrastructure as Code (IaC)** engine. It turns declarative configuration files into live, managed cloud infrastructure—handling API ordering, dependency graphs, rollbacks, and state management automatically.

    1. **Core Architecture & Mental Model**: Think of CloudFormation as a **3-tier hierarchy**:

        * **Template (The Blueprint)**: A JSON or YAML document defining *what* you want.
        * **Stack (The Container)**: A logical grouping of resources deployed and lifecycle-managed as a single unit.
        * **Resources (The Assets)**: The actual AWS components (S3 buckets, EC2 instances, IAM roles) spun up in your account.

        ```
            [ Template (JSON/YAML) ]
                        │
                        ▼
            [ CloudFormation Engine ]
                        │
        ┌───────────────┼───────────────┐
        ▼               ▼               ▼
        [ Stack A ]   [ Stack B ]    [ Stack Set ]
        (Dev)         (Prod)     (Multi-Account)

        ```

    2. **Anatomy of a Template**: A CloudFormation template consists of nine main sections, though only `Resources` is strictly required.

        ```yaml
        AWSTemplateFormatVersion: "2010-09-09" # Version lock
        Description: "Production Multi-AZ Architecture"

        Parameters:    # Dynamic inputs passed at deploy time
        Mappings:       # Static lookup tables (e.g., AMI IDs by Region)
        Conditions:     # Logical flags to toggle resources on/off
        Transform:      # Macros / Serverless Application Model (SAM) extensions

        Resources:      # REQUIRED: The infrastructure components
        Outputs:        # Values exported or returned after deployment
        Metadata:       # Extra UI or configuration instructions
        Rules:          # Validation rules for parameters
        ```

        -   **Detailed Section Breakdown**:

            | Section        | What it Does                                                         | Common Use Case                                                       |
            | -------------- | -------------------------------------------------------------------- | --------------------------------------------------------------------- |
            | **Parameters** | Accepts input values before deployment without modifying the code.   | Passing DB instance classes or environment names (`dev`, `prod`).     |
            | **Mappings**   | Static key-value dictionaries evaluated via `Fn::FindInMap`.         | Mapping region names (`us-east-1`, `eu-west-1`) to specific AMI IDs.  |
            | **Conditions** | Evaluates `true`/`false` expressions (`Fn::If`, `Fn::Equals`).       | Creating a Bastion host only when `Environment == 'prod'`.            |
            | **Resources**  | Defines AWS objects, their properties, and relationships.            | Declaring `AWS::EC2::Instance` or `AWS::DynamoDB::Table`.             |
            | **Outputs**    | Returns values (e.g., Subnet IDs, S3 ARNs) and optional **Exports**. | Exposing a VPC ID so independent stacks can import it.                |
            | **Transform**  | Invokes CloudFormation Macros to preprocess the code.                | Expanding `AWS::Serverless-2016-10-31` (SAM) into standard templates. |

    3. **Operational Concepts & Stack Management**:

        -   **Change Sets**: Before modifying running infrastructure, CloudFormation generates a **Change Set** (similar to `terraform plan`). It shows exactly which resources will be created, modified, or deleted without executing the change immediately.

        -   **Drift Detection**: Over time, resources managed by a stack might be modified manually via the AWS Console or CLI. **Drift Detection** compares the current live state of your AWS resources against the expected state declared in the template, flagging any property discrepancies.

        -   **Stack Operations**:

            * **Nested Stacks:** Stacks created inside other stacks using the `AWS::CloudFormation::Stack` resource. They break down large architectures into reusable modular components (e.g., standard VPC stack + App stack).
            * **Cross-Stack References:** Sharing resources between standalone stacks using `Export` in the source stack's `Outputs` and `Fn::ImportValue` in the target stack.
            * **StackSets:** Extends stack management across **multiple AWS accounts and Regions** from a single central administration stack. Ideal for organizational security baselines or multi-region deployments.

    4. **Intrinsic Functions & Pseudo Parameters**: CloudFormation provides built-in functions to dynamicize templates:

        -   **Essential Intrinsic Functions**:

            * **`Ref`**: Returns the value of a Parameter or the primary identifier of a Resource (e.g., an Instance ID or Bucket Name).
            * **`Fn::GetAtt`**: Retrieves a specific attribute from a resource (e.g., `Fn::GetAtt: [ MyALB, DNSName ]`).
            * **`Fn::Join`**: Concatenates a set of values with a delimiter (e.g., `Fn::Join: [ "-", [ "app", !Ref Environment ] ]`).
            * **`Fn::Sub`**: Substitutes variables in a string (e.g., `!Sub "arn:aws:s3:::my-bucket-${AWS::AccountId}"`).
            * **`Fn::ImportValue`**: Imports a value exported by another stack.

        -   **Pseudo Parameters**: Predefined parameters provided by AWS that resolve at execution time:

            * `AWS::AccountId` — The 12-digit AWS account ID running the stack.
            * `AWS::Region` — The AWS region (e.g., `us-east-1`).
            * `AWS::StackId` / `AWS::StackName` — Unique ID and user-assigned name of the active stack.
            * `AWS::NoValue` — Acts as an unassigned property value (useful inside conditional logical blocks to omit optional properties).

    5. **Advanced Mechanics: Lifecycle & Extensibility**:

        -   **Stack Policies**: A JSON document applied directly to a stack that prevents accidental updates or deletions to critical resources (e.g., protecting production RDS databases from being replaced).

            ```json
            {
                "Statement" : [
                    {
                        "Effect" : "Allow",
                        "Action" : "Update:*",
                        "Principal": "*",
                        "Resource" : "*"
                    },
                    {
                        "Effect" : "Deny",
                        "Action" : ["Update:Replace", "Update:Delete"],
                        "Principal": "*",
                        "Resource" : "LogicalResourceId/ProductionDatabase"
                    }
                ]
            }
            ```
        -   **Custom Resources**: When CloudFormation doesn't natively support an AWS feature or third-party service, a **Custom Resource** delegates provisioning logic to an AWS Lambda function or SNS topic via a custom HTTP webhook protocol.
        -   **CloudFormation Registry & Modules**:
            * **Resource Providers:** Custom resource types written using the CloudFormation CLI (cfn-cli) to manage non-AWS or third-party SaaS resources (e.g., Datadog monitors, GitHub repos).
            * **Modules:** Reusable, packaged template fragments that standardize resource configurations across an enterprise.

    6. **Export Cloudformation Stack**: Depending on what you are trying to accomplish with "export AWS CloudFormation stack," here are the three primary contexts:

        1. **Export Output Values to Share Between Stacks or IaC (Terraform)**: To make a resource output (like a VPC ID or Security Group ID) available to other CloudFormation stacks or Terraform data sources, add an `Export` block inside the template's `Outputs` section.

            -   **YAML Syntax Example**:

                ```yaml
                Outputs:
                VpcIdOutput:
                    Description: "The ID of the primary VPC"
                    Value: !Ref MyVPC
                    Export:
                    Name: "ProductionVpcId"  # This is the exported name key
                ```

            -   **Consuming the Exported Value**:

                * **In another CloudFormation Stack:**
                Use the `Fn::ImportValue` intrinsic function:
                ```yaml
                Resources:
                MySubnet:
                    Type: AWS::EC2::Subnet
                    Properties:
                    VpcId: !ImportValue ProductionVpcId
                    CidrBlock: "10.0.1.0/24"
                ```


                * **In Terraform:**
                Use the `aws_cloudformation_export` data source:
                ```hcl
                data "aws_cloudformation_export" "vpc_id" {
                name = "ProductionVpcId"
                }

                resource "aws_subnet" "example" {
                vpc_id     = data.aws_cloudformation_export.vpc_id.value
                cidr_block = "10.0.1.0/24"
                }
                ```
        2. **Export / Download the Stack Template**: If you want to extract the underlying JSON or YAML template of an already deployed stack:

            -   **AWS CLI**:

                ```bash
                aws cloudformation get-template \
                --stack-name YourStackName \
                --query "TemplateBody" \
                --output text > template.yaml

                ```

            -   **AWS Management Console**:

                1. Open the **CloudFormation Console**.
                2. Select your stack from the **Stacks** list.
                3. Click the **Template** tab.
                4. Click **View in Designer** or select **Download template**.
        3. **List All Active Exports in an Account / Region**: To view all available exports created across your stacks in a specific AWS account and region:

            -   **AWS CLI**:

                ```bash
                aws cloudformation list-exports --region us-east-1
                ```

            -   **Output Example**:

                ```json
                {
                    "Exports": [
                        {
                            "ExportingStackId": "arn:aws:cloudformation:us-east-1:123456789012:stack/VpcStack/...",
                            "Name": "ProductionVpcId",
                            "Value": "vpc-0a1b2c3d4e5f6g7h8"
                        }
                    ]
                }
            ```

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Trust Store</summary>

    > The AWS Trust Store is a centralized repository of trusted certificates that allows AWS services to verify the identity of clients and servers during secure communication. It plays a crucial role in establishing secure connections using protocols like **Transport Layer Security** (TLS) and **mutual TLS** (mTLS).

    ### Core Concepts

    -   **Certificate Authority (CA) Certificates:** A trust store primarily contains CA certificates. These are digital certificates issued by trusted entities (CAs) that vouch for the identity of other certificates.
    -   **Trust Anchor:** The CA certificates within a trust store act as trust anchors. If a server or client presents a certificate that is directly signed by a CA in the trust store, or by a certificate in a chain leading back to a trusted CA, its identity can be verified.
    -   **Mutual TLS (mTLS):** The trust store is fundamental for enabling mTLS, a process where both the client and the server authenticate each other by presenting and verifying digital certificates. This ensures that both parties in a communication are who they claim to be.
    -   **Certificate Revocation Lists (CRLs):** Optionally, a trust store can include CRLs. These are lists of digital certificates that have been revoked by the issuing CA and should no longer be trusted. Including CRLs enhances the security of mTLS by ensuring that compromised certificates are not accepted.

    ### AWS Services Utilizing Trust Stores

    Several AWS services leverage the Trust Store to facilitate secure communication:

    -   **Elastic Load Balancing (ELB):** Application Load Balancers (ALBs) use trust stores to perform mTLS authentication with clients. You can upload CA certificate bundles to a trust store and associate it with an HTTPS listener on your ALB. The ALB then verifies client certificates against the CAs in the trust store. It can operate in two modes:
        -   **Verify Mode:** The ALB authenticates the client. Only if the client's certificate is valid and trusted, the request is forwarded to the backend.
        -   **Passthrough Mode:** The ALB forwards the client's certificate chain to the backend applications via HTTP headers, allowing the applications to handle the authentication.
    -   **Amazon WorkSpaces Web:** This service allows you to create secure web portals. You can associate a trust store with a web portal so that the browser in a streaming session recognizes certificates issued by the CAs in the trust store. This is particularly useful for accessing internal websites that use certificates from private CAs.
    -   **AWS IoT SiteWise Edge:** When configuring HTTPS proxies for AWS IoT SiteWise Edge components, you need to add the proxy server's certificate to the appropriate trust stores used by these components. Different components (like the Greengrass Core component or Java-based components) might use different trust stores.

    ### Managing AWS Trust Stores

    The management of AWS Trust Stores involves several key operations:

    -   **Creating a Trust Store:** You can create a trust store using the AWS Management Console, AWS Command Line Interface (CLI), or AWS SDKs. When creating a trust store, you typically provide a name for it.
    -   **Uploading CA Certificates:** You upload CA certificate bundles (usually in PEM format) to the trust store. For Application Load Balancers, you upload these as a batch; individual certificate uploads are not supported.
    -   **Adding Certificate Revocation Lists (CRLs):** If you want to perform revocation checks during mTLS, you can upload CRLs (in PEM format for ALBs) to the trust store.
    -   **Updating a Trust Store:** You can replace the existing CA certificate bundle or add/remove CRLs in a trust store after its creation. For ALBs, replacing the CA bundle is done via the `ModifyTrustStore` API.
    -   **Associating with Resources:** Once created, you associate the trust store with the AWS resources that will use it. For example, with an HTTPS listener on an Application Load Balancer or with an Amazon WorkSpaces Web portal.
    -   **Sharing Trust Stores:** For Application Load Balancers, you can use AWS Resource Access Manager (AWS RAM) to securely share your trust store resources across different AWS accounts or within your AWS Organization. The account owning the trust store (owner) can share it with other AWS accounts (consumers). Consumers can then use the shared trust store with their load balancers.
    -   **Listing Trust Stores and Certificates:** You can list the trust stores in your account and the certificates within a specific trust store using the AWS Management Console or the AWS CLI.
    -   **Deleting a Trust Store:** You can delete a trust store if it is no longer associated with any resources. For Application Load Balancers, you need to delete all associations before you can delete the trust store itself.

    ### Security Considerations

    -   **Protecting Private Keys:** While the trust store itself contains public CA certificates and optional CRLs, it's crucial to securely manage the private keys associated with the server and client certificates used in mTLS. AWS Certificate Manager (ACM) can help manage the lifecycle and security of TLS certificates. Note that for importing certificates into ACM, you need to provide both the certificate and its private key.
    -   **Regular Updates:** It's important to keep the CA certificates in your trust store up-to-date. CAs may issue new root or intermediate certificates, and you'll need to update your trust store to maintain trust.
    -   **Certificate Revocation:** If client certificates are compromised, ensure that the corresponding CRLs are updated in the trust store (if your service supports and is configured to use them) to prevent unauthorized access.
    -   **Permissions:** Control access to creating, modifying, and deleting trust stores and their associations using AWS Identity and Access Management (IAM) policies.

    ### Enabling Mutual TLS with Trust Stores

    The AWS Elastic Load Balancer (ELB), specifically the Application Load Balancer (ALB), leverages the AWS Trust Store to facilitate **mutual TLS (mTLS)** authentication between clients and the load balancer. Here's a detailed explanation of how this works:
    When you configure an HTTPS listener on an ALB, you have the option to enable mTLS. To do this with client certificate verification, you need to associate a Trust Store with the listener. The Trust Store acts as a repository of trusted Certificate Authority (CA) certificates.

    1.  **Create a Trust Store:** You create a Trust Store using the AWS Management Console, CLI, or SDKs. When creating it, you provide a name and upload a bundle of CA certificates in PEM format to an Amazon S3 bucket. You then specify the S3 URI of this bundle when creating the Trust Store. Optionally, you can also upload Certificate Revocation Lists (CRLs) to an S3 bucket and associate them with the Trust Store.
    2.  **Associate with an HTTPS Listener:** You associate the created Trust Store with an HTTPS listener on your ALB. When configuring the listener, you'll specify that you want to "Verify" client certificates and select the ARN (Amazon Resource Name) of the Trust Store you created.
    3.  **Client Authentication:** When a client initiates a TLS handshake with the ALB, the ALB presents its server certificate. If mTLS is configured with "Verify" mode, the ALB will also request a client certificate.
    4.  **Verification against the Trust Store:** The ALB then verifies the client's certificate against the CA certificates present in the associated Trust Store. This involves checking if the client certificate was signed by one of the trusted CAs or by a certificate in a valid chain leading back to a trusted CA in the Trust Store. If CRLs are associated with the Trust Store, the ALB can also check if the client certificate has been revoked.
    5.  **Authentication Outcome:**
        -   **Success:** If the client's certificate is valid and trusted (signed by a CA in the Trust Store and not revoked, if CRL checking is enabled), the TLS connection is established. The ALB can then forward the request to the backend targets.
        -   **Failure:** If the client's certificate is invalid or not trusted, the ALB will reject the TLS connection.

    ### Modes of mTLS on ALB

    The ALB offers two modes for handling client certificates:

    -   **Verify Mode:** This is where the Trust Store plays a direct role. The ALB actively verifies the client's certificate against the CAs in the Trust Store. Only successfully authenticated clients are allowed to proceed.
    -   **Passthrough Mode:** In this mode, the ALB does not perform the client certificate verification itself. Instead, it forwards the entire client certificate chain to the backend applications via HTTP headers (e.g., `X-Amzn-Mtls-Clientcert`). The backend applications are then responsible for performing their own client certificate validation and authentication logic. In this mode, a Trust Store is not directly used by the ALB for verification.

    ### Benefits of Using Trust Stores with ALB for mTLS

    -   **Centralized Trust Management:** Trust Stores provide a central place to manage trusted CA certificates for client authentication across multiple ALBs.
    -   **Simplified Configuration:** Instead of configuring trust on each backend instance, you manage it at the load balancer level.
    -   **Scalability:** The ALB handles the TLS handshake and client authentication, offloading this processing from your backend applications, which can improve their scalability.
    -   **Enhanced Security:** By verifying client certificates at the load balancer, you can ensure that only authenticated and authorized clients can access your applications.
    -   **Revocation Management:** Trust Stores can include CRLs, allowing you to revoke access for compromised client certificates.
    -   **Cross-Account Sharing:** You can share Trust Stores across different AWS accounts within your organization using AWS Resource Access Manager (RAM), enabling consistent mTLS configurations.

    ### Managing Trust Stores for ELB

    -   You can create, update (replace CA bundles, add/remove CRLs), list, and delete Trust Stores.
    -   For updating CA certificates, you typically upload a new bundle to S3 and then update the Trust Store to point to the new S3 URI.
    -   Before deleting a Trust Store, you must ensure it is not associated with any ALB listeners.
    -   You can monitor the status and details of your Trust Stores in the AWS Management Console.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">AWS Organization</summary>

    AWS Organizations is a foundational service for any large-scale AWS environment. Here is a vivid, detailed breakdown of its core components, resources, and features.

    #### Core Components and Resources of AWS Organizations

    These are the fundamental building blocks that form the hierarchical structure of your multi-account environment.

    | Component / Resource         | Description                                                                                                                                        | Vivid Detail                                                                                                                                                                                                                                                       |
    | :--------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
    | **Organization**             | The top-level entity that is a collection of all your AWS accounts.                                                                                | This is the **entire legal entity** or company structure, acting as the root container for everything else. It defines the central administrative boundary.                                                                                                        |
    | **Root**                     | The parent container for all accounts in the organization, automatically created when you create the organization.                                 | This is the **apex of the inverted tree structure**. Any policy attached directly to the Root applies as a maximum permission guardrail to _every single account_ in the Organization.                                                                             |
    | **Organizational Unit (OU)** | A container that you can use to group accounts together to manage them as a single unit.                                                           | Think of OUs as **folders in a filing cabinet**. You group accounts by function (e.g., Security, Infrastructure), environment (e.g., Development, Production), or business unit. This is the key to scalable governance. OUs can also contain other OUs (nesting). |
    | **Management Account**       | The single account that creates and manages the organization, controls consolidated billing, and acts as the central administrator for governance. | This is the **CEO and CFO account**. It holds the master bill and is immune to Service Control Policies (SCPs) applied within the organization, giving it ultimate power to administer the entire structure. **Crucially, it is the payer account.**               |
    | **Member Account**           | All other AWS accounts that are part of the organization, holding your actual workloads and resources.                                             | These are the **Worker Bee accounts**—hosting your EC2 instances, S3 buckets, databases, and applications. They are governed by the policies inherited from their parent OUs and the Root.                                                                         |
    | **Policy**                   | An object that, when attached to an entity (Root, OU, or Account), controls access to AWS services.                                                | These are the **Organizational Rules and Laws**. They flow down the hierarchy, defining boundaries and guardrails. The most common type is the **Service Control Policy (SCP)**.                                                                                   |

    #### Key Governance and Management Features

    AWS Organizations provides powerful features to simplify governance, security, and financial management across all your accounts.

    1. **Centralized Governance with Service Control Policies (SCPs)**:

        - **What it is:** SCPs are JSON policies that provide **centralized control** over the maximum available permissions for all IAM users and roles in your member accounts, _including the member account's root user_.
        - **Vivid Detail:** SCPs act as **non-negotiable security guardrails** at the organizational level. They are **filters**, not granters of permissions. If an SCP _denies_ an action, no IAM policy in the member account can override that denial, ensuring consistent compliance across the entire organization. For example, you can deny the use of a specific, expensive AWS service in all Development accounts.

        - **Service Control Policies (SCPs):** These define the maximum permissions for member accounts. Even if an IAM user has "Full Administrator" access, an SCP can explicitly deny them access to specific services (e.g., preventing them from leaving a specific region).
        - **Tag Policies:** Enforce standardized tagging across resources to ensure cost tracking and automation work correctly.
        - **Backup Policies:** Centrally manage and enforce backup plans across all accounts using AWS Backup.
        - **AI Services Opt-out:** Control whether AWS AI services can use your data for model improvement.
        - **Upgrade Rollout Policies:** (Latest feature) Systematically manage and stagger automatic minor version upgrades for RDS and Aurora databases across your fleet.


    2. **Consolidated Billing and Cost Management**:

        - **What it is:** The Management Account handles payment for all member accounts, and all charges are aggregated into a single monthly bill.
        - **Vivid Detail:** This feature is the **Financial Hub**. It doesn't just simplify payments; it allows all accounts to benefit from **volume discounts** (tiered pricing) and **Reserved Instance/Savings Plan sharing** across the entire organization, leading to significant cost optimization. You can also use the hierarchy (OUs and accounts) to break down and allocate costs to specific teams or projects.

        - **Consolidated Billing:** You receive a single bill for all accounts in the organization.
        - **Volume Discounts:** AWS treats all accounts as one for the purposes of volume-based pricing tiers (e.g., S3 storage costs), often resulting in significant savings.

    3. **Account Management and Provisioning**:

        - **What it is:** The ability to programmatically create new accounts directly within the organization or invite existing accounts to join.
        - **Vivid Detail:** AWS Organizations offers a simplified API for **"account vending."** Instead of manually creating accounts and applying baseline settings, you can automate the process, ensuring new accounts are born compliant and immediately subject to the organization's policies (SCPs).

        - **Trusted Access:** Allows AWS services (like CloudTrail, Config, or GuardDuty) to perform tasks across all accounts in your organization automatically.
        - **Delegated Administration:** Assign a member account as the "administrator" for a specific service (e.g., making a Security account the admin for Amazon GuardDuty), so you don't have to use the Management account for daily security tasks.

    4. **Integration with AWS Services (Trusted Access)**:

        - **What it is:** The ability to enable other AWS services (like AWS Config, AWS CloudTrail, AWS GuardDuty) to act as a **Delegated Administrator** on behalf of the organization.
        - **Vivid Detail:** This is how you achieve **Organization-Wide Visibility and Enforcement**. For instance, you can designate an account (often the "Security" account) to centralize all **AWS CloudTrail logs** from every member account, creating an immutable, organization-wide audit trail for security review.

    5. **Policy Inheritance**:

        - **What it is:** Policies attached to the Root or an OU automatically apply to all OUs and accounts beneath them in the hierarchy.
        - **Vivid Detail:** This is the **cascading effect of governance**. A policy attached to the "Production" OU immediately affects all Production-related accounts inside it. This radically simplifies policy management—you set the rule once at a high level, and it enforces itself down to hundreds of individual accounts.

    -   **Other Types of Policies**: While SCPs are the most common, AWS Organizations supports other policy types to enforce different organizational standards:

        | Policy Type                      | Purpose                                                                                                                          | How it Works                                                                                                                                                                   |
        | :------------------------------- | :------------------------------------------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
        | **Tag Policies**                 | Enforce consistent tagging rules across all resources in your accounts.                                                          | Define required tag keys (e.g., `Project`, `Environment`) and their permitted values (e.g., `Prod`, `Dev`), preventing non-compliant resources from being created or modified. |
        | **Backup Policies**              | Centrally manage and automate data protection (backup) plans.                                                                    | Define backup schedules, retention periods, and target AWS Backup vaults, ensuring compliance for all resources in your organization without individual account configuration. |
        | **AI services opt-out policies** | Control whether AI services (like Amazon Sagemaker, Amazon Comprehend) can store and use your content to improve their services. | Provides a centralized way to manage privacy and data residency requirements for your machine learning and AI workloads.                                                       |

    #### Recommended Foundational OU Structure

    This structure ensures that the highest-priority concerns—security, logging, and core networking—are isolated and centrally managed.

    1. **Root**:

        - **Purpose:** The very top of the hierarchy.
        - **Key Policy:** Attached SCPs here should be extremely broad, ensuring mandatory security baselines apply to _all_ accounts. This is where you might **deny root user access** for daily operations or **restrict access to unused global regions** for compliance and cost control.
        - **Accounts:** Contains the **Management Account** (Payer/Organization Admin) and often the **Service Control Policy Staging Account** (used to test SCP changes).

    2. **Security OU**:

        - **Purpose:** Centralizes all logging, security monitoring, and auditing functions. This OU is crucial for compliance.
        - **Key Policy:** Highly restrictive SCPs to protect log immutability and prevent any account from turning off security services.
        - **Key Accounts:**
            - **Log Archive Account:** A highly restricted, read-only account dedicated to storing immutable, aggregated AWS CloudTrail logs, AWS Config history, and VPC flow logs from every account in the organization.
            - **Security Tooling/Audit Account:** The delegated administrator account for services like AWS GuardDuty, AWS Security Hub, Amazon Macie, and AWS Config. This is where security staff gain cross-account access to perform audits and incident response.

    3. **Infrastructure OU**:
        - **Purpose:** Houses critical shared services that all or many workload accounts rely on.
        - **Key Policy:** Moderate SCPs that ensure only approved centralized services can be deployed.
        - **Key Accounts:**
            - **Network Account:** Centralizes shared networking infrastructure, such as AWS Transit Gateway, AWS Direct Connect connections, and centralized DNS via Amazon Route 53 Resolver.
            - **Shared Services Account:** Hosts centralized deployment tools (CI/CD pipelines), corporate directory services (AWS Managed Microsoft AD or IAM Identity Center), and golden AMI/Docker image pipelines.

    #### Workload and Experimental OUs

    These OUs house the actual applications and allow development teams to operate with the appropriate level of freedom and governance.

    | OU Name                          | Purpose                                                                                  | Recommended Policy Control (SCPs)                                                                                                                                               | Key Accounts                                                |
    | :------------------------------- | :-------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :---------------------------------------------------------- |
    | **Workloads OU**                 | Groups accounts based on the Software Development Lifecycle (SDLC).                     | Policies differ based on environment (see nested OUs below).                                                                                                                    | All business-critical applications (e.g., e-commerce, ERP). |
    | _Nested:_ **Production OU**      | Hosts live, customer-facing applications.                                               | **Tightest controls:** Deny high-risk actions, enforce tagging for cost/compliance, and require specific instance types/regions.                                                | `AppA-Prod`, `AppB-Prod`                                    |
    | _Nested:_ **SDLC (Dev/Test) OU** | Hosts pre-production environments (Dev, QA, Staging).                                   | **Looser controls:** Allow developers freedom to experiment, but still enforce cost-management guardrails.                                                                      | `AppA-Dev`, `AppB-Test`                                     |
    | **Sandbox OU**                   | Provides a safe, isolated, and disposable environment for experimentation and learning. | **Strictly enforced budget/time limits:** SCPs that prevent expensive service usage and possibly an automated cleanup tool (e.g., AWS Nuke) triggered by time or budget limits. | `Engineer-X-Sandbox`                                        |
    | **Suspended OU**                 | A holding area for accounts that are closed or retired, prior to final deletion.        | **Deny All SCP:** A policy that denies all actions to prevent any resources from being launched or accessed while the account is suspended.                                     | `Old-Project-Account`                                       |

    -   **Key Best Practices**:

        1.  **Policy Target:** **Always attach Service Control Policies (SCPs) to the OUs, not individual accounts,** unless a specific account is a true exception. This maintains scalability and simplifies troubleshooting.
        2.  **OU Design:** Group accounts based on the **commonality of their applied policies.** If two accounts need the exact same SCPs, put them in the same OU.
        3.  **Isolation:** Use OUs to enforce **blast radius reduction.** By separating Production, Security, and Development, you ensure a breach in a Dev account cannot impact your sensitive Log Archive account.
        4.  **Least Privilege:** Use **Delegated Administrator** to assign security and auditing tasks to the _Security Tooling Account_, limiting the need to use the highly privileged Management Account for daily operations.

    Do you have a specific business requirement, like HIPAA compliance or a large number of development teams, that you'd like to see mapped to this structure?

    </details>

--- 

-   <details><summary style="font-size:25px;color:Orange">AWS Key Management Service (KMS)</summary>


    > AWS Key Management Service (KMS) is a managed service that makes it easy to create and control the cryptographic keys used to protect your data. It uses Hardware Security Modules (HSMs) to protect the security of your keys.


    1. **Core Concepts and Components**: Understanding KMS starts with the hierarchy of how keys are structured and managed.

        -   **AWS KMS Keys (KMS Keys)**: The primary resource in KMS. A KMS key is a logical representation of a cryptographic key. It contains metadata (key ID, creation date, description, state) and a reference to the **Key Material** used for cryptographic operations.

            * **Customer Master Key (CMK):** This is the older term for a KMS key. While the console now just uses "KMS Key," you will still see CMK in documentation.
            * **Backing Key:** This is the actual library of bytes used for encryption, stored securely within the HSM. You never see or export this material in plaintext.

        -   **Key Material and Origins**:The "secret sauce" used to encrypt data. You have three choices for where this comes from:

            1. **AWS_KMS:** AWS generates the material for you (most common).
            2. **EXTERNAL:** You import your own key material (BYOK).
            3. **AWS_CLOUDHSM:** The key material is generated and stored in a custom key store (CloudHSM cluster).

        -   **Symmetric vs. Asymmetric Key Types**:
            -   **Symmetric KMS Keys:** Use a single 256-bit key for both encryption and decryption (AES-GCM). The data never leaves KMS in plaintext.
            -   **Asymmetric KMS Keys:** Represent a mathematically related public/private key pair (RSA or Elliptic Curve). You can share the public key with anyone to encrypt data, but only KMS can use the private key to decrypt it.


    2. **Ownership and Management**: KMS keys are categorized based on who owns them and who manages them.

        | Key Type                  | Managed By | Owned By     | Cost                    |
        | ------------------------- | ---------- | ------------ | ----------------------- |
        | **AWS Owned Keys**        | AWS        | AWS          | Free                    |
        | **AWS Managed Keys**      | AWS        | Your Account | Free (usage fees apply) |
        | **Customer Managed Keys** | You        | Your Account | $1/month + usage        |

        -   **AWS Managed Keys:** Created automatically when you use a service like S3 or EBS for the first time. They look like `aws/s3` or `aws/ebs`. You cannot delete these or change their policies.
        -   **Customer Managed Keys:** These offer the most control. You define the rotation schedule, key policies, and aliases.


    3. **Advanced Features**:

        -   **Envelope Encryption**: This is the practice of encrypting data with a **Data Key**, and then encrypting that Data Key with a **KMS Key**.
            * **Why?** KMS cannot encrypt more than 4 KB of data directly. Envelope encryption allows you to encrypt massive datasets (like a 10TB S3 bucket) locally using the Data Key, while KMS only handles the small, encrypted version of that key.

        -   **Multi-Region Keys**: Standard KMS keys are regional. However, **Multi-Region Keys** allow you to replicate a primary key into other AWS regions. They share the same Key ID and key material, making it easy to move encrypted data between regions (e.g., for Disaster Recovery) without re-encrypting it.

        -   **Key Rotation**
            * **Automatic:** For Customer Managed Keys, AWS can rotate the backing key material once per year. KMS keeps the old material to decrypt older data, but uses the new material for new requests.
            * **Manual:** You create a new KMS key and update your application code or aliases to point to the new Key ID.

    4. **Security and Access Control**: KMS does not use IAM roles alone; it relies heavily on **Key Policies**.
        * **Key Policy:** The primary way to control access. A KMS key *must* have a policy. If the policy doesn't explicitly allow an IAM user or the root account, even an Administrator cannot access the key.
        * **Grants:** A temporary, granular permission mechanism. Often used by AWS services (like EBS) to gain permission to use your key to encrypt a volume on your behalf.
        * **Encryption Context:** A set of non-secret key-value pairs (e.g., `"AppName": "Finance"`) that act as "additional authenticated data." If you provide it during encryption, you **must** provide the exact same context during decryption, or it will fail. This prevents "substitution attacks."


    5. **Auditing**: Every single time a key is used, created, or deleted, a log is sent to **AWS CloudTrail**. This provides a detailed audit trail of who used which key, when, and for what resource, which is critical for compliance (HIPAA, PCI-DSS, etc.).

    ##### Example

    > Here is a practical implementation of **Envelope Encryption** using Python and `boto3`. In this scenario, we use the `cryptography` library to handle the actual data encryption (AES-GCM), while KMS manages the keys.

    - **Prerequisites**: You will need to install the following library: `$ pip install boto3 cryptography`

    1. **The Encryption Workflow**: The goal is to request a **Data Key** from KMS. KMS returns a plaintext version (for immediate use) and an encrypted version (to store with your data).

        ```python
        import boto3
        import os
        from cryptography.hazmat.primitives.ciphers.aead import AESGCM

        # Initialize KMS client
        kms = boto3.client('kms', region_name='us-east-1')

        def envelope_encrypt(plaintext_data, kms_key_id):
            # 1. Ask KMS for a data key (returns both plaintext and encrypted versions)
            response = kms.generate_data_key(
                KeyId=kms_key_id,
                KeySpec='AES_256'
            )
            
            plaintext_data_key = response['Plaintext']
            encrypted_data_key = response['CiphertextBlob']

            # 2. Encrypt the data locally using the plaintext data key
            aesgcm = AESGCM(plaintext_data_key)
            nonce = os.urandom(12)  # GCM recommended nonce size
            ciphertext = aesgcm.encrypt(nonce, plaintext_data.encode(), None)

            # 3. CRITICAL: Securely delete the plaintext data key from memory
            del plaintext_data_key

            # Return the pieces you need to store together
            return {
                'ciphertext': ciphertext,
                'encrypted_data_key': encrypted_data_key,
                'nonce': nonce
            }

        # Usage
        MY_KMS_KEY = "alias/my-app-key"  # or the Key ID / ARN
        payload = envelope_encrypt("This is a secret message", MY_KMS_KEY)

        ```

    2. **The Decryption Workflow**: To decrypt, you send the **Encrypted Data Key** back to KMS. If you have the right permissions, KMS returns the plaintext key so you can decrypt the local file.

        ```python
        def envelope_decrypt(payload):
            # 1. Send the encrypted data key back to KMS to get the plaintext key
            response = kms.decrypt(
                CiphertextBlob=payload['encrypted_data_key']
            )
            plaintext_data_key = response['Plaintext']

            # 2. Decrypt the data locally
            aesgcm = AESGCM(plaintext_data_key)
            decrypted_data = aesgcm.decrypt(payload['nonce'], payload['ciphertext'], None)

            # 3. Wipe the plaintext key again
            del plaintext_data_key

            return decrypted_data.decode('utf-8')

        # Usage
        original_message = envelope_decrypt(payload)
        print(f"Decrypted: {original_message}")
        ```

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">CloudWatch</summary>

    -   [Be a Better Dev: AWS Cloudwatch Guides - Learn AWS Monitoring Techniques](https://www.youtube.com/playlist?list=PL9nWRykSBSFir2FLla2thQkEwmLpxPega)
    -   [What is AWS CloudWatch? Metric | Alarms | Logs Custom Metric](https://www.youtube.com/watch?v=G4_ay2_h9GI)

    > Amazon CloudWatch is a monitoring service provided by Amazon Web Services (AWS) that allows you to monitor and collect metrics, collect and monitor log files, and set alarms. Here are some important terms and concepts related to AWS CloudWatch:

    -   `Metrics`: A metric is a variable that you want to monitor, such as CPU usage, disk space usage, or network traffic. CloudWatch provides a set of predefined metrics for AWS resources, and you can also create your own custom metrics.
    -   `Events`: CloudWatch Events is a service that allows you to monitor and respond to changes in your AWS resources. You can create rules that trigger automated actions when certain events occur, such as launching an EC2 instance or creating a new S3 bucket.
        -   `Event Sources`: an "event source" refers to the entity or service that generates events that CloudWatch Events can capture and process. An event source is the origin or producer of events that you want to monitor and respond to within the AWS ecosystem. CloudWatch Events can capture events from various AWS services and custom applications, and each of these sources is considered an event source.
    -   `Alarms`: An alarm is a notification that is triggered when a metric breaches a specified threshold. You can configure CloudWatch to send notifications to various destinations, such as email, SMS, or other AWS services.
    -   `Rules`: A rule matches incoming events and routes them to targets for processing. A single rule can route to multiple targets, all of which are processed in parallel. Rules are not processed in a particular order. A rule can customize the JSON sent to the target, by passing only certain parts or by overwriting it with a constant.
    -   `Target`: A target processes events. Targets can include Amazon EC2 instances, AWS Lambda functions, Kinesis streams, Amazon ECS tasks, Step Functions state machines, Amazon SNS topics, Amazon SQS queues, and built-in targets. A target receives events in JSON format.
    -   `Dashboards`: A dashboard is a customizable view of metrics and alarms that you can create to monitor the health and performance of your AWS resources. You can add multiple metrics and alarms to a single dashboard, and you can create multiple dashboards to monitor different aspects of your infrastructure.
    -   `Logs`: CloudWatch Logs is a service that allows you to collect, monitor, and store log files generated by your applications and AWS resources. You can also use CloudWatch Logs to search and analyze log data.
        -   `Log Groups`: Log groups are containers for log streams.
        -   `Log Streams`: Log streams represent the sequence of log events coming from a specific source, such as an EC2 instance or Lambda function.
    -   `Retention periods`: CloudWatch allows you to specify how long you want to retain your metric data and log data. By default, CloudWatch retains` metric data for 15 months` and `log data for 30 days`, but you can customize these retention periods to suit your needs.
    -   `Namespaces`: A namespace is a container for CloudWatch metrics. AWS resources are organized into namespaces, and you can create custom namespaces for your own metrics.
    -   `Dimensions`: A dimension is a name-value pair that helps you to uniquely identify a metric. For example, a dimension for an EC2 instance might include the instance ID and the region where the instance is running.
    -   `CloudWatch Agent`: The CloudWatch agent is a software component that you can install on your EC2 instances to collect and send system-level metrics and logs to CloudWatch. The agent supports both Windows and Linux operating systems.

    #### CloudWatch Events vs EventBridge

    Amazon Web Services (AWS) provides two services for managing events and automating responses: Amazon CloudWatch Events and Amazon EventBridge. While both services are designed for event-driven architectures, they have some key differences in terms of functionality and use cases.

    -   `AWS CloudWatch Events`:

        -   `Use Case`: CloudWatch Events primarily focuses on events related to AWS resources. It is designed for monitoring and reacting to events from AWS services, such as EC2, Lambda, S3, and more.
        -   `Event Sources`: It integrates with AWS services and can capture events from those services. These events are typically related to resource changes, operational activities, and management.
        -   `Targets`: CloudWatch Events can route events to targets such as AWS Lambda functions, Amazon SNS topics, Kinesis streams, and more.
        -   `Event Rules`: You can create event rules that define which events to capture and how to respond to them. These rules are based on events from AWS services.
        -   `Retention`: CloudWatch Events retains events for a maximum of 1 or 2 weeks, depending on the event source.

    -   `AWS EventBridge`:

        -   `Use Case`: EventBridge, previously known as CloudWatch Events bus, is an advanced event bus service. It is designed for a broader range of event sources and use cases, including AWS services and custom applications.
        -   `Event Sources`: EventBridge can capture events from both AWS services and custom applications, making it suitable for hybrid and multi-cloud environments.
        -   `Schema Registry`: It includes a schema registry that allows you to define the structure of events, making it easier to work with event data.
        -   `Event Buses`: EventBridge supports multiple event buses that allow you to segment and manage events effectively. Each bus can have its own permissions and event sources.
        -   `Targets`: Similar to CloudWatch Events, EventBridge can route events to AWS Lambda functions, SNS topics, Kinesis streams, and more.
        -   `Archiving`: EventBridge offers event archiving, which allows you to retain events for a longer duration than CloudWatch Events.
        -   `Rules and EventBridge API`: EventBridge introduces more advanced rules and support for the EventBridge API, providing finer-grained control over event routing and transformation.

    -   `Key Considerations`:

        -   If you primarily need to handle AWS service events, CloudWatch Events may suffice.
        -   If you need to manage events from custom applications, multiple AWS accounts, or other AWS services in a more structured and scalable way, EventBridge is a better choice.
        -   EventBridge is often the preferred service for building event-driven architectures for microservices, serverless applications, and complex integrations.

    In summary, AWS CloudWatch Events is a specialized service for AWS resource events, while AWS EventBridge is a more versatile event bus service designed for a broader range of event sources and use cases, including custom applications and multi-cloud environments. Your choice depends on your specific use case and requirements.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">SNS</summary>

    Amazon Simple Notification Service (SNS) is a messaging service provided by Amazon Web Services (AWS) that enables the publishing and delivery of messages to multiple subscribers or endpoints. Here are some important terms and concepts related to AWS SNS:

    ![sns](../assets/aws/sns.png)

    -   `Topic`: A topic is a communication channel in SNS. Publishers send messages to a topic, and subscribers receive messages from a topic. A topic can have one or more subscribers.

        ```python
        sns = boto3.client('sns')
        sns.publish(
            TopicArn='ARN_OF_EC2StateChangeTopic',
            Message=message,
            Subject='EC2 State Change Notification'
        )
        ```

    -   `Subscription`: A subscription is a request to receive messages from a topic. Subscribers can receive messages via a variety of protocols, such as email, SMS, HTTP, HTTPS, Lambda, or mobile push notifications.
    -   `Publisher`: A publisher is an entity that sends messages to a topic. Publishers can be AWS services or applications that use an SNS client.
    -   `Message`: A message is the content that is sent to a topic. Messages can be up to 256 KB in size and can be in a variety of formats, including text, JSON, and binary data.
    -   `Protocol`: A protocol is the method used to send messages to subscribers. SNS supports multiple protocols, including HTTP, HTTPS, email, SMS, Lambda, and mobile push notifications.
    -   `Endpoint`: An endpoint is the destination for a message. Endpoints can be email addresses, mobile device tokens, HTTP/HTTPS URLs, or Amazon resource names (ARNs) for Lambda functions.
    -   `ARN`: An Amazon Resource Name (ARN) is a unique identifier for an AWS resource, such as an SNS topic or a Lambda function.
    -   `Message filtering`: SNS allows you to filter messages based on attributes or message content. This enables you to send targeted messages to specific subscribers.
    -   `Dead-letter queue`: A dead-letter queue is a queue where messages are sent if they cannot be delivered to their intended recipients. SNS provides support for dead-letter queues to help you troubleshoot message delivery issues.
    -   `Message attributes`: SNS allows you to add custom attributes to messages, which can be used for filtering and routing messages to specific subscribers.
    -   `Access policies`: SNS allows you to control access to topics and subscriptions using access policies. Access policies define which AWS accounts or users are authorized to perform specific actions on a topic or subscription.
    -   `SNS Mobile Push`: SNS provides a mobile push service that enables you to send push notifications to iOS, Android, and Kindle Fire devices. SNS Mobile Push supports Apple Push Notification Service (APNS), Google Cloud Messaging (GCM), Firebase Cloud Messaging (FCM), and Amazon Device Messaging (ADM).

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">SQS</summary>

    ![sqs](../assets/aws/sqs.png)

    AWS Simple Queue Service (SQS) is a fully managed message queuing service that enables you to **decouple and scale** microservices, distributed systems, and serverless applications. It acts as a buffer between the component that sends the message (**producer**) and the component that processes the message (**consumer**), allowing them to operate asynchronously and independently.

    -   <details><summary style="font-size:20px;color:Magenta">Core Components and Concepts</summary>

        1. **Queue**: The **Queue** is the temporary repository for messages. It is distributed across multiple AWS servers for high availability and durability.

        2. **Message**: A **Message** is the unit of communication sent to the queue by a producer and retrieved by a consumer.

            - **Maximum Size:** Up to **256 KB** of text in any format (e.g., JSON, XML). For larger messages (up to 2 GB), you can use the SQS Extended Client Library for Java, which stores the payload in Amazon S3 and sends a reference via SQS.
            - **Message Retention Period:** The amount of time SQS keeps a message in the queue. It ranges from 1 minute to 14 days, with a default of 4 days.

        3. **Producer (Sending Component)**: An application component that sends messages to the SQS queue. The producer does not need to know if the consumer is available or how many consumers there are. The primary API action is `SendMessage`.

        4. **Consumer (Receiving Component)**: An application component that polls the queue to retrieve and process messages. Once processed, the consumer must delete the message from the queue. The primary API actions are `ReceiveMessage` and `DeleteMessage`.

        </details>

    -   <details><summary style="font-size:20px;color:Magenta">Queue Types</summary>

        AWS SQS offers two main queue types, catering to different application requirements:

        1. **Standard Queues**:

            - **Throughput:** Support a nearly **unlimited number of transactions per second (TPS)**.
            - **Ordering:** Provide **best-effort ordering**. Messages are generally delivered in the order they were sent, but the exact order is not guaranteed.
            - **Delivery:** Provide **At-Least-Once Delivery**. A message is delivered at least once, but occasionally, more than one copy of a message may be delivered (duplicates can occur). They are suitable for scenarios where duplicates and out-of-order processing can be tolerated.

        2. **FIFO (First-In-First-Out) Queues**:

            - **Ordering:** Guarantee **strict message ordering** (First-In-First-Out).
            - **Delivery:** Guarantee **Exactly-Once Processing**. A message is delivered once and remains available until a consumer processes and deletes it, preventing duplicates.
            - **Throughput:** Support a lower, but still high, throughput (up to 3,000 messages per second with batching).
            - **Message Group ID:** Required for all messages in a FIFO queue. It specifies the group the message belongs to, and ordering is maintained **strictly within that group**. This allows for multiple ordered groups within a single queue, enabling parallel processing while preserving order for related messages.
            - **Message Deduplication ID:** Used to ensure exactly-once processing. It can be provided explicitly or enabled automatically via **Content-Based Deduplication** (based on the message body).

        </details>

    -   <details><summary style="font-size:20px;color:Magenta">Key Features and Configuration</summary>

        1. **Message Lifecycle and Visibility Timeout**: The **Visibility Timeout** is a critical concept in the SQS message lifecycle.

            - When a consumer retrieves a message using `ReceiveMessage`, the message remains in the queue but becomes **temporarily invisible** to other consumers. This is often referred to as "message locking."
            - The **Visibility Timeout** defines the duration of this invisibility (default is 30 seconds, configurable from 0 seconds to 12 hours).
            - If the consumer successfully processes the message before the timeout expires, it calls `DeleteMessage` to remove it permanently.
            - If the consumer fails to process or delete the message within the timeout, the message becomes **visible again** and can be retrieved by another consumer, potentially leading to duplicate processing (in Standard Queues) or a re-attempt (in FIFO Queues). Consumers can also extend the timeout programmatically using `ChangeMessageVisibility`.

        2. **Polling**: The method consumers use to retrieve messages.

            - **Short Polling:** The default behavior. It queries only a subset of SQS servers, returning immediately, even if the queue is empty. This can lead to more empty responses and higher costs.
            - **Long Polling:** The `ReceiveMessage` API call waits for a specified time (up to 20 seconds, the **Receive Message Wait Time**) for a message to arrive before returning a response. This reduces the number of empty responses, minimizes extraneous polling, and lowers costs.

        3. **Dead-Letter Queues (DLQ)**: A separate, designated queue for messages that a consumer has failed to process successfully after a specified number of attempts (the **Maximum Receive Count** defined in the **Redrive Policy**). DLQs help isolate problematic messages for debugging without blocking the main queue. DLQs must be the same type as the source queue (Standard or FIFO).

        4. **Delay Queues / Delivery Delay**:

            - **Delivery Delay (per message):** An attribute set on an individual message that determines the amount of time (0 seconds to 15 minutes) the message will be hidden before it is made available to a consumer.
            - **Delay Queue (per queue):** A setting that applies a delay to _all_ messages sent to the queue. This is useful for delaying processing of newly written messages by a fixed time.

        5. **Batch Operations**: You can perform `SendMessage`, `DeleteMessage`, and `ReceiveMessage` operations in batches of up to **10 messages** or **256 KB** of data in a single API request. This reduces costs by consolidating requests.

        6. **Security**:

            - **Server-Side Encryption (SSE):** Protects the contents of messages using encryption keys managed by the **AWS Key Management Service (AWS KMS)**. Messages are encrypted at rest and decrypted only when sent to an authorized consumer.
            - **Access Control:** Integration with **AWS Identity and Access Management (IAM)** and **Queue Access Policies** to control which users or AWS accounts can send or receive messages from the queue.

        </details>

    -   <details><summary style="font-size:20px;color:Magenta">Terms & Concepts</summary>

        -   `Queue`: A queue is a container for messages in SQS. Queues allow messages to be stored and retrieved asynchronously between components or services.
        -   `Message`: A message is the information being sent between components or services. Messages can contain up to 256KB of text in any format.
        -   `Producer`: A producer is a system or application that sends messages to a queue.
        -   `Consumer`: A consumer is a system or application that receives messages from a queue.
        -   `Visibility timeout`: When a consumer retrieves a message from a queue, the message becomes "invisible" to other consumers for a specified period of time known as the visibility timeout. This allows the consumer time to process the message without the risk of another consumer processing the same message.
        -   `Long polling`: Long polling is a method of retrieving messages from a queue where the request to retrieve messages stays open for an extended period of time, waiting for new messages to arrive. This reduces the number of empty responses and can improve the efficiency of message retrieval.
        -   `Dead-letter queue`: A dead-letter queue is a queue where messages are sent if they cannot be processed successfully by a consumer. SQS provides support for dead-letter queues to help you troubleshoot message processing issues.
        -   `FIFO queue`: A FIFO queue is a queue that supports "first-in, first-out" ordering of messages. FIFO queues are designed for applications that require the exact order of messages to be preserved.
        -   `Standard queue`: A standard queue is a queue that provides at-least-once delivery of messages. Standard queues are designed for applications that can handle the possibility of duplicate messages or messages that are not delivered in the exact order they were sent.
        -   `Message attributes`: SQS allows you to add custom attributes to messages, which can be used for filtering and routing messages to specific consumers.
        -   `Access policies`: SQS allows you to control access to queues using access policies. Access policies define which AWS accounts or users are authorized to perform specific actions on a queue.
        -   `Batch operations`: SQS supports batch operations that allow you to send, delete, or change the visibility timeout of multiple messages in a single API call.
        -   `Delay queues`: Delay queues allow you to delay the delivery of messages for a specified amount of time, up to 15 minutes. This can be useful for scenarios where messages need to be delayed until certain conditions are met.

        </details>

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">EventBridge</summary>

    ![event_bridge](../assets/aws/event_bridge.png)

    -   `Event-Driven Architecture`: Amazon EventBridge facilitates event-driven architecture, where services or applications communicate by emitting and consuming events. An event can be anything from a simple notification to a significant change in your application's state.

    Amazon EventBridge is a serverless event bus service that simplifies the building of event-driven architectures. It enables you to connect different AWS services, SaaS applications, and custom applications using events, making it easier to build scalable, decoupled, and flexible applications.
    AWS EventBridge is a serverless event bus service that enables you to connect applications using data from your own apps, integrated Software-as-a-Service (SaaS) apps, and AWS services. It simplifies event-driven architectures, allowing services to communicate through events. Below are the crucial components and concepts in AWS EventBridge:

    -   **Events**: An **event** is a data record that signifies a change in the state of a system, application, or AWS resource. The event is in JSON format and contains details like the source of the event, the event type, and the event data (payload).

        -   Events in EventBridge are typically generated by:
            -   AWS services (e.g., S3 file creation).
            -   Custom applications.
            -   Integrated SaaS applications.

    -   **Event Buses**: EventBridge uses an event bus, a central message broker that receives and distributes events to the relevant targets. The event bus acts as the intermediary for the communication between different event sources and event targets.

        -   **Event Bus** is the central component where events are sent and from where they are routed to the appropriate targets.
            -   **Default Event Bus**: Every AWS account has a default event bus that receives events from AWS services (e.g., EC2, S3).
            -   **Custom Event Bus**: You can create custom event buses for your applications or microservices to handle specific events.
            -   **SaaS Partner Event Bus**: SaaS applications can send events directly to your event bus using partner event sources.

    -   **Event Patterns**: Event Pattern is a set of conditions used to filter and match specific events based on their attributes or content. Event patterns help you identify which events you want to capture and respond to by defining criteria that events must meet before they are processed by rules in EventBridge.

        -   **Event Patterns** are used in rules to filter events and specify which events should trigger a specific rule.
        -   Patterns can match specific fields in an event, such as event source, detail type, or the contents of custom event data.
        -   EventBridge checks incoming events against defined patterns, and when there’s a match, it routes the event to the specified target.

    -   **Rules**: A rule in AWS EventBridge is a configuration that matches incoming events to specific patterns and routes them to one or more target destinations, such as AWS Lambda, SQS, or other services. Rules act as filters, ensuring that only events that meet the defined criteria trigger the specified actions. - **Event Pattern Matching**: EventBridge matches events to rules based on defined event patterns, which are JSON objects that specify the structure and content of the event to be matched. - Rules can trigger multiple targets when a matching event is received. Each rule can have one or more targets.

    -   **Targets**: Targets are the destination resources or services where events are routed after being matched by a rule.

        -   Some common targets include:
            -   AWS Lambda functions
            -   Step Functions
            -   Amazon SNS or SQS for messaging
            -   Kinesis Streams or Firehose for data streaming
            -   Amazon EC2 or ECS
            -   Other event buses (you can route events between buses)

    -   **Event Sources**: Event sources are the entities that emit events to EventBridge. AWS services, such as AWS CloudTrail, Amazon S3, or AWS Step Functions, can be event sources. Custom applications and SaaS applications can also emit events to EventBridge using the PutEvents API.

        -   **Event Sources** are the entities that generate events. EventBridge can handle events from:
            -   **AWS services**: Many AWS services (e.g., S3, EC2) automatically emit events when specific actions occur.
            -   **Custom Event Producers**: Your own applications or microservices can act as event sources, publishing custom events to EventBridge.
            -   **SaaS Applications**: Third-party SaaS applications can send events to your EventBridge using SaaS partner integration.

    -   **Schemas Registry**

        -   **Schema Registry** allows you to automatically discover and manage event schemas used by EventBridge.
            -   **Schema Discovery**: When you enable schema discovery, EventBridge automatically analyzes incoming events and creates a schema for them.
            -   Schemas can be downloaded as code bindings for programming languages like Python or Java to make it easier to work with events in your code.

    -   **Key Use Cases for AWS EventBridge**:

        -   `Event-Driven Architectures`: Helps decouple microservices, where services react to events without direct communication.
        -   `Monitoring and Automation`: Trigger workflows or Lambda functions in response to events like EC2 state changes or file uploads in S3.
        -   `SaaS Integrations`: Seamlessly integrate third-party SaaS services like Zendesk, Datadog, or Shopify into your AWS environment.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">ACM</summary>

    **AWS Certificate Manager (ACM)** is a **fully managed** service that handles **SSL/TLS certificate provisioning, management, and renewal** for AWS services like **Elastic Load Balancers (ELB), CloudFront, API Gateway, and AWS App Runner**. It allows **automatic renewal** of certificates, eliminating manual management.

    #### Key Components & Terms in ACM

    -   **Public Certificates**: A **public certificate** is an **SSL/TLS certificate issued by a trusted Certificate Authority (CA)** that is recognized globally by web browsers, operating systems, and devices. These certificates **verify the identity of a website or service** and ensure encrypted communication over HTTPS.

        -   **Key Features of Public Certificates**:

            -   Issued by a public CA such as DigiCert, Let's Encrypt, GlobalSign, or Sectigo.
            -   Globally trusted by browsers and devices (pre-installed CA root certificates).
            -   Used for public-facing websites, APIs, and web services.
            -   Requires domain ownership verification before issuance.

        -   **Where Are Public Certificates Used?**:

            -   Public websites (e.g., `https://www.example.com`).
            -   E-commerce sites, SaaS applications, and public APIs.
            -   Cloud services like AWS CloudFront, ALB, and API Gateway.

        -   **How to Get a Public Certificate?**:

            -   Buy from a CA (e.g., DigiCert, Sectigo) and then import into ACM
            -   Use a free CA (e.g., Let's Encrypt) and then import into ACM
            -   Request an AWS Certificate Manager (ACM) Public Certificate (for AWS services).
            -   `Example`: Requesting a Public Certificate from AWS ACM
                ```bash
                aws acm request-certificate \
                --domain-name example.com \
                --validation-method DNS
                ```

    -   **Private Certificates**: A **private certificate** is an **SSL/TLS certificate issued by a private certificate authority (CA)**, typically within an **organization's internal network**. These certificates **are not publicly trusted** but are used for internal systems, secure communication, and authentication within an organization's infrastructure.

        -   **Key Features of Private Certificates**

            -   Issued by a private CA (e.g., AWS Private CA, Microsoft Active Directory Certificate Services).
            -   Not publicly trusted (browsers do not recognize them unless manually installed).
            -   Used for internal services, VPNs, databases, and private applications.
            -   Provides encryption and authentication without exposing data to the public internet.

        -   **Where Are Private Certificates Used?**

            -   Internal applications (e.g., intranet, internal APIs, databases).
            -   Private networks, VPNs, and corporate email encryption.
            -   Mutual TLS (mTLS) authentication between microservices.
            -   IoT devices, Kubernetes clusters, and internal service communication.

        -   **How to Get a Private Certificate?**

            -   Use AWS Private CA (part of AWS Certificate Manager).
            -   Set up a self-signed certificate using OpenSSL.
            -   Use an on-premises CA (e.g., Microsoft Active Directory Certificate Services).
            -   `Example`: Generating a Private Certificate with OpenSSL

                -   `$ openssl req -x509 -newkey rsa:2048 -keyout private_key.pem -out certificate.pem -days 365`

            -   `Example`: Requesting a Private Certificate from AWS ACM Private CA
                ```bash
                aws acm-pca issue-certificate \
                --certificate-authority-arn <private-ca-arn> \
                --csr file://csr.pem \
                --signing-algorithm "SHA256WITHRSA" \
                --validity Value=365,Type="DAYS"
                ```

    -   **Certificate Validation Types**: ACM requires domain validation before issuing a certificate. There are two ways:

        -   `DNS Validation (Recommended)`

            -   ACM provides a **CNAME record** to add to your domain's DNS settings.
            -   Once added, ACM automatically validates and renews the certificate.

        -   `Email Validation`

            -   ACM sends an email to the **domain admin (WHOIS contact)**.
            -   The recipient must **click a link** to approve the certificate request.

    -   **Certificate Renewal & Expiration**

        -   Public ACM certificates are **auto-renewed** before expiration.
        -   Private certificates **can be auto-renewed** if configured properly.
        -   If **DNS validation is used**, renewals are **automatic**.
        -   If **email validation is used**, renewals **require manual approval**.

    -   **ACM Certificate Deployment**: Once issued, ACM certificates can be **deployed** to AWS services like:

        -   `Elastic Load Balancer (ALB, NLB, CLB)`
        -   `Amazon CloudFront`
        -   `Amazon API Gateway`
        -   `AWS App Runner`
        -   `AWS Elastic Beanstalk`

    #### Step-by-Step: Requesting an SSL Certificate in ACM

    1. **Request a Certificate**

        - **Using AWS CLI**(alternatively Using AWS Console):

            ```sh
            aws acm request-certificate \
            --domain-name example.com \
            --validation-method DNS \
            --subject-alternative-names www.example.com
            ```

    2. **Validate Your Domain**:

        - If using **DNS validation**:

            - Go to **Route 53** (or your DNS provider).
            - Add the **CNAME record** provided by ACM.
            - ACM will automatically detect it and issue the certificate.

        - If using **Email validation**:
            - Check the **WHOIS-registered email inbox**.
            - Click the validation link.

    3. **Deploy the ACM Certificate**: Once issued, deploy it to supported AWS services.

        - **Attach to an ALB (Application Load Balancer)**:

            ```sh
            aws elbv2 create-listener \
            --load-balancer-arn <your-load-balancer-arn> \
            --protocol HTTPS --port 443 \
            --certificates CertificateArn=<your-certificate-arn> \
            --default-actions Type=forward,TargetGroupArn=<your-target-group-arn>
            ```

        - **Attach to CloudFront**:

            ```sh
            aws cloudfront update-distribution \
            --id <your-distribution-id> \
            --default-root-object index.html \
            --viewer-certificate CloudFrontDefaultCertificate=false,ACMCertificateArn=<your-certificate-arn>,SSLSupportMethod=sni-only
            ```

    #### Custom SSL Certificate

    A **Custom SSL Certificate** in the context of AWS refers to an **SSL/TLS certificate that you manually upload and manage** instead of using an AWS-managed certificate from **AWS Certificate Manager (ACM)**. These certificates are often issued by third-party **Certificate Authorities (CAs)** or generated for internal use.

    -   **Custom SSL Certificates Used in AWS**: Custom SSL certificates are typically used in AWS services that require **TLS encryption** for securing connections, such as:

        1. **AWS CloudFront (CDN Service)**: You can upload a custom SSL certificate to **AWS Certificate Manager (ACM) in the US East (N. Virginia) region (`us-east-1`)** and use it for **HTTPS connections** on your CloudFront distribution.
        2. **AWS Elastic Load Balancer (ELB - ALB, NLB, CLB)**: Custom SSL certificates can be used with **Application Load Balancer (ALB)** and **Network Load Balancer (NLB)** to terminate SSL/TLS traffic before forwarding it to backend instances.
        3. **AWS API Gateway**: API Gateway allows **custom domain names** with a custom SSL certificate for secure API endpoints.
        4. **AWS IoT Core & AWS MQTT**: When using AWS IoT services, you may need a **custom SSL certificate** for **device authentication** and secure communication.
        5. **AWS CloudFormation & Terraform**: Infrastructure as Code (IaC) tools can reference and deploy **custom SSL certificates** stored in ACM.
        6. **AWS EC2 & Self-Managed Web Servers**: Custom SSL certificates can be installed manually on **Apache, Nginx, or other web servers** running on **Amazon EC2 instances**.

    -   **Key Features of Custom SSL Certificates**

        -   **Manually uploaded** to AWS ACM or IAM.
        -   **Supports wildcard (`*.example.com`) and multi-domain (`SAN`) certificates**.
        -   **Full control** over renewal and revocation.
        -   Can be used with **ALB, NLB, API Gateway, and CloudFront**.

    -   **How to Upload and Use a Custom SSL Certificate in AWS?**

        1. **Obtain an SSL Certificate**

            - Purchase an **SSL/TLS certificate** from a trusted CA (e.g., DigiCert, Let’s Encrypt).
            - Generate a **private key** and **Certificate Signing Request (CSR)**:

                - `openssl req -new -newkey rsa:2048 -nodes -keyout private_key.pem -out csr.pem`

            - Submit the **CSR** to the CA and obtain the **certificate files (`.crt`, `.pem`, `.key`)**.

        2. **Upload the Certificate to AWS**

            - `Option 1`: Upload to AWS Certificate Manager (ACM)

                - Run the following AWS CLI command:
                    ```bash
                    aws acm import-certificate \
                    --certificate file://certificate.pem \
                    --private-key file://private_key.pem \
                    --certificate-chain file://ca_bundle.pem
                    ```

            - `Option 2`: Upload to AWS IAM (For ELB)
                - Use AWS CLI to upload a custom SSL certificate to IAM for **Classic Load Balancer (CLB)**:
                    ```bash
                    aws iam upload-server-certificate \
                    --server-certificate-name MyCustomCert \
                    --certificate-body file://certificate.pem \
                    --private-key file://private_key.pem \
                    --certificate-chain file://ca_bundle.pem \
                    --path /cloudfront/
                    ```

        3. **Attach the Certificate to an AWS Service**

            - `For AWS CloudFront`: Select the Custom SSL Certificate from ACM when configuring CloudFront’s HTTPS settings.

            - `For AWS Load Balancer`: Use the uploaded certificate in Application Load Balancer (ALB) or Network Load Balancer (NLB):

                ```bash
                aws elbv2 create-listener \
                --load-balancer-arn <your-load-balancer-arn> \
                --protocol HTTPS --port 443 \
                --certificates CertificateArn=<your-certificate-arn> \
                --default-actions Type=forward,TargetGroupArn=<your-target-group-arn>
                ```

            - `For AWS API Gateway`: Assign the custom certificate to a **custom domain name** in API Gateway.

    -   **Custom SSL Certificates vs. AWS-Managed Certificates**

        | Feature                | Custom SSL Certificate                   | AWS-Managed (ACM) Certificate |
        | ---------------------- | ---------------------------------------- | ----------------------------- |
        | **Issued by**          | Third-party CA (DigiCert, Sectigo, etc.) | AWS ACM                       |
        | **Renewal**            | Manual                                   | Automatic                     |
        | **Supported Services** | CloudFront, ELB, API Gateway, EC2        | CloudFront, ELB, API Gateway  |
        | **Management**         | Fully controlled by the user             | Managed by AWS                |
        | **Cost**               | May require CA fees                      | Free via ACM                  |

    #### IAM vs ACM vs Custom SSL Certificates

    | Feature                                   | IAM Certificate                       | ACM Certificate                | Custom SSL Certificate                      |
    | ----------------------------------------- | ------------------------------------- | ------------------------------ | ------------------------------------------- |
    | **Where Stored?**                         | AWS IAM                               | AWS Certificate Manager (ACM)  | User-managed, can be imported to ACM or IAM |
    | **Managed by AWS?**                       | No                                    | Yes                            | No                                          |
    | **Automatic Renewal?**                    | No                                    | Yes                            | No                                          |
    | **Supports AWS CloudFront?**              | Legacy support only                   | Yes                            | Yes (when imported to ACM)                  |
    | **Supports ALB & NLB?**                   | No                                    | Yes                            | Yes (when imported to ACM)                  |
    | **Supports Classic Load Balancer (CLB)?** | Yes                                   | No                             | Yes (when imported to IAM)                  |
    | **Can Be Used Outside AWS?**              | No                                    | No                             | Yes                                         |
    | **Private Key Exportable?**               | Yes                                   | No                             | Yes                                         |
    | **Supports Self-Signed Certificates?**    | Yes                                   | No                             | Yes                                         |
    | **Best Use Case?**                        | Legacy AWS services (CLB, CloudFront) | Fully AWS-managed environments | Hybrid AWS & non-AWS environments           |

    #### Trust Store

    A **Trust Store** in AWS is a collection of **trusted Certificate Authorities (CAs)**—specifically, a set of **X.509 certificates** that are used to validate client certificates during **Mutual TLS (mTLS)** authentication. It defines **which certificates your system trusts** when a client tries to establish a secure connection. This concept is foundational for mutual TLS, where **both client and server authenticate each other** using certificates.

    -   **Where Trust Store is Used in AWS**

        1. **Amazon API Gateway (for Mutual TLS)**: When using mTLS with API Gateway, you upload a **Trust Store (a PEM file or an Amazon S3 location of trusted CA certs)**. This Trust Store is used to **validate the client’s certificate**.

        -   The Trust Store must contain the **root CA certificates** that issued the client certs.
        -   If the client presents a cert signed by a CA not in the trust store, the connection is rejected.

        > Used when you want to **verify client identity** with certificates (e.g., B2B APIs, internal systems).

        1. **AWS Verified Access**: In AWS Verified Access (used to provide secure access to internal apps without VPN), a **Trust Provider** can use a **Trust Store** to validate device or user certificates.

            - This helps ensure that only devices/users with valid certificates from a trusted CA can access resources.

        2. **Custom Applications on EC2, ELB, or NLB**: If you’re running a service on EC2 behind an **Elastic Load Balancer (ELB)** with mTLS enabled, you may need to configure your backend with a **trust store** to validate incoming client certificates.

        3. **Private Certificate Authority (CA)**: While not called a "trust store" directly, AWS Private CA can issue certificates, and the certificates issued by a trusted CA (internal or external) would be included in the **Trust Store** of clients/servers that validate those certs.

    -   **How it Works: Mutual TLS & Trust Store**

        1. **Client sends certificate** during TLS handshake.
        2. **API Gateway or backend checks client cert**:
            - Is it signed by a trusted CA from the Trust Store?
            - Is it expired or revoked?
        3. **If valid**, the connection proceeds.
        4. **If not trusted**, the connection is denied (HTTP 403).

    -   **How to Create a Trust Store in AWS**

        -   Upload one or more PEM-encoded X.509 certificates (Root/Intermediate CAs) to **Amazon S3**.
        -   Reference the Trust Store in services like API Gateway by providing:
            ```json
            {
                "truststoreUri": "s3://your-bucket/path-to-ca.pem"
            }
            ```
        -   Ensure S3 permissions allow the service to access the Trust Store.

    -   **Best Practices**

        -   Keep your Trust Store updated with **valid CA certificates**.
        -   Revoke or remove compromised CA certs immediately.
        -   Use **certificate revocation lists (CRLs)** or **OCSP** for more dynamic cert validation (depending on service support).
        -   Use **least privilege** for access to the Trust Store (e.g., S3 bucket policies).

    -   **Example Use Case (Securing Internal APIs with mTLS)**: You have a service hosted in AWS API Gateway that should only be accessed by clients within your org:

        -   You generate client certs using AWS Private CA.
        -   You upload the CA certs to S3 to act as a Trust Store.
        -   You enable mTLS on API Gateway and point it to the Trust Store.
        -   Now, only clients with valid certs signed by your CA can access the API.

    -   <details><summary style="font-size:20px;color:red">self-signed certificate</summary>

        A **self-signed certificate** is an SSL/TLS certificate that is **signed by the same entity that created it**, instead of being signed by a trusted Certificate Authority (CA).

        -   🔐 What Is a Self-Signed Certificate?

            -   A **Certificate Authority (CA)** like Amazon, Let's Encrypt, or DigiCert **verifies** the identity of the domain owner and then **signs** the certificate.
            -   This **signature builds trust**, so browsers and clients accept it as valid.

            -   A **self-signed certificate** is **created and signed by the domain owner** without any external validation.
            -   It is **not trusted** by default in browsers or operating systems.

        -   📍 Why Use Self-Signed Certificates?

            -   **Testing & Development:** Commonly used for local or non-production environments.
            -   **Internal Services:** For internal APIs, microservices, or lab environments not exposed to the internet.
            -   **No Cost:** Doesn’t require payment or CA involvement.

        -   ❌ Why Not Use in Production?

            -   **Not trusted by browsers.**
            -   Browsers show security warnings like _"Your connection is not private."_
            -   Clients may reject connections unless explicitly configured to trust the certificate.

        -   ✅ What ACM Supports:

            -   **Public ACM Certificates**: Issued by Amazon’s trusted CA and used with services like: CloudFront, Elastic Load Balancer (ELB), API Gateway
            -   These certificates are **automatically renewed and trusted**.

        -   🚫 What ACM Does NOT Support:

            -   **You cannot import self-signed certificates into ACM for use with CloudFront or ELB.**
            -   ACM **only supports imported certificates for certain services (like EC2 Nginx/Apache)** if:

                -   You bring your **own certificate** (including self-signed),
                -   You **manually import it** into ACM via the console, CLI, or SDK.

            ```bash
            aws acm import-certificate \
            --certificate file://cert.pem \
            --private-key file://privkey.pem \
            --certificate-chain file://chain.pem
            ```

            > ⚠️ But such self-signed certs won’t work with CloudFront, ELB, or API Gateway — only with services where you control the TLS termination (like an EC2 instance or private ALB listener).

        </details>

    </details>

---