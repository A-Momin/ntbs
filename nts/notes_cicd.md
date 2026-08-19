<details><summary style="font-size:25px;color:Orange">CICD in General</summary>

CI/CD, which stands for Continuous Integration and Continuous Delivery (or Continuous Deployment), is a set of practices and principles that aim to automate and streamline the software development and delivery processes. CI/CD helps improve code quality, reduce development cycle times, and enable faster and more reliable releases. Here are key terms and concepts related to CI/CD:

1. **Continuous Integration (CI)**:

    - The practice of automatically integrating code changes from multiple developers into a shared repository several times a day.
    - Automated builds and tests are run to detect integration issues early.
    - Tools often used: Jenkins, GitHub Actions, CircleCI, Travis CI.

2. **Continuous Delivery (CD)**:

    - Builds on CI by ensuring that the software can be reliably released at any time.
    - After code is integrated and tested, it is automatically prepared for deployment (e.g., creating a production-ready artifact).
    - Deployments still require manual approval.

3. **Continuous Deployment (CD)** (an extension of Continuous Delivery):
    - Takes it a step further by automating the deployment process as well.
    - Code that passes all automated tests and checks is automatically deployed to production without manual intervention.

-   **Version Control System (VCS)**: Software tools that enable teams to track changes to source code, collaborate, and maintain a history of code changes.

    -   `Tools`:
        -   `Git`: Git is a distributed version control system widely used for tracking changes in source code during software development. It is known for its speed, scalability, and flexibility.
        -   `GitHub`: GitHub is a web-based hosting service for Git repositories. It provides collaboration features such as issue tracking, pull requests, and code review, making it a popular platform for open-source projects and team collaboration.
        -   `GitLab`: GitLab is another web-based Git repository management tool similar to GitHub. It offers integrated CI/CD pipelines, issue tracking, code review, and wiki functionality, and it can be self-hosted or used as a cloud service.
        -   `Bitbucket`: Bitbucket is a Git-based version control and collaboration platform developed by Atlassian. It offers features such as code hosting, pull requests, and issue tracking, and it integrates with other Atlassian products like Jira and Confluence.
        -   `Subversion (SVN)`: Subversion is a centralized version control system used for managing and tracking changes in source code. Unlike Git, which is distributed, SVN uses a central repository model where developers commit changes directly to a central server.

-   **Build Automation**: The process of automating the compilation and packaging of source code into executable binaries or artifacts.

    -   Ensure consistency and repeatability in the build process, reducing manual errors.

-   **Artifact Repository**: A centralized location for storing and managing binary artifacts generated during the build process.

    -   `Examples`: Nexus, Artifactory.

-   **Automated Testing**: The use of automated test scripts to validate that the application functions as expected.

    -   `Types`: Unit testing, integration testing, functional testing, and other testing types.

-   **Pipeline**: A series of automated steps that code changes go through, from integration and testing to deployment.

    -   `CI/CD` Pipeline Components: Source code repository, build, test, deploy, and monitoring stages.

-   **Infrastructure as Code (IaC)**: The practice of managing and provisioning infrastructure using code (declarative or imperative). `Terraform`, `Ansible`, `CloudFormation` are the example of IaC tools

-   **Deployment Strategies**: Approaches for releasing and updating applications, minimizing downtime and impact on users.

    -   `Strategies`: **Blue-Green Deployment**, **Canary Deployment**, **Rolling Deployment**.

-   **Configuration Management**: The process of managing and maintaining consistent configurations across various environments.

    -   `Examples`: Puppet, Chef, Ansible.

-   **Continuous Monitoring**: The practice of continuously monitoring applications and infrastructure to detect issues and performance bottlenecks.

    -   `Tools`: Prometheus, Grafana, ELK Stack.

-   **Rollback**: The process of reverting a deployment to a previous, known-good state in case of issues or errors.

    -   Quickly address problems and restore system functionality.

-   **Artifacts vs Assets**:

    -   `Artifacts`:

        -   Artifacts typically refer to the outputs generated during the build, test, and packaging phases of the CI/CD pipeline.
        -   These outputs are the result of compiling, assembling, and packaging the source code into a deployable format, ready for deployment to various environments.
        -   Examples of artifacts include compiled binaries, executables, libraries, Docker images, ZIP files, or any other packaged form of the application that can be deployed.
        -   Artifacts are usually stored in an artifact repository or artifact management system to facilitate distribution, versioning, and deployment to different environments.

    -   `Assets`:

        -   Assets, on the other hand, encompass a broader range of resources and files that are required throughout the CI/CD pipeline.
        -   Assets include not only the output artifacts but also the source code, configuration files, dependencies, test data, documentation, and other resources needed to support the software development lifecycle.
        -   Unlike artifacts, assets are not necessarily generated during the pipeline; they may already exist as part of the project's source code or external dependencies.
        -   Assets are managed and processed at different stages of the CI/CD pipeline to facilitate the automated build, testing, and deployment of the application.

-   <b style="color:maroon">What is CI/CD?</b>

    -   CI/CD stands for Continuous Integration and Continuous Deployment. It is a set of practices and tools that enable developers to automate the process of integrating code changes into a shared repository (Continuous Integration) and automatically deploying those changes to production (Continuous Deployment).

-   <b style="color:maroon">Explain the benefits of implementing CI/CD.</b>

    -   CI/CD provides benefits such as faster and more frequent releases, reduced manual errors, improved collaboration among development and operations teams, and faster feedback on code quality.

-   <b style="color:maroon">What is the difference between Continuous Integration and Continuous Deployment?</b>

    -   Continuous Integration (CI) is the practice of automatically integrating code changes into a shared repository several times a day. Continuous Deployment (CD) is the practice of automatically deploying every code change that passes automated testing to production.

-   <b style="color:maroon">Name some popular CI/CD tools.</b>

    -   Jenkins, Travis CI, GitLab CI/CD, CircleCI, and GitHub Actions are popular CI/CD tools.

-   <b style="color:maroon">What is the role of version control in CI/CD?</b>

    -   Version control systems, like Git, provide a way to manage and track changes to code. In CI/CD, version control helps ensure that the correct code is used in each stage of the pipeline, and it facilitates collaboration among team members.

-   <b style="color:maroon">Explain Blue-Green Deployment.</b>

    -   Blue-Green Deployment is a CI/CD strategy where two identical production environments, labeled "Blue" and "Green," are maintained. Only one environment serves live production traffic at a time, allowing for seamless deployment and rollback.

-   <b style="color:maroon">What is Canary Deployment in CI/CD?</b>

    -   Canary Deployment is a deployment strategy where a new version of an application is gradually rolled out to a small subset of users or servers before being deployed to the entire infrastructure.

-   <b style="color:maroon">Explain the concept of Continuous Monitoring in CI/CD.</b>

    -   Continuous Monitoring involves tracking and analyzing metrics, logs, and other data from applications and infrastructure to identify issues, ensure performance, and support rapid feedback.

