# Diagrams Used in Software Engineering to Understand Data Flow

Software engineers use several kinds of diagrams to understand how data moves through a system. Some focus specifically on **data flow**, while others show data movement as part of broader system behavior, architecture, or interactions.

Below is a practical list, with a small Mermaid example for each.

---

## 1. Data Flow Diagram (DFD)

A **Data Flow Diagram** focuses directly on how data moves between:

- External entities
- Processes
- Data stores
- Other processes

DFDs are especially useful during requirements analysis and system design.

### Example

```mermaid
flowchart LR
    User[User]
    Process[Process Order]
    DB[(Order Database)]
    Payment[Payment Gateway]

    User -->|Order details| Process
    Process -->|Store order| DB
    Process -->|Payment request| Payment
    Payment -->|Payment result| Process
    Process -->|Order confirmation| User
```

**Best for:** Understanding data movement at a conceptual or logical level.

---

## 2. Context Diagram

A **Context Diagram** is a high-level DFD that treats the entire application as a single process. It shows the system's boundary and the external systems or actors that exchange data with it.

### Example

```mermaid
flowchart LR
    Customer[Customer]
    Admin[Administrator]
    Payment[Payment Service]
    Shipping[Shipping Service]

    System((E-Commerce System))

    Customer -->|Orders / customer data| System
    System -->|Order status| Customer

    Admin -->|Product updates| System
    System -->|Reports| Admin

    System -->|Payment request| Payment
    Payment -->|Payment result| System

    System -->|Shipping request| Shipping
    Shipping -->|Tracking information| System
```

**Best for:** Quickly understanding system scope and external data exchanges.

---

## 3. Levelled DFD

A large DFD can be decomposed into multiple levels. A **Level 0 DFD** breaks the system into major processes, while Level 1, Level 2, etc. progressively decompose those processes.

### Example: Level 0

```mermaid
flowchart LR
    Customer[Customer]
    P1[1. Manage Orders]
    P2[2. Process Payment]
    P3[3. Fulfill Order]
    Orders[(Orders)]
    Payments[(Payments)]

    Customer -->|Order| P1
    P1 -->|Order data| Orders
    P1 -->|Payment details| P2
    P2 -->|Payment record| Payments
    P2 -->|Payment confirmation| P1
    P1 -->|Approved order| P3
    P3 -->|Fulfillment status| Orders
    P3 -->|Status| Customer
```

**Best for:** Moving from a high-level view into progressively more detailed data flows.

---

## 4. UML Activity Diagram

A **UML Activity Diagram** models a workflow or business process. Although it is not exclusively a data-flow diagram, it can clearly show how data objects are produced, transformed, and consumed during a workflow.

### Example

```mermaid
flowchart TD
    Start((Start))
    Receive[Receive Order]
    Validate[Validate Order]
    Data[/Order Data/]
    Decision{Valid?}
    Process[Process Payment]
    Receipt[/Payment Receipt/]
    Reject[Reject Order]
    End((End))

    Start --> Receive
    Receive --> Data
    Data --> Validate
    Validate --> Decision
    Decision -->|Yes| Process
    Process --> Receipt
    Receipt --> End
    Decision -->|No| Reject
    Reject --> End
```

**Best for:** Understanding data as it moves through a business or application workflow.

---

## 5. UML Sequence Diagram

A **Sequence Diagram** shows interactions between components over time. It is useful for understanding **who sends what data to whom, and in what order**.

### Example

```mermaid
sequenceDiagram
    participant User
    participant App
    participant API
    participant DB
    participant Payment

    User->>App: Submit order
    App->>API: POST /orders
    API->>DB: Create order
    DB-->>API: Order ID
    API->>Payment: Charge payment
    Payment-->>API: Payment result
    API->>DB: Update order status
    API-->>App: Order confirmation
    App-->>User: Display confirmation
```

**Best for:** Understanding data exchanges and request/response flows between components over time.

---

## 6. UML Communication Diagram

A **Communication Diagram** (formerly called a Collaboration Diagram) emphasizes the relationships between objects/components and the messages exchanged between them.

It is similar to a sequence diagram, but the emphasis is on **connections and communication structure** rather than a vertical timeline.

