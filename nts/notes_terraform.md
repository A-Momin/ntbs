

-   <details><summary style="font-size:25px;color:Orange">Terms & Concepts</summary>

    -   <details><summary style="font-size:20px;color:Magenta">Terraform Configuration</summary>

        -   **Terraform Configuration**:

            -   A set of files written in HashiCorp Configuration Language (HCL) that describe the desired infrastructure state.
            -   The main configuration file is usually named `main.tf` and contains resource definitions, providers, variables, and other settings.
            -   In Terraform, several files are automatically generated to manage and track the state of your infrastructure, handle locks, and ensure consistent operations. These files are critical to the functionality of Terraform, ensuring that the infrastructure is created, updated, and destroyed correctly.

                -   **terraform.tfstate**:

                    -   This file stores the current state of your infrastructure. It includes details about the resources that Terraform manages, their current configuration, and metadata.
                    -   It's usually in JSON format and can be quite large, depending on the size and complexity of your infrastructure.
                    -   It Should be stored securely because it contains sensitive information about your infrastructure.

                -   **terraform.tfstate.backup**:

                    -   This file is a backup of the previous state. Before Terraform makes changes to your infrastructure, it creates a backup of the existing state in this file.
                    -   It's useful in case something goes wrong during an apply, and you need to roll back to the previous state.
                    -   While it's good to keep a backup, you might not want to version control it, especially if it contains sensitive information. Ensure it's stored securely.

                -   **terraform.lock.hcl**:

                    -   This file is related to Terraform's dependency locking mechanism. It's used to lock down the versions of providers and modules to ensure that subsequent runs use the same versions as the original deployment.
                    -   It's generally used in conjunction with terraform init and is crucial for ensuring consistency in a team or CI/CD environment.
                    -   This file should be version controlled along with your Terraform configuration files. It ensures that everyone working on the project uses the same versions of providers and modules.

            | File Name                      | Short Explanation                                                                                                                                                                                                                                                                                    |
            | :----------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
            | **`terraform.tfstate`**        | The primary **State File** and the single source of truth. It maps your configuration to the real-world infrastructure created on your cloud provider, storing the current status and IDs of all managed resources. **Never edit manually.**                                                         |
            | **`terraform.tfstate.backup`** | A **backup of the state file** created automatically by Terraform whenever a successful operation modifies the primary state file. It serves as a safety mechanism to prevent data loss if the primary state file is corrupted during an operation.                                                  |
            | **`terraform.lock.hcl`**       | The **Dependency Lock File**. It records the exact versions of the **providers** downloaded and used for the configuration. This ensures that everyone working on the project uses the same provider versions to avoid unexpected changes or state drift. It should be committed to version control. |
            | **`terraform.tfvars`**         | A **default**. If present, Terraform **automatically** loads all variable values defined within it during execution. It's typically used to store common, non-sensitive input variables for a configuration.                                                                                         |
            | **`*.auto.tfvars`**            | **Automatically loaded variable files**. Any file ending with `.auto.tfvars` or `.auto.tfvars.json` is automatically loaded by Terraform. This is commonly used for injecting values from external systems or for environment-specific variables (e.g., `prod.auto.tfvars`).                         |
            | **`__________.tfvars`**        | A **manually-loaded variable file**. If present, Terraform will ignore it unless you manually add them with your `terraform` command (e.g. `$ terraform apply -var-file="global.tfvars" -var-file="dev.tfvars"`).                                                                                    |

        -   **Terraform Cloud**:
            -   A hosted service by HashiCorp that provides collaboration, versioning, and automation features for Terraform configurations.
            -   **Usage**: **Terraform Cloud** facilitates remote execution of Terraform runs, workspace management, and collaboration among team members.

        -   **Provider**: A plugin that translates Terraform configurations into API calls to interact with specific cloud or infrastructure platforms.
            -   **Tier**: A classification system used by HashiCorp to indicate the level of maintenance and support for a specific provider.
                -   **Official Provider**: A provider owned and maintained directly by HashiCorp (e.g., AWS, Azure, Google Cloud).
                -   **Partner Provider**: A provider developed and maintained by a third-party company in collaboration with HashiCorp (e.g., MongoDB, Datadog).
                -   **Community Provider**: A provider created and maintained by individual contributors or open-source organizations rather than a formal partner.
            -   **Provider Namespace**: The prefix in a provider's source address (e.g., `hashicorp/`) that identifies the organization or individual responsible for publishing it.

        </details>

    -   <details><summary style="font-size:20px;color:Magenta">Blocks</summary>

        -   A block is a structural unit of configuration that defines specific behavior or configuration for resources, providers, modules, and other components. Blocks in Terraform contain settings or instructions in a declarative format and are the building blocks of a Terraform configuration file.
        -   Each block typically starts with a keyword (e.g., `resource`, `provider`, `variable`, etc.), followed by parameters or attributes that define the desired state or configuration for that specific entity. These blocks can be nested and often contain other blocks or key-value pairs.

        -   **Elements/Parts of a Block**:

            -   `Block Type`: The first keyword that defines what kind of entity the block is configuring (e.g., `resource`, `provider`, `output`, etc.).
            -   `Block Label(s)`: After the block type keyword, many blocks take one or more lebales. It identifies the specific instance or name of the entity you define in the block.
                -   The following **resource block** takes two labels: `"aws_s3_bucket"` and `"logs"`
                    -   `resource "aws_s3_bucket" "logs"{ ... }`
                    -   reference: `aws_s3_bucket.logs.id`
                -   The following blocks take one/no label.
                    -   `provider "aws" { ... }`
                    -   `variable "my_vpc_id" { ... }`
                    -   `module "vpc" { ... }`
                    -   `locals { ... }` -> it take no label at all.
            -   `Block Body`:
                -   `Attributes/Arguments`: Key-value pairs or other configurations inside the block that describe the properties of the entity.
                    `Expressions`:
                -   `Nested Blocks`: Other blocks inside a block that further refine its configuration.
            -   `Meta Arguments`:

        1. <details><summary style="font-size:20px;color:#C71585">terraform</summary>

            - The `terraform` block is used to configure Terraform itself, such as backend settings (where the state files are stored) and version constraints.
            - This is usually found at the top of the configuration file.

            ```ini
            terraform {
                backend "s3" {
                    bucket = "my-terraform-state"
                    key    = "state/terraform.tfstate"
                    region = "us-west-2"
                }
            }
            ```

            </details>

        2. <details><summary style="font-size:20px;color:#C71585">provider</summary>

            - The `provider` block specifies which infrastructure provider (e.g., AWS, Azure, Google Cloud) Terraform should interact with.
            - It defines the connection details like region, authentication, and API version.

            - Providers are responsible for interacting with APIs and exposing resources for a specific infrastructure platform (e.g., AWS, Azure, Google Cloud).
            - Providers are declared in the configuration file to specify the target platform and set configuration details.

            ```ini
            provider "aws" {
                region = "us-west-2"
            }
            ```
            </details>

        3. <details><summary style="font-size:20px;color:#C71585">resource</summary>

            -   [Resource Block](https://developer.hashicorp.com/terraform/language/resources)

            - The `resource` block is used to define a specific infrastructure component such as compute instances, storage, or networks.
            - It declares the type of resource and its configuration parameters.

            - A representation of an infrastructure object (e.g., virtual machines, databases, networks) that Terraform manages.
            - Resources are declared with a resource type and a unique name, and they define the desired state of the infrastructure.

            ```ini
            resource "RESOURCE_TYPE" "RESOURCE_NAME" {
                # Configuration settings for the resource

                ATTRIBUTE_NAME = ATTRIBUTE_VALUE
                # Additional attribute configurations
            }
            ```

            ```ini
            resource "aws_instance" "example" {
                ami           = "ami-12345678"
                instance_type = "t2.micro"
            }
            ```

            ##### Some Critical Resource Blocks

            -   **`resource "aws_resourcegroups_group" "test"`**:

                ```ini
                resource "aws_resourcegroups_group" "test" {
                    name = "test-group"

                    resource_query {
                        query = jsonencode({
                            ResourceTypeFilters = ["AWS::EC2::Instance"]
                            TagFilters = [
                                {
                                    Key    = "Stage"
                                    Values = ["Test"]
                                }
                            ]
                        })
                    }
                }
                ```

            </details>

        4. <details><summary style="font-size:20px;color:#C71585">variable (Input Variables)</summary>

            > These are the **parameters** of your Terraform module. They allow users to pass values into the configuration from the outside.

            -   **Analogy:** The arguments/parameters you pass into a function.
            -   **Static:** Their values must be determined *before* Terraform starts its work. Hence assignment of an expression/function as a value to a variable name is not allowed.
            -   **Source:** Assigned via `.tfvars` files, CLI flags, or environment variables.

            ```ini
            variable "instance_type" {
                description = "Type of EC2 instance"
                type        = string
                default     = "t2.micro"
                # default     = aws_ec2_instane.instance_type # This is not allowed
            }
            ```
            </details>

        5. <details><summary style="font-size:20px;color:#C71585">locals (Local Variables)</summary>

            > While often called "variables" by beginners, these are actually **internal constants**. They are used to calculate values within the code to avoid repetition.

            -   **Analogy:** A variable declared *inside* the body of a function.
            -   **Dynamic:** They can change based on the logic of other variables or resource attributes.
            -   **Source:** Defined directly in the code using dynamic expressions and functions.

            ```ini
            locals {
                instance_type = aws_ec2_instane.instance_type # This is allowed
                instance_name = "web-server"
                environment   = "production"
            }
            ```

            </details>

        6. <details><summary style="font-size:20px;color:#C71585">output</summary>

            > These are like **return values** for your Terraform configuration. They highlight important information after a deployment.

            -   **Analogy:** The "return" statement of a function.
            -   **Purpose:** To print information to the console or share data with other configurations (via remote state).

            ```ini
                output "instance_ip" {
                value = aws_instance.example.public_ip
            }
            ```

            </details>

        7. <details><summary style="font-size:20px;color:#C71585">module</summary>

            > A self-contained unit of Terraform configuration that groups multiple related resources together (e.g., a "Network" module containing VPC, Subnets, and Gateways).
            -   **The Root Module**: Every Terraform project has at least one module, known as the **Root Module**, which consists of all `.tf` files in your main working directory.
            -   **Child Modules**: These are external packages of code called by the root module. Using them allows you to keep your configuration concise and "DRY" (Don't Repeat Yourself).
            -   **Encapsulation & Reusability**: Modules act as "containers," allowing you to share standardized infrastructure patterns across different teams or projects without rewriting code.
            -   **Sources**: Modules can be pulled from **Local paths** (on your machine), **GitHub/GitLab**, or the **Terraform Registry**.
            -   **Interface**:
            -   **Inputs**: Defined by `variable` blocks in the child module; passed via the `module` block in the parent.
            -   **Outputs**: Defined by `output` blocks in the child; used by the parent to retrieve information (like a Load Balancer's DNS).
            -   **Calling a Module**: To "call" a module, you define a `module` block and provide the `source` location along with any required input variables.

                ```ini
                # Example: Calling a child module from the root module
                module "network" {
                    source = "./modules/network"     # Location of the code
                    vpc_cidr = "10.0.0.0/16"         # Input variable passed to the module
                }
                ```

            </details>

        8. <details><summary style="font-size:20px;color:#C71585">data</summary>
                    
            -   [Data Block](https://developer.hashicorp.com/terraform/language/data-sources)

            > The `data` block is used to fetch or read data from external existing resources without creating or modifying them. This is useful for fetching details about existing infrastructure components (like AMIs, VPCs, etc.).

            -   Data sources are evaluated during planning, so Terraform can use that information to build the execution plan.
            -   Terraform resolves dependencies first, then fetches the referenced data before generating the plan.
            -   Retrieved data can be used in resource arguments, outputs, and other expressions.

            ```ini
            data "aws_ami" "example" {
                most_recent = true
                owners      = ["amazon"]
                filter {
                    name   = "name"
                    values = ["amzn2-ami-hvm-*"]
                }
            }
            ```
            ##### Some Critical Data Blocks

            -   **`data "aws_caller_identity" "current" {}`**: In Terraform, `data "aws_caller_identity" "current" {}` is a **Data Source**.

                > Instead of creating something new in your AWS account, a data source reaches out to AWS to fetch information about your existing infrastructure or session. Specifically, `aws_caller_identity` is the Terraform equivalent of running the AWS CLI command: `aws sts get-caller-identity`

                -   **What Information Does It Give You?**: Once you declare this data source, Terraform connects to AWS using your current provider credentials and populates three useful attributes:

                    1. **`account_id`**: The 12-digit AWS account ID currently being used.
                    2. **`arn`**: The Amazon Resource Name of the logged-in IAM user or role.
                    3. **`user_id`**: The unique identifier for the calling entity.

                -   **Why and How Do People Use It?**: The primary reason to use this is to **avoid hardcoding** values (like your AWS Account ID) into your Terraform configuration. This makes your code dynamic, secure, and reusable across multiple environments or accounts.

                    -   **Common Example: Building an S3 Bucket Policy**: If you need to create an S3 bucket policy that references your own account ID, you can use the data source to inject it automatically:

                        ```ini
                        # 1. Look up the current AWS identity
                        data "aws_caller_identity" "current" {}

                        # 2. Use the account ID in a resource
                        resource "aws_s3_bucket_policy" "example" {
                            bucket = aws_s3_bucket.my_bucket.id

                            policy = jsonencode({
                                Version = "2012-10-17"
                                Statement = [
                                    {
                                        Sid       = "AllowCurrentAccount"
                                        Effect    = "Allow"
                                        Principal = "*"
                                        Action    = "s3:*"
                                        Resource  = "${aws_s3_bucket.my_bucket.arn}/*"
                                        Condition = {
                                            StringEquals = {
                                                # This dynamically inserts your 12-digit account ID
                                                "aws:PrincipalAccount" = data.aws_caller_identity.current.account_id
                                            }
                                        }
                                    }
                                ]
                            })
                        }

                        ```

            -   **`data "aws_cloudformation_export" "example_name" {}`**: The aws_cloudformation_export data source in Terraform is used to retrieve the value of an output exported by an AWS CloudFormation stack. This is especially useful when you need to bridge existing CloudFormation infrastructure with new resources managed by Terraform.

                ```ini
                data "aws_cloudformation_export" "vpc_id" {
                    name = "11111"
                }
                ```

            -   **`data "terraform_remote_state" "trs" {}`**: **Terraform Remote State** data source is the standard way to share information (outputs) between two completely separate Terraform configurations.
                -   [Terraform Remote State data source](https://developer.hashicorp.com/terraform/language/state/remote-state-data)
                -   **The Syntax (Standard S3 Backend)**: If your "source" project stores its state in AWS S3, your data source block should look like this:

                    ```ini
                    data "terraform_remote_state" "trs" {
                        backend = "s3"

                        config = {
                            bucket = "your-terraform-state-bucket"
                            key    = "path/to/source/project/terraform.tfstate"
                            region = "us-east-1" # Or your specific region
                        }
                    }
                    ```

                -   **How to access the data**: To actually use the data from the remote state, the source project **must** have defined `output` blocks. You access them like this:

                    ```ini
                    resource "aws_instance" "app_server" { 
                        subnet_id     = data.terraform_remote_state.trs.outputs.subnet_id
                        ...
                    }
                    ```

            </details>

        9. <details><summary style="font-size:20px;color:#C71585">lifecycle</summary>

            > The `lifecycle` block inside a resource block is used to define special lifecycle management behaviors, such as preventing resource deletion or defining creation-time dependencies.

            ```ini
            resource "aws_s3_bucket" "example" {
                bucket = "my-bucket"
                lifecycle {
                    prevent_destroy = true
                }
            }
            ```

            </details>

        10. <details><summary style="font-size:20px;color:#C71585">provisioner</summary>

            > The provisioner block allows you to execute scripts or commands on a resource after it has been created or updated. Provisioners are typically used to configure resources (such as virtual machines) beyond the basic setup provided by the Terraform resource block. This might include installing software, configuring files, or setting up the environment after an instance or other resource is provisioned.

            ```ini
            provisioner "remote-exec" {
                inline = ["echo 'Wait until SSH is ready'"]

                connection {
                type        = "ssh"
                user        = local.ssh_user
                private_key = file(local.private_key_path)
                host        = aws_instance.nginx.public_ip
                }
            }
            provisioner "local-exec" {
                command = "ansible-playbook  -i ${aws_instance.nginx.public_ip}, --private-key ${local.private_key_path} nginx.yaml"
            }
            ```

            </details>

        </details>

    -   <details><summary style="font-size:20px;color:Magenta">Meta-Arguments</summary>

        > In Terraform, a **meta-argument** is a special argument that can be used with resources to control aspects of how those resources are managed rather than specifying properties of the resource itself. `Meta-arguments` give more control over lifecycle, dependencies, and iteration.

        1. **count**: The `count` meta-argument allows you to create multiple instances of a resource based on a given number.

            ```ini
            resource "aws_instance" "example" {
                count         = 3  # Creates 3 instances
                ami           = "ami-0c55b159cbfafe1f0"
                instance_type = "t2.micro"

                tags = {
                    Name = "ExampleInstance-${count.index}"
                }
            }
            ```

            - In this example, Terraform creates 3 instances. The `count.index` is used to give each instance a unique name tag like `ExampleInstance-0`, `ExampleInstance-1`, and `ExampleInstance-2`.

        2. **for_each**: The `for_each` meta-argument allows you to create resources based on a map or a set, where each item is uniquely identified by a key.

            ```ini
            resource "aws_instance" "example" {
                for_each      = {
                    "web" = "ami-0c55b159cbfafe1f0"
                    "db"  = "ami-0a313d6098716f372"
                }
                ami           = each.value
                instance_type = "t2.micro"

                tags = {
                    Name = "ExampleInstance-${each.key}"
                }
            }
            ```

            - In this example, Terraform creates two instances with different AMIs, one for `web` and one for `db`. Each instance gets a tag name of either `ExampleInstance-web` or `ExampleInstance-db`.

        3. **provider**: The `provider` meta-argument specifies which provider configuration should be used for a particular resource. This is useful if multiple provider configurations are defined.

            ```ini
            provider "aws" {
                alias  = "us_east"
                region = "us-east-1"
            }

            provider "aws" {
                alias  = "us_west"
                region = "us-west-2"
            }

            resource "aws_instance" "example" {
                provider      = aws.us_east  # Use the `us_east` provider configuration
                ami           = "ami-0c55b159cbfafe1f0"
                instance_type = "t2.micro"
            }
            ```

            - Here, Terraform uses the `us_east` provider configuration for this specific instance, even though other provider configurations are defined.

        4. **depends_on**: The `depends_on` meta-argument explicitly specifies dependencies for a resource. This ensures that the resource is created only after the specified dependencies have been created.

            ```ini
            resource "aws_security_group" "example_sg" {
            # Security group configuration
            }

            resource "aws_instance" "example_instance" {
                ami           = "ami-0c55b159cbfafe1f0"
                instance_type = "t2.micro"
                depends_on    = [aws_security_group.example_sg]  # Ensure SG is created first
            }
            ```

            - In this example, `example_instance` will only be created after `example_sg` has been created, ensuring proper ordering.

        5. **lifecycle**: The `lifecycle` meta-argument controls how Terraform manages changes to resources, including preventing deletion or customizing behavior during updates.

            ```ini
            resource "aws_instance" "example" {
                ami           = "ami-0c55b159cbfafe1f0"
                instance_type = "t2.micro"

                lifecycle {
                    create_before_destroy = true  # Replace old instance only after new one is created
                    prevent_destroy       = true  # Prevent accidental deletion
                }
            }
            ```

            - Here, `create_before_destroy` ensures that if an update requires replacement, the new resource is created before the old one is destroyed. `prevent_destroy` protects this instance from being accidentally deleted.

        6. **provisioner**: The `provisioner` meta-argument allows you to run scripts or commands on a resource after it has been created or destroyed. Common provisioners include `local-exec` (runs on the local machine) and `remote-exec` (runs on the remote resource).

            ```ini
            resource "aws_instance" "example" {
                ami           = "ami-0c55b159cbfafe1f0"
                instance_type = "t2.micro"

                provisioner "local-exec" {
                    command = "echo ${self.private_ip} > instance_ip.txt"
                }
            }
            ```

        </details>

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Multiple Environment Managements</summary>

    > Managing multiple environments (such as development, staging, and production) in Terraform is crucial for safety, isolation, and efficiency. There are three primary methods for environment management in Terraform:

    -   <details><summary style="font-size:20px;color:Magenta">Workspaces</summary>

        > **Workspaces** are designed to manage multiple, separate **state files** within a **single configuration**.

        - You keep one set of `*.tf` files and use the built-in `terraform workspace` commands to switch context.

            1. Create a new workspace: `terraform workspace new staging`
            2. Switch to it: `terraform workspace select staging`
            3. Run apply: `terraform apply`

        - Workspaces rely on the `terraform.workspace` variable, which you reference in your code to change resource attributes:

            ```terraform
            # Example: Use the workspace name to set the instance size
            resource "aws_instance" "app_server" {
                instance_type = var.instance_sizes[terraform.workspace]
                # ...
            }
            ```

        - **Best Use Case:** Spinning up temporary or **ephemeral environments** (e.g., a "sandbox" for a new team member, or a dedicated environment for a feature branch—like `pr-101`). They are best for configurations that are **nearly identical** except for simple variables (like size or name prefix).
        - **Caution:** HashiCorp advises **against** using workspaces for managing long-lived, critical environments like `prod` and `staging` because they all share the exact same code base, which increases the risk of deploying a change intended for `dev` to `prod`.

        -   **Best Practices & Warnings**

            -  **Environment Specific Vars:** This is a best practice to keep environment-specific settings—like the number of server instances, the database size, or a tag prefix—out of your main `.tf` files. Use workspaces in conjunction with `-var-file`.
                | Variable File | Use Case                   | Command                                 |
                | :------------ | :------------------------- | :-------------------------------------- |
                | `dev.tfvars`  | Small, cheap resources     | `terraform apply -var-file=dev.tfvars`  |
                | `prod.tfvars` | Large, expensive resources | `terraform apply -var-file=prod.tfvars` |
            -  **Avoid for Critical Isolation:** Most experts recommend using Workspaces for "similar" environments (Dev/QA/Staging) but using **separate directories or accounts** for Production to prevent accidental `terraform destroy` commands on the wrong workspace.
            -  **Shell Integration:** It is highly recommended to add the current Terraform workspace to your terminal prompt (Zsh/Bash) so you always know which environment you are currently "pointing" at.
            > **Peer Tip:** If you find yourself writing too many `if/else` statements using the `terraform.workspace` variable, your code might be getting too complex. At that point, consider using **Terraform Modules** instead.

        ##### how do you reference a resource created in a different workspace?

        > In Terraform, you **cannot** directly reference a resource from a different workspace using standard resource syntax (like `aws_instance.example.id`). Each workspace is an isolated silo with its own independent state. To access data from a different workspace, you must use a **Data Source** called `terraform_remote_state`. This allows one workspace to "read" the outputs of another workspace.

        1.  **Define Outputs in the Source Workspace**: Before a different workspace can see your data, you must explicitly export it as an `output` in your configuration.

            **In the "Network" workspace:**

            ```ini
            resource "aws_vpc" "main" {
                cidr_block = "10.0.0.0/16"
            }

            output "vpc_id" {
                value = aws_vpc.main.id
            }
            ```

        2.  **Use the Remote State Data Source**: In your "App" workspace, you configure a data source that points to the state file of the "Network" workspace. You specify the workspace name inside the `config` block.

            **In the "App" workspace:**

            ```ini
            data "terraform_remote_state" "network_layer" {
                backend = "s3" # Or "local", "gcs", "remote", etc.

                config = {
                    bucket    = "my-terraform-state-bucket"
                    key       = "network/terraform.tfstate"
                    region    = "us-east-1"
                    workspace = "dev" # This points to the 'dev' workspace specifically
                }
            }

            # Now you can reference the output
            resource "aws_instance" "web" {
                # ... other config ...
                subnet_id = data.terraform_remote_state.network_layer.outputs.vpc_id
            }
            ```

        3.  **Making it Dynamic**: Hardcoding `workspace = "dev"` defeats the purpose of workspaces. Usually, you want your "App" workspace to pull from the "Network" workspace of the **same name**. You can use the `${terraform.workspace}` variable to make this automatic.

            ```ini
            data "terraform_remote_state" "network" {
                backend = "s3"
                config = {
                    bucket    = "my-terraform-state-bucket"
                    key       = "network/terraform.tfstate"
                    region    = "us-east-1"
                    workspace = terraform.workspace # Dynamically matches current workspace
                }
            }
            ```

        -   **Key Considerations**:

            | Factor             | Description                                                                                                                                                 |
            | ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
            | **Permissions**    | The user running Terraform must have read access to the backend storage (e.g., S3 Bucket) of the source workspace.                                          |
            | **Sensitive Data** | Be careful! Any output you define is stored in plain text in the state file and will be visible to anyone who can read the remote state.                    |
            | **Coupling**       | This creates a dependency. If you delete the "Network" workspace, the "App" workspace will fail its next plan because the data source will return an error. |

        > Sharing data via **AWS SSM Parameter Store** (or a similar key-value store like Azure Key Vault) is often considered a "cleaner" architectural pattern than reading remote state. It creates a **producer-consumer** relationship that doesn't require the App team to have access to the Network team's sensitive state files. Here is how you set this up.

        1. **The Producer (Network Workspace)**: In your network configuration, you create a "Resource" that writes the value to the Cloud provider's parameter store. You use the workspace name in the path to keep things organized.

            ```ini
            # In the Network Workspace
            resource "aws_ssm_parameter" "vpc_id" {
                name  = "/network/${terraform.workspace}/vpc_id"
                type  = "String"
                value = aws_vpc.main.id
            }
            ```

        2. **The Consumer (App Workspace)**: In your application configuration, you simply use a **Data Source** to look up that specific path.

            ```ini
            # In the App Workspace
            data "aws_ssm_parameter" "network_vpc" {
                name = "/network/${terraform.workspace}/vpc_id"
            }

            # Reference it in your resources
            resource "aws_instance" "app" {
                # ...
                subnet_id = data.aws_ssm_parameter.network_vpc.value
            }
            ```

        3. **Why this is often better than Remote State**

            | Feature        | Remote State Method                                   | SSM / Parameter Store Method                          |
            | -------------- | ----------------------------------------------------- | ----------------------------------------------------- |
            | **Security**   | Requires access to the entire state file (risky).     | Requires access only to specific keys.                |
            | **Coupling**   | High: Changes in State structure can break consumers. | Low: Consumers only care about the Key Name.          |
            | **Visibility** | Hard to see values without CLI tools.                 | Easy to see and edit values in the AWS/Azure Console. |
            | **Cross-Tool** | Only works with Terraform.                            | Works with Python, Shell scripts, Lambda, etc.        |

        4. **Handling Dependencies**: One thing to watch out for: **Timing.**

            -   If the App workspace runs `terraform plan` before the Network workspace has finished creating the SSM parameter, the plan will fail.
            -   Most CI/CD pipelines handle this by running the "Core" or "Network" infrastructure jobs first.

        </details>

    -   <details><summary style="font-size:20px;color:Magenta">Separate Directories (Recommended Best Practice)</summary>

        > **Separate Directories** approch is the most widely recommended and robust solution for managing **long-lived, distinct environments** like `dev`, `staging`, and `prod`. Instead of using a single configuration, you create a dedicated root module (a separate folder) for each environment.

        - **File Structure**:

            ```
            ├── modules/
            │   ├── vpc/             # Reusable module for VPC resources
            │   └── database/        # Reusable module for DB resources
            ├── envs/
            │   ├── dev/
            │   │   ├── main.tf      # Calls modules in ../../modules
            │   │   ├── backend.tf   # Configures a unique, separate state file
            │   │   └── dev.tfvars   # Small, cheap instance sizes
            │   ├── staging/
            │   │   ├── main.tf
            │   │   ├── backend.tf
            │   │   └── staging.tfvars # Medium instance sizes
            │   └── prod/
            │       ├── main.tf
            │       ├── backend.tf
            │       └── prod.tfvars  # Large, highly available instance sizes
            ```

        -   **Maximum Isolation (Best for Production):** Each environment has its own completely separate **state file** and remote backend (e.g., different keys in an S3 bucket or GCS), ensuring that a mistake in `dev` cannot affect `prod`.
        -   **Architectural Flexibility:** Because each folder is an independent configuration, you can deploy different resource types, providers, or even different architectural designs in one environment compared to another.
        -   **Clearer CI/CD Integration:** You can easily restrict who can run `terraform apply` on the `envs/prod` directory and ensure production deploys only run on the `main` branch.

        </details>

    -   **External Tools (Terragrunt)**:For large-scale infrastructure using the **Separate Directories** approach, you may find yourself repeating backend configuration or module calls in many directories.

        -   **Terragrunt** is a popular open-source wrapper tool that addresses this repetition by letting you define configurations once and inherit them across all environment directories, keeping your entire infrastructure code **D**on't **R**epeat **Y**ourself (DRY).

    -   **NOTES ON `.tfvars`**:Regardless of whether you choose Separate Directories or Workspaces, you will use **Terraform Variable Definition Files (`.tfvars`)** to manage environment-specific values.


    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Setting Input variables in order of precedence</summary>

    The order of precedence for setting **Input Variables** in Terraform determines which value is used when multiple sources attempt to define the same variable. Terraform uses the first value it finds, starting from the highest priority source and moving down. Here is the complete order of precedence, from **highest priority (1)** to **lowest priority (6)**:

    1. **The `-var` flag on the CLI (Highest)**: Values passed directly on the command line using the `-var` flag take the highest precedence. This is often used for quick overrides or sensitive values that shouldn't be committed to files.

        - `$ terraform apply -var="instance_type=t2.micro"`

    2. **The `-var-file` flag on the CLI**: Values loaded from a file specified using the `-var-file` flag are the second highest priority. If you use this flag multiple times, files are processed in order, with later files overriding earlier ones.

        - `$ terraform apply -var-file="secrets.tfvars" -var-file="dev.tfvars"`
          -> Values in `dev.tfvars` would override values in `secrets.tfvars`.

    3. **Environment Variables**: Terraform automatically recognizes environment variables with the prefix `TF_VAR_`. The variable name is everything after the prefix.

        - **Example:** Setting the environment variable `TF_VAR_instance_type` will set the Terraform variable named `instance_type`.
            ```bash
            export TF_VAR_region="us-east-1"
            ```

    4. **Automatically Loaded Variable Definition Files**: Terraform automatically loads variables from files named in the following exact order:

        1. Files named **`terraform.tfvars`** (or `terraform.tfvars.json`)
        2. Files with names ending in **`.auto.tfvars`** (or `.auto.tfvars.json`)
        -   **NOTES**: If both file types are present, `terraform.tfvars` is processed first, followed by all files matching `*.auto.tfvars` in alphabetical order.

    5. **Variables in the `variables.tf` file (Default Values)**: If a variable block in your configuration (e.g., in `variables.tf`) includes a **`default`** value, that value is used if no value is provided by any of the higher-precedence sources (1 through 4).

        - **Example:**
            ```terraform
            variable "instance_type" {
                type    = string
                default = "t3.medium" # Used if no value is set elsewhere
            }
            ```

    6. **Prompted Input (Lowest)**: If a variable is declared with **no default value** and is not set by any of the higher-precedence sources, Terraform will **prompt the user** to enter a value during execution.

    > The primary takeaway is that **command-line arguments and flags always override file-based or environment-based settings.**

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Hashicorp Configuration Language(HCL)</summary>

    -   [Terraform Configuration Syntex](https://developer.hashicorp.com/terraform/language/syntax/configuration)

    -   `Arguments`: An argument assigns a value to a particular name:

        ```ini
        image_id = "abc123"
        ```

        -   The identifier before the equals sign is the argument name, and the expression after the equals sign is the argument's value.

    -   `Identifiers`:

        -   Argument names, block type names, and the names of most Terraform-specific constructs like resources, input variables, etc. are all identifiers.
        -   Identifiers can contain letters, digits, underscores (`_`), and hyphens (`-`). The first character of an identifier must not be a digit, to avoid ambiguity with literal numbers.

    -   `Comments`: The Terraform language supports three different syntaxes for comments:

        -   `#` begins a single-line comment, ending at the end of the line.
        -   `//` also begins a single-line comment, as an alternative to `#`.
        -   `/*` and `*/` are start and end delimiters for a comment that might span over multiple lines.

    -   [`Modules`, `Variables` and `Outputs`](https://developer.hashicorp.com/terraform/language/values): If you're familiar with traditional programming languages, it can be useful to compare Terraform's

        -   `modules` to function definitions.
        -   `Input` variables are like function arguments.
        -   `Output` values are like function return values.
        -   `Local` values are like a function's temporary local variables.

    -   [Expressions in HCL](https://developer.hashicorp.com/terraform/language/expressions):

        -   **Other expression types:**

            -   For expressions
            -   Splat expressions
            -   Dynamic blocks
            -   Type constraints
            -   Version constraints

    -   [Meta-Arguments]()

    #### Collections

    - [Conversion of Complex Types](https://developer.hashicorp.com/terraform/language/expressions/type-constraints#conversion-of-complex-types)

    1. **Lists (`list(...)`)**: a sequence of values identified by consecutive whole numbers starting with zero.

        -   The keyword list is a shorthand for `list(any)`, which accepts any element type as long as every element is the same type. This is for compatibility with older configurations; for new code, we recommend using the full form.

        ```ini
        # Declare a list of availability zones
        variable "availability_zones" {
            type    = list(string)
            default = ["us-west-2a", "us-west-2b", "us-west-2c"]
        }
        ```

    2. **Tuple (`tuple(...)`)**: a sequence of elements identified by consecutive whole numbers starting with zero, where each element has its own type.

        -   The schema for tuple types is `[<TYPE>, <TYPE>, ...]` — a pair of square brackets containing a comma-separated series of types. Values that match the tuple type must have exactly the same number of elements (no more and no fewer), and the value in each position must match the specified type for that position.
        -    a tuple type of `tuple([string, number, bool])` would match a value like the following: `["a", 15, true]`

    3. **Maps**:

        - Maps allow you to create key-value pairs for organizing and accessing data. Example:

        ```ini
        # Declare a map for tags
        variable "tags" {
            type    = map(string)
            default = { "env" : "dev", "app" : "web" }
        }
        ```

    4. **Object (`object(...)`)***: a collection of named attributes that each have their own type.

        -   The schema for object types is `{ <KEY> = <TYPE>, <KEY> = <TYPE>, ... }` — a pair of curly braces containing a comma-separated series of `<KEY> = <TYPE>` pairs. Values that match the object type must contain all of the specified keys, and the value for each key must match its specified type. (Values with additional keys can still match an object type, but the extra attributes are discarded during type conversion.)

    3. `For Each`:

        - The for_each expression is used for resource iteration. Example:

        ```ini
        # Use for_each to create multiple instances of an AWS EC2 instance
        resource "aws_instance" "example" {
            for_each = toset(["a", "b", "c"])

            ami           = "ami-0c55b159cbfafe1f0"
            instance_type = "t2.micro"
        }

        # Define a set of instance names
        variable "instance_names" {
            type    = set(string)
            default = ["web", "db", "cache"]
        }

        # Create multiple instances using for_each
        resource "aws_instance" "example" {
            for_each = var.instance_names

            ami           = "ami-12345678"
            instance_type = "t2.micro"
            tags = {
                Name = each.key
            }
        }

        # Access set elements in a resource
        resource "aws_instance" "example" {
            for_each = var.instance_names

            ami           = "ami-12345678"
            instance_type = "t2.micro"
            tags = {
                Name = each.key
            }
        }

        variable "database_config" {
        description = "Configuration settings for the database cluster"
        type = object({
            instance_count = number
            instance_class = string
            allocated_gb   = number
            publicly_accessible = bool
        })

        default = {
            instance_count      = 2
            instance_class      = "db.t3.micro"
            allocated_gb        = 20
            publicly_accessible = false
        }
        }

        # Define a map of instance configurations
        variable "instance_configurations" {
            type = map(object({
                ami           = string
                instance_type = string
            }))
            default = {
                web   = { ami = "ami-12345678", instance_type = "t2.micro" }
                db    = { ami = "ami-87654321", instance_type = "t2.small" }
                cache = { ami = "ami-56781234", instance_type = "t2.nano" }
            }
        }

        # Create multiple instances using for_each
        resource "aws_instance" "example" {
            for_each = var.instance_configurations

            ami           = each.value.ami
            instance_type = each.value.instance_type
            tags = {
                Name = each.key
            }
        }
        ```

    #### [Built-in Functions](https://developer.hashicorp.com/terraform/language/functions)

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Terraform Interview Questions</summary>

    #### Terraform Fundamentals

    -   <details><summary style="font-size:18px;color:#C71585">What is Terraform State File? How do you manage it?</summary>

        The Terraform **State File** is a crucial component that acts as the **single source of truth** for your infrastructure managed by Terraform.

        It is a JSON file (typically named `terraform.tfstate`) that maps the real-world resources (like AWS EC2 instances, Azure VMs, or Google Cloud networks) to your Terraform configuration files.

        -   **Purpose of the State File**: The state file serves three primary purposes:

            1.  **Mapping and Tracking:** It keeps track of the **metadata** and **current status** of the resources Terraform has created. When you run a command like `terraform plan`, Terraform reads the state file to know which remote resources it should compare against the desired configuration in your `.tf` files.
            2.  **Performance Improvement:** By storing resource attributes (like IDs, IPs, and dependencies) locally, Terraform can often avoid making unnecessary, repetitive API calls to the cloud provider, speeding up planning and execution.
            3.  **Dependency Management:** Terraform uses the state file to understand the relationships between resources and correctly determine the order in which they should be created, updated, or destroyed.

            > **Example:** If you define an AWS VPC and a Subnet, the state file stores the actual ID of the created VPC, which the Subnet resource then references during its creation.

        -   **How to Manage the Terraform State File**: Managing the state file involves two main considerations: **Location** and **Security/Integrity**.

            1. **Remote State Storage (Location)**: While Terraform defaults to a local state file, this is only suitable for individual, non-collaborative use. For team environments, you **must** use a **Remote Backend** to store the state file.

                This is configured within the **`terraform` block** of your configuration (e.g., in a file like `backend.tf`).

                | Backend Type            | Benefits                                         | Configuration Example (in `backend.tf`)                                                                      |
                | :---------------------- | :----------------------------------------------- | :----------------------------------------------------------------------------------------------------------- |
                | **Amazon S3**           | Highly available, durable, inexpensive.          | `backend "s3" { bucket = "my-tf-state"; key = "prod/state"; region = "us-east-1" }`                          |
                | **Azure Storage**       | Microsoft cloud equivalent.                      | `backend "azurerm" { container_name = "tfstate"; key = "prod.tfstate"; storage_account_name = "mystorage" }` |
                | **Terraform Cloud/HCP** | Fully managed state, built-in remote operations. | `cloud { organization = "my-org"; workspace = "prod" }`                                                      |

            2. **State Locking (Integrity)**: When multiple team members or CI/CD pipelines attempt to modify the infrastructure simultaneously, the state file can become corrupted.

                **State locking** prevents this by creating a lock on the state file when an operation (`plan`, `apply`, `destroy`) begins and releasing it only when the operation finishes.

                - Most **Remote Backends** (like S3, Azure, or GCS) natively support locking by leveraging a secondary service (e.g., DynamoDB for S3).
                - **Terraform Cloud/HCP** provides state locking inherently as part of its managed service.

            3. **State Manipulation (Security and Maintenance)**: You should generally avoid manually editing the state file. However, Terraform provides several commands for safe state management:

                | Command                           | Purpose                                                                                                             |
                | :-------------------------------- | :------------------------------------------------------------------------------------------------------------------ |
                | `terraform state list`            | Shows all resources tracked in the current state file.                                                              |
                | `terraform state show <address>`  | Displays the attributes of a specific resource.                                                                     |
                | `terraform state mv <old> <new>`  | Renames or moves a resource entry in the state without touching the real resource.                                  |
                | `terraform state rm <address>`    | Removes a resource from the state file **without destroying the real resource** (useful for taking manual control). |
                | `terraform import <address> <id>` | Adds an existing, unmanaged resource to the state file.                                                             |

        -   **Important Note**:

            -   The Terraform state file can contain sensitive information like database passwords, private keys, and API tokens if they are configured directly in your `.tf` files.
            -   Therefore, you must ensure that your remote backend is configured for **at-rest encryption** (e.g., using S3 bucket encryption or Azure Storage encryption) to protect this sensitive data.

        </details>

    -   <details><summary style="font-size:18px;color:#C71585">What is the purpose of terraform block in Terraform configuration?</summary>

        The `terraform block` is a top-level configuration block that is used to define settings and configurations for Terraform itself. It is not directly related to the infrastructure being provisioned but rather controls how Terraform operates.

        In Terraform, the `terraform` block is a top-level configuration block that is used to define settings and configurations for Terraform itself. It is not directly related to the infrastructure being provisioned but rather controls how Terraform operates.

        1. **Specifying Backend Configuration**:
            - The `backend` section within the `terraform` block defines where Terraform stores the **state file**.
            - Backends can be local (default) or remote (e.g., S3, Azure Blob Storage, Google Cloud Storage).
        2. **Defining Required Providers**: The `required_providers` block specifies which providers Terraform will use, including their source and version constraints.
        3. **Setting Required Terraform Version**: The `required_version` attribute ensures that the Terraform configuration is compatible with a specific version or range of Terraform versions.
        4. **Enabling Experiments or Features**: Used to enable experimental features or feature flags in Terraform.
        5. **Using Terraform Cloud or Enterprise**: Configuration to use Terraform Cloud or Enterprise for remote operations and state management.
        6. **Controlling Dependency Lock Files**: Terraform uses a lock file (`.terraform.lock.hcl`) to record the provider versions being used. The `terraform` block can define settings for this behavior indirectly through provider configuration.

        -   **Example Full `terraform` Block**:

            ```ini
            terraform {
                required_version = ">= 1.3.0"

                backend "s3" {
                    bucket         = "my-terraform-state"
                    key            = "state/terraform.tfstate"
                    region         = "us-east-1"
                }

                required_providers {
                    aws = {
                        source  = "hashicorp/aws"
                        version = "~> 4.0"
                    }
                }
            }
            ```

        -   **Summary**: The `terraform` block is primarily used to
            -   Configure backend storage for the state file.
            -   Define provider dependencies.
            -   Set version constraints for Terraform.
            -   Enable features or manage Terraform Cloud/Enterprise settings.

        </details>

    -   <details><summary style="font-size:18px;color:#C71585">What is provider in Terraform? When and why you need to define multiple providers?</summary>

        A **provider** in Terraform is a plugin that acts as an interface between Terraform and a specific API. It's responsible for understanding the necessary API interactions and exposing **resources** (e.g., a virtual machine, a database, a network) that you can manage and configure in your Terraform code.

        Essentially, the provider defines the universe of infrastructure you can interact with.

        ##### Components of a Provider

        -   **API Wrapper:** The provider handles authentication and translates your HCL configuration into the specific API calls required by the cloud platform (like AWS, Azure, Google Cloud) or service (like Kubernetes, GitHub, Splunk).
        -   **Resources and Data Sources:** Providers define the schema for the resources they manage. For example, the `aws` provider defines the `aws_instance` resource and the `aws_vpc` resource, along with their respective arguments.

        You declare which providers you need in the **`terraform` block** and configure them in the **`provider` block**:

        ```terraform
        terraform {
            required_providers {
                # Define the source and required version
                aws = {
                source  = "hashicorp/aws"
                version = "~> 5.0"
                }
            }
        }

        # Configure the provider (default block)
        provider "aws" {
            region = "us-east-1"
        }
        ```

        ##### When and Why You Need to Define Multiple Providers

        Defining multiple provider configurations is necessary when you need to interact with the same underlying service or cloud platform in different, distinct ways within a single configuration. This is accomplished using **Provider Aliases**.

        This is required in two main scenarios:

        1. **Different Geographic Regions (Multiple Regions)**

            - **When:** Your infrastructure needs to span multiple, distinct geographical regions within the same cloud provider (e.g., deploying a global application where the primary API servers are in `us-east-1` and disaster recovery assets are in `eu-west-1`).

            - **Why:** A single, unaliased provider block can only manage resources in one region. You need a dedicated, aliased configuration for each region.

            - **Example:**

                ```terraform
                # Default provider block (no alias) for the primary region
                provider "aws" {
                    region = "us-east-1"
                }

                # Aliased provider block for the disaster recovery region
                provider "aws" {
                    alias  = "dr" # The alias name is 'dr'
                    region = "eu-west-1"
                }

                # The resource creation must explicitly use the alias
                resource "aws_s3_bucket" "dr_bucket" {
                    provider = aws.dr # Use the aliased provider
                    bucket   = "dr-backup-data"
                }
                ```

        2. **Different Accounts or Credentials (Multiple Accounts)**

            - **When:** You need to deploy resources across different, isolated cloud accounts (e.g., a **production account** and a **development account**) for security and billing separation, but manage both from the same root Terraform configuration.

            - **Why:** Each account requires unique authentication credentials (or a distinct IAM role). An alias allows you to specify a unique set of credentials for a specific provider instance.

            - **Example:**

                ```terraform
                # Default provider block for the Development Account
                provider "aws" {
                    region  = "us-east-1"
                    profile = "dev-profile" # Credentials stored locally in AWS CLI config
                }

                # Aliased provider block for the Production Account
                provider "aws" {
                    alias  = "prod"
                    region = "us-east-1"
                    # Assume a specific role for production access
                    assume_role {
                        role_arn = "arn:aws:iam::123456789012:role/TerraformProdRole"
                    }
                }

                # Resources use the appropriate aliased provider
                resource "aws_vpc" "prod_vpc" {
                    provider = aws.prod # Use the Production provider
                    cidr_block = "10.0.0.0/16"
                }
                ```

        </details>

    -   <details><summary style="font-size:18px;color:#C71585">How does Terraform handle secrets or sensitive information?</summary>

        Terraform provides the sensitive argument for variables to mark sensitive information. Secrets can also be stored in environment variables.

        Terraform provides several mechanisms for handling secrets or sensitive information securely:

        -   **Sensitive Data Handling**: Terraform offers the sensitive argument to mark sensitive values within resources. When a value is marked as sensitive, Terraform will prevent it from being displayed in the plan or any output, including state files.

            ```ini
            resource "aws_secretsmanager_secret" "example" {
                name = "example"
                secret_string = "super_secret_value"
                sensitive = true
            }
            ```

        -   **Backend Configuration**: Terraform's backend configuration can be used to specify where state data is stored. It is recommended to use a backend that supports encryption and access control, such as Amazon S3 with server-side encryption enabled.

            ```ini
            terraform {
                backend "s3" {
                    bucket = "example-bucket"
                    key = "terraform/state.tfstate"
                    region = "us-east-1"
                    dynamodb_table = "terraform-lock"
                    encrypt = true
                }
            }
            ```

        -   **Input Variables and Environment Variables**: Input variables can be defined in Terraform configuration files to parameterize configurations. When sensitive information is required as input, it is recommended to use environment variables or input variables defined in separate files that are not checked into source control.

            ```ini
            variable "db_password" {
                type = string
                default = ""
            }
            ```

        -   **Provider Credentials**: Provider credentials, such as AWS access keys or Azure Service Principal credentials, should be managed using secure mechanisms provided by the respective cloud provider. For example, AWS IAM roles or Azure Managed Identities can be used to provide credentials securely without exposing them in Terraform configuration files.
        -   **Secrets Management Integration**: Terraform integrates with third-party secrets management solutions, such as HashiCorp Vault or AWS Secrets Manager, to manage sensitive information securely. These solutions can be used to store and retrieve secrets dynamically during Terraform execution.

            ```ini
            data "aws_secretsmanager_secret" "example" {
                name = "example"
            }

            resource "aws_db_instance" "example" {
            # ...
                password = data.aws_secretsmanager_secret.example.secret_string
            }
            ```

        By leveraging these mechanisms, Terraform enables secure handling of secrets and sensitive information, reducing the risk of exposure and ensuring compliance with security best practices.

        </details>

    -   <details><summary style="font-size:18px;color:#C71585">What is Terraform, and why is it used?</summary>

        **Terraform** is an open-source **Infrastructure as Code (IaC)** tool developed by HashiCorp that allows users to define, provision, and manage infrastructure resources in a declarative manner. Terraform enables the automation of infrastructure across various cloud platforms, data centers, and other service providers.

        ##### Why Terraform is Used:

        1. **Infrastructure as Code (IaC)**:

            - Terraform enables users to define infrastructure using **declarative configuration files** (written in HashiCorp Configuration Language, HCL, or JSON).
            - These files describe the desired state of your infrastructure, and Terraform ensures that this state is achieved and maintained.

        2. **Multi-Cloud and Multi-Provider Support**:

            - Terraform supports a wide range of cloud providers such as **AWS**, **Azure**, **Google Cloud**, and many others.
            - It also integrates with services and platforms like Kubernetes, GitHub, Datadog, etc., allowing you to manage diverse infrastructure in a unified way.

        3. **Declarative and Consistent**:

            - In a declarative approach, users define the desired outcome (e.g., "I want 3 EC2 instances"), and Terraform takes care of making it happen, rather than writing out step-by-step instructions.
            - Terraform manages the **dependency graph** of resources, ensuring that resources are created, updated, or destroyed in the correct order.

        4. **Automation and Orchestration**:

            - Terraform automates the provisioning, scaling, and de-provisioning of infrastructure resources.
            - It simplifies complex tasks by allowing users to define reusable modules, automatically handling configuration drift, and tracking dependencies across resources.

        5. **State Management**:

            - Terraform uses a **state file** (`terraform.tfstate`) to track the current state of the infrastructure. This allows Terraform to understand what changes need to be made in the infrastructure to match the desired state defined in the configuration.
            - This state can be stored locally or remotely (e.g., in S3, Terraform Cloud, etc.) for better collaboration and consistency.

        6. **Plan and Apply Workflow**:

            - Terraform allows users to **plan** changes before applying them with the `terraform plan` command, giving a detailed view of what actions will be taken (creating, modifying, or destroying resources).
            - After reviewing the plan, users can apply the changes with the `terraform apply` command, ensuring a controlled and auditable process for modifying infrastructure.

        7. **Version Control and Collaboration**:

            - Since infrastructure is defined as code, Terraform files can be stored in version control systems (such as Git), enabling versioning, collaboration, and auditing.
            - Teams can collaborate on infrastructure changes using pull requests, code reviews, and other version control practices.

        8. **Modularity and Reusability**:

            - Terraform allows users to create **modules** (collections of resources) that can be reused across different environments, projects, or teams, ensuring consistency and reducing duplication.

        9. **Provisioning Across Environments**:

            - Terraform can be used to manage infrastructure for **development**, **staging**, and **production** environments using the same codebase, enabling consistency and reducing configuration drift between environments.

        10. **Extensibility**:
            - Terraform supports **custom providers** and can be extended with plugins, making it highly flexible to manage infrastructure across various types of services or custom environments.

        ##### Example Terraform Use Cases:

        -   **Provisioning cloud resources** like virtual machines, networks, databases, and load balancers.
        -   **Managing multi-cloud infrastructure** by provisioning resources across AWS, GCP, and Azure in a unified way.
        -   **Creating and managing Kubernetes clusters** and deploying applications on them.
        -   **Managing infrastructure as code** for development, testing, and production environments with version control.
        -   **Automating infrastructure changes** and reducing manual intervention in infrastructure scaling or decommissioning.

        ##### Key Benefits of Terraform:

        -   **Consistency**: Ensures your infrastructure is always configured the way you want it to be.
        -   **Scalability**: Manages large-scale infrastructure and automates scaling as your needs grow.
        -   **Collaborative**: With version control, teams can work together on infrastructure changes, just like application code.
        -   **Infrastructure Auditing**: Every change is tracked and can be reviewed before being applied, leading to better governance and security.

        </details>

    -   <details><summary style="font-size:18px;color:#C71585">How do you handle dependency management between Terraform resources?</summary>

        -   Terraform automatically manages dependencies between resources. It understands the order in which resources need to be created or updated.

        </details>

    -   <details><summary style="font-size:18px;color:#C71585">Explain the concept of idempotency in Terraform.</summary>

        Idempotency ensures that running the same Terraform configuration multiple times results in the same infrastructure state, regardless of the initial state.

        </details>

    -   <details><summary style="font-size:18px;color:#C71585">What is the purpose of Terraform providers?</summary>

        Providers in Terraform are responsible for understanding and interacting with APIs of specific infrastructure platforms. The "aws" provider, for example, manages resources on AWS.

        </details>

    -   <details><summary style="font-size:18px;color:#C71585">What is the Terraform configuration file, and what extension does it have?</summary>

        A Terraform configuration file is a script or a set of files written in HashiCorp Configuration Language (HCL) that defines the infrastructure and resources to be provisioned or managed by Terraform. These files typically have a `*.tf` extension. The configuration specifies the infrastructure components, their relationships, configurations, and other details necessary for provisioning and managing infrastructure.

        </details>

    -   <details><summary style="font-size:18px;color:#C71585">Explain the perpose of the <b>terraform init</b>, <b>terraform plan</b>, <b>terraform apply</b>, <b>terraform destroy</b> commands.</summary>

        -   `terraform init`: Initializes the Terraform working directory, downloading necessary provider plugins and configuring the backend.
        -   `terraform plan`: Creates an execution plan, displaying the changes Terraform will apply to the infrastructure without actually making modifications.
        -   `terraform apply`: Applies the planned changes to the infrastructure, creating or updating resources according to the Terraform configuration.
        -   `terraform destroy`: Initiates the destruction of provisioned resources, reverting the infrastructure to its pre-deployment state.

        </details>

    -   <details><summary style="font-size:18px;color:#C71585">Explain the purpose of the <b>terraform.tfstate</b>, <b>terraform.tfstate.backup</b>, and <b>terraform.lock.hcl</b> file.</summary>

        -   **terraform.tfstate**: It is the default Terraform state file that records the current state of the infrastructure managed by Terraform, including resource metadata, dependencies, and attribute values
        -   **terraform.tfstate.backup**: A backup of the previous state file (terraform.tfstate) created automatically before each terraform apply, providing a fallback in case of accidental data loss or errors during the apply process.
        -   **terraform.lock.hcl**: The `terraform.lock.hcl` file is a lock file generated by Terraform when using Terraform 0.14 and later versions. It is used to lock the versions of providers and modules used in a Terraform configuration to ensure reproducibility and consistency across different environments and executions.

        -   `Purpose`:

            -   The `terraform.lock.hcl` file records the exact versions of providers and modules used in a Terraform configuration when it is initialized or updated.
            -   It serves as a lock file to freeze the versions of dependencies, preventing unexpected changes in the versions of providers and modules during subsequent executions.

        -   `Usage`:

            -   When running `terraform init`, Terraform checks for the presence of the `terraform.lock.hcl` file in the working directory.
            -   If the lock file exists, Terraform installs the exact versions of providers and modules specified in the file, ensuring that the same versions are used consistently across environments.
            -   If the lock file does not exist, Terraform generates one based on the current configuration and installed versions of providers and modules.

        -   `Managing Dependencies`:

            -   The `terraform.lock.hcl` file simplifies dependency management by providing a deterministic way to specify and track dependencies.
            -   It helps avoid unexpected changes in dependencies due to updates or changes in upstream sources, ensuring that infrastructure deployments are reproducible and reliable.

        -   By using the `terraform.lock.hcl` file, Terraform users can achieve greater confidence in the consistency and reliability of their infrastructure deployments, as it helps ensure that the same versions of providers and modules are used across different environments and executions.

        </details>

    -   <details><summary style="font-size:18px;color:#C71585">What is Terraform backend? Explain the purpose of Terraform Backends.</summary>

        -   Terraform backend is a configuration block that defines where and how Terraform stores its state files. The state file contains information about the infrastructure managed by Terraform, such as resource metadata, dependencies, and attribute values.
        -   There are various types of backends supported by Terraform, including local, remote, and enhanced backends. Some popular backends include:

        -   `Local Backend`: Stores the state file on the local disk. This is the default if no backend configuration is provided. It is suitable for solo developers working on small projects.
        -   `Remote Backends` (e.g., Amazon S3, Azure Storage, Google Cloud Storage): Store the state file remotely, allowing collaboration and better management of infrastructure. Remote backends often include additional features like state locking to prevent conflicts during concurrent operations.
        -   `Terraform Cloud/Enterprise Backend`: Terraform Cloud and Terraform Enterprise are managed services that provide collaboration features, remote state storage, and other enterprise-level capabilities.

        </details>

    -   <details><summary style="font-size:18px;color:#C71585">What is Terraform remote state, and why is it used?</summary>

        **Terraform remote state** refers to storing the state file (`terraform.tfstate`) in a remote location rather than on the local filesystem. This allows multiple users and systems to access and work with the state in a shared environment, facilitating collaboration and improving consistency.

        ##### Why Terraform Remote State is Used:

        1. **Collaboration**:

            - When multiple team members are working on the same infrastructure, having a **shared state** is essential. Local state files are isolated and do not reflect changes made by others, leading to inconsistencies. Remote state allows all team members to work with the same, up-to-date state.
            - For example, if one user provisions a resource and another user runs Terraform commands locally, the latter might inadvertently overwrite the existing resources. Remote state ensures everyone uses the latest state of the infrastructure.

        2. **State Locking**:
            - Remote state storage typically supports **state locking**, which prevents multiple users from modifying the state file at the same time. This helps avoid conflicts and ensures that only one `terraform apply` operation runs at a time.
            - When a user starts running Terraform operations, the state is locked until the operation completes. This locking mechanism is crucial for preventing race conditions and state corruption in collaborative environments.
        3. **Security**:

            - Local state files may contain **sensitive information**, such as secrets, credentials, or access keys. Storing the state file remotely in a secure environment (e.g., an S3 bucket with encryption and access control) is a best practice to avoid security risks associated with exposing sensitive data.
            - In a remote setup, you can enforce encryption at rest and in transit, access control policies, and audit logging to secure the state file properly.

        4. **Consistency Across Environments**:

            - Remote state ensures that different environments (e.g., development, staging, production) share the correct state files for their respective configurations. This reduces the risk of applying changes to the wrong environment, which can occur if state files are managed locally.

        5. **Team Collaboration in CI/CD Pipelines**:

            - When using CI/CD pipelines to automate infrastructure changes, storing state remotely ensures that pipeline jobs and other users have access to the latest state.
            - For example, when running automated tests or deployments in a pipeline, remote state ensures that the infrastructure matches the desired configuration and that all jobs work from the same infrastructure state.

        6. **Backups and Recovery**:
            - Remote backends like S3, GCS, or Terraform Cloud can be configured to automatically create **versioned backups** of your state files, making it easy to roll back if something goes wrong or if state corruption occurs.

        ##### Common Backends for Remote State:

        Terraform supports a wide variety of **remote backends** for storing state, some of the most commonly used ones include:

        -   **Amazon S3** (with DynamoDB for state locking)
        -   **Google Cloud Storage (GCS)**
        -   **Azure Blob Storage**
        -   **HashiCorp's Terraform Cloud/Enterprise**
        -   **Consul**
        -   **PostgreSQL**
        -   **Artifactory**

        ##### Example of Configuring Remote State in Terraform:

        Here’s how you can configure remote state with **Amazon S3** as the storage backend and **DynamoDB** for state locking.

        ```ini
        terraform {
        backend "s3" {
            bucket         = "my-terraform-state-bucket"
            key            = "project/terraform.tfstate"
            region         = "us-west-2"
            encrypt        = true
            dynamodb_table = "terraform-state-lock"
        }
        }
        ```

        ###### Explanation:

        -   **`bucket`**: The S3 bucket where the state file will be stored.
        -   **`key`**: The path to the state file in the bucket (useful if multiple projects share the same bucket).
        -   **`region`**: The AWS region where the bucket resides.
        -   **`encrypt`**: Ensures the state file is encrypted at rest in S3.
        -   **`dynamodb_table`**: Specifies the DynamoDB table to use for state locking, preventing concurrent state modifications.

        ##### Benefits of Remote State:

        1. **Centralized Management**: Remote state ensures a single source of truth for the infrastructure's current state, avoiding discrepancies and making it easier to manage the infrastructure lifecycle across teams and environments.
        2. **Locking and Concurrency**: With state locking, it avoids the risk of multiple users or processes modifying the state simultaneously, preventing potential conflicts and corruption.
        3. **Security and Access Control**: Sensitive data is securely stored and managed in a centralized, secure backend, allowing for better access control, encryption, and audit logging.
        4. **Collaboration**: Facilitates collaboration by allowing multiple team members to access and modify infrastructure using the same state file, ensuring consistency across their work.
        5. **Consistency Across Environments**: Remote state enables consistent infrastructure management across different environments (e.g., development, staging, production).

        ##### Use Cases for Remote State:

        -   **Team Collaboration**: In teams where multiple engineers work on the same infrastructure project.
        -   **CI/CD Pipelines**: For automated workflows, remote state ensures consistent access to the latest state across pipeline jobs.
        -   **Production Infrastructure**: Remote state is essential when managing critical infrastructure that requires versioned state, security, and auditability.
        -   **Multi-Environment Setup**: Managing different environments (development, staging, production) and ensuring that each environment has its own consistent state file.

        ##### Summary:

        **Terraform remote state** allows the state file to be stored in a shared, secure, and centralized location rather than locally. It enables collaboration, prevents state corruption through locking, and improves security by supporting secure backends like S3, GCS, or Terraform Cloud. Remote state is crucial for managing large-scale infrastructure with multiple users or in production environments where consistency and security are vital.

        </details>

    -   <details><summary style="font-size:18px;color:#C71585">How do you handle rolling updates or blue-green deployments using Terraform?</summary>

        Terraform provides features like count and launch_template to manage rolling updates or blue-green deployments.

        </details>

    -   <details><summary style="font-size:18px;color:#C71585">What is the terraform import command? How is it used</summary>

        -   The terraform import command in Terraform is used to bring an existing resource under Terraform management. This is particularly useful when you have infrastructure that was created outside of Terraform, and you want to start managing it using Terraform without recreating or modifying the resource.
        -   `$ terraform import aws_instance.example i-0c1234567890abcdef`
        -   After running terraform import, Terraform will create an entry in the state file (terraform.tfstate) for the imported resource. However, this doesn't automatically generate a Terraform configuration for the resource. You'll need to manually write the Terraform configuration to match the existing resource's configuration.
        -   Once the resource is imported and you've created a corresponding Terraform configuration, you can use Terraform commands like terraform plan and terraform apply to manage the resource going forward.
        -   Keep in mind that not all resources are fully importable, and you might need to manually configure additional settings in your Terraform configuration to match the existing resource's configuration. Always refer to the Terraform documentation for specifics on each resource type.

        The `terraform import` command is used in Terraform to bring an existing resource under Terraform management. This is useful when you have resources created outside Terraform (e.g., manually through a cloud provider's console) but want to manage them with Terraform going forward without recreating them.

        -   **Basic Syntax**

            -   `$ terraform import <resource_type>.<resource_name> <resource_id>`

                -   `resource_type` -> The type of resource in Terraform (e.g., `aws_instance`, `azurerm_resource_group`).
                -   `resource_name` -> The name you want to assign to the resource in Terraform configuration.
                -   `resource_id` -> The unique identifier of the resource in the cloud provider.

        -   **Steps for Importing a Resource**

            1. `Write the Configuration`: Define the resource configuration in your Terraform files. This configuration will tell Terraform what type of resource you want to import.
            2. `Run the Import Command`: Use `terraform import` with the appropriate arguments.
            3. `Verify the Import`: Run `terraform plan` to see the imported resource's state.

        -   **Example**: Suppose you have an existing AWS S3 bucket named `my-bucket` created manually, and you want to import it into your Terraform configuration.

            1. `Write the Configuration`: Create a configuration file (`main.tf`) with the following contents:

                ```ini
                resource "aws_s3_bucket" "my_bucket" {
                bucket = "my-bucket"
                }
                ```

            2. `Run the Import Command`: Now, use the `terraform import` command to bring the bucket under Terraform’s management.

                - `$ terraform import aws_s3_bucket.my_bucket my-bucket`

                - `aws_s3_bucket` is the resource type.
                - `my_bucket` is the resource name in your Terraform configuration.
                - `my-bucket` is the actual name of the S3 bucket.

            3. `Verify the Import`: After importing, run:

                - `$ terraform plan`

        Terraform should show the imported state without any changes, indicating that the resource is now managed by Terraform.

        </details>

        #### Terraform Best Practices

    -   <details><summary style="font-size:18px;color:#C71585">Explain the purpose of Terraform workspaces.</summary>

        -   Workspaces allow you to manage multiple environments (dev, prod, staging) within a single Terraform configuration. Each workspace maintains its own state.

        </details>

    -   <details><summary style="font-size:18px;color:#C71585">How can you organize Terraform configurations for better modularity?</summary>

        -   Use modules to organize Terraform configurations into reusable components. Modules encapsulate related resources and can be shared across projects.

        </details>

    -   <details><summary style="font-size:18px;color:#C71585">Why is it important to use variables in Terraform?</summary>

        -   Variables in Terraform allow you to parameterize configurations, making them more flexible, reusable, and easier to maintain.

        </details>

        #### Infrastructure as Code Principles

    -   <details><summary style="font-size:18px;color:#C71585">What are the benefits of Infrastructure as Code (IaC) principles?</summary>

        -   IaC brings benefits like version control, repeatability, and automation to infrastructure provisioning, reducing manual errors and promoting collaboration.

        </details>

        #### Troubleshooting Terraform

    -   <details><summary style="font-size:18px;color:#C71585">How can you troubleshoot Terraform errors?</summary>

        -   Review Terraform's error messages, check the configuration for syntax errors, and use the terraform console or terraform fmt commands for debugging.

        </details>

    -   <details><summary style="font-size:18px;color:#C71585">What does Terraform's taint command do?</summary>

        The terraform taint command marks a resource for recreation on the next terraform apply, forcing Terraform to destroy and recreate the resource.

        </details>

        #### AWS-Specific Terraform Questions

    -   <details><summary style="font-size:18px;color:#C71585">How do you authenticate Terraform with AWS?</summary>

        -   AWS credentials can be provided via environment variables (AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY) or through AWS CLI configuration.

        </details>

    -   <details><summary style="font-size:18px;color:#C71585">What is an AWS IAM role, and how can you create it using Terraform?</summary>

        -   An IAM role in AWS defines a set of permissions. It can be created using Terraform's aws_iam_role resource.

        </details>

    -   <details><summary style="font-size:18px;color:#C71585">How can you create a Virtual Private Cloud (VPC) in AWS using Terraform?</summary>

        -   Use the aws_vpc resource to define a VPC in Terraform.

        </details>

    -   <details><summary style="font-size:18px;color:#C71585">Explain the purpose of security groups in AWS, and how can you create them using Terraform?</summary>

        -   Security groups control inbound and outbound traffic. They can be created using Terraform's aws_security_group resource.

        </details>

    -   <details><summary style="font-size:18px;color:#C71585">How can you use Terraform to create an Auto Scaling Group in AWS?</summary>

        -   Use the aws_autoscaling_group resource to define an Auto Scaling Group in Terraform.

        </details>

    -   <details><summary style="font-size:18px;color:#C71585">What is AWS Elastic Load Balancer (ELB), and how can you configure it with Terraform?</summary>

        -   ELB distributes incoming traffic across multiple targets. It can be configured using Terraform's aws_lb and aws_lb_target_group resources.

        </details>

    -   <details><summary style="font-size:18px;color:#C71585">Explain the difference between declarative and imperative programming in the context of Terraform.</summary>

        In the context of Terraform, **declarative** and **imperative** programming paradigms represent two different approaches to defining and managing infrastructure.

        ##### Declarative Programming in Terraform

        Terraform primarily follows the **declarative** programming model, where users specify _what the desired state of the infrastructure should be_, and Terraform figures out how to achieve that state.

        -   **What, not How**: In a declarative approach, you define _what_ the final state of your infrastructure should look like, without specifying the step-by-step instructions on _how_ to achieve that state.
        -   **State-Driven**: Terraform compares the desired state (as written in the configuration files) with the actual state of the infrastructure (tracked in the state file) and determines the actions necessary to align the actual state with the desired state.
        -   **Idempotent**: Declarative code is idempotent, meaning that applying the same configuration multiple times will produce the same result without reapplying changes unnecessarily.
        -   **Automatic Dependency Management**: Terraform automatically determines the dependencies between resources and ensures they are created or updated in the correct order.

        ##### Imperative Programming in Terraform (and Infrastructure in General)

        In an **imperative** approach, the user provides explicit, step-by-step instructions on _how_ to achieve the desired outcome. It focuses more on the "how" and defines specific commands or sequences to accomplish a task.

        While Terraform itself is declarative, **provisioners** and external scripting can introduce imperative behaviors. For example, provisioning a server and then running a script to install software is an imperative action within an otherwise declarative Terraform workflow.

        -   **How, not What**: The imperative approach focuses on describing the _steps_ to reach the desired outcome, rather than just defining the end goal.
        -   **Procedural**: It involves a series of commands or steps that must be executed in a certain order.
        -   **Manual Dependency Handling**: The user needs to explicitly manage dependencies between steps, ensuring that actions occur in the correct sequence.

        </details>

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Terraform CLI</summary>

    -   `$ terraform init`

    -   `$ terraform plan`
    -   `$ terraform plane -refresh=false`
    -   `$ terraform plane console`
    -   `$ terraform plane -out iam.tfplane`
    -   `$ terraform plan -out iam.tfplan`
    -   `$ terraform plan -refresh=false -var="iam_user_name_prefix=VALUE_FROM_COMMAND_LINE"`

    -   `$ terraform apply -var-file=file_name`
    -   `$ terraform apply -var="db_user=myuser" -var="db_pass=secretpassword"`
    -   `$ terraform apply -refresh=false`
    -   `$ terraform apply "iam.tfplan"`
    -   `$ terraform apply -target="aws_iam_user.tf_iam_user"`
    -   `$ terraform apply -target=aws_default_vpc.default`
    -   `$ terraform apply -target=data.aws_subnet_ids.default_subnets`
    -   `$ terraform apply -target=data.aws_ami_ids.aws_linux_2_latest_ids`
    -   `$ terraform apply -target=data.aws_ami.aws_linux_2_latest`

    -   `$ terraform destroy`

    -   `$ terraform console`

    -   `$ terraform get -update` -> Check already-downloaded modules for available updates and install the newest versions available.
    -   `$ terraform validate`
    -   `$ terraform fmt`
    -   `$ terraform show`
    -   `$ export TF_VAR_iam_user_name_prefix = FROM_ENV_VARIABLE_IAM_PREFIX`
    -   `$ export TF_VAR_iam_user_name_prefix=FROM_ENV_VARIABLE_IAM_PREFIX`

    -   `$ terraform workspace list`
    -   `$ terraform workspace new production`
    -   `$ terraform workspace show`
    -   `$ terraform workspace new prod-env`
    -   `$ terraform workspace select default`
    -   `$ terraform workspace list`
    -   `$ terraform workspace select prod-env`


    -   **Essential Terraform Workflow Commands**: These commands represent the core steps of the standard Terraform workflow: initialize, plan, apply, and destroy.

        | Command              | Flags / Parameters         | Explanation                                                                            |
        | :------------------- | :------------------------- | :------------------------------------------------------------------------------------- |
        | `terraform init`     | `--upgrade`                | Initializes a working directory, downloading necessary providers and modules.          |
        |                      | `--backend-config=path`    | Configures the backend (e.g., S3 bucket name) non-interactively.                       |
        | `terraform validate` | `-json`                    | Checks configuration files for syntax and internal consistency before planning.        |
        | `terraform plan`     | `-out=path`                | Generates and saves an execution plan to a file for later application.                 |
        |                      | `-destroy`                 | Generates a plan to destroy all resources defined in the configuration.                |
        |                      | `-target=resource_address` | Focuses the plan on specific resources (use with caution).                             |
        |                      | `-var 'key=value'`         | Sets a variable value on the command line.                                             |
        |                      | `-var-file=path`           | Loads variable values from a specified file.                                           |
        | `terraform apply`    | `<planfile>`               | Executes the saved plan file or generates a plan and applies it interactively.         |
        |                      | `-auto-approve`            | Skips the interactive approval prompt for the execution plan.                          |
        |                      | `-target=resource_address` | Applies changes only to specific resources and their dependencies (use with caution).  |
        |                      | `-refresh-only`            | Updates the state file to reflect real-world changes without proposing config changes. |
        | `terraform destroy`  | `-auto-approve`            | Destroys all infrastructure managed by the current configuration without prompting.    |
        |                      | `-target=resource_address` | Destroys only the specified resources (use with caution).                              |

    -   **State Management and Inspection**: These commands allow you to view, modify, and manage the Terraform state file.

        | Command                | Flags / Parameters        | Explanation                                                                         |
        | :--------------------- | :------------------------ | :---------------------------------------------------------------------------------- |
        | `terraform show`       | `<path_to_state_or_plan>` | Provides human-readable output of the state file or a saved plan file.              |
        |                        | `-json`                   | Displays the state or plan output in machine-readable JSON format.                  |
        | `terraform state list` | `[address]`               | Lists all or specific resources currently tracked in the state file.                |
        | `terraform state mv`   | `<source> <destination>`  | Moves an item's address within the state file (e.g., renaming a resource).          |
        | `terraform state rm`   | `<address>...`            | Removes resource instances from the state file without touching the infrastructure. |
        | `terraform import`     | `<address> <id>`          | Imports existing infrastructure into the Terraform state file.                      |
        | `terraform refresh`    |                           | Updates the state file to reflect the current real-world status of resources.       |

    -   **Utility and Maintenance Commands**: These commands handle formatting, external data, module fetching, and other general tasks.

        | Command                    | Flags / Parameters   | Explanation                                                                                    |
        | :------------------------- | :------------------- | :--------------------------------------------------------------------------------------------- |
        | `terraform fmt`            | `--recursive`        | Rewrites all configuration files to a canonical format and style.                              |
        |                            | `--check`            | Checks if files are formatted correctly; returns non-zero exit code if not.                    |
        | `terraform output`         | `[name]`             | Displays the value of the root module's output variables.                                      |
        |                            | `-json`              | Displays the output values in JSON format.                                                     |
        | `terraform console`        |                      | Opens an interactive console for evaluating HCL expressions against the configuration/state.   |
        | `terraform get`            | `-update`            | Downloads and updates remote modules referenced in the configuration.                          |
        | `terraform graph`          | `-type=plan`         | Generates a visual graph of resource dependencies (outputs DOT format).                        |
        | `terraform taint`          | `<resource_address>` | Manually marks a managed resource for replacement on the next apply.                           |
        | `terraform untaint`        | `<resource_address>` | Removes the 'tainted' mark from a resource.                                                    |
        | `terraform providers`      | `schema`             | Prints a schema for the installed providers, including all resource and data source arguments. |
        | `terraform providers lock` |                      |                                                                                                |

    -   **Workspace Commands (Legacy)**: These commands manage separate, isolated state files within a single working directory.

        | Command                      | Flags / Parameters | Explanation                                                        |
        | :--------------------------- | :----------------- | :----------------------------------------------------------------- |
        | `terraform workspace list`   |                    | Lists all existing workspaces.                                     |
        | `terraform workspace show`   |                    | Displays the name of the current workspace.                        |
        | `terraform workspace new`    | `<name>`           | Creates a new workspace and switches to it.                        |
        | `terraform workspace select` | `<name>`           | Switches the current state environment to the specified workspace. |
        | `terraform workspace delete` | `<name>`           | Deletes the named workspace (must be empty of resources).          |

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Courses & Tutorials</summary>

    -   [HCL Language Documentation](https://developer.hashicorp.com/terraform/language)
    -   [AWS: TERRAFORM DOCUMENTATION](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
        -   [Expressions](https://developer.hashicorp.com/terraform/language/expressions)
    -   [TERRAFORM CLI](https://developer.hashicorp.com/terraform/cli)
    -   [Terraform Tips & Tricks: loops, if-statements, and more](https://www.youtube.com/watch?v=7S94oUTy2z4&list=PLiMWaCMwGJXmJdmfJjG3aK1IkU7oWvxIj&index=4)
    -   [50+ Terraform Molules](https://github.com/clouddrove?utf8=%E2%9C%93&q=terraform-&type=&language=)

    -   [Terraform Real World Use Case | Process SQS Messages With Lambda and Upload to S3 | 9886611117](https://www.youtube.com/watch?v=etru_8t7Dyk)
    -   [How do I deploy AWS Lambda using Terraform?](https://www.youtube.com/watch?v=JSR7U700h0U)
    -   [Master Terraform Interview Questions with this Easy Demo](https://www.youtube.com/watch?v=LPW3VriwLVs&list=PLH1ul2iNXl7v5qKBE62pp6GjmodSm5Wbb)
    -   [Terraform Interview ( Mock Interview )](https://www.youtube.com/watch?v=pCoCynze4Ag)

    #### Courses:

    -   [HashiCorp Terraform Associate Certification Course - Pass the Exam!](https://www.youtube.com/watch?v=V4waklkBC38)
    -   [HashiCorp Terraform Associate Certification Course (003) - Pass the Exam!](https://www.youtube.com/watch?v=SPcwo0Gq9T8&t=4685s)
    -   [Terraform by RahulWagh](https://www.youtube.com/playlist?list=PL7iMyoQPMtAOz187ezONf7pL8oGZRobYl)
        -   [CODE](https://github.com/in28minutes/devops-master-class/tree/master/terraform)
    -   [Complete Terraform Course - From BEGINNER to PRO! (Learn Infrastructure as Code)](https://www.youtube.com/watch?v=7xngnjfIlK4&t=178s)
    -   [Terraform Course - Automate your AWS cloud infrastructure](https://www.youtuzbe.com/watch?v=SLB_c_ayRMo&t=2725s)

    -   [How to Create AWS Lambda with Terraform? (API Gateway & GET/POST & IAM S3 Access & Dependencies)](https://antonputra.com/amazon/how-to-create-aws-lambda-with-terraform/)
    -   [AWS Lambda – Terraform Example with API Gateway](https://tekanaid.com/posts/aws-lambda-terraform-configuration-example-with-api-gateway#code)
    -   [Terraform to create AWS SNS | GitHub Actions](https://www.youtube.com/watch?v=e7P0TGwp1VA&t=679s)
    -   [Terraform to create AWS SNS and AWS SQS service which invokes AWS lambda function | GitHub Actions](https://www.youtube.com/watch?v=tTD5D9ZHYUc)
    -   [HashiCorp Vault + Terraform: The Ultimate Secrets Management Guide](https://www.youtube.com/watch?v=FQE_gyEwu0Q)

    </details>

---
---


---

### 3. Common Backend Configurations

| Backend              | Key Config Requirements                                                |
| :------------------- | :--------------------------------------------------------------------- |
| **S3**               | `bucket`, `key`, `region`. (Optional: `profile` or `role_arn`)         |
| **Remote (TFC/TFE)** | `organization` and `workspaces = { name = "workspace-name" }`          |
| **Local**            | `path = "../other-project/terraform.tfstate"`                          |
| **Azure (azurerm)**  | `resource_group_name`, `storage_account_name`, `container_name`, `key` |

---

### 4. Important Troubleshooting Tips
*   **Outputs Only:** You can *only* access what was explicitly defined in an `output` block in the source project. You cannot reach into the remote state to grab a resource attribute that wasn't exported.
*   **Permissions:** The IAM role or user running the *current* Terraform plan must have `s3:GetObject` permissions on the bucket and key of the *source* state file.
*   **State Locking:** Using a data source does not typically trigger a state lock on the remote file, but it’s good practice to ensure your backends are configured consistently.

---