-   <b style="color:maroon">What is Git branching strategy, and why is it important in CI/CD?</b>

    -   A Git branching strategy defines how code changes are managed and merged in version control. It is crucial in CI/CD to ensure that branches align with stages in the pipeline and support parallel development without conflicts.

-   <b style="color:maroon">How do you handle secrets and sensitive information in CI/CD pipelines?</b>

    -   Secrets and sensitive information should be stored securely in a credential manager or secret store. CI/CD tools often provide integrations with these stores, allowing secure retrieval during the build and deployment process.

-   <b style="color:maroon">What is the purpose of the "Rollback" in CI/CD?</b>

    -   Rollback is the process of reverting to a previous version or state in case of a failed deployment or critical issues in the latest release. It ensures quick recovery from deployment failures.

-   <b style="color:maroon">Explain the concept of Automated Testing in CI/CD.</b>

    -   Automated Testing involves writing and executing test cases automatically during the CI/CD process to validate code changes. It ensures that new features or changes do not introduce defects.

-   <b style="color:maroon">What is the role of a CI/CD pipeline in Microservices architecture?</b>

    -   In a Microservices architecture, CI/CD pipelines automate the testing and deployment of individual microservices, enabling rapid and independent releases.

-   <b style="color:maroon">Explain the concept of "Shift-Left" in CI/CD.</b>

    -   "Shift-Left" refers to the practice of moving testing and quality assurance processes earlier in the development lifecycle, catching issues at an earlier stage and reducing the

</details>

---

<details><summary style="font-size:25px;color:Orange">Jenkins:</summary>

-   `$ docker exec -it jenkins-blueocean bash`
-   `/var/jenkins_home/workspace` → location of jenkin workspace
-   `/var/jenkins_home/config.xml` → location of jenkin configuration file in Docker container.
-   `journalctl -u jenkins.service` -> if you are troubleshooting Jenkins.
-   Populate `/lib/systemd/system/jenkins.service` with configuration parameters for the launch, e.g `JENKINS_HOME`
-   If Jenkins fails to start because a port is in use, run `systemctl edit jenkins` and add the following:
    ```ini
    [Service]
    Environment="JENKINS_PORT=8081"
    ```
-   `$ sudo systemctl edit jenkins`

<details><summary style="font-size:20px;color:Magenta">MISC</summary>

#### Configuration

-   Username: jenkins
-   Password: admin

#### Environment Variables

-   `localhost:8080/env-vars.html` / `remote_IP:8080/env-vars.html` → Location of pre-defined Environment Variables
-   How to access into Environment Variables in Pipeline

    ```groovy
    pipeline {
        agent any

        environment {
            // You can create your own environment variables in this block
            MY_ENV_VAR = "12345"
        }
        stages {
            stage('Access Environment Variables') {
                steps {
                    script {
                        // Accessing specific pre-defined variables
                        echo "Job Name: ${env.JOB_NAME}" // Pre-defined Environment Variable
                        echo "Build Number: ${env.BUILD_NUMBER}"
                        echo "Workspace: ${env.WORKSPACE}"
                        echo "User Defined Environment Variable: ${MY_ENV_VAR}"
                    }
                }
            }
        }
    }
    ```

#### Useful Jenkins Plugins

-   **Credentials**:
-   **Credentials Bindings**:
-   **Docker**:
-   **AWS Secrets Manager Credentials Provider**:

#### Jenkins Webhook

A **Jenkins webhook** is a mechanism used to automatically trigger a Jenkins job or pipeline when an event (`push`/`pull-request`) occurs in an external system, such as a code repository like GitHub, GitLab, or Bitbucket.

-   **How it works**:

    1. `Webhook Setup`:

        - A webhook is configured in the external system (e.g., GitHub, GitLab, or Bitbucket).
        - It specifies the URL of the Jenkins server to notify when a specific event occurs (e.g., a new code push, pull request creation, or merge).

    2. `Trigger Mechanism`:

        - When the configured event happens in the external system (GitHub, GitLab, or Bitbucket), it sends an HTTP POST request with details about the event to the webhook URL.

    3. `Jenkins Response`:
        - Jenkins receives the webhook payload and triggers the corresponding job or pipeline.
        - The payload often includes information like branch name, commit ID, author, and other details, which Jenkins can use to customize the build process.

-   **Example Use Case**:

    1. `In GitHub`:

        - Go to your repository: `settings` → `Webhooks` → `Add webhook`.
        - Specify the Jenkins webhook URL: `http://<jenkins-server>/github-webhook/`.
        - Select events like **push** or **pull request** to trigger the webhook.

    2. `In Jenkins`:

        - Create or configure a Jenkins job.
        - Under the `Build Triggers` section, select `GitHub hook trigger for GITScm polling` (for freestyle jobs) or configure it for a pipeline.

    3. `Workflow`: Triggering a Jenkins Build on GitHub Push
        - When a developer pushes code to GitHub, GitHub sends a webhook payload to Jenkins.
        - Jenkins receives the payload and starts the build process based on the updated code.

-   **Notes**:
    -   Ensure the Jenkins server is accessible from the external system (e.g., via public IP or DNS).
    -   For security, use authentication mechanisms like **shared secrets** in the webhook configuration to verify requests.

</details>

<details><summary style="font-size:20px;color:Magenta">Jenkins Architecture, Terms and Concepts</summary>

Jenkins is an open-source automation server that is used to automate the building, testing, and deployment of software projects. It provides a platform-agnostic way to continuously build and test software projects, allowing developers to integrate changes more frequently and detect errors earlier in the development process.

Jenkins is primarily used for implementing Continuous Integration (CI) practices in software development workflows. CI involves automatically building and testing code changes whenever they are committed to a version control repository, ensuring that the codebase remains in a working state.
Jenkins allows users to automate various tasks involved in the software development lifecycle, such as compiling code, running tests, generating documentation, and deploying applications. Automation reduces manual effort, minimizes human errors, and speeds up the development process.

In short, Jenkins is an open-source powerful CI automation server that is used for building, testing, and deploying software.

-   **Master-Slave Architecture**: Jenkins follows a master-slave architecture, where there is a central Jenkins server (master) that manages and distributes tasks to multiple agents (slaves). This architecture allows distributing the workload and provides scalability.

-   **Jenkins Master**: The term **Jenkins Master** refers to the central component that manages the overall Jenkins automation server. The Jenkins master, also known as the **Jenkins controller** or **Jenkins server** is responsible for orchestrating and coordinating the execution of jobs and workflows.

    -   The central server responsible for managing jobs, scheduling builds, and monitoring the overall system.
    -   Hosts the web-based user interface for configuring and monitoring Jenkins.
    -   Manages the execution of jobs and communicates with the agents.