### Example

```mermaid
flowchart LR
    User[User]
    App[Web App]
    API[Order API]
    DB[(Order DB)]
    Payment[Payment Service]

    User -->|1: Submit order| App
    App -->|2: Create order| API
    API -->|3: Save order| DB
    API -->|4: Charge payment| Payment
    Payment -->|5: Payment result| API
    API -->|6: Confirmation| App
    App -->|7: Display result| User
```

**Best for:** Understanding which components communicate and what messages/data they exchange.

---

## 7. UML State Machine Diagram

A **State Machine Diagram** models how an entity changes state in response to events. Data itself may not be the primary focus, but it is useful when the **state of data changes over its lifecycle**.

### Example

```mermaid
stateDiagram-v2
    [*] --> Created

    Created --> PendingPayment: Submit order
    PendingPayment --> Paid: Payment successful
    PendingPayment --> PaymentFailed: Payment failed

    PaymentFailed --> PendingPayment: Retry payment
    Paid --> Processing: Start fulfillment
    Processing --> Shipped: Ship order
    Shipped --> Delivered: Delivery confirmed

    Delivered --> [*]
```

**Best for:** Understanding how an entity's data/state changes as it passes through a system.

---

## 8. Entity-Relationship Diagram (ERD)

An **Entity-Relationship Diagram** focuses on the structure and relationships of data rather than the runtime movement of data.

It is important for understanding where data is stored and how different data entities relate.

### Example

```mermaid
erDiagram
    CUSTOMER ||--o{ ORDER : places
    ORDER ||--|{ ORDER_ITEM : contains
    PRODUCT ||--o{ ORDER_ITEM : appears_in
    ORDER ||--o| PAYMENT : has

    CUSTOMER {
        int customer_id PK
        string name
        string email
    }

    ORDER {
        int order_id PK
        int customer_id FK
        date order_date
        string status
    }

    ORDER_ITEM {
        int order_item_id PK
        int order_id FK
        int product_id FK
        int quantity
    }

    PRODUCT {
        int product_id PK
        string name
        decimal price
    }

    PAYMENT {
        int payment_id PK
        int order_id FK
        decimal amount
        string status
    }
```

**Best for:** Understanding data storage, relationships, ownership, and database structure.

---

## 9. System / Architecture Data-Flow Diagram

Architecture diagrams can show how data moves between major services, applications, databases, queues, and external systems.

These are particularly useful in distributed systems and microservice architectures.

### Example

```mermaid
flowchart LR
    Client[Web / Mobile Client]
    Gateway[API Gateway]
    Orders[Order Service]
    Inventory[Inventory Service]
    Payment[Payment Service]
    Queue[[Message Queue]]
    DB1[(Order DB)]
    DB2[(Inventory DB)]
    DB3[(Payment DB)]

    Client -->|HTTP request| Gateway
    Gateway -->|Order request| Orders
    Orders -->|Order data| DB1
    Orders -->|Reserve inventory| Inventory
    Inventory -->|Inventory data| DB2
    Orders -->|Payment request| Payment
    Payment -->|Payment data| DB3
    Orders -->|Order-created event| Queue
    Queue -->|Event| Inventory
```

**Best for:** Understanding data movement across services and infrastructure.

---

## 10. Sequence Flow for Event-Driven Systems

For event-driven architectures, an **event-flow diagram** can show how data is published as events and consumed asynchronously by different services.

### Example

```mermaid
flowchart LR
    OrderService[Order Service]
    Bus[[Event Bus]]
    Inventory[Inventory Service]
    Email[Notification Service]
    Analytics[Analytics Service]
    InventoryDB[(Inventory DB)]
    AnalyticsDB[(Analytics DB)]

    OrderService -->|OrderCreated event| Bus
    Bus -->|OrderCreated| Inventory
    Bus -->|OrderCreated| Email
    Bus -->|OrderCreated| Analytics

    Inventory -->|Update stock| InventoryDB
    Analytics -->|Store metrics| AnalyticsDB
```

**Best for:** Understanding asynchronous data distribution through events, queues, and message brokers.

---

