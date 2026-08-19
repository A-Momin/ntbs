-   [aws_lakeformation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lakeformation_permissions)

-   <details><summary style="font-size:25px;color:Orange">MISC</summary>

    -   [local_file (Resource)](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file)

    ```ini
    # https://www.youtube.com/watch?v=9kPj3-V8elE&t=1s
    locals {
        root_dir = "${dirname(abspath(path.root))}"
        k8s_config_dir = "${local.root_dir}/.kube"
        k8s_config_fil = "${local.root_dir}/.kube/kubernetes.yaml"
    }

    resource "local_file" "k8s_config" {
        content = "Data is comming"
        filename = "${local.k8s_config_file}"
        file_permission = "0600"
    }
    ```

    -   **Option 1**: Use inline with multiple commands

        -   inline lets you list multiple commands as an array.
        -   interpreter = ["/bin/bash", "-c"] ensures the commands run in bash.

        ```ini
        resource "null_resource" "run_local_commands" {
          provisioner "local-exec" {
            interpreter = ["/bin/bash", "-c"]

            inline = [
              "echo 'Updating system...'",
              "sudo apt-get update -y",
              "sudo apt-get install -y curl",
              "echo 'All done!'"
            ]
          }
        }
        ```

    -   **Option** 2: Use a multi-line HEREDOC script

        ```ini
        resource "null_resource" "run_script" {
        provisioner "local-exec" {
            command = <<-EOT
            echo "Starting setup..."
            sudo apt-get update -y
            sudo apt-get install -y git jq unzip
            echo "Setup complete!"
            EOT
        }
        }
        ```

        -   archive_file only re-runs if source files change hash.
        -   If you modify your code but Terraform doesn’t detect changes, run:
            -   `$ terraform taint data.archive_file.lambda_zip`

        ```ini
        resource "null_resource" "prepare_directory" {
            provisioner "local-exec" {
                command = <<-EOT
                rm -rf ${path.module}/setup
                mkdir -p ${path.module}/setup
                cp ${path.module}/python/code/cuckoo.py ${path.module}/setup/
                pip install -r ${path.module}/python/requirements.txt -t ${path.module}/setup
                EOT
            }
        }

        data "archive_file" "lambda_zip" {
            type        = "zip"
            source_dir  = "${path.module}/setup"                     # directory to compress
            output_path = "${path.module}/python/package_cuckoo.zip" # final zip file path
            depends_on  = [null_resource.prepare_directory]          # ensures zip runs after prep
        }
        ```

    -   **Option** 3: Call an external script file

        ```ini
        resource "null_resource" "run_script_file" {
            provisioner "local-exec" {
                command = "bash ./scripts/setup.sh"
            }
        }
        ```

    -   **Option 4**:

        ```ini
        resource "aws_instance" "ec2_dev_environment" {
        # ... (Instance configuration) ...

        # Define SSH connection parameters once
        connection {
            type        = "ssh"
            user        = "ubuntu"
            private_key = file("~/.ssh/${var.key_name}.pem") # Use file() for the key content
            host        = self.public_ip
        }

        # Use file provisioners for each file
        provisioner "file" {
            source      = "${var.bash_config_scripts_location}/.bash_utils.sh"
            destination = "/home/ubuntu/.bash_utils.sh"
        }

        provisioner "file" {
            source      = "${var.bash_config_scripts_location}/.bashrc"
            destination = "/home/ubuntu/.bashrc"
        }

        # ... (Repeat for all other dotfiles: .bash_profile, .aliases, .vimrc, etc.) ...

        # Optional: Execute the installation script last
        provisioner "remote-exec" {
            inline = [
                "chmod +x /home/ubuntu/.automate_installations.sh",
                "sudo /home/ubuntu/.automate_installations.sh"
            ]
        }
        }
        ```

    -   **⚡ Pro Tip**: If you want these commands to run every time you run terraform apply, add a triggers block with something like `timestamp()` or `uuid()`:

        ```ini
        resource "null_resource" "always_run" {
            triggers = {
                always_run = timestamp()
            }

            provisioner "local-exec" {
                command = <<EOT
                echo "This will always run"
                date
                EOT
            }
        }
        ```

    -   **Remote Execution**:

        ```ini
        resource "null_resource" "configure" {
        depends_on = [aws_instance.ec2_dev_environment]

        provisioner "remote-exec" {
            connection {
                type        = "ssh"
                user        = "ubuntu"
                host        = aws_instance.ec2_dev_environment.public_ip
                private_key = file("~/.ssh/${var.key_name}")
            }

            inline = [
                "sudo get update -y",
                "sudo get install -y nginx"
            ]
        }
        }
        ```

    -   **Rebuild null_resources**:

        -   `null_resource`: This resource always exists in Terraform's state, but it doesn't create anything in AWS.
        -   `triggers`: This block tells Terraform to consider the null_resource changed if any of the values within it change.
        -   `always = timestamp()`: The timestamp() function generates a new timestamp every time terraform plan or terraform apply is run. Because this value is always new, it causes the null_resource.force_rebuild to always show as "changed" or "replaced" in your Terraform plan.

        ```ini
        resource "null_resource" "force_rebuild" {
            triggers = {
                always = timestamp()
            }
        }
        ```

    </details>

-   <details><summary style="font-size:25px;color:Orange">Useful Functions</summary>

    ```ini
    element([for k, v in aws_subnet.public_subnets : v.id if strcontains(k, "public")], 0)

    ```

    </details>
