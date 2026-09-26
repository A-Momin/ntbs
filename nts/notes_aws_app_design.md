```mermaid
flowchart TD
    subgraph ClientLayer["External Clients"]
        WWW["Internet Traffic (WWW)"]
    end

    subgraph VPC["Amazon VPC (Region: us-east-1)"]
        direction TB

        subgraph VPCDNS["VPC Network Layer DNS"]
            Resolver["Route 53 Resolver / AmazonProvidedDNS<br/>(169.254.169.253 / VPC .2)"]
        end

        subgraph PublicSubnet["Public Subnet - Ingress Tier"]
            ALB["AWS Application Load Balancer (ALB)"]
            ALBSG["ALB Security Group (ALB SG)"]
        end

        subgraph PrivateSubnetApp["Private Subnet - Application Tier"]
            APP["Application Cluster / Compute (EC2 / ECS / EKS)"]
            APPSG["APP Security Group (APP SG)"]
        end

        subgraph PrivateSubnetDBProxy["Private Subnet - Database Proxy / Pooler Tier"]
            RDSPROXY["Amazon RDS Proxy<br/>(DB Connection Pooler and Load Balancer)"]
            CNAME["RDS Endpoint CNAME<br/>(db.xxxx.rds.amazonaws.com)"]
        end

        subgraph SecurityIngress["VPC Database Security Layer"]
            RDSSG["RDS Security Group (RDS SG)"]
        end

        subgraph AZ_A["Availability Zone A (Primary)"]
            DB_PRI[("Primary DB Instance<br/>(Read/Write)")]
            EBS_A[("Primary DB Volume<br/>(AES-256 KMS Encrypted)")]
            DB_PRI --- EBS_A
        end

        subgraph AZ_B["Availability Zone B (Standby)"]
            DB_SEC[("Standby DB Instance<br/>(Passive / Failover Target)")]
            EBS_B[("Standby DB Volume<br/>(AES-256 KMS Encrypted)")]
            DB_SEC --- EBS_B
        end

        subgraph BackupStorage["Automated Storage and Backup Layer"]
            DBSnap[("DB Snapshots and Backups<br/>(AES-256 KMS Encrypted)")]
        end

        DB_PRI ==>|"Synchronous Block Replication"| DB_SEC
        EBS_A -.-|"Automated or Manual Backups"| DBSnap
    end

    %% Flow Connections
    WWW -->|"1. HTTPS Traffic - Port 443"| ALB
    ALBSG -.->|"Allow Inbound Port 443"| ALB
    ALB ==>|"2. Balance Traffic across App Nodes"| APP

    APP -->|"3. DNS Query"| Resolver
    Resolver -->|"4. Resolve CNAME"| CNAME
    CNAME -->|"5. Connection Requests"| RDSPROXY
    
    APPSG ==>|"Allow App to DB Traffic"| RDSSG
    RDSSG -.->|"Inbound Firewall Rules"| DB_PRI
    
    RDSPROXY ==>|"6. Pooled SSL/TLS DB Connections"| DB_PRI

    %% Style Classes
    classDef primary fill:#232F3E,stroke:#FF9900,stroke-width:2px,color:#fff;
    classDef standby fill:#555,stroke:#999,stroke-dasharray: 5 5,stroke-width:2px,color:#fff;
    classDef dns fill:#2A9D8F,stroke:#232F3E,stroke-width:1px,color:#fff;
    classDef sec fill:#E76F51,stroke:#232F3E,stroke-width:1px,color:#fff;
    classDef lb fill:#FF9900,stroke:#232F3E,stroke-width:2px,color:#111;

    class DB_PRI primary;
    class DB_SEC standby;
    class CNAME,Resolver dns;
    class RDSSG,APPSG,ALBSG sec;
    class ALB,RDSPROXY lb;
```

---