-   **Jenkins Agent/Slave**: A slave in Jenkins is a machine or container that connects to a Jenkins controller, is used to distribute workload across multiple machines and executes tasks when directed by the controller. Slaves can be used to increase the capacity of a Jenkins server, or to run jobs on specific hardware or operating systems. There are two types of Agents.

    -   A worker node that performs tasks assigned by the master.
    -   Executes builds, tests, and other tasks on behalf of the master.
    -   Agents can be configured on different machines to distribute workloads.

    -   `Permanant Agent`: A **permanent agent** refers to a long-running worker node or build agent that is permanently connected to the Jenkins master. Unlike ephemeral agents that are dynamically provisioned for each build and then terminated, permanent agents remain connected to the Jenkins master even when idle, ready to accept build tasks whenever assigned.
    -   `Cloud Agent`: A **cloud agent** refers to a dynamic or ephemeral build agent that is provisioned on-demand in a cloud environment. Cloud agents are created as needed to execute build jobs and are terminated once the job is completed, allowing for efficient resource utilization and scalability. Docker is one of the most popular cloud agent of Jenkins besides Kubertetis and AWS Fleet Manager.

-   **Nodes**: Nodes are synonymous with agents or slaves in the Jenkins ecosystem. They can be physical machines, virtual machines, containers, or remote SSH connections. Nodes in Jenkins serve as execution environments for build jobs, providing the necessary resources and capabilities to run the jobs. The Jenkins master schedules and assigns build jobs to available nodes based on criteria such as workload, node availability, or specific job requirements.

-   **Web-Based User Interface**: Jenkins provides a web-based user interface accessible through a web browser. This interface allows users to configure jobs, view build results, manage plugins, and perform administrative tasks. The UI is an essential component for interacting with Jenkins.

    -   `Dashboard Navigation`: The dashboard navigation menu is located on the left-hand side of the screen and provides access to all of the primary functions of Jenkins. The menu is organized into several categories, including Home, New Item, Manage Jenkins, Build History, Nodes, People, and Plugins. Each of these categories provides access to a different set of features.
    -   `Home`: The Home category provides an overview of the Jenkins system, including the number of jobs currently running, the number of nodes connected to the system, and a summary of recent builds.
    -   `New Item`: The New Item category allows users to create new jobs in Jenkins. Jobs are the core of the Jenkins system and define the tasks that Jenkins performs, such as building, testing, and deploying software.
    -   `Manage Jenkins`: The Manage Jenkins category provides access to a wide range of configuration options for the Jenkins system. This includes options for managing nodes, configuring security settings, managing plugins, and more.
    -   `Build History`: The Build History category provides an overview of all builds that have been run in Jenkins. This includes information on the status of each build, the duration of the build, and other details.
    -   `Nodes`: The Nodes category provides information on all of the nodes that are connected to the Jenkins system. This includes details on the status of each node, such as whether it is online or offline, and what tasks it is currently performing.
    -   `People`: The People category provides information on all of the users that have access to the Jenkins system. This includes details on their permissions, roles, and other settings.
    -   `Plugins`: The Plugins category provides access to a wide range of plugins that can be used to extend the functionality of the Jenkins system. This includes plugins for integrating with other systems, such as version control systems, as well as plugins for enhancing the functionality of Jenkins itself.

-   **Executor**: A slot/component for execution of work defined by a Pipeline or build job on a Node. A Node may have zero or more Executors configured which corresponds to how many concurrent Jobs or Pipelines are able to execute on that Node. Executors are typically configured on agent machines, which can be physical or virtual machines, containers, or cloud instances. When a job is triggered in Jenkins, it is assigned to an available executor on a compatible agent. The executor then executes the job's tasks or steps, performing the build, test, or deployment actions specified in the job configuration. This allows for parallel execution of jobs, enabling faster builds and reducing overall execution time.

-   **Jenkinsfile**: A text file that defines the steps that need to be performed when a Jenkins Pipeline is run.

-   **Build**: A build is the process of compiling and packaging the source code for a software project. In Jenkins, a build is triggered when a job is run, and it produces a set of output artifacts that can be used for testing or deployment.

    -   `Build Types`: In Jenkins, there are several types of builds that you can configure based on your requirements. Here are two most commonly used build types in Jenkins.
        -   `Freestyle Build`: This is the most basic and flexible type of build in Jenkins. It allows you to define a series of build steps that can execute shell commands, run scripts, perform actions, or invoke external tools. Freestyle builds are highly customizable and suitable for various project types.
        -   `Pipeline Build`: Jenkins Pipeline is a powerful feature that allows you to define and manage your build process using a Groovy-based domain-specific language (DSL). Pipeline builds provide a way to define your build pipeline as code, allowing for better version control, repeatability, and advanced customization. Pipelines can have multiple stages, parallel execution, and integrate with source control systems.
        -   `Multibranch Build`: A Multibranch Pipeline in Jenkins is a job type that allows you to manage and automate the continuous integration and delivery (CI/CD) process for projects with multiple branches. It automatically creates a pipeline for each branch in a version control repository, enabling separate and isolated automation for each branch.
    -   `Trigger`: A trigger in Jenkins is an event that causes a build/job to run automatically. Triggers can be based on a schedule, a code commit, a build completion, or other events.
    -   `Build Workspace`: Each build job runs in its workspace, a directory on the Jenkins master or agent where the source code is checked out, builds are performed, and artifacts are stored. Workspaces are isolated from each other.
    -   `Distributed Builds` Jenkins supports distributed builds across multiple machines, allowing the master to delegate work to agents. This distributed nature provides scalability and flexibility for handling large and complex build environments.
    -   `Artifact`: An immutable file generated during a Build or Pipeline run which is archived onto the Jenkins Controller for later retrieval by users.

-   **Pipeline**: A pipeline in Jenkins is a series of jobs or stages that are chained together to create a complete software delivery process. Pipelines can include build, test, and deployment stages, and they can be designed to run automatically or in response to specific events.

    -   `Job`: A job in Jenkins is a specific task that needs to be performed, such as building a project or running a test suite. Jobs can be configured to trigger automatically or on a schedule, or they can be run manually. A "Build" is a type of "Job" specifically designed to automate the build process.
    -   `Stage`: A logical unit of work in a Jenkins Pipeline.
    -   `Parameter`: A parameter in Jenkins is a value that is passed to a job at runtime. Parameters can be used to customize the behavior of a job, such as specifying the target environment for a deployment.

    -   <b style="color:#C71585">Scripted Pipeline</b>: Scripted Pipelines use a more imperative, scripted approach. You write a series of steps using Groovy scripting language directly.

        -   `High Flexibility`: Provides high flexibility and allows complex scripting. You can use Groovy constructs to control flow, define functions, and perform advanced logic.
        -   `Step-by-Step Execution`: Pipeline steps are executed sequentially, and you have fine-grained control over the execution flow.
        -   `Example`:

            ```groovy
            node {
                stage('Build') {
                    sh 'mvn clean install'
                }
                stage('Test') {
                    sh 'mvn test'
                }
                stage('Deploy') {
                    sh 'deploy-to-production.sh'
                }
            }
            ```

    -   <b style="color:#C71585">Declarative Pipeline</b>: Declarative Pipelines use a more structured, declarative approach. You define the pipeline structure using a predefined syntax.

        -   `Readability and Simplicity`: Provides a simplified and more readable syntax. It is designed to be easy to understand, especially for users new to Jenkins or CI/CD.
        -   `Structured Blocks`: Pipeline is defined using structured blocks such as pipeline, agent, stages, and steps. Each block has a specific purpose.
        -   `Example`:

            ```groovy
            pipeline {
                agent {
                    docker {
                        image 'maven:3.8.3' // Specify the Docker image you want to use
                        label 'docker-agent' // Optional: Label to assign to the agent
                    }
                }

                stages {
                    stage('Build') {
                        steps {
                            // Your build steps here, for example:
                            script {
                                sh 'mvn clean install'
                            }
                        }
                    }

                    stage('Test') {
                        steps {
                            // Your test steps here
                        }
                    }

                    // Add more stages as needed
                }

                post {
                    always {
                        // Cleanup or post-build steps
                    }
                    success {
                        // Cleanup or post-build steps
                    }
                    failure {
                        // Cleanup or post-build steps
                    }
                }
            }
            ```

