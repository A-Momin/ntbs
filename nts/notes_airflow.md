-   [`docker-compose.ymal` by Airflow](https://airflow.apache.org/docs/apache-airflow/stable/docker-compose.yaml)
-   [Default Airflow Config File](https://github.com/apache/airflow/blob/main/airflow/config_templates/default_airflow.cfg)
-   [Airflow Cheat Sheet](https://github.com/cherkavi/cheat-sheet/blob/master/airflow.md)
-   [Airflow CLI Documentation](https://airflow.apache.org/docs/apache-airflow/stable/cli-and-env-variables-ref.html)
-   [Astronomer Webinars](https://www.youtube.com/playlist?list=PLCi-q9vYo4x8VdC1vCiIdjtMXIJB5G5YM)
-   [Secrets Management in Airflow 2.0](https://www.youtube.com/watch?v=Mf2uTVe3GPA)
-   [Core Concepts](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/index.html)
-   []()

---

-   [Install Airflow:](https://github.com/apache/airflow/blob/main/README.md#installing-from-pypi)

    -   `$ pip install 'apache-airflow==2.3.3' --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-2.3.3/constraints-3.7.txt"`
    -   [Command Line Interface (CLI) Cheat Sheet](https://levelup.gitconnected.com/airflow-command-line-interface-cli-cheat-sheet-6e5d90bd3552)

-   [Airflow](https://airflow.apache.org/docs/apache-airflow/1.10.1/index.html)
    -   [Concepts](https://airflow.apache.org/docs/apache-airflow/1.10.1/concepts.html)
    -   [Concept](https://airflow.apache.org/docs/apache-airflow/stable/concepts/index.html)
-   [Dag document](https://airflow.apache.org/docs/apache-airflow/stable/concepts/dags.html)

<details><summary style="font-size:25px;color:Orange">Terms & Concepts</summary>

Apache Airflow is an open-source platform for orchestrating complex workflows and data pipelines. It provides a wide range of features for managing, scheduling, and monitoring workflows. Here are some key terms and concepts related to Apache Airflow, explained in detail:

-   `DAG (Directed Acyclic Graph)`: A DAG is a collection of tasks with defined dependencies that represent the workflow to be executed. Tasks in a DAG are organized in a way that ensures they run in a specific order without forming cycles.
-   `Operator`: An operator defines what gets done in each task within a DAG. Airflow provides a variety of built-in operators for common tasks (e.g., BashOperator, PythonOperator, SQLOperator) and allows you to create custom operators.
-   `Task`: A task is an instance of an operator within a DAG. It represents a single unit of work to be performed. Each task corresponds to a specific action, such as running a script or executing a SQL query.
-   `Task Instance`: A task instance is a specific occurrence or run of a task within a DAG. It records the execution state and metadata for each run of a task, including success or failure status.
-   `Scheduler`: The scheduler is a core component of Airflow that schedules when and how often tasks should run based on their defined dependencies and specified execution intervals.
-   `Executor`: An executor is responsible for executing tasks. Airflow supports various executors, including the LocalExecutor, CeleryExecutor, and others, allowing you to distribute task execution.
-   `Worker`: A worker is a process or machine that runs tasks. Workers are responsible for executing the operations defined by tasks. Multiple workers can be deployed to parallelize task execution.
-   `Metadata Database`: Airflow uses a metadata database (such as PostgreSQL, MySQL, or SQLite) to store metadata about DAGs, task instances, and execution history. It stores information about task schedules, state, and logs.
-   `DAG Run`: A DAG run represents a specific execution or run of a DAG. Each DAG can have multiple DAG runs with different execution dates and states.
-   `Scheduler Interval`: The scheduler interval determines how often the scheduler checks for tasks to execute. It's defined in the DAG and can be set to various intervals (e.g., daily, hourly).
-   `Sensor`: A sensor is a type of operator that waits for a certain condition or external event to be met before allowing downstream tasks to execute. Sensors are useful for handling external dependencies.
-   `XCom (Cross-Communication)`: XComs are a way for tasks to exchange small amounts of data during execution. They are often used to pass information between tasks within a DAG.
-   `Plugins`: Airflow allows you to extend its functionality through plugins. Plugins can include custom operators, sensors, hooks, and other components that enhance Airflow's capabilities.
-   `Variables and Connections`: Airflow provides a way to store configuration variables and database connection strings, making it easier to manage and share settings across DAGs.
-   `Web UI`: Airflow comes with a web-based user interface that provides a visual representation of DAGs, task status, execution logs, and allows users to trigger, pause, or rerun DAGs and tasks.
-   `CLI (Command-Line Interface)`: Airflow offers a command-line interface for managing DAGs, task runs, and other aspects of the system. It provides commands for interacting with Airflow from the terminal.
-   `ExecutorConfig`: ExecutorConfig is used to configure how tasks are executed. It includes parameters like parallelism, queue, and the maximum number of active workers.
-   `Templates and Macros`: Airflow supports template fields and macros in operators, allowing you to dynamically generate values in tasks using variables, execution dates, and other context.
-   `Trigger Rules`: Trigger rules define how downstream tasks should behave when a task is executed. Common trigger rules include "all_success," "all_failed," and "one_failed."
-   `Celery Flower`: Celery Flower is an optional web-based monitoring tool that can be used to visualize and monitor the execution of Celery workers in Airflow.
-   `Pools and Queues`: Pools and queues are used for resource allocation and task prioritization. Pools can limit the number of concurrently running tasks, while queues allow you to route tasks to specific workers.

Apache Airflow is a powerful platform for managing complex workflows, and understanding these terms and concepts is essential for effectively designing, scheduling, and monitoring data pipelines and workflows.

</details>

-   `$ export AIRFLOW_HOME=.`
-   `$ airflow db init`
-   `$ airflow webserver -p 8080`
-   `$ `
-   `$ airflow user create -r Admin -e bbcredcap3@gmail.com -f Aminul -l Momin -u bbcredcap3`
-   `$ airflow webserver -p 8080`
-   `$ airflow scheduler`
-   `$ `
-   `$ `
-   `$ `
-   `$ `

### Dockerized Airflow

-   `$ curl -LfO 'https://airflow.apache.org/docs/apache-airflow/2.3.3/docker-compose.yaml'

    -   Download `docker-compose.yaml` file

-   `$ mkdir -p ./dags ./logs ./plugins`
-   `$ echo -e "AIRFLOW_UID=$(id -u)" > .env` # Only for Linux Machine

-   `$ touch .env` # Only for MacOS or Windows
    -   Content: AIRFLOW_UID=50000
-   `$ docker-compose up airflow-init`
-   `$ docker-compose up -d`

-   The webserver is available at: `http://localhost:8080`. The default account has the login `airflow` and the password `airflow`.

-   `$ `
-   `$ `
-   `$ `
-   `$ `

<details><summary style="font-size:25px;color:Orange">Terms & Concepts</summary>

What is Apache Airflow and what problem does it solve?
Explain the architecture of Apache Airflow.
How does Apache Airflow handle task scheduling and dependency management?
What are DAGs in Apache Airflow? How are they different from traditional workflows?
Describe the components of a DAG in Apache Airflow.
What are Operators in Apache Airflow? Give examples of a few commonly used operators.
How does Apache Airflow handle task failures and retries?
What is XCom in Apache Airflow? How is it used for task communication?
Explain the concept of Executors in Apache Airflow.
What are Hooks and Operators in Apache Airflow and how are they related?
How do you configure Apache Airflow for scalability and high availability?
What is the difference between a Sensor and an Operator in Apache Airflow?
How does Apache Airflow handle timezones and daylight saving time changes?
Can you explain how to set up and configure Apache Airflow for use with external databases?
How can you monitor and debug Apache Airflow workflows?
What are some best practices for writing efficient DAGs in Apache Airflow?
Explain the role of the Scheduler in Apache Airflow.
How does Apache Airflow support dynamic task generation?
What are the different ways to trigger a DAG in Apache Airflow?
Can you describe a scenario where you've used Apache Airflow in a production environment and the challenges you faced?

</details>