```mermaid
flowchart TD
    subgraph ClientLayer["Client and Application Layer"]
        WWW["Internet (WWW)"]
        APP["Application Cluster / Compute"]
        APPSG["APP Security Group (APP SG)"]
    end

    subgraph VPC["Amazon VPC (Region: us-east-1)"]
        direction TB

        subgraph VPCDNS["VPC Network Layer DNS"]
            Resolver["Route 53 Resolver / AmazonProvidedDNS<br/>(169.254.169.253 / VPC .2)"]
            CNAME["RDS Endpoint CNAME<br/>(db.xxxx.rds.amazonaws.com)"]
        end

        subgraph SecurityIngress["VPC Network Ingress and Security"]
            IP["Public IP / ENI<br/>(Optional External Access)"]
            RDSSG["RDS Security Group (RDS SG)"]
        end
        
        subgraph AZ_A["Availability Zone A (Primary)"]
            DB_PRI[("Primary DB Instance<br/>(Read/Write)")]
            EBS_A[("Primary DB Volume<br/>(AES-256 KMS Encrypted)")]
            DB_PRI --- EBS_A
        end

        subgraph AZ_B["Availability Zone B (Standby)"]
            DB_SEC[("Standby DB Instance<br/>(Passive / Failover Target)")]
            EBS_B[("Standby DB Volume<br/>(AES-256 KMS Encrypted)")]
            DB_SEC --- EBS_B
        end

        subgraph BackupStorage["Automated Storage and Backup Layer"]
            DBSnap[("DB Snapshots and Backups<br/>(AES-256 KMS Encrypted)")]
        end

        DB_PRI ==>|Synchronous Block Replication| DB_SEC
        EBS_A -.-|Automated or Manual Backups| DBSnap
    end

    %% Connections
    APP -->|1. DNS Lookup Query| Resolver
    Resolver -->|2. Resolves CNAME to Active IP| CNAME
    CNAME ==>|3. Connects via Primary IP| SSL["SSL/TLS Connection<br/>(In-Transit Encryption)"]
    SSL ==> DB_PRI

    WWW -->|Optional Public Traffic| IP
    IP --> DB_PRI

    APPSG ==>|Allow Port 3306 / DB Port| RDSSG
    RDSSG -.->|Inbound Firewall Rules| DB_PRI

    %% Style Classes
    classDef primary fill:#232F3E,stroke:#FF9900,stroke-width:2px,color:#fff;
    classDef standby fill:#555,stroke:#999,stroke-dasharray: 5 5,stroke-width:2px,color:#fff;
    classDef dns fill:#2A9D8F,stroke:#232F3E,stroke-width:1px,color:#fff;
    classDef sec fill:#E76F51,stroke:#232F3E,stroke-width:1px,color:#fff;

    class DB_PRI primary;
    class DB_SEC standby;
    class CNAME dns,Resolver;
    class RDSSG,APPSG sec;
```

---

```mermaid
flowchart TD
    subgraph ClientLayer["Client and Application Layer"]
        WWW["Internet (WWW)"]
        APP["Application Cluster / Compute"]
        APPSG["APP Security Group (APP SG)"]
    end

    subgraph ExternalDNS["AWS Managed DNS"]
        CNAME["RDS Endpoint CNAME<br/>(db.xxxx.rds.amazonaws.com)"]
    end

    subgraph VPC["Amazon VPC (Region: us-east-1)"]
        direction TB

        subgraph SecurityIngress["VPC Network Ingress and Security"]
            IP["Public IP / ENI<br/>(Optional External Access)"]
            RDSSG["RDS Security Group (RDS SG)"]
        end
        
        subgraph AZ_A["Availability Zone A (Primary)"]
            DB_PRI[("Primary DB Instance<br/>(Read/Write)")]
            EBS_A[("Primary DB Volume<br/>(AES-256 KMS Encrypted)")]
            DB_PRI --- EBS_A
        end

        subgraph AZ_B["Availability Zone B (Standby)"]
            DB_SEC[("Standby DB Instance<br/>(Passive / Failover Target)")]
            EBS_B[("Standby DB Volume<br/>(AES-256 KMS Encrypted)")]
            DB_SEC --- EBS_B
        end

        subgraph BackupStorage["Automated Storage and Backup Layer"]
            DBSnap[("DB Snapshots and Backups<br/>(AES-256 KMS Encrypted)")]
        end

        DB_PRI ==>|Synchronous Block Replication| DB_SEC
        EBS_A -.-|Automated or Manual Backups| DBSnap
    end

    %% Traffic and Security Connections
    WWW -->|Optional Public Traffic| IP
    APP -->|Private Application Traffic| CNAME
    CNAME ==>|Resolves to Primary IP| SSL["SSL/TLS Connection<br/>(In-Transit Encryption)"]
    SSL ==> DB_PRI

    APPSG ==>|Allow Port 3306 / DB Port| RDSSG
    RDSSG -.->|Inbound Firewall Rules| DB_PRI
    IP --> DB_PRI

    %% Style Classes
    classDef primary fill:#232F3E,stroke:#FF9900,stroke-width:2px,color:#fff;
    classDef standby fill:#555,stroke:#999,stroke-dasharray: 5 5,stroke-width:2px,color:#fff;
    classDef dns fill:#2A9D8F,stroke:#232F3E,stroke-width:1px,color:#fff;
    classDef sec fill:#E76F51,stroke:#232F3E,stroke-width:1px,color:#fff;

    class DB_PRI primary;
    class DB_SEC standby;
    class CNAME dns;
    class RDSSG,APPSG sec;
```

---