-   **Plugins**: Jenkins is highly extensible, thanks to its vast plugin ecosystem. Plugins are additional modules that extend the functionality of Jenkins. They can add support for various version control systems, build tools, deployment platforms, and more. Plugins can be installed and configured through the Jenkins UI.

-   **Logs and Reporting**: Jenkins logs all build activity and provides detailed reports for each build job. This information is crucial for debugging, monitoring, and analyzing the health of your continuous integration and continuous delivery (CI/CD) processes.

-   **Jenkins Features**: Jenkins has a wide range of features, including:

    -   `Build automation`: Jenkins can be used to automate the build process for software projects. This can save time and effort, and it can help to ensure that the build process is repeatable and reliable.
    -   `Testing`: Jenkins can be used to automate the testing process for software projects. This can help to ensure that the software is working properly before it is deployed.
    -   `Deployment`: Jenkins can be used to deploy software projects to production. This can be done manually or automatically.
    -   `Notifications`: Jenkins can send notifications when builds, tests, or deployments succeed or fail. This can help to keep developers informed of the status of their projects.
    -   `Plugins`: Jenkins has a large number of plugins that can be used to extend its functionality. This includes plugins for building, testing, deploying, and managing software projects.

-   **Jenkins Best Practices**: There are a few best practices that you should follow when using Jenkins. These best practices can help you to get the most out of Jenkins and to avoid common problems.

    -   `Use a consistent naming convention for your jobs`: Using a consistent naming convention for your jobs will make it easier to find and manage your jobs. A good naming convention would include the name of the project, the build number, and the date.
    -   `Use a build tool`: Using a build tool can help you to automate the build process and to make it more reliable. A good build tool will allow you to define the steps that need to be performed when the project is built.
    -   `Configure notifications`: Configuring notifications will help you to stay informed of the status of your builds. You can configure Jenkins to send notifications when builds succeed or fail.
    -   `Use plugins`: Jenkins has a large number of plugins that can be used to extend its functionality. These plugins can be used to add new features to Jenkins or to improve the performance of Jenkins.

-   **withCredentials**: The withCredentials wrapper in Jenkins is a powerful method used in Pipeline scripts to securely handle sensitive information, such as passwords, tokens, SSH keys, or other credentials stored in Jenkins' credential store. It ensures that secrets are exposed only within the scope of the specified block and are automatically masked in logs.

    ```groovy
    pipeline {
        agent any
        stages {
            stage('Use Credentials') {
                steps {
                    withCredentials([usernamePassword(credentialsId: 'my-credentials-id',
                                                    usernameVariable: 'USERNAME',
                                                    passwordVariable: 'PASSWORD')]) {
                        sh '''
                        echo "Using Username: $USERNAME"
                        echo "Password is securely handled"
                        '''
                    }
                }
            }
        }
    }

    pipeline {
        agent any
        stages {
            stage('Use Secret Text') {
                steps {
                    withCredentials([string(credentialsId: 'my-secret-id', variable: 'SECRET_TOKEN')]) {
                        sh '''
                        echo "Using Secret Token: $SECRET_TOKEN"
                        '''
                    }
                }
            }
        }
    }

    pipeline {
        agent any
        stages {
            stage('Use Secret File') {
                steps {
                    withCredentials([file(credentialsId: 'my-secret-file-id', variable: 'SECRET_FILE')]) {
                        sh '''
                        echo "Secret file path: $SECRET_FILE"
                        cat $SECRET_FILE
                        '''
                    }
                }
            }
        }
    }

    pipeline {
        agent any
        stages {
            stage('Use SSH Key') {
                steps {
                    withCredentials([sshUserPrivateKey(credentialsId: 'my-ssh-key-id',
                                                    keyFileVariable: 'SSH_KEY',
                                                    usernameVariable: 'SSH_USER')]) {
                        sh '''
                        echo "SSH Username: $SSH_USER"
                        echo "SSH Key file: $SSH_KEY"
                        ssh -i $SSH_KEY $SSH_USER@hostname
                        '''
                    }
                }
            }
        }
    }

    pipeline {
        agent any
        stages {
            stage('Use Certificate') {
                steps {
                    withCredentials([certificate(credentialsId: 'my-cert-id',
                                                keystoreVariable: 'CERT_FILE',
                                                passwordVariable: 'CERT_PASS')]) {
                        sh '''
                        echo "Keystore file: $CERT_FILE"
                        echo "Keystore password: $CERT_PASS"
                        '''
                    }
                }
            }
        }
    }

    ```

</details>

<details><summary style="font-size:20px;color:Magenta">Secrets Management</summary>

##### Credential Scopes

Credential scopes refer to the contexts or domains in which credentials are valid and can be used. Jenkins uses credentials to securely store sensitive information such as usernames, passwords, API tokens, or private keys. The concept of credential scopes helps manage where these credentials can be utilized within the Jenkins environment. Different plugins and features within Jenkins may define their own credential scopes to control access to specific resources or functionalities.Here are some common credential scopes in Jenkins:

-   **System (Jenkins)**: Credentials with the **Jenkins** scope are generally available and applicable across the entire Jenkins instance. They can be used by various parts of Jenkins, including job configurations, pipeline scripts, and system configurations.

    -   `Restricted Usage`:

        -   Credentials with the Jenkins scope are limited to Jenkins itself or system-level tasks, such as:
            -   Connecting to external systems like databases or version control systems for Jenkins configuration.
            -   Authenticating with APIs or cloud services used by Jenkins plugins.
        -   These credentials cannot be accessed by jobs or pipelines.
        -   Credentials with the Jenkins scope are not visible to users, jobs or pipeline, making them more secure against accidental misuse.

    -   `Use Cases`:

        -   Plugin Configuration: For example, the Git plugin might use these credentials to authenticate with a remote repository for fetching changes or webhooks.
        -   Master-Agent Communication: Secure communication between Jenkins master (controller) and its agents might require these credentials.
        -   System Services: Used for integrating Jenkins with internal or system-level services.

