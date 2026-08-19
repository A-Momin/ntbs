-   [Kafka-101](https://www.youtube.com/playlist?list=PLa7VYi0yPIH0KbnJQcMv5N9iW8HkZHztH)
-   [Apache Kafka Fundamentals You Should Know](https://www.youtube.com/watch?v=-RDyEFvnTXI)
-   [Top Kafka Use Cases You Should Know](https://www.youtube.com/watch?v=Ajz6dBp_EB4)

---

---

Apache Kafka is a **distributed event streaming platform** designed for building real-time data pipelines and streaming applications. It functions as a highly scalable, fault-tolerant, and durable publish-subscribe messaging system that allows applications to process data streams in real time.

Here is a detailed breakdown of its terms, concepts, components, and features.

#### Core Apache Kafka Concepts (The Data Model)

The Kafka ecosystem revolves around the concept of an **Event** (or **Record**), which is the atomic unit of data.

-   **Event (Record/Message):** The fundamental unit of data in Kafka. An event is structured data that records the fact that "something happened."
    -   **Key (Optional):** A byte array used to route related events to the same **Partition**. Events with the same key are guaranteed to be processed in order.
    -   **Value:** The actual data payload (e.g., a JSON object, a log entry, or a serialized object).
    -   **Timestamp:** The time the event occurred or was produced.
    -   **Headers (Optional):** Arbitrary metadata associated with the event.
-   **Topic:** A named logical channel or feed to which producers publish events and from which consumers read events. Topics are analogous to tables in a database or folders in a file system.
-   **Partition:** A topic is divided into one or more partitions. Partitions are the unit of parallelism and scale in Kafka.
    -   Each partition is an **ordered, immutable sequence** of events, stored on disk.
    -   Order is **only guaranteed within a single partition**, not across the entire topic.
-   **Offset:** A unique, sequential ID number assigned to each event within a partition. The offset tracks the event's position in the partition's log, acting as a "bookmark" for consumers.

#### Architectural Components

A Kafka deployment runs as a distributed system, known as a **Kafka Cluster**, comprising several servers (brokers) and coordinating clients.

##### 1. Kafka Cluster & Brokers

-   **Kafka Cluster:** A group of one or more Kafka servers (**Brokers**) that work together to manage the event streams, ensuring high availability and fault tolerance.
-   **Broker (Kafka Server):** A single server within the Kafka cluster. Brokers:
    -   Receive events from producers.
    -   Store events durably on disk (as part of a log).
    -   Serve events to consumers.
    -   Each broker hosts a portion of the topic partitions.

##### 2. Producers and Consumers (Clients)

-   **Producer:** A client application that **publishes** (writes) new events to a specified topic. Producers are responsible for:
    -   Serializing the event data.
    -   Choosing which partition an event is sent to (using the key for deterministic routing or round-robin for even distribution).
-   **Consumer:** A client application that **subscribes** to one or more topics and **reads** (processes) the events.
    -   Consumers track their progress using the **Offset** and request data from the partition leader broker.
-   **Consumer Group:** A group of consumers that cooperate to consume data from a set of topics.
    -   **Load Balancing:** Each partition is assigned to **exactly one** consumer within the group. This ensures parallel processing and prevents redundant message handling.
    -   **Fault Tolerance:** If a consumer fails, its assigned partitions are automatically and quickly reassigned to other consumers in the same group (a process called **rebalancing**).

##### 3. Metadata Management (KRaft)

-   **KRaft (Kafka Raft):** In modern Kafka versions (4.0+), KRaft is the built-in, distributed consensus protocol that manages the Kafka cluster's metadata (e.g., topic configuration, partition leaders, and broker health).
    -   KRaft replaces the external dependency on **Apache ZooKeeper**, greatly simplifying deployment, scaling, and operational management.

#### Reliability and Durability Concepts

Kafka's design prioritizes data durability and high availability through replication.

-   **Replication Factor:** A topic-level setting that determines how many copies (replicas) of each partition are maintained across different brokers in the cluster. A factor of 3 is common for production.
-   **Partition Leader:** For each partition, one replica is designated as the **Leader**.
    -   All Producer writes and Consumer reads for that partition must go through the Leader.
-   **Follower Replicas:** The other replicas for a partition are **Followers**.
    -   Followers passively replicate data from the Leader. If the Leader fails, one of the Followers is elected as the new Leader, ensuring continuous availability.
-   **In-Sync Replicas (ISRs):** The set of replicas (including the Leader) that are fully caught up with the Leader's log. Producers can be configured to wait for acknowledgments from all ISRs before considering a message committed, guaranteeing durability.
-   **Retention Policy:** Kafka does not delete messages immediately upon consumption. Data is retained for a configurable period (e.g., 7 days) or until a certain size limit is reached.
    -   **Log Compaction:** A specialized retention policy that ensures Kafka always retains the last-known value for each unique **Key**. It is used for storing state changes rather than temporary event streams.

#### The Kafka Ecosystem (APIs and Tools)

Kafka is more than just a message queue; it is a full event streaming platform with a rich ecosystem of client APIs and tools.

##### 1. Client APIs

-   **Producer API:** Allows applications to publish streams of events to the Kafka cluster.
-   **Consumer API:** Allows applications to subscribe to topics and process streams of events.
-   **Admin API:** Used for managing and inspecting topics, brokers, and other Kafka objects.

##### 2. Stream Processing & Integration Tools

-   **Kafka Streams:** A lightweight, client-side Java/Scala library for building real-time stream processing applications. It provides high-level operations (like `filter`, `map`, `join`, `aggregate`) for transforming, enriching, and analyzing data streams.
-   **Kafka Connect:** A framework for reliably and scalably integrating Kafka with other external systems, such as databases, file systems, and search indices.
    -   **Source Connectors:** Ingest data _from_ a source system (e.g., PostgreSQL, S3) **into** Kafka.
    -   **Sink Connectors:** Deliver data _from_ Kafka **to** a sink system (e.g., Elasticsearch, Snowflake).

##### 3. Key Features

-   **High Throughput & Low Latency:** Designed for sequential disk I/O and efficient network protocol, allowing it to handle millions of events per second with low-millisecond latency.
-   **Decoupling:** Producers and consumers are fully decoupled; they don't know about each other, allowing independent scaling and evolution of the data source and destination applications.
-   **Exactly-Once Processing Semantics:** Kafka offers guarantees to ensure an event is processed exactly one time, even when failures occur in the producer, broker, or consumer applications.
-   **Tiered Storage (New):** A feature that allows older, less frequently accessed partition data to be moved to cheaper, remote storage (like S3) while remaining accessible to consumers, improving broker storage efficiency.
-   **Queues for Kafka (New):** The introduction of **Shared Consumer Groups** enables traditional queue semantics (where multiple consumers can read from the same partition, but each message is processed only once by one of the consumers) alongside the existing pub/sub model.

---

---

#### Workflow of Kafka

1. **Producers** send messages to a Kafka topic.
2. Messages are distributed across **partitions** within the topic.
3. Kafka stores the messages in the partition logs on the brokers.
4. **Consumers** fetch messages from the topic partitions based on offsets.
5. Messages are retained in Kafka for a configured duration or until a size limit is reached.

#### Kafka Design Principles

-   **Scalability**:

    -   Kafka scales horizontally by adding more brokers and partitions.
    -   Producers and consumers can also scale independently.

-   **Fault Tolerance**:

    -   Data replication across brokers ensures availability even if some brokers fail.
    -   Replicas are maintained for each partition.

-   **High Throughput**:

    -   Optimized for high-throughput event streaming, even with large data volumes.

-   **Durability**:

    -   Kafka persists data to disk, enabling fault recovery and replaying events.

#### Advantages of Kafka

-   **Real-Time Processing**: Supports low-latency data processing.
-   **Decoupling of Systems**: Producers and consumers are independent, enabling flexibility.
-   **Event Replay**: Consumers can replay events by resetting offsets.
-   **Strong Ecosystem**: Kafka Streams, Kafka Connect, and Schema Registry enhance its functionality.

#### Common Use Cases

-   **Log Aggregation**: Centralized collection and processing of logs.
-   **Real-Time Analytics**: Monitoring and analyzing data streams in real time.
-   **Data Pipelines**: Moving data between systems like databases and data lakes.
-   **Event Sourcing**: Capturing system events for audit and replay purposes.
-   **IoT**: Handling data streams from sensors or devices.
