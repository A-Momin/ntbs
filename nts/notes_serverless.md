The Serverless Framework CLI provides a robust set of commands for developing, deploying, and managing serverless applications, primarily for AWS Lambda. Many commands share common options for specifying the target **stage** and **region**.

Here are some of the most useful commands, along with their key parameters and flags:

## 🚀 Deployment Commands

These commands are central to the development lifecycle, handling the packaging and deployment of your service.

| Command                                              | Description                                                                                    | Key Options (Flags)                                                                               |
| :--------------------------------------------------- | :--------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------ |
| `serverless deploy` (`sls deploy`)                   | Deploys your entire service via CloudFormation (use for infrastructure/configuration changes). | `--stage` or `-s`: The stage (e.g., `dev`, `prod`).                                               |
|                                                      |                                                                                                | `--region` or `-r`: The region (e.g., `us-east-1`).                                               |
|                                                      |                                                                                                | `--config` or `-c`: Specify a configuration file name other than `serverless.yml`.                |
|                                                      |                                                                                                | `--package` or `-p`: Path to a pre-packaged directory to skip the packaging step.                 |
|                                                      |                                                                                                | `--force`: Forces a deployment to take place, even if no changes are detected.                    |
|                                                      |                                                                                                | `--param="<key>=<value>"`: Pass parameters to be used in your `serverless.yml`.                   |
| `serverless deploy function` (`sls deploy function`) | Quickly deploys code and configuration for a **single function** (use for code changes).       | `--function` or `-f`: **Required**. The name of the function to deploy.                           |
|                                                      |                                                                                                | `--stage` or `-s`, `--region` or `-r`, `--config` or `-c`, `--aws-profile`: Same as `sls deploy`. |
| `serverless package` (`sls package`)                 | Packages your entire infrastructure into a `.serverless` directory, ready for deployment.      | `--stage` or `-s`, `--region` or `-r`, `--config` or `-c`, `--aws-profile`: Common options.       |
|                                                      |                                                                                                | `--package` or `-p`: Path to a custom directory for the output package.                           |

## 🛠️ Local Development & Testing Commands

These are essential for testing functions without deploying them to the cloud.

| Command                                        | Description                                                                                                                    | Key Options (Flags)                                                                                     |
| :--------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------ |
| `serverless invoke local` (`sls invoke local`) | Invokes a function locally on your machine.                                                                                    | `--function` or `-f`: **Required**. The name of the function to invoke.                                 |
|                                                |                                                                                                                                | `--path` or `-p`: Path to a JSON file to pass as the event data.                                        |
|                                                |                                                                                                                                | `--data` or `-d`: String of data (parsed as JSON by default) to pass as the event.                      |
|                                                |                                                                                                                                | `--raw`: Treat input data (`--data`) as a raw string instead of parsing as JSON.                        |
|                                                |                                                                                                                                | `--env` or `-e`: String in the format `<name>=<value>` to set an environment variable. Can be repeated. |
| `serverless dev` (`sls dev`)                   | Activates a long-running development session to run, develop, and test functions locally while connecting to remote resources. | `--stage` or `-s`, `--region` or `-r`, `--aws-profile`: Common options.                                 |

## 💻 Service Information & Operations Commands

Commands for monitoring, viewing details, and managing deployments.

| Command                                      | Description                                                                               | Key Options (Flags)                                                                        |
| :------------------------------------------- | :---------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------- |
| `serverless logs` (`sls logs`)               | Fetches and displays the logs of a specific function.                                     | `--function` or `-f`: **Required**. The name of the function.                              |
|                                              |                                                                                           | `--startTime`: Display logs starting from a specific time (e.g., `10m` ago, `2019-12-01`). |
|                                              |                                                                                           | `--tail` or `-t`: Tail the logs, keeping the command running to fetch new logs.            |
|                                              |                                                                                           | `--interval`: The time interval in milliseconds between log fetches when tailing.          |
| `serverless info` (`sls info`)               | Displays information about your service, including deployed endpoints and function names. | `--stage` or `-s`, `--region` or `-r`, `--aws-profile`: Common options.                    |
|                                              |                                                                                           | `--json`: Output the information in JSON format.                                           |
|                                              |                                                                                           | `--verbose`: Shows additional Stack Output details.                                        |
| `serverless rollback` (`sls rollback`)       | Rolls back your service to a previous deployment version.                                 | `--timestamp`: **Required**. The timestamp of the deployment to roll back to.              |
|                                              |                                                                                           | `--stage` or `-s`, `--region` or `-r`, `--aws-profile`: Common options.                    |
| `serverless remove` (`sls remove`)           | Removes the deployed service and all its resources from the cloud provider.               | `--stage` or `-s`, `--region` or `-r`, `--aws-profile`: Common options.                    |
| `serverless deploy list` (`sls deploy list`) | Lists information about past deployments, useful for finding a timestamp for rollback.    | `functions`: An optional subcommand to list deployed function names and versions.          |
|                                              |                                                                                           | `--stage` or `-s`, `--region` or `-r`, `--aws-profile`: Common options.                    |

## 🔌 Plugin & Utility Commands

| Command                                                | Description                                                 | Key Options (Flags)                                          |
| :----------------------------------------------------- | :---------------------------------------------------------- | :----------------------------------------------------------- |
| `serverless plugin install` (`sls plugin install`)     | Installs a new plugin from the Serverless plugins registry. | `--name`: **Required**. The name of the plugin to install.   |
| `serverless plugin uninstall` (`sls plugin uninstall`) | Uninstalls an installed plugin.                             | `--name`: **Required**. The name of the plugin to uninstall. |

## ⚙️ Global Options

The following flags are often available on _most_ Serverless CLI commands:

-   `--stage` or `-s`: Specify the deployment stage.
-   `--region` or `-r`: Specify the cloud provider region.
-   `--config` or `-c`: Specify a custom configuration file name.
-   `--aws-profile`: Specify the AWS profile to use from your local credentials.
-   `--verbose`: Increase the verbosity of the output.
-   `--help`: Display help for a specific command (e.g., `serverless deploy --help`).

Would you like to explore the commands related to a **specific cloud provider** (like Azure or Google Cloud) or see the details for a command like **`serverless invoke`** for remote function invocation?