-   **Global (Jenkins)**: Similar to the "Jenkins" scope, credentials with the **Global (Jenkins)** scope are accessible globally. They can be used in various configurations, but they may have a more limited scope than system-wide credentials.

    -   `Usage Scope`:

        -   Available to all users, jobs, and pipelines across the entire Jenkins instance.
        -   No need to configure the credentials separately for each job or project.
        -   Credentials with the Jenkins scope are global in nature and can be accessed anywhere within Jenkins.
        -   They are not tied to any specific folder or restricted by job/project boundaries.

    -   `Use Cases`:

        -   Pipelines: Referencing shared credentials in Jenkins pipelines for tasks like connecting to external systems.
        -   Plugins: Providing credentials to plugins such as Git, Docker, or Cloud integrations.
        -   Automation: Centralizing sensitive data for automation tasks that span multiple jobs.

-   **System (Nodes)**: Credentials with the **Node (agent)** scope are specific to Jenkins agent nodes. They can be used in configurations related to distributed builds or specific tasks that run on agent nodes.

-   **User**: User-scoped credentials are associated with a specific Jenkins user. These credentials are typically used within user-specific configurations, such as in pipeline scripts owned by that user.

-   **Item (Job)**: Credentials with the **Item** scope are specific to a particular Jenkins job or project. They are often used in job configurations or pipeline scripts associated with that job.

-   **Folder**: Folder-scoped credentials are specific to a Jenkins folder. They can be used within jobs or configurations contained within that folder.

These are just a few examples, and the availability of credential scopes may depend on the plugins installed and the Jenkins version. When configuring credentials in Jenkins, you will typically specify the credential scope to indicate where and how those credentials can be used.

By using credential scopes, Jenkins provides a way to manage and organize credentials based on the context in which they are intended to be used, enhancing security and access control within the CI/CD environment.

##### Types of Credentials

Jenkins supports various types of credentials, allowing users to securely store sensitive information such as usernames, passwords, API tokens, or private keys. Different credential types are designed to accommodate specific authentication mechanisms and use cases. Here are some common types of Jenkins credentials:

-   **Username and Password**:

    -   `Usage`: Used for basic username and password authentication.
    -   `Fields`: Typically includes "Username" and "Password" fields.
    -   `Example Use Case`: Authenticating with a version control system (e.g., Git, Subversion), accessing an external service, or connecting to a database.

-   **Secret Text**:

    -   `Usage`: Stores a secret string (e.g., an API token, encryption key).
    -   `Fields`: Usually contains a single "Secret" field.
    -   `Example Use Case`: Storing an API token for authentication with an external API.

-   **Secret File**:

    -   `Usage`: Stores a secret as a file.
    -   `Fields`: Typically includes a file path or content field.
    -   `Example Use Case`: Storing a private key file for SSH authentication.

-   **SSH Username with Private Key**:

    -   `Usage`: Used for SSH authentication with a private key.
    -   `Fields`: Includes "Username" and "Private Key" fields.
    -   `Example Use Case`: Authenticating with a remote server using SSH.

-   **Certificate**:

    -   `Usage`: Stores X.509 certificates for secure communication.
    -   `Fields`: May include certificate, private key, and passphrase fields.
    -   `Example Use Case`: Establishing secure connections with services that require SSL/TLS.

-   **AWS Credentials**:

    -   `Usage`: Stores AWS access key ID and secret access key.
    -   `Fields`: Typically includes "Access Key ID" and "Secret Access Key" fields.
    -   `Example Use Case`: Integrating Jenkins with AWS services (e.g., S3, EC2).

-   **Docker Host Certificate Authentication**:

    -   `Usage`: Stores certificates for authenticating with a Docker host.
    -   `Fields`: Includes certificate, key, and ca key fields.
    -   `Example Use Case`: Authenticating Jenkins to interact with Docker daemon securely.

-   **Bearer Token**:

    -   `Usage`: Stores a bearer token for authentication.
    -   `Fields`: Usually contains a single "Token" field.
    -   `Example Use Case`: Authenticating with APIs that use bearer token authentication.

-   **Git Username with Password**:

    -   `Usage`: Stores Git credentials for repository access.
    -   `Fields`: Includes "Username" and "Password" fields.
    -   `Example Use Case`: Authenticating Jenkins to clone or fetch from a Git repository.

-   **Jenkins**:

    -   `Usage`: Internal credential type for Jenkins itself.
    -   `Fields`: Specific to Jenkins internal use.

These credential types can be configured and managed through the Jenkins web interface. Users can associate credentials with Jenkins jobs, build pipelines, and other configurations to facilitate secure interactions with external systems and services. The choice of credential type depends on the authentication method required by the external system or service being accessed.

##### Secret management options in Jankins

In Jenkins, secret management is a crucial aspect of ensuring secure and reliable CI/CD processes. Secrets typically include sensitive information such as API keys, passwords, access tokens, and other credentials required by jobs or pipelines. Jenkins provides several options for secret management to secure and handle these sensitive pieces of information.

1. **Credentials Plugin**: The Credentials plugin is a core Jenkins plugin that provides a centralized and secure way to manage various types of credentials.

    - Supports different credential types, including usernames and passwords, secret text, secret files, and more.
    - Credentials can be stored globally or scoped to specific folders.
    - Credentials can be referenced in Jenkins jobs and pipelines.

2. **Secrets Management Plugins**: These plugins are designed to enhance secret management capabilities in Jenkins.

    - `AWS Secrets Manager Credentials Provider` Plugin: Integrates Jenkins with AWS Secrets Manager for managing AWS credentials securely.
    - `HashiCorp Vault Plugin`: Integrates Jenkins with `HashiCorp Vault` for secret storage and management.

3. **Jenkins Credentials Binding Plugin**: This plugin integrates with the Credentials plugin and allows you to inject credentials directly into your builds.

    - Credentials can be bound to environment variables or files during the build.
    - Simplifies the handling of secrets in build scripts.

4. **Jenkins Pipeline withCredentials Step**: The Pipeline DSL provides a `withCredentials` step that allows you to temporarily expose credentials to a block of code within a Jenkins pipeline.

    - Credentials can be used securely within a specific context in the pipeline script.
    - Credentials are masked in the console output.

    ```groovy
    withCredentials([usernamePassword(credentialsId: 'my-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
        // Your code that uses USERNAME and PASSWORD
    }
    ```

5. **Jenkins Managed File Encryption**: Jenkins provides a mechanism for encrypting sensitive files to protect them during storage.

    - Files containing sensitive information (e.g., private keys) can be encrypted.
    - Encrypted files can be used in build processes.

</details>

<details><summary style="font-size:20px;color:Magenta">End to End Jankins Pipeline</summary>

Setting up a Jenkins pipeline for a Django project hosted on GitHub involves several steps. Below is a step-by-step procedure to guide you through the process. This assumes that you already have Jenkins installed and running.

