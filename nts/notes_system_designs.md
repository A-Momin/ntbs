### Software Design

-   <details><summary style="font-size:25px;color:Orange">Application Design Architectures</summary>

    -   <details><summary style="font-size:22px;color:Tomato">Monolithic Architecture</summary>

        **Monolithic Architecture** is a software design approach where an application is built as a single, unified unit. All components, such as the user interface, business logic, and data access, are tightly integrated and operate together in one codebase and deployment package.

        A **Monolithic Architecture** refers to an application that is built as a single, indivisible unit. All components of the application, such as the user interface (UI), business logic, and database access, are packaged and deployed together.

        #### Characteristics:

        -   **Single Codebase**: All the functionality resides in a single codebase and is deployed as one cohesive unit.
        -   **Tight Coupling**: Different components (UI, logic, database, etc.) are tightly coupled.
        -   **Single Deployment**: You deploy the entire application as one package. Any change requires redeploying the whole system.
        -   **Shared Database**: Typically, a monolithic system uses a single, shared database.

        #### Advantages:

        -   **Simplicity**: Easy to develop and deploy as it’s a single unit.
        -   **Performance**: Monolithic systems can perform well because everything runs in the same process.
        -   **Fewer Cross-cutting Concerns**: Tools and libraries for security, logging, etc., can be easily integrated since there’s one shared codebase.

        #### Disadvantages:

        -   **Scalability**: Scaling a monolithic application means scaling the entire application, even if only a small part of the system needs more resources.
        -   **Limited Flexibility**: Changes in one part of the system can affect other parts, making it difficult to modify or update features.
        -   **Slow Development and Deployment**: As the system grows, building, testing, and deploying the application becomes more complex and time-consuming.

        #### Use Cases:

        -   Suitable for small applications with limited complexity.
        -   Early stages of startups or applications with well-defined, simple features.

        </details>

    -   <details><summary style="font-size:22px;color:Tomato">Multi-Tier Architecture</summary>

        **Multi-tier Architecture** (also called N-tier Architecture) is a software design approach where an application is divided into separate layers (tiers), each responsible for a specific function. The most common tiers are the `presentation layer` (UI), the `application logic layer` (business logic), and the `data layer` (database). These tiers are physically or logically separated and communicate with each other.

        In **Multi-tier Architecture** (or **N-tier Architecture**), the application is divided into several distinct layers (tiers), each responsible for a specific function. The separation of concerns between these layers enhances maintainability, scalability, and flexibility. Here are the main and critical components of multi-tier architecture:

        #### Components of Multi-tier Architecture

        1. **Presentation Tier (UI Layer)**

            - This is the topmost layer responsible for interacting with users.
            - Displays data to users and collects input through graphical interfaces (web, desktop, or mobile UI).

        2. **Application Tier (Logic/Business Layer)**

            - Contains the core business logic that processes requests, enforces rules, and performs computations.
            - Acts as the middle layer that handles operations requested by the presentation tier and accesses data from the data tier.

        3. **Data Tier (Database Layer)**
            - Manages data storage, retrieval, and updates.
            - Handles interactions with the database, ensuring that data is stored and retrieved efficiently and securely.

        #### Characteristics:

        -   **Layered Approach**: Each tier is physically or logically separated. Typical layers are the user interface, business logic, and data management.
        -   **Modular**: Each tier performs a specific function, allowing for better separation of concerns.
        -   **Client-Server Model**: Usually follows a client-server architecture where the client handles the presentation and interacts with the application server (which handles logic) and the database server (which handles data storage).

        #### Typical Layers:

        1. **Presentation Tier**: This is the user interface layer where users interact with the application. It sends user requests to the logic tier and presents the response.
        2. **Application Tier**: This layer contains the business logic of the application. It processes the data and enforces rules.
        3. **Data Tier**: This tier manages the data storage, usually in a database. It retrieves, stores, and updates the data as requested by the application tier.

        #### Advantages:

        -   **Separation of Concerns**: Each tier focuses on its specific responsibility, making the system more maintainable and easier to manage.
        -   **Scalability**: Each tier can be scaled independently based on its load. For example, the database layer can be scaled separately from the logic layer.
        -   **Maintainability**: It is easier to maintain and update individual tiers without affecting others.

        #### Disadvantages:

        -   **Performance Overhead**: Communication between tiers can introduce latency, making the system slower compared to monolithic architecture.
        -   **Complexity**: More moving parts (servers, connections, etc.) can increase the complexity of the system.
        -   **Deployment Complexity**: Managing the deployment of multiple layers requires more planning and resources.

        #### Use Cases:

        -   Web applications that require a clear separation of concerns.
        -   Enterprise-level applications where scalability and maintainability are important.

        </details>

    -   <details><summary style="font-size:22px;color:Tomato">Microservices Architecture</summary>

        > **Microservice Architecture** is a software design approach where an application is built as a collection of small, independent services, each responsible for a specific business function. These services operate autonomously, communicate through APIs (such as REST or messaging), and can be developed, deployed, and scaled independently of one another. This architecture promotes flexibility, scalability, and fault isolation. In **Microservices Architecture**, the application is divided into small, independent services, each responsible for a specific business capability. Each microservice operates as a separate process, and they communicate with each other via well-defined APIs (such as REST or messaging queues).

        #### Components of Microservice Architecture:

        1. **Services**:

            - **Independent Modules**: Each microservice is a self-contained, independent module responsible for a specific business function (e.g., user management, payment processing).
            - **Autonomous Deployment**: Each service can be developed, deployed, and scaled independently.

        2. **API Gateway**: Acts as a single entry point for clients to interact with various microservices. It handles routing, request aggregation, and can enforce security, rate limiting, and authentication.

        3. **Service Discovery**: A mechanism that allows microservices to find each other dynamically within the system, usually through a registry (e.g., Eureka, Consul). This ensures flexibility in scaling and changing services.

        4. **Load Balancer**: Distributes incoming requests across multiple instances of services to ensure even workload distribution and high availability.

        5. **Database Per Service**: Each microservice has its own dedicated database, ensuring data autonomy and avoiding direct data sharing between services.

        6. **Inter-Service Communication**: Microservices communicate with each other, usually via lightweight protocols such as HTTP/REST, gRPC, or messaging queues (e.g., Kafka, RabbitMQ) for asynchronous communication.

        7. **Centralized Configuration Management**: A system that manages configurations for microservices across environments (development, production) without embedding them in the services (e.g., Spring Cloud Config).

        8. **Logging and Monitoring**: Centralized logging (e.g., ELK stack) and monitoring (e.g., Prometheus, Grafana) to track service performance, detect failures, and analyze system health.

        9. **Containerization & Orchestration**: **Containers** (e.g., Docker) package microservices, and **orchestration tools** (e.g., Kubernetes) manage the deployment, scaling, and operation of these containers in a distributed environment.

        10. **Fault Tolerance**: Mechanisms like **circuit breakers** (e.g., Hystrix) and **retries** help maintain stability by isolating failing services and preventing cascading failures.

        #### Characteristics:

        -   **Loose Coupling**: Microservices are loosely coupled. Each service is independent of others, making the system highly modular.
        -   **Autonomous Deployment**: Each microservice can be developed, deployed, and scaled independently.
        -   **Technology Agnostic**: Each service can use different technologies, programming languages, and databases based on its needs.
        -   **Service Isolation**: Each microservice has its own data store, so there's no need for a shared database.

        #### Advantages:

        -   **Scalability**: You can scale individual services as needed, improving resource efficiency.
        -   **Flexibility**: Developers can choose different tools or languages for each service based on specific requirements.
        -   **Fault Isolation**: Failure in one microservice typically doesn’t bring down the entire system. Other services can continue running.
        -   **Agility**: Independent development and deployment of services enable faster iterations and continuous delivery.

        #### Disadvantages:

        -   **Complexity**: Managing multiple services, each with its own database and deployment, adds significant operational complexity.
        -   **Distributed Systems Issues**: Communication between services introduces challenges like network latency, load balancing, and fault tolerance.
        -   **Data Consistency**: Since each microservice manages its own database, ensuring consistency across services can be difficult.
        -   **Deployment Overhead**: Managing and deploying multiple microservices requires sophisticated DevOps practices like containerization, orchestration (e.g., Kubernetes), and automated CI/CD pipelines.

        #### Use Cases:

        -   Large, complex applications that require scalability, flexibility, and frequent updates.
        -   Organizations adopting continuous deployment practices and want the flexibility to update or change parts of the application independently.

        </details>

    #### Comparison Summary:

    | Feature               | Monolithic                  | Multi-tier                           | Microservices                                |
    | --------------------- | --------------------------- | ------------------------------------ | -------------------------------------------- |
    | **Modularity**        | Low                         | Medium                               | High                                         |
    | **Deployment**        | Single Unit                 | Multiple tiers but deployed together | Independent services                         |
    | **Scalability**       | Difficult                   | Moderate                             | High, each service is scalable independently |
    | **Development Speed** | Slower as app grows         | Moderate                             | Faster with independent teams                |
    | **Fault Isolation**   | Low                         | Moderate                             | High                                         |
    | **Technology Choice** | Limited to one stack        | May vary per tier                    | Freedom to use different stacks per service  |
    | **Maintenance**       | More difficult as app grows | Moderate complexity                  | Easier but requires robust infrastructure    |

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Lucidchart</summary>

    -   [How to Use Lucidchart for System Design](https://www.youtube.com/watch?v=zoqUniosOLE)

    Designing a web application involves several stages—from mapping out the user journey to building wireframes and technical architecture. Lucidchart is a versatile tool for all these steps.

    1. **Planning User Journeys & Flows**: Before you design the interface, you need to understand how a user moves through the app.

        * **User Flows:** Use standard flowchart shapes to map the sequence of steps a user takes (e.g., Login → Dashboard → Settings).
        * **Logical Branching:** Use decision diamonds to show what happens if a user is logged in vs. logged out.

    2. **Creating Wireframes (UI/UX)**: Lucidchart has built-in **UI Mockup** shape libraries that allow you to create low-fidelity wireframes.

        * **Shape Libraries:** Press "M" on your keyboard and search for "UI Mockups," "iOS Mockups," or "Android Mockups."
        * **Standard Elements:** Drag and drop browser windows, search bars, buttons, and text placeholders to build your page layout.
        * **Interactivity:** Use **Hotspots** and **Layers** to make your wireframe interactive. For example, clicking a "Submit" button can trigger a layer that shows a "Success" popup.

    3. **Designing Technical Architecture**: For the developers on your team, you can design the back-end structure.

        * **ER Diagrams (ERDs):** Use the ERD shape library to design your database schema, showing tables, keys, and relationships.
        * **UML Diagrams:** Create sequence diagrams or class diagrams to show how different parts of your software communicate.
        * **Data Import:** You can even import data from your actual database to automatically generate a diagram in Lucidchart.

    4. **Collaboration & Feedback**

        * **Real-time Editing:** Multiple team members can work on the same wireframe at once.
        * **Commenting:** Use the commenting feature to tag developers or stakeholders on specific design elements to get feedback without leaving the canvas.

    </details>

---