## 11. ETL / Data Pipeline Diagram

A **data pipeline diagram** shows how data is extracted, transformed, transported, and loaded into another system.

It is particularly common in data engineering, analytics, and machine-learning systems.

### Example

```mermaid
flowchart LR
    Sources[(Operational Databases)]
    Files[(CSV / JSON Files)]
    API[External APIs]

    Extract[Extract]
    Transform[Transform / Clean]
    Load[Load]
    Warehouse[(Data Warehouse)]
    BI[BI / Analytics]

    Sources --> Extract
    Files --> Extract
    API --> Extract
    Extract --> Transform
    Transform --> Load
    Load --> Warehouse
    Warehouse --> BI
```

**Best for:** Understanding movement and transformation of data through a data-processing pipeline.

---

## 12. C4 Container Diagram

A **C4 Container Diagram** shows the major applications/services inside a system and how they communicate. It is not specifically a data-flow diagram, but arrows can be annotated with the data or protocols being exchanged.

### Example

```mermaid
flowchart LR
    User[Customer]

    Web[Web Application]
    API[Backend API]
    DB[(Database)]
    Payment[Payment System]
    Email[Email System]

    User -->|HTTPS / user actions| Web
    Web -->|JSON / HTTPS| API
    API -->|SQL / customer & order data| DB
    API -->|Payment request| Payment
    API -->|Email message| Email
```

**Best for:** Understanding data movement between major application components.

---

# Comparison

| Diagram | Main Focus | Shows Data Flow? | Typical Use |
|---|---|---:|---|
| **Context Diagram** | System boundary | Yes | System scope |
| **DFD** | Data movement | **Yes — primary purpose** | Requirements & system analysis |
| **Levelled DFD** | Hierarchical data movement | **Yes — primary purpose** | Decomposing complex systems |
| **Activity Diagram** | Workflow/process | Yes | Business/application processes |
| **Sequence Diagram** | Time-ordered interactions | **Yes** | API/component interactions |
| **Communication Diagram** | Component relationships/messages | **Yes** | Object/component communication |
| **State Machine Diagram** | State transitions | Indirectly | Entity lifecycle |
| **ERD** | Data structure/relationships | No, primarily | Database design |
| **Architecture Data-Flow Diagram** | System/service communication | **Yes** | Distributed systems |
| **Event-Flow Diagram** | Event propagation | **Yes** | Event-driven systems |
| **ETL/Data Pipeline** | Data processing pipeline | **Yes — primary purpose** | Analytics/data engineering |
| **C4 Container Diagram** | Software architecture | Yes | Architecture communication |

---

# Which Diagram Should You Use?

A useful rule of thumb is:

```text
What are you trying to understand?
              │
      ┌───────┴────────┐
      │                │
  "Where does       "How does
   data go?"         the system work?"
      │                │
      ▼                ▼
    DFD            Activity Diagram
      │
      ├── System boundary? ──► Context Diagram
      │
      ├── Need more detail? ─► Levelled DFD
      │
      ├── Between services? ─► Architecture Data Flow
      │
      ├── Via events? ───────► Event-Flow Diagram
      │
      └── Through ETL? ──────► Data Pipeline
```

For **database structure**, use an **ERD**.

For **time-ordered communication**, use a **Sequence Diagram**.

For **entity lifecycle/state changes**, use a **State Machine Diagram**.

For **overall software architecture**, use a **C4 diagram**.

## The most important distinction

If the question is specifically:

> **"I want to understand how data flows through my software system."**

Start with a **Context Diagram → DFD → Levelled DFD**.

Then use **Sequence Diagrams** when you need to understand the runtime interaction between components, and **Architecture/Event/Data Pipeline diagrams** when the system becomes distributed or data-intensive.

In other words:

```text
                 System understanding
                         │
             ┌───────────┴───────────┐
             │                       │
       Data perspective        Behavior perspective
             │                       │
             ▼                       ▼
           Context                 Activity
             │
             ▼
            DFD
             │
       ┌─────┼──────────┐
       ▼     ▼          ▼
   Levelled  Event     Pipeline
     DFD     Flow
       │
       ▼
 Architecture
 Data Flow
```