-   **Step 1: Install Required Jenkins Plugins**

    -   Make sure you have the necessary Jenkins plugins installed. For a Django project, you might need plugins like:

    -   GitHub plugin
    -   Pipeline plugin

-   **Step 2: Configure GitHub Credentials in Jenkins**

    -   In Jenkins, go to `Manage Jenkins` > `Manage Credentials`
    -   Add a new credential of type `Secret text` or `Secret file` with your GitHub token or credentials.

-   **Step 3: Create a Jenkinsfile in root directory of your Django project**

    -   Create a file named Jenkinsfile in the root of your Django project. This file defines the Jenkins pipeline.

    -   Here is a basic example of a Jenkinsfile:

        ```groovy
        pipeline {
            //agent any
            agent {
                // Use a Docker agent with the host's Docker daemon
                docker {
                    // Use the same Docker daemon as the host
                    reuseNode true
                }
            }

            environment {
                DJANGO_SETTINGS_MODULE = 'yourproject.settings'
            }

            stages {
                stage('Checkout') {
                    steps {
                        script {
                            // credentialsId: 'your-github-credentials-id': Specifies the credentials ID to be used for authenticating with the Git repository. This ID corresponds to the credentials stored in Jenkins that contain the necessary authentication information, such as username and password or token.
                            git credentialsId: 'your-github-credentials-id', url: 'https://github.com/A-Momin/bookstore.git'
                        }
                    }
                }

                stage('Install Dependencies') {
                    steps {
                        sh 'pip install -r requirements.txt'
                    }
                }

                stage('Run Tests') {
                    steps {
                        sh 'python manage.py test'
                    }
                }

                stage('Deploy') {
                    steps {
                        // Add deployment steps if applicable
                    }
                }
            }

            post {
                always {
                    // Clean up steps, e.g., collect artifacts, send notifications
                }
            }
        }
        ```

-   **Step 4: Create and Configure Your Jenkins Pipeline**

    -   In Jenkins, create a new pipeline job.
    -   In the job configuration, select `Pipeline script from SCM` for the Definition.
    -   Choose Git as the SCM, and provide your GitHub repository URL.
    -   Add your GitHub credentials.
    -   Specify the branch to build (e.g., `/master`, `/regular`, `/feature`).
    -   Save the configuration.

-   **Step 5: Run Your Jenkins Pipeline**

    -   Trigger the Jenkins pipeline manually or set up a webhook to trigger the pipeline automatically on each push to your GitHub repository.

    -   `Additional Considerations`:
        -   Ensure that your Jenkins server has the necessary tools installed, such as Python and any other dependencies your Django project requires.
        -   Customize the Jenkinsfile stages based on your project's needs.
        -   Add additional steps for deployment or any other actions your pipeline should perform.

</details>

<details><summary style="font-size:20px;color:Magenta;text-align:left">Jenkins Interview Questions</summary>

### Jenkins Basic

What is Jenkins and how is it used in DevOps?
How does Jenkins differ from other CI/CD tools like GitLab CI, CircleCI, or Travis CI?
What are the key features of Jenkins?
Can you explain the Jenkins architecture?

### Pipelines and Job

What are Jenkins pipelines, and how do they work?
What is the difference between a Jenkins freestyle job and a pipeline?
How can you configure a Jenkins pipeline as code?
What is the "Pipeline as Code" concept in Jenkins?
What is the purpose of a Jenkins Pipeline script?
How do you handle parallel execution in Jenkins pipelines?

### Jenkins Administration and Scalin

What is a Jenkinsfile?
Explain the Jenkinsfile Declarative Syntax.
What is a Jenkins Agent?
Explain the concept of a Build Agent or Build Slave.
What is Jenkins master-slave architecture?
How do you configure a Jenkins node (agent)?
What steps would you take to scale Jenkins in a large organization?
How does Jenkins support distributed builds?
What is the purpose of a Docker container in CI/CD?
What is the purpose of the "Artifact" in CI/CD?
Explain the role of the Jenkins Artifacts.
How do you create a job in Jenkins?
How can you secure Jenkins?
What is the purpose of the Jenkins Matrix project?
How do you trigger a Jenkins job?
What is the purpose of the Jenkins Dashboard?

1.  <details><summary style="font-size:18px;color:#C71585">How do you backup and restore Jenkins configurations?</summary>

    -   **Backup Jenkins Configuration**:

        1. `Backup Jenkins Home Directory`: The primary configuration and job data for Jenkins is stored in its home directory. Ensure you back up the entire Jenkins home directory, which typically includes the `jobs/`, `workspace/`, and other subdirectories.
            - `$ cp -r /var/lib/jenkins /path/to/backup/location`
        2. `Backup Jenkins Job Configurations`: Optionally, you can individually export job configurations from the Jenkins web interface. For each job, go to http://your-jenkins-url/job/job-name/config.xml and save the XML configuration file.
        3. `Backup Jenkins Plugin Configurations`: Jenkins plugin configurations are stored in the plugins/ directory inside the Jenkins home. You can back up this directory to preserve plugin configurations.
            - `$ cp -r /var/lib/jenkins/plugins /path/to/backup/location`
        4. `Backup Global Jenkins Configurations`: Some global configurations, including Jenkins system settings, are stored in the config.xml file in the Jenkins home directory. Ensure you back up this file.
            - `$ cp /var/lib/jenkins/config.xml /path/to/backup/location`

    -   **Restore Jenkins Configuration**:

        1. `Restore Jenkins Home Directory`: To restore Jenkins to a previous state, copy the contents of the backup Jenkins home directory back to the original Jenkins home location.
            - `$ cp -r /path/to/backup/location/jenkins /var/lib/jenkins`
        2. `Restore Jenkins Job Configurations`: If you exported individual job configurations, you can restore them by replacing the existing job configuration files in the `jobs/` directory.
            - `$ cp /path/to/backup/location/job-config.xml /var/lib/jenkins/jobs/job-name/config.xml`
        3. `Restore Jenkins Plugin Configurations`: Copy the backup plugins/ directory back to the Jenkins home directory to restore the plugin configurations.
            - `$ cp -r /path/to/backup/location/plugins /var/lib/jenkins`
        4. `Restore Global Jenkins Configurations`: Replace the existing config.xml file in the Jenkins home directory with the backed-up version.
            - `$ cp /path/to/backup/location/config.xml /var/lib/jenkins`
        5. `Restart Jenkins`: After restoring configurations, restart Jenkins to apply the changes.
            - `$ systemctl restart jenkins`

    </details>

### Automation, Integration, and Monitorng

How do you automate Jenkins job triggers?
How does Jenkins integrate with version control systems like Git?
How do you integrate Jenkins with Docker?
How would you implement Jenkins for continuous deployment (CD)?
How can you monitor Jenkins jobs and manage job failures?

### Plugins and Configuratio

What are Jenkins plugins, and why are they important?
Can you name a few essential Jenkins plugins and their use cases?
How do you install and configure Jenkins plugins?
How do you manage credentials securely in Jenkins?
What is the purpose of Jenkins plugins?