```mermaid
flowchart TD
    subgraph ClientLayer["Client and Application Layer"]
        WWW["Internet (WWW)"]
        APP["Application Cluster / Compute"]
        APPSG["APP Security Group (APP SG)"]
    end

    subgraph SecurityIngress["Network Ingress and Traffic Management"]
        IP["Public IP<br/>(Optional External Access)"]
        CNAME["RDS Endpoint CNAME<br/>(db.xxxx.rds.amazonaws.com)"]
        RDSSG["RDS Security Group (RDS SG)"]
    end

    subgraph VPC["Amazon VPC (Region: us-east-1)"]
        direction TB
        
        subgraph AZ_A["Availability Zone A (Primary)"]
            DB_PRI[("Primary DB Instance<br/>(Read/Write)")]
            EBS_A[("Primary DB Volume<br/>(AES-256 KMS Encrypted)")]
            DB_PRI --- EBS_A
        end

        subgraph AZ_B["Availability Zone B (Standby)"]
            DB_SEC[("Standby DB Instance<br/>(Passive / Failover Target)")]
            EBS_B[("Standby DB Volume<br/>(AES-256 KMS Encrypted)")]
            DB_SEC --- EBS_B
        end

        subgraph BackupStorage["Automated Storage and Backup Layer"]
            DBSnap[("DB Snapshots and Backups<br/>(AES-256 KMS Encrypted)")]
        end

        DB_PRI ==>|Synchronous Block Replication| DB_SEC
        EBS_A -.-|Automated or Manual Backups| DBSnap
    end

    %% Traffic & Security Connections
    WWW -->|Optional Public Traffic| IP
    IP --> CNAME

    APP -->|Private Application Traffic| CNAME
    APPSG ==>|Allow Port 3306 / DB Port| RDSSG
    RDSSG -.->|Inbound Rule Evaluation| DB_PRI

    CNAME ==>|Resolves to Active Primary IP| SSL["SSL/TLS Connection<br/>(In-Transit Encryption)"]
    SSL ==> DB_PRI

    %% Style Classes
    classDef primary fill:#232F3E,stroke:#FF9900,stroke-width:2px,color:#fff;
    classDef standby fill:#555,stroke:#999,stroke-dasharray: 5 5,stroke-width:2px,color:#fff;
    classDef dns fill:#2A9D8F,stroke:#232F3E,stroke-width:1px,color:#fff;
    classDef sec fill:#E76F51,stroke:#232F3E,stroke-width:1px,color:#fff;

    class DB_PRI primary;
    class DB_SEC standby;
    class CNAME dns;
    class RDSSG,APPSG sec;
```

### Key Syntax Adjustments Made:
* Removed spaces between subgraph keys and label brackets (`subgraph ID["Title"]`).
* Replaced literal `&` characters with `and` inside subgraph titles to prevent parser token confusion.
* Standardized edge label delimiters (`|label|`) across all connection paths.
---
---

Combine the followig two mermaid diagram to demonstrate data flow and big pictures of AWS RDS
make sure they are factually correct based on most updated AWS documentaions

```mermaid
flowchart TD
    APP[Application Cluster] -->|Read/Write via Endpoint DNS| CNAME["RDS Endpoint CNAME\n(db.xxxx.rds.amazonaws.com)"]

    subgraph VPC ["Amazon VPC (Region: us-east-1)"]
        direction LR
        
        subgraph AZ_A ["Availability Zone A"]
            CNAME ==>|Resolves to Primary IP| DB_PRI[("Primary DB Instance\n(Read/Write)")]
            DB_PRI --- EBS_A[("EBS Storage")]
        end

        subgraph AZ_B ["Availability Zone B"]
            DB_SEC[("Standby DB Instance\n(Passive / No Direct Access)")]
            DB_SEC --- EBS_B[("EBS Storage")]
        end

        DB_PRI == Synchronous Storage Replication ==> DB_SEC
    end

    classDef active fill:#232F3E,stroke:#FF9900,stroke-width:2px,color:#fff;
    classDef standby fill:#555,stroke:#999,stroke-dasharray: 5 5,stroke-width:2px,color:#fff;
    classDef dns fill:#2A9D8F,stroke:#232F3E,stroke-width:1px,color:#fff;
    
    class DB_PRI active;
    class DB_SEC standby;
    class CNAME dns;
```

```mermaid
flowchart TD
    subgraph VPC["Virtual Private Cloud (VPC)"]
        subgraph Ingress["Network Ingress & Access Control"]
            IP["Public IP<br/>(Optional Internet Access)"]
            RDSSG["RDS Security Group (RDS SG)"]
        end

        subgraph Database["RDS Database Layer"]
            RDS[("Amazon RDS Instance")]
            SSL["SSL/TLS Encryption<br/>(In-Transit Protection)"]
        end

        subgraph Storage["Storage Layer - Encryption at Rest (AES 256)"]
            DBVol[("DB Volume")]
            DBSnap[("DB Snapshot")]
        end

        IP --> RDS
        RDSSG -.->|Allow Port 3306| RDS
        RDS --- DBVol
        DBVol --- DBSnap
    end

    WWW["Internet (WWW)"] -->|Optional Access| IP

    subgraph AppTier["Application Tier"]
        APPSG["APP Security Group (APP SG)"]
        APP["Application / Compute"]
    end

    APP -->|Encrypted Traffic SSL/TLS| SSL
    SSL --> RDS
    APPSG ==>|Allow Port 3306| RDSSG
```