</details>

</details>

---

<details><summary style="font-size:25px;color:Orange">GitHub Actions:</summary>

-   [E1 - GitHub Actions: Write your first workflow with GitHub APIs || Beginner friendly tutorial](https://www.youtube.com/watch?v=-hVG9z0fCac&list=PLArH6NjfKsUhvGHrpag7SuPumMzQRhUKY&index=1)
-   [E3 - GitHub Actions: Write continuous deployment (CD) pipelines || Beginner Friendly](https://www.youtube.com/watch?v=-JvHif_CxTs&list=PLArH6NjfKsUhvGHrpag7SuPumMzQRhUKY&index=3)
-   [GitHub Actions Tutorial](https://www.youtube.com/watch?v=TLB5MY9BBa4)
-   [Nana: GitHub Actions Tutorial - Basic Concepts and CI/CD Pipeline with Docker](https://www.youtube.com/watch?v=R8_veQiYBjI&list=PLy7NrYWoggjzSIlwxeBbcgfAdYoxCIrM2)
-   Documents:

    -   [All GitHub Actions docs](https://docs.github.com/actions#all-docs)
    -   [Events that trigger workflows](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows)
    -   [GitHub Actions](https://github.com/actions)
    -   [webhooks](https://docs.github.com/en/webhooks-and-events/webhooks/about-webhooks)
    -   [Variables](https://docs.github.com/en/actions/learn-github-actions/variables)
    -   [Using secrets in GitHub Actions](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions)
    -   [Encrypted secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
    -   [Github Support](https://support.github.com/)
    -   []()

### Github-Actions Terms & Concepts

-   `Workflow`: A workflow is an automated process defined in a YAML file (`.github/workflows/file_name.yml`) within your repository. It consists of one or more jobs, which are executed when triggered by specific events, such as pushes, pull requests, or scheduled intervals.
-   `Job`: A job represents a unit of work within a workflow. It contains a set of steps that define the tasks to be performed. Jobs run in parallel by default, but you can also configure them to run sequentially. Each job executes on a separate runner, which is a virtual machine or container where the job's steps are executed.
-   `Step`: A step is an individual task within a job. It can be a command, script, or an action. Steps are executed sequentially within a job and can include actions from the GitHub Marketplace, shell commands, or custom scripts.
-   `Action`: An action is a reusable unit of code that encapsulates a specific task. It can be created by you or obtained from the GitHub Marketplace, allowing you to extend the functionality of your workflows. Actions can be written in various languages and perform a wide range of tasks, such as building, testing, or deploying your code.
-   `Event`: An event triggers a workflow run. Events can include push events (when code is pushed to the repository), pull request events (when pull requests are opened, updated, or closed), scheduled events (triggered by a cron-like schedule), and more. You can configure workflows to respond to specific events based on your requirements.
-   `Runner`: A runner is a machine (virtual or physical) that executes jobs in a workflow. GitHub provides hosted runners that are maintained by GitHub, or you can set up self-hosted runners on your own infrastructure. Self-hosted runners give you more control and allow you to execute workflows on your own hardware or cloud environments.
-   `Artifact`: An artifact is a file or collection of files produced by a job. It can be saved for later use or passed to other jobs in the workflow. Artifacts are commonly used to share build outputs, test results, or deployment packages between different stages of the workflow.
-   `Environment`: An environment represents a target deployment environment, such as staging or production. GitHub Actions allows you to define environments and associate them with specific branches or workflows. Environments help you manage and control the deployment of your code to different stages.
-   `Variavles`: Variables provide a way to store and reuse non-sensitive configuration information. You can store any configuration data such as compiler flags, usernames, or server names as variables. Variables are interpolated on the runner machine that runs your workflow. Commands that run in actions or workflow steps can create, read, and modify variables.

    -   You can set your own custom variables or use the [Default environment variables](https://docs.github.com/en/actions/learn-github-actions/variables#default-environment-variables) that GitHub sets automatically. You can set a custom variable in two ways.

        -   To define an environment variable for use in a single workflow, you can use the env key in the workflow file. For more information, see "Defining environment variables for a single workflow".
        -   To define a configuration variable across multiple workflows, you can define it at the organization, repository, or environment level. For more information, see "Defining configuration variables for multiple workflows".

-   `Secrets`: Secrets are encrypted variables that you can store in your repository or organization settings. They are used to securely store sensitive information, such as API keys, credentials, or access tokens, which can be used within your workflows. Secrets are encrypted and can only be accessed by selected workflows or actions.

    -   [Creating secrets for a repository](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions#creating-secrets-for-a-repository)
    -   [Creating secrets for an environment](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions#creating-secrets-for-an-environment)
    -   [Creating secrets for an organization](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions#creating-secrets-for-an-organization)

-   [Defining environment variables for a single workflow](https://docs.github.com/en/actions/learn-github-actions/variables#defining-environment-variables-for-a-single-workflow)
-   [Defining configuration variables for multiple workflows](https://docs.github.com/en/actions/learn-github-actions/variables#defining-configuration-variables-for-multiple-workflows)

<details><summary style="font-size:15px;color:Red;text-align:left">List of Common Directives on Github Workflow</summary>

-   **name**: Defines the name of the workflow.

```yaml
name: My Workflow
```

-   **on**: Specifies the events that trigger the workflow.

```yaml
on:
    push:
        branches:
            - main
```

-   **workflow_dispatch**: Allows manual triggering of the workflow using the GitHub Actions UI.

```yaml
on:
    workflow_dispatch:
```

-   **jobs**: Defines a set of jobs that run in parallel or sequentially.

```yaml
jobs:
    my-job:
        runs-on: ubuntu-latest
```

-   **steps**: Lists the individual steps to be executed in a job.

```yaml
steps:
    - name: Checkout Repository
      uses: actions/checkout@v2
```

-   **run**: Specifies the shell commands or scripts to be executed within a step.

```yaml
run: |
    echo "Hello, world!"
```

-   **env**: Sets environment variables for a job or a specific step.

```yaml
env:
    MY_VARIABLE: "some_value"
```

-   **with**: Provides additional options or parameters for an action or a step.

```yaml
with:
    key: value
```

-   **uses**: Specifies the action or Docker container to be used in a step.

```yaml
- name: Use an Action
  uses: actions/setup-node@v3
```

-   **strategy**: Defines a strategy for matrix builds, enabling parallel execution with different configurations.

```yaml
strategy:
    matrix:
        os: [ubuntu-latest, windows-latest]
```

-   **matrix**: Allows defining a matrix of values for parallel jobs.

```yaml
jobs:
    my-job:
        runs-on: ubuntu-latest
        strategy:
            matrix:
                version: [8, 10, 12]
```

-   **defaults**: Sets default values for jobs or steps.

```yaml
defaults:
    run:
        shell: bash
        working-directory: ./my-directory
```

-   **continue-on-error**: Allows a workflow to continue even if a job or step fails.

```yaml
jobs:
    my-job:
        runs-on: ubuntu-latest
        steps:
            - name: Run Step 1
              run: echo "Step 1"
            - name: Run Step 2
              run: echo "Step 2"
              continue-on-error: true
```

</details>
</details>

---

<details><summary style="font-size:25px;color:Orange">GitLab:</summary>

-   [Learn GitLab in 3 Hours | GitLab Complete Tutorial For Beginners](https://www.youtube.com/watch?v=8aV5AxJrHDg)
-   [Nana: GitLab CI CD](https://www.youtube.com/watch?v=qP8kir2GUgo)
    -   [GilLab Code](https://gitlab.com/nanuchi/gitlab-cicd-crash-course/-/blob/main/.gitlab-ci.yml)
-   [DevOps with GitLab CI Course - Build Pipelines and Deploy to AWS](https://www.youtube.com/watch?v=PGyhBwLyK2U)
    -   [ Course Notes](https://gitlab.com/gitlab-course-public/freecodecamp-gitlab-ci/-/blob/main/docs/course-notes.md)

### Gitlab Terms & Concepts

-   `.gitlab-ci.yml`: The `.gitlab-ci.yml` file is a configuration file written in YAML (Yet Another Markup Language) that defines the structure and steps of the CI/CD pipeline. It resides in the root directory of your GitLab repository and provides a declarative way to specify the stages, jobs, and their associated scripts or commands.
-   `Pipeline`: A pipeline in GitLab CI/CD is a series of stages and jobs that define the tasks to be executed. Each pipeline is triggered by an event, such as a code push or a scheduled time. Pipelines provide a structured way to define and visualize the entire CI/CD process.
-   `Stage`: A stage represents a logical division within a pipeline. For example, a typical pipeline may consist of stages like "build," "test," and "deploy." Each stage contains one or more jobs.
-   `Job`: A job is a defined task within a stage. It represents a specific unit of work, such as compiling code, running tests, or deploying the application. Jobs are executed sequentially within their respective stages.
-   `Runner`: A runner is an agent that executes the jobs defined in a pipeline. Runners can be shared or specific to a project. They can run on different operating systems, such as Linux, Windows, or macOS. GitLab provides shared runners, but you can also set up your own custom runners.
-   `Artifacts`: Artifacts are files generated by a job and passed to subsequent stages or jobs within the pipeline. For example, a build job may produce an executable file that needs to be used in the deployment stage. Artifacts can be downloaded or used for archiving purposes.
-   `Runner Tags`: Runner tags are labels assigned to specific runners to indicate their capabilities or characteristics. For example, you can assign a runner with the tag "docker" to indicate that it can execute jobs within Docker containers. Tags are useful for assigning specific jobs to runners with specific capabilities.
-   `Triggers`: Triggers allow you to manually start a pipeline from an external source, such as an API call or a webhook. They provide a way to integrate with external systems or trigger pipelines from events outside of GitLab.
-   `Environments`: Environments in GitLab CI/CD represent different target environments where your application can be deployed, such as staging or production. Environments provide a way to define deployment-specific variables, control access, and view deployment statuses.
-   `GitLab CI/CD Variables`: Variables allow you to define and pass custom values to your CI/CD pipeline. They can be defined at the pipeline, stage, or job level and are useful for storing sensitive information, like API keys or environment-specific configurations.
</details>

---

<details><summary style="font-size:25px;color:Orange">Ansible</summary>

-   [Ansible Full Course | 34 Topics in 2 Hours | Ansible Tutorial for Beginners](https://www.youtube.com/watch?v=Wr8zAU-0uR4)
-   [LinuxTV: Getting started with Ansible](https://www.youtube.com/playlist?list=PLT98CRl2KxKEUHie1m24-wkyHpEsa4Y70)
-   [Ansible Playbook Examples](https://www.middlewareinventory.com/blog/ansible-playbook-example/)
-   [What is Ansible?](https://www.youtube.com/watch?v=fHO1X93e4WA)
-   [Using Ansible playbooks](https://docs.ansible.com/ansible/latest/playbook_guide/index.html)

### Terms & Concepts

-   `Control Node`: A system on which Ansible is installed. You run Ansible commands such as ansible or ansible-inventory on a control node.
-   `Managed Node`: A remote system, or host, that Ansible controls.
-   `Inventory`: A list of managed nodes that are logically organized. You create an inventory on the control node to describe host deployments to Ansible.
-   `Ansible`: An open-source automation platform used for configuring and managing computers and software.
-   `Playbook`: A YAML file that contains a set of instructions for Ansible to execute on target hosts.
-   `Task`: An action to be performed by Ansible, such as installing a package, copying a file, or restarting a service.
-   `Module`: A pre-written Ansible task that can be used in a playbook, such as the 'yum' module for installing packages.
-   `Inventory`: A list of hosts that Ansible can manage, usually stored in a file in INI or YAML format.
-   `Play`: A section of a playbook that groups related tasks together and defines the target hosts.
-   `Role`: A reusable set of tasks, files, templates, and variables that can be included in a playbook.
-   `Variable`: A named value that can be used in a playbook, often used to make playbooks more dynamic and reusable.
-   `Fact`: Information about a target host that Ansible gathers, such as the operating system, network interfaces, and installed packages.
-   `Handler`: A task that is triggered when a previous task changes something on a host, such as restarting a service after its configuration file has been updated.
-   `Vault`: A feature for encrypting sensitive data, such as passwords, in Ansible playbooks.
-   `Galaxy`: A repository of pre-built Ansible roles that can be easily installed and used in playbooks.
-   `SSH`: Secure Shell, a network protocol ued by Ansible to connect to target hosts.
-   `Variables`: Variables are used to store values that can be used throughout a playbook. Variables can be defined in multiple ways, including as part of an inventory, in a playbook, or in a role.

### Here are some of the most commonly used Ansible keywords:

-   `ansible`: The main command that runs an Ansible playbook.
-   `hosts`: Specifies the hosts or groups of hosts on which a playbook should run.
-   `tasks`: The main component of a playbook, tasks specify the actions that Ansible should perform on the target hosts.
-   `roles`: A collection of tasks, variables, and templates that can be reused across multiple playbooks.
-   `vars`: Used to define variables that can be used in tasks and templates.
-   `templates`: Used to generate configuration files on the target hosts.
-   `files`: Used to copy files from the control machine to the target hosts.
-   `handlers`: Actions that should be taken after a task completes, such as restarting a service.
-   `include`: Allows you to include other files or tasks in your playbook.
-   `when`: A conditional statement that specifies when a task should run.
-   `register`: Used to store the output of a task in a variable for later use.
-   `ignore_errors`: Specifies whether Ansible should ignore errors and continue executing a playbook.
-   `with_items`: A loop that allows you to iterate over a list of items.
-   `become`: Used to elevate privileges on the target hosts.
-   `become_user`: Specifies the user account that should be used when elevating privileges.

</details>

---
