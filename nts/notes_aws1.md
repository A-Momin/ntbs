-   <details><summary style="font-size:25px;color:Orange">S3</summary>

    Amazon S3 (Simple Storage Service) is a highly scalable, durable, and secure object storage service provided by Amazon Web Services (AWS). It is designed to store and retrieve any amount of data from anywhere on the web, making it a fundamental building block for many cloud-based applications. S3 is widely used for data storage, backup and restore, content distribution, big data analytics, archiving, and much more.

    -   `Bucket`: A bucket is a container for storing objects in Amazon S3. All objects are stored in buckets, and each bucket has a globally unique name that must adhere to specific naming rules. Buckets act as the top-level namespace in S3.
    -   `Object`: An object is the basic unit of data in Amazon S3. It can be any file, data, or media, including text files, images, videos, and more. Objects consist of the actual data, a key (or identifier), and metadata (optional attributes). All keys are objects.
    -   `Prefix`: A prefix is the beginning part of the object key used to group objects. It acts like a virtual folder path, but S3 is flat (not hierarchical).
    -   `Key`: The key is the unique identifier for an object within a bucket. It is similar to a file path and is used to retrieve objects from S3. For example, if an object is stored at the path "my-folder/image.jpg", the key would be "my-folder/image.jpg"
    -   `Region`: A region is a geographical area where S3 stores data. Each bucket is associated with a specific AWS region, and the data within that bucket is physically stored in data centers located in that region.
    -   `Access Control List (ACL)`: An ACL is a set of permissions attached to each object and bucket, defining who can access the objects and what actions they can perform (e.g., read, write, delete). While still supported, IAM policies are now generally recommended for controlling access to S3 resources.
    -   `Object Versioning`: S3 supports versioning, which allows you to keep multiple versions of an object in the same bucket. It helps protect against accidental deletions or overwrites, and you can easily restore previous versions of objects.
    -   `Server-Side Encryption`: S3 provides server-side encryption to protect data at rest. You can choose to have S3 automatically encrypt your objects using AWS Key Management Service (KMS) keys or Amazon S3 managed keys.
    -   `Lifecycle Policies`: Lifecycle policies allow you to automatically transition objects between different storage classes or delete objects after a specific period. This helps optimize storage costs and manage data lifecycle.
    -   `Cross-Region Replication (CRR)`: CRR is a feature that allows you to replicate objects from one S3 bucket to another bucket in a different AWS region. It provides data redundancy and disaster recovery capabilities.
    -   `Event Notifications`: S3 allows you to set up event notifications to trigger actions (e.g., invoking an AWS Lambda function) when specific events occur, such as object creation or deletion.
    -   `Access Logs`: You can enable access logging for S3 buckets to track all requests made to the bucket. Access logs are stored in a separate bucket and can help with auditing and monitoring.

    Amazon Simple Storage Service (**S3**) is a highly scalable, durable, and secure **Object Storage** service. It is designed to store and retrieve any amount of data from anywhere on the web, offering **11 nines (99.999999999%) of durability**.

    S3 is foundational to the AWS ecosystem and is used for everything from serving static website assets and hosting data lakes to providing critical backup and archiving.

    ##### Core Terms & Components

    -   **Object Storage**: Unlike **Block Storage** (like Amazon EBS, which is used for operating systems) or **File Storage** (like Amazon EFS, which uses folders and protocols), S3 is an object store.

    -   **Object:** The fundamental entity stored in S3. An object is a file (data) combined with its **metadata** (information about the object).
    -   **Bucket:** The logical container for objects. Think of a bucket as the top-level folder where you organize your data.
        -   **Global Uniqueness:** Every bucket name must be **globally unique** across all of AWS, regardless of the AWS Region or account.
        -   **Region:** A bucket is created in a specific AWS Region and cannot be moved. Objects stored in that bucket will never leave that region unless explicitly replicated.
    -   **Key:** The unique identifier for an object within a bucket. The Key is essentially the full path and name of the file (e.g., `images/puppy.jpg`). S3 uses a **flat namespace**, and the appearance of folders is created using **prefixes** (the parts of the Key separated by a `/`).

    ##### Key Features: Security and Compliance

    S3 provides robust security tools, ensuring data is protected both in transit and at rest.

    -   **Access Control:** S3 uses multiple policy types for granular permissions:

        -   **IAM Policies:** Define _who_ (users/roles) can access S3 resources.
        -   **Bucket Policies:** Define _what_ (actions) can be done on a specific bucket and its objects, often used for cross-account access or public access control.
        -   **Access Control Lists (ACLs):** A legacy permission model that is simple and object-specific, but generally superseded by IAM/Bucket Policies.
        -   **S3 Block Public Access:** A vital account-level security feature that **overrides** all other permissions to block public read/write access to S3 buckets. It is **enabled by default** for all new buckets.

    -   **Versioning:** When enabled on a bucket, S3 retains multiple versions of an object (including deleted ones). This allows you to easily **recover from accidental deletions or overwrites**.

    ##### Key Features: Performance and Data Management

    | Feature                            | Purpose                                                                                                                                                                                                         |
    | :--------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
    | **S3 Lifecycle Management**        | Automatically **transitions** objects between different **Storage Classes** (to save cost) or **expires** (permanently deletes) objects after a specified period of time.                                       |
    | **S3 Transfer Acceleration**       | Uses Amazon CloudFront's globally distributed **Edge Locations** to speed up data transfers (uploads and downloads) to and from an S3 bucket over long distances.                                               |
    | **S3 Object Lock**                 | Provides **WORM (Write Once, Read Many)** protection for objects. This helps meet regulatory requirements by preventing an object from being deleted or overwritten for a fixed amount of time or indefinitely. |
    | **Cross-Region Replication (CRR)** | Automatically and asynchronously copies objects across buckets in **different AWS Regions** for disaster recovery and compliance.                                                                               |
    | **Same-Region Replication (SRR)**  | Automatically copies objects across buckets in the **same AWS Region**, often used to aggregate logs or meet compliance requirements.                                                                           |
    | **Event Notifications**            | Allows S3 to publish notifications (e.g., to an AWS Lambda function, SQS queue, or SNS topic) when an object is created, deleted, or restored. This enables **event-driven architectures**.                     |

    ##### Storage Classes (The Cost/Performance Trade-Off)

    S3 offers various storage classes, which differ primarily in their **Cost**, **Durability/Availability**, and **Access Speed** (Latency). You choose the class based on how frequently you need to access the data.

    | Storage Class                          | Description                                                                                                                              | Durability & Availability                                                   | Retrieval Time & Cost                                                                              |
    | :------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------- |
    | **S3 Standard**                        | General-purpose, frequently accessed data ("Hot Data").                                                                                  | $\text{99.999999999\%}$ Durability (3+ AZs), $\text{99.99\%}$ Availability. | **Millisecond** access. Highest storage cost.                                                      |
    | **S3 Intelligent-Tiering**             | **Automatically moves data** between frequent and infrequent tiers based on access patterns, optimizing cost without performance impact. | $\text{99.999999999\%}$ Durability (3+ AZs).                                | **Millisecond** access. Ideal for unknown access patterns.                                         |
    | **S3 Standard-IA** (Infrequent Access) | Long-lived, infrequently accessed data ("Cool Data") that requires **rapid access** when needed.                                         | $\text{99.999999999\%}$ Durability (3+ AZs).                                | **Millisecond** access. Lower storage cost, higher retrieval cost.                                 |
    | **S3 One Zone-IA**                     | Same as Standard-IA, but data is stored in **a single Availability Zone (AZ)**.                                                          | $\text{99.5\%}$ Availability (lower).                                       | **Millisecond** access. Lowest cost _per GB_ outside of Glacier, but data is lost if the AZ fails. |
    | **S3 Glacier Flexible Retrieval**      | Archival data that rarely needs to be accessed.                                                                                          | $\text{99.999999999\%}$ Durability (3+ AZs).                                | **Minutes to Hours** retrieval time (configurable speed/cost).                                     |
    | **S3 Glacier Deep Archive**            | Long-term data retention (7-10 years) for regulatory compliance; the **lowest-cost** storage class.                                      | $\text{99.999999999\%}$ Durability (3+ AZs).                                | **12 hours** retrieval time.                                                                       |
    | **S3 Express One Zone**                | High-performance, single-AZ storage for extremely **latency-sensitive applications** (e.g., databases, machine learning training).       | Single AZ.                                                                  | **Single-digit millisecond** access.                                                               |

    -   <details><summary style="font-size:20px;color:Magenta">S3 API Action keywords</summary>

        The AWS S3 API Action keywords, often referred to as **IAM Actions**, are the specific permissions you use in IAM policies to grant or deny access to S3 operations. They follow the format **`s3:ActionName`**.

        The list below is categorized by the resource they primarily act upon (**Buckets** or **Objects**) and their general access level (**List, Read, Write, Permissions Management**).

        -   **Bucket-Level Actions (Permissions on the Container)**: These actions generally target the S3 **bucket ARN** (e.g., `arn:aws:s3:::my-bucket`).

            | Access Level               | Key Action Keywords             | Description                                            |
            | :------------------------- | :------------------------------ | :----------------------------------------------------- |
            | **List**                   | `s3:ListAllMyBuckets`           | Allows listing all buckets in the account. (Global)    |
            |                            | `s3:ListBucket`                 | Allows listing the objects in a specific bucket.       |
            |                            | `s3:GetBucketLocation`          | Allows retrieving the AWS Region of a bucket.          |
            | **Read**                   | `s3:GetBucketAcl`               | Allows reading the Bucket's Access Control List (ACL). |
            |                            | `s3:GetBucketPolicy`            | Allows reading the Bucket Policy.                      |
            |                            | `s3:GetBucketTagging`           | Allows reading the tags assigned to the bucket.        |
            |                            | `s3:GetEncryptionConfiguration` | Allows reading the default encryption settings.        |
            |                            | `s3:GetLifecycleConfiguration`  | Allows reading the lifecycle rules.                    |
            | **Write**                  | `s3:CreateBucket`               | Allows creating a new bucket.                          |
            |                            | `s3:DeleteBucket`               | Allows deleting an empty bucket.                       |
            | **Permissions Management** | `s3:PutBucketPolicy`            | Allows setting or replacing the Bucket Policy.         |
            |                            | `s3:DeleteBucketPolicy`         | Allows deleting the Bucket Policy.                     |
            |                            | `s3:PutBucketPublicAccessBlock` | Allows setting the Block Public Access configuration.  |
            |                            | `s3:PutLifecycleConfiguration`  | Allows setting or replacing lifecycle rules.           |

        -   **Object-Level Actions (Permissions on Files)**: These actions generally target the S3 **object ARN** (e.g., `arn:aws:s3:::my-bucket/my-file.txt`).

            | Access Level         | Key Action Keywords           | Description                                                                   |
            | :------------------- | :---------------------------- | :---------------------------------------------------------------------------- |
            | **Read**             | `s3:GetObject`                | The most common read action. Allows downloading the object data.              |
            |                      | `s3:GetObjectAcl`             | Allows reading the object's ACL.                                              |
            |                      | `s3:GetObjectTagging`         | Allows reading the object's tags.                                             |
            |                      | `s3:GetObjectRetention`       | Allows retrieving the Object Lock retention settings.                         |
            |                      | `s3:GetObjectVersion`         | Allows retrieving a specific version of an object (if versioning is enabled). |
            | **Write**            | `s3:PutObject`                | The most common write action. Allows uploading a new object.                  |
            |                      | `s3:DeleteObject`             | Allows deleting an object (removes the latest version).                       |
            |                      | `s3:DeleteObjectVersion`      | Allows deleting a specific version of an object.                              |
            |                      | `s3:PutObjectTagging`         | Allows setting or replacing the object's tags.                                |
            |                      | `s3:PutObjectRetention`       | Allows setting or replacing the Object Lock retention settings.               |
            | **Multipart Upload** | `s3:AbortMultipartUpload`     | Allows stopping an ongoing multipart upload.                                  |
            |                      | `s3:ListMultipartUploadParts` | Allows listing the parts of an ongoing multipart upload.                      |
            | **Copy**             | `s3:GetObject` (Source)       | Required on the source object for any copy operation.                         |
            |                      | `s3:PutObject` (Destination)  | Required on the destination object for any copy operation.                    |

        </details>

    -   <details><summary style="font-size:20px;color:Magenta">S3 Encryption</summary>

        AWS S3 encryption is a multi-layered security framework designed to protect data both **at rest** (stored on disks) and **in transit** (moving between your client and S3).

        Since January 5, 2023, Amazon S3 automatically applies a base level of encryption (**SSE-S3**) to all new objects at no additional cost. However, for higher compliance and control, several other methods are available.

        1. **Server-Side Encryption (SSE)**: In SSE, AWS handles the encryption process as the object is written to the data center and decrypts it when you access it.

            | Type         | Key Management        | Use Case                                                                   | Header Requirement                                        |
            | ------------ | --------------------- | -------------------------------------------------------------------------- | --------------------------------------------------------- |
            | **SSE-S3**   | Fully managed by S3   | Baseline security; simple compliance.                                      | `x-amz-server-side-encryption: AES256`                    |
            | **SSE-KMS**  | Managed via AWS KMS   | Detailed audit logs (CloudTrail); separate permissions for key and object. | `x-amz-server-side-encryption: aws:kms`                   |
            | **DSSE-KMS** | Dual-layer (KMS + S3) | High-security compliance (e.g., CNSA, FIPS). Encrypts data twice.          | `x-amz-server-side-encryption: aws:kms:dsse`              |
            | **SSE-C**    | Managed by Customer   | You provide the key; S3 never stores it. AWS only does the crypto.         | `x-amz-server-side-encryption-customer-algorithm: AES256` |

            - **SSE-KMS & DSSE-KMS:** These allow you to use **Customer Managed Keys (CMKs)**. This is powerful because you can rotate the keys, disable them to "digitally shred" data, and see exactly who used the key in CloudTrail.
            - **SSE-C:** You must provide the exact 256-bit, base64-encoded encryption key in every single request. If you lose the key, the data is **permanently unrecoverable** because AWS does not keep a backup.

        2. **Client-Side Encryption (CSE)**: With CSE, you encrypt the data **before** it ever leaves your local environment. AWS only sees an opaque blob of encrypted bits.

            - **Envelope Encryption:** The client generates a unique **Data Key** for each object, encrypts the object with it, and then encrypts that Data Key with a **Master Key** (which can be stored in AWS KMS or locally).
            - **Tools:** Usually implemented using the **Amazon S3 Encryption Client**.
            - **Best For:** Zero-trust architectures where even AWS administrators must not have the ability to decrypt your data.

        3. **Encryption in Transit**: Encryption in transit ensures that your data cannot be intercepted while moving over the internet.

            - **HTTPS (TLS):** All S3 API endpoints support TLS. As of 2024, AWS requires a minimum of **TLS 1.2**.
            - **Enforcement:** You can enforce transit encryption by adding a "Deny" statement to your Bucket Policy for any request where `"aws:SecureTransport": "false"`.

        4. **Cost Optimization**:
            - Using SSE-KMS at scale can become expensive due to the high volume of API calls to AWS KMS (which charges per request).
            - **S3 Bucket Keys** reduce these costs by up to **99%**. Instead of S3 calling KMS for every single object, it requests a "bucket-level" key from KMS, which it then uses to derive unique data keys for objects locally within S3 for a limited time.

        -   **Comparison Summary**

            | Feature                  | SSE-S3 | SSE-KMS       | SSE-C | Client-Side |
            | ------------------------ | ------ | ------------- | ----- | ----------- |
            | **Who manages keys?**    | AWS    | AWS/You (KMS) | You   | You         |
            | **Who does encryption?** | AWS    | AWS           | AWS   | Your Client |
            | **Audit logs for keys?** | No     | Yes           | No    | Your choice |
            | **Cost?**                | Free   | KMS Costs     | Free  | Free        |

        </details>

    -   <details><summary style="font-size:20px;color:Magenta">Replication</summary>

        Amazon S3 replication provides automatic, asynchronous copying of objects across buckets. As of 2026, it remains a cornerstone for disaster recovery, compliance, and latency optimization.

        1.  **Core Facts & Types**: AWS offers three primary ways to replicate data, each serving different architectural needs:

            -   **Cross-Region Replication (CRR):** Replicates data between buckets in different AWS Regions. Ideal for compliance and minimizing latency for global users.
            -   **Same-Region Replication (SRR):** Replicates data between buckets in the same Region. Used for log aggregation or syncing production and test environments while maintaining data sovereignty.
            -   **S3 Batch Replication:** A managed way to replicate **existing objects**, objects that previously failed to replicate, or objects that were created before a replication rule was in place.
            -   **Prerequisites**:

                -   **Versioning:** Must be enabled on **both** source and destination buckets.
                -   **IAM Role:** S3 requires an IAM role with permissions to read from the source and write to the destination.
                -   **Permissions:** If the buckets are in different accounts, the destination bucket owner must grant the source account permission to replicate objects via a bucket policy.

        2.  **Technical Limitations (What is NOT Replicated)**: Understanding what S3 **cannot** or **will not** replicate is critical for data integrity:

            -   **Transitive Replication:** S3 does **not** support "chained" replication. If Bucket A replicates to Bucket B, and Bucket B has a rule to replicate to Bucket C, objects arriving in B from A will **not** be sent to C.
            -   **Existing Objects:** Standard replication rules only apply to objects created _after_ the rule is enabled. (Use **S3 Batch Replication** for existing data).
            -   **SSE-C Encrypted Objects:** Objects encrypted using Customer-Provided Keys (SSE-C) are **not** supported for replication.
            -   **Archived Objects:** You cannot replicate objects stored in S3 Glacier or S3 Glacier Deep Archive until they have been restored to a readable tier.
            -   **Delete Operations:** \* **Delete Markers:** Not replicated by default (must be explicitly enabled in the rule).
            -   **Permanent Deletes:** If you delete a specific version ID in the source, S3 does **not** replicate that deletion to the destination to prevent accidental data loss.

            -   **Directory Buckets (S3 Express One Zone):** These do not support standard S3 replication rules. Instead, they use a specialized **"Import"** feature or Batch Operations to move data in or out.

        3.  **Advanced Features & Notes**

            -   **Encryption Handling**:

                | Encryption Type | Replicable? | Note                                                                                                        |
                | --------------- | ----------- | ----------------------------------------------------------------------------------------------------------- |
                | **SSE-S3**      | Yes         | Supported by default.                                                                                       |
                | **SSE-KMS**     | Yes         | Must be explicitly enabled in the replication configuration; requires KMS key permissions for the IAM role. |
                | **DSSE-KMS**    | Yes         | Dual-layer server-side encryption is supported.                                                             |
                | **SSE-C**       | **No**      | Requires manual copying.                                                                                    |

            -   **Replication Time Control (RTC)**:For mission-critical workloads, S3 RTC provides a Service Level Agreement (SLA).

                -   **The Guarantee:** 99.99% of objects will be replicated within **15 minutes**.
                -   **Monitoring:** Provides real-time metrics in CloudWatch (e.g., `BytesPendingReplication`, `ReplicationLatency`).
                -   **Limit:** Has a default 1 Gbps data transfer limit, which can be increased via a service quota request.

            -   **Metadata & Two-Way Sync**:

                -   **Replica Modification Sync:** You can enable this to sync metadata changes (like tags or ACL updates) bi-directionally between buckets.
                -   **Ownership Overwrite:** In cross-account replication, you can configure S3 to change object ownership to the destination bucket owner, ensuring they have full control over the replicas.

        4.  **Cost Considerations**: Replication is not free; you are charged for:

            1. **Storage:** You pay for storage in both the source and destination buckets.
            2. **Replication PUT Requests:** Standard S3 request charges apply at the destination.
            3. **Data Transfer (Inter-Region):** For CRR, you pay standard AWS data transfer out rates from the source region.
            4. **RTC Fee:** If S3 RTC is enabled, there is an additional "Replication Time Control" fee and a per-GB data transfer charge.

        </details>

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Various Types of Storage Services</summary>

    AWS offers a comprehensive suite of storage services categorized primarily into **Object, Block, and File Storage**, along with specialized services for **Archiving, Data Transfer,** and **Hybrid** environments.

    -   **Object Storage**: Object storage is designed for massive scale, durability, and cost-effectiveness. It is ideal for unstructured data, backups, and media content.

        -   **Amazon Simple Storage Service (S3):** The flagship object storage service. It stores data in "buckets" and offers various **Storage Classes** to manage cost based on access frequency (e.g., S3 Standard, S3 Intelligent-Tiering, S3 Standard-IA).
        -   **Amazon S3 Glacier:** A family of extremely low-cost storage classes within S3 designed for data **archiving** and long-term backup, with configurable retrieval times (e.g., S3 Glacier Instant Retrieval, S3 Glacier Flexible Retrieval, S3 Glacier Deep Archive).

    -   **Block Storage**: Block storage provides volumes that function like a local hard drive, offering high-performance, low-latency access for a single compute instance. It is the preferred choice for transactional workloads like databases and virtual machine boot volumes.

        -   **Amazon Elastic Block Store (EBS):** Provides persistent block storage volumes that are attached to **Amazon EC2** instances. It offers various volume types (SSD-backed for performance, HDD-backed for throughput/cost).
        -   **Amazon EC2 Instance Store:** Provides **temporary** block-level storage physically attached to the host computer of an EC2 instance. Data is lost when the instance is stopped or terminated (often called "ephemeral" storage).

    -   **File Storage**: File storage allows multiple compute instances to share the same storage volume simultaneously using standard file-level protocols (like NFS or SMB).

        -   **Amazon Elastic File System (EFS):** A fully managed, scalable file storage service for **Linux** workloads, providing shared access via the NFS protocol. It automatically scales capacity and performance.
        -   **Amazon FSx Family:** A group of fully managed services that let you choose from four widely-used commercial and open-source file systems:
            -   **Amazon FSx for Windows File Server** (SMB protocol)
            -   **Amazon FSx for Lustre** (for high-performance computing/analytics)
            -   **Amazon FSx for NetApp ONTAP**
            -   **Amazon FSx for OpenZFS**
        -   **Amazon File Cache:** A high-speed cache that speeds up processing of file data stored in disparate locations, including S3 and on-premises file systems.

    -   **Hybrid, Data Transfer & Supporting Services**: These services bridge the gap between your on-premises data centers and the AWS cloud, or offer centralized data protection.

        -   **AWS Storage Gateway:** A hybrid cloud storage service that provides on-premises applications with low-latency access to virtually unlimited cloud storage in AWS. It includes File Gateway, Volume Gateway, and Tape Gateway.
        -   **AWS Snow Family:** Physical devices used to transfer **large amounts of data** into and out of AWS (petabyte-scale) when internet transfer is impractical or too slow. Includes **AWS Snowball Edge** and **AWS Snowmobile** (exabyte-scale).
        -   **AWS Backup:** A centralized, managed service to automate and govern backup across AWS services (EBS volumes, RDS databases, EFS file systems, etc.).

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">VPC (Virtual Private Cloud)</summary>

    -   [Linux Academy: AWS Essentials: Project Omega!](https://www.youtube.com/watch?v=CGFrYNDpzUM&list=PLv2a_5pNAko0Mijc6mnv04xeOut443Wnk)
    -   [DogitalCloud: AWS VPC Beginner to Pro - Virtual Private Cloud Tutorial](https://www.youtube.com/watch?v=g2JOHLHh4rI&t=2769s)
    -   [VPC Assignments](https://www.youtube.com/playlist?list=PLIUhw5xEbE-UzGtDn5yBfXBTkJR6QgWIi)
    -   [3.Terraform : Provision VPC using Terraform | Terraform Manifest file to Create VPC and EC2 Instance](https://www.youtube.com/watch?v=wx7L6snkrTU)

    > Amazon VPC (Virtual Private Cloud) is a service that enables you to launch Amazon Web Services (AWS) resources into a virtual network that you define. Here are some common terms and concepts related to AWS VPC:

    -   **VPC**: AWS VPC (Amazon Virtual Private Cloud) is a service provided by Amazon Web Services (AWS) that allows you to create a virtual network in the AWS cloud. It enables you to define a logically isolated section of the AWS cloud where you can launch AWS resources such as EC2 instances, RDS databases, and more. Here are some key aspects and features of AWS VPC:

        -   `Isolation`: A VPC provides network isolation, allowing you to create a virtual network environment that is logically isolated from other networks in the AWS cloud. This isolation helps enhance security and control over your resources.
        -   `Customization`: You have full control over the IP address range, subnets, route tables, and network gateways within your VPC. This allows you to design and configure the network according to your specific requirements.
        -   `Subnets`: Within a VPC, you can create multiple subnets, each associated with a specific availability zone (AZ) within an AWS region. Subnets help organize and segment your resources and allow you to control network traffic between them.
        -   `Internet Connectivity`: By default, instances launched within a VPC do not have direct access to the internet. To enable internet connectivity, you can configure an internet gateway (IGW) and route internet-bound traffic through it.
        -   `Security`: VPC provides several features to enhance network security, including security groups and network access control lists (ACLs). Security groups act as virtual firewalls, controlling inbound and outbound traffic at the instance level, while network ACLs provide subnet-level security by controlling traffic flow.
        -   `Peering and VPN Connections`: VPC allows you to establish peering connections between VPCs within the same AWS region, enabling inter-VPC communication. Additionally, you can establish VPN (Virtual Private Network) connections between your on-premises network and your VPC, extending your network securely into the AWS cloud.
        -   `VPC Endpoints`: VPC endpoints enable private connectivity to AWS services without requiring internet gateway or NAT gateway. This enhances security and can reduce data transfer costs.
        -   `VPC Flow Logs`: VPC Flow Logs capture information about the IP traffic flowing in and out of network interfaces in your VPC. This data can be used for security analysis, troubleshooting, and compliance auditing.

    -   **Subnet**: In AWS, a subnet (short for sub-network) is a segmented portion of an Amazon VPC. Subnets allow you to divide a VPC's IP address range into smaller segments, which can be associated with specific availability zones (AZs) within an AWS region. Here are some key points to understand about AWS subnets:

        -   `Public and Private Subnets`: Subnets can be categorized as public or private based on their routing configuration:
            -   `Public Subnets`: Public subnets have routes to an internet gateway, allowing instances within the subnet to communicate directly with the internet. They are typically used for resources that require public accessibility, such as web servers.
            -   `Private Subnets`: Private subnets do not have direct internet access. Instances in private subnets can communicate with the internet or other AWS services through a NAT gateway, VPC endpoint, or VPN connection. Private subnets are commonly used for backend services or databases that should not be directly exposed to the internet.
        -   `Segmentation`: Subnets enable you to logically segment your VPC's IP address space. Each subnet is associated with a specific CIDR (Classless Inter-Domain Routing) block, which defines the range of IP addresses available for use within that subnet.
        -   `Routing`: Each subnet has its own route table, which defines how traffic is routed within the subnet and to other subnets or external networks. You can customize route tables to control traffic flow, including specifying routes to internet gateways, virtual private gateways, NAT gateways, and VPC peering connections.
        -   `Availability Zones`: Subnets are tied to specific availability zones within an AWS region. Each subnet exists in exactly one availability zone, and you can create subnets in multiple AZs within the same region to achieve high availability and fault tolerance for your applications.
        -   `Traffic Isolation`: Instances launched in different subnets within the same VPC are isolated from each other at the network level. By controlling the routing and network access policies within subnets, you can control the flow of traffic between resources.
        -   `Associated Resources`: Subnets can be associated with various AWS resources, including EC2 instances, RDS databases, Lambda functions, and more. When launching resources, you can specify the subnet in which the resource should reside.

    -   **CIDR (Classless Inter-Domain Routing)**: `CIDR` is a notation for representing a range/block of IP addresses with their associated `Network Prefix`. It allows for a more flexible allocation of IP addresses than the older class-based system (Class A, B, and C networks). `CIDR` notation includes both the IP address and the length of the network prefix, separated by a slash (`/`). For example, `10.0.0.0/16` indicates a network with a 16-bit prefix and represents a `CIDR` block with a range of IP addresses from `10.0.0.0` to `10.0.255.255`. The size of a `CIDR` block is $2^{32 − Prefix Length} = 2^{32 − 16} = 2^16$

        -   In AWS, when you create a VPC, you define its IP address range using `CIDR` notation. `CIDR` notation is a compact representation of an IP address range, expressed as a base address followed by a forward slash and a numerical value representing the prefix length. For example, `10.0.0.0/16` indicates a network with a 16-bit network-prefix and represents a `CIDR` block with a range of IP addresses from 10.0.0.0 to 10.0.255.255.

        -   `Network Prefix`: A network prefix refers to the part of an IP address that identifies the network or subnet itself. It is specified by a `CIDR` (Classless Inter-Domain Routing) notation, which consists of an IP address followed by a slash (`/`) and a number (the prefix length). The prefix length defines how many bits of the IP address are dedicated to identifying the network. For example, in the `CIDR` block `192.168.1.0/24`, the `/24` is the network prefix length, meaning the first 24 bits (or the first three octets) of the IP address represent the network itself, and the remaining bits are available for host addresses within that network. The first 24 bits (or the first three octets) are reffered as the `Network Prefix`.

    -   <details><summary style="font-size:20px;color:Magenta">Route Table</summary>

        A Route Table in AWS VPC is a set of rules that controls how network traffic is directed within the VPC. It determines where traffic from your subnets is routed, such as to the internet, other VPCs, or within the same VPC. **Each subnet in a VPC must be associated with a route table**, and the table specifies the paths traffic can take, like sending internet-bound traffic through an internet gateway or directing traffic to other private resources.

        -   `Main Route Table`: The default route table that is automatically created when a VPC is set up. All subnets not explicitly associated with a custom route table use this table.

            -   Acts as the fallback route table for all subnets in the VPC unless overridden by custom route tables.

        -   `Route`: A Route Table contains a set of rules, known as routes, that determine the path of network traffic. Each route specifies a destination `CIDR` (Classless Inter-Domain Routing) block and a target, indicating where traffic destined for that `CIDR` block should be forwarded.

            -   `Default Route`: Every Route Table includes a default route, which typically directs traffic with an unspecified destination (`0.0.0.0/0`) to a target, such as an internet gateway (`IGW`) or a virtual private gateway (VGW). This default route allows instances within the VPC to communicate with resources outside the VPC, such as the internet or other VPCs.
            -   `Custom Routes`: In addition to the default route, you can add custom routes to a Route Table to define specific paths for traffic destined for particular CIDR blocks. For example, you can create custom routes to route traffic to a VPN connection, Direct Connect gateway, or VPC peering connection.
            -   `Example Route Table Entries`:

                | Destination      | Target           | Purpose                                                    |
                | ---------------- | ---------------- | ---------------------------------------------------------- |
                | `0.0.0.0/0`      | Internet Gateway | Route internet-bound traffic from public subnets.          |
                | `10.0.0.0/16`    | local            | Default route for intra-VPC communication.                 |
                | `10.0.1.0/24`    | VPC Endpoint     | Direct traffic to AWS services like S3 using VPC Endpoint. |
                | `0.0.0.0/0`      | NAT Gateway      | Route internet-bound traffic from private subnets.         |
                | `192.168.1.0/24` | VPC Peering      | Route traffic to a peered VPC.                             |

        -   `Associations`: Each subnet in a VPC is associated with one Route Table for inbound traffic and one Route Table for outbound traffic. This association determines how traffic is routed to and from instances within the subnet. By associating subnets with different Route Tables, you can control the flow of traffic and implement network segmentation.
        -   `Propagation`: Route Tables can be associated with **Virtual Private Gateways** (`VGW`) for **VPN connections** or **Transit Gateways** for inter-VPC communication. In such cases, routes learned from these gateways are automatically propagated to the associated Route Table.
        -   `Prioritization`: Routes in a Route Table are evaluated in priority order, with more specific routes taking precedence over less specific routes. If multiple routes match a destination CIDR block, the most specific route (i.e., the route with the longest prefix length) is chosen.
        -   `Multi-Subnet Routing`: In a multi-subnet VPC architecture, different subnets can be associated with different Route Tables, allowing you to implement distinct routing policies based on subnet requirements. This enables you to enforce security policies, direct traffic to specific gateways, or implement advanced networking configurations.

        </details>

    -   **Internet Gateway**: An AWS Internet Gateway (IGW) is a horizontally scaled, redundant, and highly available VPC component that allows communication between instances within your VPC and the internet. It serves as a gateway to facilitate inbound and outbound internet traffic for resources within your VPC. Here are the key points to understand about AWS Internet Gateways:

        -   `Public Subnets`: Internet Gateways are typically associated with public subnets within your VPC. Public subnets have routes to the Internet Gateway in their route tables, enabling instances within those subnets to communicate directly with the internet.
        -   `Routing`: To enable internet access for instances within your VPC, you need to add a route to the internet gateway in the route table associated with the subnet. This route directs traffic destined for the internet to the Internet Gateway.
        -   `High Availability`: Internet Gateways are designed to be highly available and redundant. They are automatically replicated across multiple Availability Zones within the same AWS region to ensure resilience and fault tolerance.
        -   `Stateful`: Internet Gateways are stateful devices, meaning they keep track of the state of connections and allow return traffic for outbound connections initiated by instances within the VPC. This enables bidirectional communication between instances and external hosts on the internet.
        -   `Security`: Internet Gateways do not perform any security functions on their own. Security is primarily managed using AWS security groups and network access control lists (NACLs) associated with the instances and subnets within the VPC.
        -   `Billing`: While there is no charge for creating an Internet Gateway, you are billed for data transfer out of your VPC to the internet based on the volume of data transferred.

    -   **NAT Gateway**: An AWS NAT (Network Address Translation) Gateway Gateway is a managed AWS service that enables instances within private subnets of a VPC to initiate outbound traffic to the internet while preventing inbound traffic from reaching those instances. Here are the key aspects of AWS NAT Gateway:

        -   `Outbound Internet Access`: NAT Gateway allows instances in private subnets to access the internet for software updates, patching, or downloading dependencies. It achieves this by performing network address translation (NAT), replacing the private IP addresses of the instances with its own public IP address when communicating with external hosts on the internet.
        -   `Private Subnets`: NAT Gateway is typically deployed in a public subnet within the VPC, allowing instances in private subnets to route their outbound traffic through it. Private subnets do not have direct internet connectivity and rely on NAT Gateway to access the internet.
        -   `Security`: Since NAT Gateway resides in a public subnet, it is exposed to the internet. However, it does not allow inbound traffic initiated from external sources to reach instances in private subnets. This enhances security by preventing direct access to instances from the internet.
        -   `High Availability`: NAT Gateway is a managed service provided by AWS and is designed for high availability and fault tolerance. It automatically scales to handle increased traffic volumes and is replicated across multiple Availability Zones within the same AWS region to ensure resilience.
        -   `Elastic IP Address`: Each NAT Gateway is associated with an Elastic IP (EIP) address, which provides a static, public IP address for outbound traffic. The EIP remains associated with the NAT Gateway even if it is replaced due to scaling or maintenance activities.
        -   `Usage Costs`: While there is no charge for creating a NAT Gateway, you are billed for the data processing and data transfer fees associated with outbound traffic routed through the NAT Gateway. Pricing is based on the volume of data processed and the AWS region where the NAT Gateway is deployed.
        -   `Automatic Failover`: AWS NAT Gateway automatically detects failures and redirects traffic to healthy instances. This ensures continuous availability and minimizes disruption to outbound internet connectivity.

    -   <details><summary style="font-size:20px;color:Magenta">Network Access Control List (NACL)</summary>

        > AWS Network Access Control Lists (NACLs) are stateless, optional security layers that control inbound and outbound traffic at the subnet level in an Amazon VPC. They act as a firewall for controlling traffic entering and leaving one or more subnets within a VPC. Here's an explanation of the key aspects of AWS NACLs:

        -   `Subnet-Level Security`: NACLs are associated with individual subnets within a VPC. Each subnet can have its own NACL, which allows you to customize the network security policies for different parts of your VPC.
        -   `Stateless Inspection`: Unlike security groups, which are stateful, NACLs are stateless. This means that they evaluate each network packet independently, without considering the state of previous packets. As a result, you must explicitly configure rules for both inbound and outbound traffic in both directions.
        -   `Rules`: NACL rules consist of a rule number, direction (inbound or outbound), protocol (TCP, UDP, ICMP, etc.), port range, source or destination IP address range, and action (allow or deny). You can create rules to permit or deny specific types of traffic based on criteria such as IP addresses, ports, and protocols.
        -   `Rule Evaluation`: NACLs are evaluated in a numbered order, starting with the lowest numbered rule and proceeding sequentially. When a network packet matches a rule, the corresponding action (allow or deny) is applied, and rule evaluation stops. If no rule matches, the default action (allow or deny) specified for the NACL is applied. A table of Two Inbound Rules are shown and explained below.

            | Rule # | Type        | Protocol | Port Range | Source    | Allow/Deny |
            | ------ | ----------- | -------- | ---------- | --------- | ---------- |
            | 100    | All traffic | All      | All        | 0.0.0.0/0 | **Allow**  |
            | \*     | All traffic | All      | All        | 0.0.0.0/0 | **Deny**   |

            -   ✅ **Rule 100 (Explicit Allow)**

                -   **Allows** _all inbound traffic_ (all protocols, all ports, from anywhere — `0.0.0.0/0`).
                -   Being assigned **Rule #100**, it has **higher precedence** than the default rule.
                -   This means **any inbound traffic** will be allowed **first**, before lower-numbered rules (if any).

            -   ❌ **Rule \* (Implicit Deny)**

                -   This is the **default rule** in every NACL — effectively "deny everything else."
                -   It applies **only if no previous rule matched**.
                -   Since Rule 100 allows everything, **this rule never gets applied** unless Rule 100 is removed or changed.

        -   `Ordering`: The order of rules in an NACL is crucial because rule evaluation stops after the first matching rule is found. Therefore, it's essential to organize rules effectively to ensure that traffic is permitted or denied according to your security requirements.
        -   `Default Rules`: By default, every newly created NACL allows all inbound and outbound traffic. You can modify the default rules to restrict or permit traffic as needed. It's important to understand the default rules when configuring custom rules to avoid unintended consequences.
        -   `Association`: Each subnet in a VPC must be associated with one NACL for inbound traffic and one NACL for outbound traffic. If no custom NACLs are explicitly associated with a subnet, the default NACL is applied automatically.
        -   `Logging`: You can enable logging for a NACL to capture information about the traffic that matches the rules. This can be helpful for troubleshooting network connectivity issues, monitoring traffic patterns, and auditing security configurations.

        </details>

    -   **Network Interface**: An AWS network interface is a virtual network interface that represents a network interface card (NIC) in a traditional server and can be attached to an EC2 instance in a VPC. It acts as a network interface for an EC2 instance, providing connectivity to the network and allowing the instance to communicate with other resources within the VPC and the internet. Here are some key points about AWS network interfaces:

        -   `Flexible Attachment`: Network interfaces can be attached to or detached from EC2 instances as needed. This allows for flexibility in networking configurations, such as adding additional network interfaces for specific purposes like high availability or security.
        -   `Multiple Network Interfaces`: An EC2 instance can have multiple network interfaces attached to it. Each network interface operates independently, with its own private IP address, MAC address, and security groups.
        -   `Private IP Address`: Each network interface is assigned a private IP address from the subnet to which it is attached. This IP address allows the instance to communicate with other resources within the same VPC.
        -   `Public IP Address`: A network interface can also be associated with a public IP address or an Elastic IP address (EIP), allowing the instance to communicate with the internet.
        -   `Security Groups`: Network interfaces can be associated with one or more security groups, which act as virtual firewalls, controlling the traffic allowed to and from the instance.
        -   `Traffic Monitoring and Control`: AWS provides tools for monitoring and controlling traffic through network interfaces, such as VPC Flow Logs, which capture information about the IP traffic going to and from network interfaces.


    -   <details><summary style="font-size:20px;color:Magenta">VPC Endpoint</summary>

        - An `VPC Endpoint` allows you to privately connect your VPC to supported AWS services and VPC endpoint services powered by **AWS PrivateLink**, without using an internet gateway, NAT device, VPN connection, or AWS Direct Connect. These endpoints provide secure access to services by keeping traffic within the AWS network, avoiding exposure to the public internet.
        - **Types of Endpoints**: AWS classifies VPC endpoints into three distinct categories based on how they connect and which services they support.

            | Type                    | Technology      | Supported Services                                 | Connectivity Method                             | Cost                                 |
            | ----------------------- | --------------- | -------------------------------------------------- | ----------------------------------------------- | ------------------------------------ |
            | **Interface Endpoint**  | AWS PrivateLink | Most AWS services (SQS, SNS, Kinesis, etc.) & SaaS | Elastic Network Interface (ENI) with private IP | Hourly charge + Data processing fees |
            | **Gateway Endpoint**    | Routing Rules   | **Amazon S3** and **DynamoDB** only                | Prefix List entry in a Route Table              | **Free**                             |
            | **Gateway LB Endpoint** | GWLB            | Virtual appliances (Firewalls, IDS/IPS)            | Target of a route table entry                   | Hourly charge + Data processing fees |

            1. **Interface Endpoints**: Elastic Network Interfaces (ENI) with private IP addresses that act as entry points to services such as S3, DynamoDB, SNS, or your own AWS-hosted services.
                - `Purpose`: Provides private connectivity between your VPC and AWS services through the private IPs of the endpoints.
                - `Example Use Case`: Accessing Amazon S3 or Amazon DynamoDB from within your VPC without exposing traffic to the internet.
                - `Cost`: There's a cost for creating and using interface endpoints because they rely on AWS PrivateLink.

            2. **Gateway Endpoints**: A gateway that you specify in your route table to route traffic privately to Amazon S3 or DynamoDB It does not use PrivateLink.
                - `Purpose`: Provides a direct route from your VPC to these services without an intermediate NAT or VPN.
                - `Supported Services`: Currently, only Amazon S3 and DynamoDB are supported.
                - `Cost`: Free to use, but only available for a limited set of services.

            3. **Gateway Load Balancer Endpoints**:

        - **Core Components**: To function, a VPC Endpoint relies on several network and identity components:
            - **Elastic Network Interface (ENI) - _Interface Endpoints Only_**: When you create an interface endpoint, AWS creates an ENI in your chosen subnets. This ENI is assigned a **private IP address** from your VPC range, serving as the entry point for the service.

            - **Route Table & Prefix Lists - _Gateway Endpoints Only_**: Gateway endpoints do not use ENIs. Instead, they use a **Prefix List** (a range of public IP addresses for the service) which is added as a target in your VPC Route Table.
                - **Target:** `vpce-xxxxxxxx`
                - **Destination:** `pl-xxxxxxxx` (e.g., `com.amazonaws.us-east-1.s3`)

            - **Private DNS**: Interface endpoints support **Private DNS**. When enabled, the standard public service URL (e.g., `sqs.us-east-1.amazonaws.com`) automatically resolves to the private IP of your endpoint's ENI within the VPC.

            - **Endpoint Policy**: A JSON resource-based policy attached to the endpoint itself. It functions like an IAM policy to control which principals (users/roles) can access which resources through that specific endpoint.

        - **Key Features**:
            - **Private Connectivity:** Traffic stays entirely within the AWS backbone. This reduces exposure to common internet threats like brute force attacks or DDoS.
            - **Security Groups & Network ACLs:**
                - **Interface Endpoints:** You can associate Security Groups with the endpoint's ENI to restrict inbound traffic from specific instances or subnets.
                - **Gateway Endpoints:** Controlled primarily through Endpoint Policies and the Security Groups/ACLs of the source instances.

            - **Cross-Region & On-Premises Access:**
                - **Interface Endpoints** can be accessed from on-premises via Direct Connect or VPN, and from other regions via VPC Peering.
                - **Gateway Endpoints** are typically restricted to the VPC and region where they are created.

            - **Granular Access Control:** Through **Endpoint Policies**, you can define "Data Perimeter" rules—for example, allowing access to only your company's S3 buckets and denying access to all other external buckets, even if the user has broad IAM permissions.

        </details>

    -   <details><summary style="font-size:20px;color:Magenta">PrivateLink</summary>

        AWS PrivateLink is a networking service that enables secure, **private connectivity** between Virtual Private Clouds (VPCs), AWS services, and on-premises networks without exposing traffic to the public internet. It simplifies network architecture by allowing **direct communication** between services while maintaining security and reducing the need for complex VPC peering or NAT gateways.

        -   **How AWS PrivateLink Works**:

            1. `Service Provider and Consumer Model`:

                - A **Service Provider** (AWS services or a custom application in a VPC) **creates a PrivateLink service** (also called a VPC endpoint service).
                - A **Service Consumer** (another VPC, on-premises network, or AWS account) **connects to the PrivateLink service** via an **interface VPC endpoint**.
                - The communication remains within AWS's private network, avoiding the **public internet**.

            2. `Uses Elastic Network Interfaces (ENIs)`:
                - PrivateLink **creates ENIs in the consumer VPC**, acting as an access point to the provider service.
                - These ENIs have **private IP addresses**, ensuring all communication stays within AWS.

        -   **Components of AWS PrivateLink**:

                1. `Interface VPC Endpoints`: Allows private connectivity to AWS services or PrivateLink-enabled services from a VPC.

                    - Creates an **ENI** in the VPC consumer subnet.
                    - The ENI gets a **private IP address** and serves as the entry point to the service.
                    - The endpoint is reachable **only within the consumer's VPC**.
                    - Connecting to AWS services like **S3, DynamoDB, SNS, SQS, Lambda, KMS, and API Gateway** privately.
                    - Accessing **third-party SaaS applications** privately via AWS Marketplace.

                2. `VPC Endpoint Services (PrivateLink Services)`: Enables a VPC to **offer services privately** to other VPCs using PrivateLink.

                    - The **service provider** creates a **VPC endpoint service**.
                    - The **service consumer** requests a connection to that service.
                    - Once accepted, the consumer can access the service **via a private endpoint**.
                    - Private access to **AWS services like Amazon RDS, Amazon S3, or custom applications**.
                    - Secure connectivity between **multi-account AWS environments**.

                3. `NLB (Network Load Balancer) Integration`:

                    - PrivateLink services **must be exposed via a Network Load Balancer (NLB)**.
                    - The NLB forwards traffic from the service consumer’s VPC to the **backend instances, containers, or Lambda functions**.

                4. `AWS PrivateLink for On-Premises`:

                    - **Direct Connect or VPN** can be used to route **on-premises traffic to AWS PrivateLink** services.
                    - Allows **hybrid cloud** architectures with **secure, low-latency** connectivity.

        </details>

    -   <details><summary style="font-size:20px;color:Magenta">Peering</summary>

        VPC Peering is a network connection between two VPCs that enables you to route traffic privately between them using private IP addresses.

        -   Works within a region or across regions (inter-region peering).
        -   Traffic stays within AWS's backbone network — no public internet involved.
        -   You can peer across accounts, organizations, or within the same account.

        -   Both VPCs can send/receive traffic once routes are set.
        -   You can’t use VPC A as a bridge to reach VPC C from VPC B.
        -   You can peer VPCs in us-east-1 and us-west-2, etc.
        -   Uses AWS's internal backbone network, not internet.
        -   Peered VPCs must have non-overlapping IP ranges.
        -   **No transitive peering:** You can’t chain peering connections. Use **Transit Gateway** if needed.
        -   **Security Groups** must explicitly allow traffic from the peer CIDR.
        -   **NACLs** must also allow cross-VPC traffic if used.

        -   How VPC Peering Works (High-Level Flow)

            -   `Create Peering Connection`: One VPC owner initiates the request.

            -   `Accept Peering Request`: The other VPC owner accepts it (same or different AWS account).

            -   `Update Route Tables`: Add routes in both VPCs to enable communication.

            -   `Adjust Security Groups/NACLs`: Allow traffic between the CIDR blocks of the VPCs.

        -   Peering vs Transit Gateway vs VPN

            | Feature                | VPC Peering         | Transit Gateway    | VPN/Direct Connect    |
            | ---------------------- | ------------------- | ------------------ | --------------------- |
            | **Type**               | Point-to-point      | Hub-and-spoke      | External connectivity |
            | **Transitive Routing** | ❌ No                | ✅ Yes              | N/A                   |
            | **Scale**              | 1:1 connections     | 1000s of VPCs      | Limited               |
            | **Use Case**           | Small-medium setups | Large/multi-region | Hybrid cloud          |

        </details>

    -   <details><summary style="font-size:20px;color:Magenta">VPN</summary>

        A Virtual Private Network (VPN) on Amazon Web Services (AWS) is a service that provides a secure, encrypted connection for transmitting data over the public internet. This allows you to securely connect your on-premises networks or remote users to your Amazon Virtual Private Cloud (Amazon VPC) resources, creating a **hybrid cloud architecture**. AWS offers two primary VPN solutions: **AWS Site-to-Site VPN** and **AWS Client VPN**.

        -   **AWS Site-to-Site VPN**: AWS Site-to-Site VPN is designed to create a secure connection between your entire **on-premises network (a "site")** and your **Amazon VPC**. It's primarily used for connecting corporate data centers, branch offices, or other remote network locations to your cloud resources.

            -   **Key Components**:

                -   **Virtual Private Gateway (VGW):** This is the **AWS side** of the VPN connection. It's a logically redundant component attached to your Amazon VPC or an AWS Transit Gateway. It's the termination point for the VPN tunnels on the AWS side.
                -   **Customer Gateway (CGW):** This is the **customer side** resource in AWS that represents your physical or software VPN appliance (e.g., a firewall or router) in your on-premises data center. When you configure the CGW, you provide AWS with the internet-routable IP address of your appliance.
                -   **VPN Connection:** This is the AWS resource that establishes the secure link between the Virtual Private Gateway (VGW) and the Customer Gateway (CGW).
                    -   **High Availability:** Each VPN Connection automatically provisions **two separate IPSec VPN tunnels** running concurrently. This provides redundancy and high availability. If one tunnel fails, network traffic automatically routes to the second tunnel, ensuring continuous connectivity.
                    -   **IPSec Tunnels:** The tunnels use the **IP Security (IPSec)** protocol suite to provide encryption, confidentiality, and integrity for the data in transit over the public internet.

            -   **Routing Options**:

                -   **Static Routing:** You manually specify the IP address prefixes (CIDR blocks) for your on-premises network and for the VPC/Transit Gateway on both the Customer Gateway and the AWS side.
                -   **Dynamic Routing (BGP):** This uses the **Border Gateway Protocol (BGP)** to automatically exchange route information between the Customer Gateway and the Virtual Private Gateway/Transit Gateway. This is generally preferred as it simplifies network management and provides quicker adaptation to network changes.

            -   **Use Cases**:

                -   **Hybrid Cloud:** Integrating your existing on-premises infrastructure with AWS cloud services.
                -   **Disaster Recovery:** Setting up replication and failover between your data center and a recovery VPC on AWS.
                -   **AWS Direct Connect Backup:** Using the Site-to-Site VPN as a lower-cost, redundant backup path for your dedicated AWS Direct Connect link.

        -   **AWS Client VPN**: AWS Client VPN is a managed, client-based VPN service that enables **individual remote users** (like employees working from home or traveling) to securely access your AWS resources and any connected on-premises networks. It is a modern replacement for traditional self-managed remote access VPN solutions.

            -   **Key Components**:

                -   **Client VPN Endpoint:** This is the regional AWS resource that you create and configure. It is the termination point for all client VPN sessions, handling authentication, encryption, and session management.
                -   **Target Network Association:** You associate one or more subnets in your VPC with the Client VPN Endpoint. This allows the VPN to inject traffic directly into the VPC.
                -   **VPN Client:** Users connect to the endpoint using an **OpenVPN-based software client** (including the AWS provided desktop client) installed on their laptop or mobile device.
                -   **Client CIDR Range:** An IP address range (e.g., $10.10.0.0/16$) that is separate from your VPC CIDR, from which the Client VPN Endpoint assigns a unique, temporary IP address to each connected user.

            -   **Authentication and Authorization**: Client VPN is more focused on user identity management and supports several authentication methods:

                -   **Active Directory:** Integrate with AWS Directory Service to authenticate users against your corporate AD.
                -   **Mutual Authentication:** Uses both a server certificate (uploaded to AWS) and a client certificate (installed on the user's device) for verification.
                -   **Federated Authentication (SAML 2.0):** Use an identity provider (IdP) for single sign-on.
                -   **Authorization Rules:** After successful authentication, you configure rules that specify which users (or Active Directory groups) are allowed to access which target networks (e.g., VPC CIDRs).

            -   **Use Cases**:

                -   **Remote Work Access:** Allowing employees secure access to internal applications and resources hosted in AWS.
                -   **Administrative Access:** Providing secure access for administrators and developers to manage AWS instances in a private subnet.

        -   **Site-to-Site vs. Client VPN Summary**:

            | Feature                | AWS Site-to-Site VPN                                     | AWS Client VPN                                            |
            | :--------------------- | :------------------------------------------------------- | :-------------------------------------------------------- |
            | **Primary Use**        | Network-to-Network connection (e.g., Data Center to VPC) | User-to-Network connection (e.g., Remote Employee to VPC) |
            | **Connectivity Model** | Always-on, fixed link                                    | On-demand, user-initiated session                         |
            | **Protocols**          | IPSec                                                    | OpenVPN-based (TLS)                                       |
            | **User Management**    | None (It connects _networks_)                            | Centralized access control (AD, SAML, Certificates)       |
            | **AWS Endpoint**       | Virtual Private Gateway (VGW) or Transit Gateway         | Client VPN Endpoint                                       |

        </details>

    -   <details><summary style="font-size:20px;color:Magenta">AWS Transit Gateway: The Central Hub</summary>

        Absolutely! The **AWS Transit Gateway (TGW)** is a powerful networking service that dramatically improves how you handle connectivity, especially when integrating multiple Virtual Private Clouds (VPCs) and Site-to-Site VPN connections.

        The Transit Gateway acts as a highly scalable **cloud router** that functions as a central hub in a **hub-and-spoke** network model. Instead of having many individual point-to-point connections (like a mesh of VPC peering links), all your network connections (VPCs, VPNs, and Direct Connect) attach to the single TGW hub.

        -   **How TGW Enhances VPN Architecture**: When using AWS Site-to-Site VPN, you can choose the Transit Gateway instead of a Virtual Private Gateway (VGW) as the AWS-side endpoint.

            1.  **Centralized Connectivity:** With a VGW, your VPN connection is tied to **one single VPC**. If you have 10 VPCs that need access to your on-premises data center, you would need to either set up 10 separate VGW/VPN connections, or use complex VPC peering with the single VPC attached to the VGW.

                -   **TGW Solution:** You create **one Site-to-Site VPN connection** and attach it to the Transit Gateway. Then, you attach all your VPCs to the same Transit Gateway. Traffic can now be routed from your on-premises network, through the single VPN connection, to _any_ attached VPC.

            2.  **Simplified Routing (Hub-and-Spoke):**

                -   The TGW manages routing between all its attachments. You define **Transit Gateway Route Tables** to control which spoke (VPC, VPN, etc.) can talk to which other spoke.
                -   This eliminates the complex, transitive routing problems that arise from a VPC peering mesh.

            3.  **Scalability:** TGW supports thousands of VPCs and up to 5000 attachments per gateway, allowing your hybrid cloud architecture to scale seamlessly as your organization grows and adds new AWS accounts or regions.

            4.  **High-Performance VPN (ECMP and High Bandwidth):**

                -   **Equal-Cost Multi-Path (ECMP):** With a Transit Gateway, you can terminate **multiple Site-to-Site VPN connections** (e.g., from different Customer Gateways) and enable ECMP routing. If all connections advertise the same routes with the same cost, the TGW can use all tunnels concurrently to **load balance** traffic across the multiple VPN connections, effectively increasing the total bandwidth available for your on-premises connection.
                -   **High Bandwidth Tunnels:** TGW supports higher-bandwidth VPN tunnels (up to $5 \text{ Gbps}$ per tunnel), which are not available on a standard VGW connection. Combining multiple of these high-bandwidth tunnels with ECMP allows for a very robust and high-throughput connection.

            5.  **Inter-Region Communication:** TGWs can be peered together across different AWS regions. This means a single VPN connection terminated in one region's TGW can be used to route traffic to resources in a different region, leveraging the secure and high-speed **AWS Global Network** backbone.

        -   **Key Transit Gateway Components for VPN**

            | Component           | Description                                                                                                                                                                  |
            | :------------------ | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
            | **TGW Attachment**  | The connection point on the Transit Gateway. This is where you link your VPCs, your Site-to-Site VPN, or your Direct Connect Gateway.                                        |
            | **TGW Route Table** | A table of rules that determines the next hop for a network packet, based on its destination IP address. You can have multiple tables for fine-grained network segmentation. |
            | **Association**     | Links an attachment (VPC, VPN) to a specific TGW Route Table, determining _how_ incoming traffic from that attachment is routed.                                             |
            | **Propagation**     | Automatically adds the routes for a connected resource (like a VPC CIDR or on-premises routes learned over VPN) into a TGW Route Table.                                      |

        </details>

    -   **Elastic IP Address**: In AWS, a Elastic IP (EIP) usually refers to an Static IP address is a public, static IPv4 address that you can allocate and associate with AWS resources, most commonly EC2 instances or Network Interfaces.

        -   A Static IP is an IP address that does not change over time. It's ideal for services where DNS caching or firewall whitelisting is required (e.g., APIs, external integrations, webhooks, etc.).
        -   Web servers that need a stable IP for DNS A-records.
        -   Whitelisting in external firewalls, partners, or SaaS integrations.
        -   Failover/HA designs where you want to move the IP between instances.
        -   Outbound NAT gateways using Elastic IPs for fixed egress traffic.
        -   VPNs, APIs, or reverse proxies with static IP requirements.
        -   Elastic IPs are region-specific.
        -   Only 5 EIPs per region by default (can request more).
        -   Idle EIPs cost money. (When not attached to a running resource.)

    -   **VPN**: Virtual Private Network, a connection between your on-premises network and your VPC that enables secure communication.
    -   **AWS Direct Connect**: A dedicated network connection between your on-premises data center and your VPC.
    -   **VPC Flow Logs**: A feature that enables you to capture information about the IP traffic going to and from network interfaces in your VPC.

    -   **Egress-only Internet Gatway**:
    -   **NAT Instanc**:
    -   **Virtual Private Gateway**:
    -   **Customer Gateway**:

    -   <details><summary style="font-size:20px;color:Magenta">Availability Zone</summary>

        An **Availability Zone (AZ)** in Amazon Web Services (AWS) is a distinct, isolated location within an AWS Region. Each AZ is a fully independent data center (or a cluster of data centers) with its own power, cooling, and networking infrastructure. However, Availability Zones within a region are connected to each other through low-latency, high-speed private networking.

        -   **Key Features of Availability Zones**

            1. `Isolation`: Each AZ is physically separated from others in the same region, reducing the likelihood of a single point of failure affecting multiple AZs.
            2. `Low Latency`: The network connections between AZs within a region are designed to have very low latency, making it possible to build high-availability applications across multiple AZs.
            3. `Redundancy`: By using multiple AZs, you can design fault-tolerant applications. If one AZ goes down, your application can continue running from another AZ.
            4. `Proximity`: AZs are located close enough to ensure fast data transfer between them but far enough to avoid being impacted by the same physical disasters.

        -   **Use Cases of Availability Zones**

            1. `High Availability`: Deploy resources (like EC2 instances, RDS databases, etc.) in multiple AZs to ensure high availability and disaster recovery.
            2. `Scalability`: Distribute workloads across multiple AZs to scale applications and balance traffic.
            3. `Disaster Recovery`: In case of an AZ failure, applications can fail over to another AZ in the same region.
            4. `Fault Tolerance`: Applications designed with redundancy across AZs can remain operational even if one AZ experiences issues.

        -   **Availability Zones vs. Regions**

            | **Feature**    | **Region**                            | **Availability Zone (AZ)**               |
            | -------------- | ------------------------------------- | ---------------------------------------- |
            | **Definition** | Geographical location (e.g., US East) | Isolated data center(s) within a region  |
            | **Scope**      | Contains multiple AZs                 | Subset of a region                       |
            | **Redundancy** | Achieved across AZs within the region | Achieved across resources in the same AZ |
            | **Examples**   | `us-east-1`, `ap-south-1`             | `us-east-1a`, `ap-south-1b`              |

        -   **Why Use Multiple AZs?**

            -   `Fault tolerance`: Your app can survive an AZ failure.
            -   `Improved latency`: Load balancers can distribute traffic across AZs.
            -   `Better disaster recovery`: Resources in one AZ can back up those in another.

        </details>

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">IAM (Identity and Access Management)</summary>

    -   [AWS IAM Core Concepts You NEED to Know](https://www.youtube.com/watch?v=_ZCTvmaPgao)
    -   [AWS IAM Guides](https://www.youtube.com/playlist?list=PL9nWRykSBSFjJK9mFrIP_BPWaC0hAL9dZ)

    > **AWS IAM** is a service that enables you to manage access to AWS resources securely. IAM allows you to create and manage users, groups, roles, and permissions that define what actions are allowed or denied for AWS resources. Here are the key components of AWS IAM:

    -   `Entities`: In AWS, an entity refers to any object or resource that can be managed by AWS services. Entities can include a wide variety of resources, including IAM users, EC2 instances, S3 buckets, RDS databases, Lambda functions, and more. AWS entities can be created, configured, and managed using AWS management tools such as the AWS Management Console, AWS CLI, and AWS SDKs. Depending on the type of entity, different AWS services may be used to manage it.
    -   `Identity`: In the context of AWS (Amazon Web Services), "identity" refers to the concept of uniquely identifying and authenticating users or entities within the AWS ecosystem.
    -   `Users`: IAM users are entities that you create to represent people, applications, or services that need access to AWS resources. Each user has a unique name and credentials.
    -   `Groups`: IAM groups are collections of users. You can apply policies to groups to grant or deny access to AWS resources. Instead of assigning permissions directly to individual users, you can assign permissions to groups. This simplifies access management, as you can grant and revoke permissions for multiple users by managing group memberships.
    -   `Roles`: IAM roles are similar to users but are intended for use by AWS services, applications, or other AWS accounts. Roles allow you to grant temporary access to resources across different accounts and services without having to create long-term credentials like access keys. IAM roles are a way to delegate permissions to entities that you trust. A role does not have any credentials, but instead, it is assumed by an entity that has credentials. This entity could be an AWS service, an EC2 instance, or an IAM user in another account. IAM roles can be used for a variety of purposes, such as granting permissions to AWS services or resources, allowing cross-account access, or providing permissions to an external identity provider (IdP).
    -   `Permissions`: Permissions are the actions that users, groups, and roles are allowed or denied to perform on AWS resources. They are defined by IAM policies.

    -   <details><summary style="font-size:20px;color:#C71585">IAM Policies</summary>

        > **IAM policies** are documents that define permissions. They are attached to users, groups, and roles to determine what actions they can perform on AWS resources. A policy is a set of permissions that can be attached to an identity to define its overall access to AWS resources. A policy can include one or more permissions and can be attached to multiple identities. For example, a policy might allow all members of a certain group to access a specific set of EC2 instances.

        > The file `policy` is a JSON document in the current folder that grants read only access to the shared folder in an Amazon S3 bucket named my-bucket:

        ```json
        {
            "Version": "2012-10-17",
            "Id": "default",
            "Statement": [
                {
                    "Sid": "lambda-a75c4b44-4416-4229-91af-350e53bb044c",
                    "Effect": "Allow",
                    "Principal": {
                        "Service": "events.amazonaws.com"
                    },
                    "Action": "lambda:InvokeFunction",
                    "Resource": "arn:aws:lambda:us-east-1:554116157557:function:lambda_canary",
                    "Condition": {
                        "ArnLike": {
                            "AWS:SourceArn": "arn:aws:events:us-east-1:554116157557:rule/canary"
                        }
                    }
                }
            ]
        }
        ```

        -   **Common Attributes of AWS Policy Documents**:

            -   `Version`: The "Version" field specifies the version of the AWS policy language being used. It is required and indicates the syntax and structure of the policy. The version is typically specified as a date, such as "2012-10-17" or "2016-10-17."
            -   `Id`: The optional "Id" field is used to give a unique identifier to the policy. It is often used for managing and organizing policies in the AWS Management Console.
            -   `Statement`: The "Statement" field is the most important part of an AWS policy document. It contains an array of individual statements, each of which defines a permission or access control rule. A policy can have multiple statements.
            -   `Sid`: The optional "Sid" (Statement ID) field is used to provide a unique identifier for each statement within a policy. It is helpful for referencing or managing specific statements within the policy.
            -   `Effect`: The "Effect" field specifies whether the statement grants ("Allow") or denies ("Deny") permissions. It is a required field in each statement.
            -   `Principal`: The "Principal" field identifies the AWS identity (user, group, role, or AWS service) to which the permissions are granted or denied. It can also specify the **\*** wildcard to apply the permission to all identities.
            -   `Action`: The "Action" field defines the AWS service actions that are allowed or denied by the statement. It can specify a single action or a list of actions. AWS actions are typically named using a combination of the service name and the action name (e.g., "s3:GetObject," "ec2:CreateInstance").
            -   `Resource`: The "Resource" field specifies the AWS resources to which the actions are applied. It defines the scope of the permissions and can use Amazon Resource Names (ARNs) to identify specific resources.
            -   `Condition`: The optional "Condition" field allows you to define additional conditions that must be met for the permission to take effect. You can use various condition operators to check attributes like time, IP address, encryption status, and more.
            -   `NotAction, NotResource, NotPrincipal`: These fields are used to specify exceptions or negations in the policy. For example, "NotAction" can be used to allow all actions except the ones listed.
            -   `Resources and Actions ARN Format`: When specifying resources or actions in a policy, Amazon Resource Names (ARNs) are used. ARNs uniquely identify AWS resources and follow a specific format.
            -   `IAM Policies and Resource Policies`: AWS policy documents can be attached to IAM users, groups, and roles to manage access control. They can also be used as resource policies to manage permissions on individual AWS resources (e.g., S3 bucket policy).

        -   **Managed Policy**: A managed policy in AWS is a standalone policy that you can attach to multiple IAM users, groups, or roles. Managed policies allow you to create and maintain a single policy that you can reuse across different entities, simplifying policy management and ensuring consistency in permissions across your AWS environment.

            -   `AWS Managed Policies`: Created and maintained by AWS, these policies are designed to provide permissions for common use cases, such as full access to a specific AWS service or read-only access to certain resources.
            -   `Customer Managed Policies`: Created and maintained by the user, these policies provide custom permissions tailored to specific organizational needs.

        -   **Inline Policy**: An inline policy in AWS is a policy that's embedded directly within a single IAM user, group, or role. Unlike managed policies, which can be attached to multiple entities and reused, an inline policy is specific to the entity to which it is attached.

            ```json
            {
                "Version": "2012-10-17",
                "Statement": [
                    {
                        "Effect": "Allow",
                        "Action": ["s3:GetObject", "s3:ListBucket"],
                        "Resource": [
                            "arn:aws:s3:::example-bucket",
                            "arn:aws:s3:::example-bucket/*"
                        ]
                    }
                ]
            }
            ```

        -   **Trust Policy** (**Assume-Role Policy**): A trust policy in AWS is a JSON document that specifies which principals (users, accounts, services, etc.) are allowed to assume a specific role. It defines the conditions under which a role can be assumed and the actions that are allowed as a result.

            ```json
            {
                "Version": "2012-10-17",
                "Statement": [
                    {
                        "Effect": "Allow",
                        "Principal": { "Service": "lambda.amazonaws.com" },
                        "Action": "sts:AssumeRole"
                    }
                ]
            }
            ```

        -   **Principle-Based Policy**: A principal-based policy is a policy that is designed to allow or restrict actions based on the **principal** (i.e., the AWS account, user, role, or service) that is making the request. These policies specify what actions a specific principal can perform on a resource. Principals are at the center of AWS Identity and Access Management (IAM) policies, defining "who" has permission to do "what" on "which" resources. Following are key types of principal-based policies:

            1. `Identity-Based Policies`:

                - `Attached to Users, Groups, or Roles`: Identity-based policies are created to allow or deny access to AWS resources by attaching them directly to an IAM user, group, or role.
                - `Defines Permissions of the Principal`: These policies specify which actions and resources the principal (user, group, or role) can interact with.
                - `Flexible Scope`: You can make identity-based policies broad (like granting S3 access to a role) or specific (like restricting certain S3 actions).

            2. `Resource-Based Policies`:
                - `Attached Directly to AWS Resources`: Some resources (like S3 buckets, Lambda functions, etc.) allow policies to be attached directly to them, defining who can access them. These policies also define the allowed actions on the resource.
                - `Granting Cross-Account Access`: Resource-based policies are often used to grant cross-account access, specifying who (in another account) can access a resource.

            3. `Service-Control Policies (SCPs)`:

                - `Applied at the Organization Level`: In AWS Organizations, SCPs set boundaries for accounts within the organization or organizational units (OUs), limiting or allowing actions for all IAM users, groups, and roles within those accounts.
                - `Permissions Boundary`: SCPs act as a boundary layer, meaning even if a user has broader permissions in their IAM policy, SCPs can restrict certain actions, effectively setting the upper limit of permissions.

        </details>

    -   <details><summary style="font-size:20px;color:#C71585">Role</summary>

        > An AWS IAM Role is a set of permissions that define what actions are allowed (or denied) in AWS. It is not associated with a specific user or group, but instead, it can be assumed by any trusted entity (like an AWS service, user, or application).

        > In simple terms, an IAM role allows you to grant temporary access to AWS resources to other services or users without sharing long-term credentials like access keys. The role specifies:

        -   Who can assume the role (the trusted entity).
        -   What permissions are granted to that entity while they use the role.

        -   A role is an IAM identity that you can create in your account that has specific permissions. An IAM role has some similarities to an IAM user. Roles and users are both AWS identities with permissions policies that determine what the identity can and cannot do in AWS. However, instead of being uniquely associated with one person, a role can be assumed by anyone who needs it. A role does not have standard long-term credentials such as a password or access keys associated with it. Instead, when you assume a role, it provides you with temporary security credentials for your role session. You can use roles to delegate access to users, applications, or services that don't normally have access to your AWS resources.

        -   **service role**: A **Service Role** in AWS Identity and Access Management (IAM) is an IAM role that an **AWS service assumes** to perform actions on your behalf. This mechanism is crucial for the security and functionality of numerous AWS services, as it allows them to interact with other AWS resources without using your permanent user credentials.

            -   **Core Concepts of an IAM Role**: An IAM role, in general, is an AWS identity with permission policies, similar to an IAM user. However, a role is designed to be **assumed** by a trusted entity rather than being permanently associated with a single person. The two essential components of any IAM role, including a Service Role, are:

                -   **Trust Policy:** This policy defines **which entities** (principals) are allowed to assume the role. For a Service Role, the trust policy is configured to trust a specific AWS service principal (e.g., `lambda.amazonaws.com` for AWS Lambda or `ec2.amazonaws.com` for Amazon EC2).
                -   **Permissions Policy:** This policy specifies **what actions** the entity can perform on **which AWS resources** once the role is assumed. This is where you define the permissions needed for the service to carry out its function (e.g., allow `s3:GetObject` on a specific S3 bucket).

            -   **How a Service Role Works**

                1.  **Creation:** An administrator creates the IAM Service Role, attaching the necessary permissions policies and defining the trust policy to allow a specific AWS service (the **principal**) to assume it.
                2.  **Assumption:** When the AWS service needs to perform an action on a resource (like an EC2 instance needing to read data from S3, or a Lambda function needing to write logs to CloudWatch), the service automatically _assumes_ the Service Role.
                3.  **Temporary Credentials:** When the service assumes the role, it receives **temporary security credentials**. These credentials are automatically managed, rotated, and have a defined expiration time, adhering to the principle of least privilege and enhancing security.
                4.  **Action:** The service uses these temporary credentials to execute the allowed actions on your behalf (e.g., creating a network interface, launching an EC2 instance, or writing logs).

            -   **Types of Service Roles**: There are two main categories of service roles you will encounter:

                | Type of Role            | Description                                                                                                                                                                                                  | Management                                                                                                                                                   | Example Use Case                                                                                  |
                | :---------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------ |
                | **Service Role**        | A custom role created by an administrator to grant specific, scoped permissions for an AWS service (like Lambda or EC2) to access resources in your account.                                                 | **Customer-Managed**. You define and control both the trust and permissions policies.                                                                        | An **AWS Lambda function** needs to read data from a DynamoDB table and write logs to CloudWatch. |
                | **Service-Linked Role** | A unique type of IAM role that is **directly linked** to an AWS service. These roles are pre-defined by the service and automatically contain all permissions required for the service to operate correctly. | **AWS-Managed**. The service automatically creates and updates the role, and you typically cannot modify its permissions or trust policy (only view/delete). | An **Auto Scaling Group** needs to manage EC2 instances or Elastic Load Balancers on your behalf. |

        -   **Service-Linked Role**:

        -   **Assumed Role**:

        -   **Pass Role**:

        -   **assume-role-policy-document**: An assume-role-policy-document is a policy attached to an IAM role that defines who (which entities) can assume the role. This policy, also known as a trust policy, specifies the conditions under which the role can be assumed and the permissions granted to those entities.

            ```json
            {
                "Version": "2012-10-17",
                "Statement": [
                    {
                        "Effect": "Allow",
                        "Principal": {
                            "Service": "ec2.amazonaws.com"
                        },
                        "Action": "sts:AssumeRole"
                    }
                ]
            }
            ```

            -   `Version`: Specifies the version of the policy language.
            -   `Statement`: Contains one or more statements that define the principals and the actions allowed.
            -   `Effect`: Specifies whether the statement allows or denies access (usually "Allow").
            -   `Principal`: Specifies the AWS account, user, role, or service that can assume the role.
            -   `Action`: Specifies the action that is allowed (usually "sts ").
            -   `Condition`: (Optional) Specifies conditions under which the role can be assumed.

        -   **Example**:

            -   Let's say we have an ec2 instance (which is a service as opposed to a user) where softwares are running and that softwares nees to access information that is in an s3 bucket. So we have one AWS service trying to communicate and talk with another AWS service. You may just think, well, let's just assign the s3 policy and that will grant access to the s3 bucket. But with AWS services you can't directly assign policies to other AWS services.
            -   First you need to attach a role to a service and then to the role you could attach policies. What the role does in essence is give permissions to another AWS service to almost act as a user. So we can assign a role to an EC2 instance that has the s3 full access policy attached to it, thus granting the ec2 instance access to s3. So you can almost think of roles as a group but for other AWS services as opposed to AWS users.

            -   Create Role:

                ```bash
                aws iam create-role
                --role-name Test-Role
                --assume-role-policy-document file://Test-Role-Trust-Policy.json
                ```

        </details>

    -   <details><summary style="font-size:20px;color:#C71585">Security Group</summary>

        > In Amazon Web Services (AWS), a security group is a virtual firewall that controls the inbound and outbound traffic for one or more instances. A security group acts as a set of firewall rules for your instances, controlling the traffic that is allowed to reach them. When you create an instance in AWS, you can assign it to one or more security groups. The following are some key terms and concepts related to AWS Security Groups:

        -   `Inbound rules`: Inbound rules are used to control incoming traffic to an EC2 instance. Each rule specifies the source IP address, protocol (TCP/UDP/ICMP), port range, and action (allow/deny) for incoming traffic.
        -   `Outbound rules`: Outbound rules are used to control outgoing traffic from an EC2 instance. Each rule specifies the destination IP address, protocol (TCP/UDP/ICMP), port range, and action (allow/deny) for outgoing traffic.
        -   `IP address`: An IP address is a unique identifier assigned to devices on a network. In the context of AWS Security Groups, IP addresses can be used to specify the source or destination of traffic in inbound and outbound rules.
        -   `CIDR block`: A Classless Inter-Domain Routing (`CIDR`) block is a range of IP addresses. It is used to specify a range of IP addresses in an inbound or outbound rule.
        -   `Security Group ID`: A Security Group ID is a unique identifier assigned to an AWS Security Group. It is used to reference the Security Group in other AWS resources, such as EC2 instances.
        -   `Stateful`: AWS Security Groups are stateful, which means that any traffic that is allowed in is automatically allowed out, and any traffic that is denied in is automatically denied out.
        -   `Default Security Group`: Every VPC comes with a default security group. This security group is applied to all instances that are launched in the VPC if no other security group is specified.
        -   `Port`: A port is a communication endpoint in an operating system. In the context of AWS Security Groups, it is used to specify the network port number for incoming or outgoing traffic.
        -   `Protocol`: Protocol is a set of rules that govern how data is transmitted over a network. In the context of AWS Security Groups, it is used to specify the transport protocol (TCP/UDP/ICMP) for incoming or outgoing traffic.
        -   `Network ACLs`: Network Access Control Lists (ACLs) are another layer of security at a VPC subnet level that can be used to control inbound and outbound traffic to the subnet. Unlike Security Groups, Network ACLs are stateless and can be used to filter traffic based on source/destination IP addresses, protocol, and port number.

        -   **Security Groups**:
            -   `Ingress`: Security groups define inbound rules to control incoming traffic to your instances.
            -   `Egress`: Security groups also define outbound rules to control outgoing traffic from your instances.

        -   **Network Access Control Lists (NACLs)**:
            -   `Ingress and Egress`: NACLs operate at the subnet level and provide additional control over inbound and outbound traffic. They are stateless, meaning rules for ingress and egress must be defined separately.

        -   **Application Load Balancers (ALB) and Network Load Balancers (NLB)**:
            -   `Ingress`: Load balancers handle incoming traffic and distribute it across multiple instances. ALBs are used for routing HTTP/HTTPS traffic, while NLBs handle TCP/UDP traffic.
            -   `Egress`: Load balancers themselves don't generate egress traffic, but instances behind load balancers might generate egress traffic.

        -   **Amazon VPC**:
            -   `Ingress and Egress`: VPCs allow you to define routing tables, which control the flow of traffic within and outside the VPC. Ingress and egress routes can be specified to direct traffic to specific destinations.

        ```ini
        resource "aws_security_group" "alb_sg" {
            name_prefix = "${var.project_name}-alb-"
            description = "Security group for Application Load Balancer"
            vpc_id      = var.vpc_id

            ingress {
                description = "HTTP"
                from_port   = 80
                to_port     = 80
                protocol    = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
            }

            egress {
                from_port   = 0
                to_port     = 0
                protocol    = "-1"
                cidr_blocks = ["0.0.0.0/0"]
            }
        }

        resource "aws_security_group" "ecs_sg" {
            name_prefix = "${var.project_name}-ecs-"
            description = "Security group for ECS tasks"
            vpc_id      = var.vpc_id

            ingress {
                description     = "HTTP from ALB"
                from_port       = 8000
                to_port         = 8000
                protocol        = "tcp"
                security_groups = [aws_security_group.alb_sg.id]
            }

            ingress {
                description = "HTTP from ALB"
                from_port   = 22
                to_port     = 22
                protocol    = "tcp"
                cidr_blocks = var.vpc_cidr_block != null ? [var.vpc_cidr_block] : []
            }
        }

        resource "aws_security_group_rule" "allow_http_inbound" {
            type              = "ingress"
            security_group_id = aws_security_group.instances.id

            from_port   = 8080
            to_port     = 8080
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }

        # Allow Lambda -> EFS (outbound NFS)
        resource "aws_security_group_rule" "lambda_to_efs" {
            type                     = "egress"
            from_port                = 2049
            to_port                  = 2049
            protocol                 = "tcp"
            source_security_group_id = aws_security_group.efs_sg.id
            security_group_id        = aws_security_group.lambda_analysis_sg.id
        }

        # Allow EFS <- Lambda (inbound NFS)
        resource "aws_security_group_rule" "efs_from_lambda" {
            type                     = "ingress"
            from_port                = 2049
            to_port                  = 2049
            protocol                 = "tcp"
            source_security_group_id = aws_security_group.lambda_analysis_sg.id
            security_group_id        = aws_security_group.efs_sg.id
        }
        ```

        </details>

    -   <details><summary style="font-size:20px;color:#C71585">Security Token Service (STS)</summary>

        > AWS Security Token Service (STS) is a web service that enables you to request temporary, limited-privilege credentials for AWS Identity and Access Management (IAM) users or for users that you authenticate (federated users). These temporary security credentials work almost identically to long-term access key credentials, with the following differences:

        -   **Temporary**: Temporary security credentials are short-lived. You configure expiration from a few minutes to several hours. After the credentials expire, AWS no longer recognizes them or allows any kind of access from API requests made with them.

        -   **Dynamic**: These credentials are dynamically generated and can be used to provide access to AWS resources for a limited amount of time, making them a secure way to grant access to resources.

        -   **Key Use Cases for STS**:

            1. `Identity Federation`: Allows users to access AWS resources using credentials from an external identity provider (IdP), such as Microsoft Active Directory, Facebook, or any other supported IdP.
            2. `Cross-Account Access`: Enables users to access resources in a different AWS account without having to create additional user identities.
            3. `IAM Roles for EC2 Instances`: Grants EC2 instances temporary security credentials to access AWS resources.
            4. `Temporary Elevated Access`: Allows you to provide users with temporary elevated access to resources without having to modify their long-term credentials.

        -   **Main STS API Operations**

            -   `AssumeRole`: Requests temporary security credentials and associates them with a specified IAM role.
            -   `AssumeRoleWithSAML`: Returns temporary security credentials for users who have been authenticated via a SAML authentication response.
            -   `AssumeRoleWithWebIdentity`: Returns temporary security credentials for users authenticated via a web identity provider, such as Login with Amazon, Facebook, Google, or any OpenID Connect-compatible provider.
            -   `GetFederationToken`: Returns temporary security credentials for a federated user.
            -   `GetSessionToken`: Returns temporary security credentials for an AWS account or IAM user.

        > There are two main ways for an **IAM User** to request an AWS STS token, which grants **temporary, limited-privilege credentials**:

        1.  **Requesting a Token with `GetSessionToken` (Same Permissions)**: The `GetSessionToken` API call generates temporary credentials that are based on the calling IAM user's long-term credentials and have the exact same permissions. This is primarily used to provide temporary, MFA-protected credentials.

            -   **Prerequisites**:

                -   The IAM user must have long-term access keys configured.
                -   (Optional but recommended) The IAM user must have an MFA device configured, and the policy controlling access must require MFA.

            -   **AWS CLI Example (with MFA)**: Use the `aws sts get-session-token` command, providing the MFA details:

                ```bash
                aws sts get-session-token \
                    --duration-seconds 3600 \
                    --serial-number arn:aws:iam::123456789012:mfa/user-name \
                    --token-code 123456
                ```

                -   `--duration-seconds`: The duration for the temporary credentials (e.g., 3600 seconds = 1 hour). Max is 36 hours for IAM users.
                -   `--serial-number`: The ARN of the IAM user's MFA device.
                -   `--token-code`: The current 6-digit code from the MFA device.

                **Output:** The command returns a `Credentials` object containing the `AccessKeyId`, `SecretAccessKey`, and `SessionToken`.

        2.  **Requesting a Token with `AssumeRole` (Delegated Permissions)**: The `AssumeRole` API call allows an IAM user to temporarily take on the permissions defined in an **IAM Role**. This is the standard method for delegating permissions within the same account or across accounts.

            -   **Prerequisites**:

                1.  **IAM Role:** An IAM Role must exist with the desired permissions (via a permissions policy).
                2.  **Role Trust Policy:** The Role's **Trust Policy** must explicitly allow the IAM User to assume it. This is done by specifying the IAM User's ARN in the `Principal` element of the trust policy, allowing the `sts:AssumeRole` action.
                    ```json
                    {
                        "Version": "2012-10-17",
                        "Statement": [
                            {
                                "Effect": "Allow",
                                "Principal": {
                                    "AWS": "arn:aws:iam::123456789012:user/target-user"
                                },
                                "Action": "sts:AssumeRole"
                            }
                        ]
                    }
                    ```
                3.  **IAM User Permissions:** The IAM User must have an **identity-based policy** that grants them the `sts:AssumeRole` permission on the specific Role ARN.

            -   **AWS CLI Example**: The IAM User uses their own long-term credentials to call the `assume-role` command, specifying the Role they want to assume:

                ```bash
                aws sts assume-role \
                    --role-arn arn:aws:iam::123456789012:role/TargetRoleName \
                    --role-session-name AWSCLI-Session
                ```

                -   `--role-arn`: The Amazon Resource Name (ARN) of the Role you want to assume.
                -   `--role-session-name`: A unique identifier for the session (visible in CloudTrail logs).

                **Output:** The command returns an `AssumedRoleUser` object and a `Credentials` object containing the temporary `AccessKeyId`, `SecretAccessKey`, and `SessionToken`.

            -   **Next Step**: Once you receive the temporary credentials (Access Key ID, Secret Access Key, and Session Token), you must set them as environment variables or configure them in your AWS CLI/SDK profile to use them for subsequent AWS API calls.

        </details>

    -   <details><summary style="font-size:20px;color:#C71585">Instance Profile</summary>

        > An instance profile is an AWS Identity and Access Management (IAM) entity that allows EC2 instances to obtain temporary AWS credentials and interact with other AWS services. It acts as a bridge between an IAM role and an EC2 instance, facilitating secure access to AWS resources.
        > An instance profile is a container for an IAM role that you can use to pass role information to an EC2 instance when it is launched.
        > An instance profile is associated with only one IAM role, and it allows EC2 instances to assume the role and obtain temporary credentials.

        -   **Create an Instance Profile**:

            -   An instance profile is created in IAM and is associated with the IAM role.
            -   You can create an instance profile using the AWS Management Console, AWS CLI, or AWS SDKs.

        -   **Associate the Instance Profile with an EC2 Instance**:

            -   When launching an EC2 instance, specify the instance profile.
            -   The instance profile enables the EC2 instance to assume the IAM role and obtain temporary credentials from the AWS Security Token Service (STS).

        -   **Access AWS Services**:

            -   Once the EC2 instance has assumed the role through the instance profile, it can use the temporary credentials to access AWS services based on the permissions defined in the role's policies.

        </details>


    -   **IAM Users**: An **IAM user** is an identity with specific permissions within an AWS account. IAM users are used to represent individuals or services that need to interact with AWS resources.

        -   **Attributes**:
            -   **Login credentials**: Users can have a username and password for the AWS Management Console and access keys for API access.
            -   **Permissions**: Users can be assigned policies that define what actions they are allowed to perform.
            -   **Best practice**: For individuals, create IAM users instead of sharing the root account credentials.
        -   **Federated Users**: Federated users are users that are authenticated by an external identity provider (IdP). AWS supports various IdPs, such as Active Directory, Google, or Facebook to grant temporary access to AWS resources. This allows you to integrate existing authentication systems with AWS, reducing the need to create separate IAM users for each individual. Federated users can be granted access to AWS resources using IAM roles.

    -   **IAM Groups**: An **IAM group** is a collection of IAM users. You can attach policies to groups to apply common permissions to multiple users at once. Users in a group inherit the permissions assigned to the group.

        -   **Attributes**:
            -   Simplifies the management of permissions.
            -   Commonly used to assign permissions based on job functions (e.g., Admins, Developers, and Read-Only Users).

    -   **IAM Access Keys**: **Access keys** are credentials that IAM users or roles use to make programmatic requests to AWS APIs. These consist of:
        Access keys consist of an access key ID and a secret access key. They are used to authenticate an AWS API request made by an IAM user, an AWS service, or an application.

        -   **Access Key ID**: A unique identifier.
        -   **Secret Access Key**: A secret key that is used with the access key ID to sign requests securely.

        -   **Attributes**:
            -   **Best practice**: Rotate keys regularly, and avoid embedding them directly into code (use tools like AWS Secrets Manager).
            -   **Usage**: Typically used for CLI or API access to AWS services.

    -   **IAM Identity Providers**: **IAM identity providers** allow users from an external identity system (such as corporate directories or web identity providers) to access AWS resources without creating an IAM user for each one.

        -   **Types of Identity Providers**:
            -   **SAML 2.0**: Integrates with corporate directories like Microsoft Active Directory for single sign-on (SSO).
            -   **Web Identity Federation**: Supports providers like Google, Facebook, and Amazon for web identity-based authentication.
            -   **OIDC (OpenID Connect)**: Allows external identity providers that support the OIDC standard to be used for access to AWS.

    -   **IAM Permissions Boundaries**: A **permissions boundary** is a feature that allows you to define the maximum permissions an IAM role or user can have. Even if the user or role has broader permissions in their assigned policies, they cannot exceed the permissions set in the boundary.

        -   **Attributes**:
            -   Useful for limiting permissions that roles or users can grant to themselves or others.
            -   Helps prevent privilege escalation attacks.

    -   **Multi-Factor Authentication (MFA)**: MFA adds an extra layer of security by requiring users to enter a second form of authentication (e.g., one-time passcode) in addition to their credentials.

        Multi-Factor Authentication (MFA) adds an extra layer of security to your AWS account. It requires users to provide a second form of authentication, such as a one-time password generated by a hardware or software token.

        -   **Attributes**:
            -   **Virtual MFA devices**: Can be implemented using applications like Google Authenticator.
            -   **Hardware MFA devices**: AWS supports physical MFA devices like hardware tokens.

    -   **Best Practices for AWS IAM**:

        -   Use **IAM roles** instead of IAM users for accessing AWS resources when possible.
        -   Implement **Multi-Factor Authentication (MFA)** for all privileged accounts.
        -   Follow the **principle of least privilege**: Assign only the permissions necessary for the task.
        -   Regularly rotate **access keys** and monitor usage with IAM credential reports.
        -   Use **permissions boundaries** to limit the scope of permissions assigned to roles and users.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Lambda Function</summary>

    > AWS Lambda is a serverless computing service provided by Amazon Web Services (AWS) that allows users to run their code without having to manage servers or infrastructure. Here are some key terms and concepts related to AWS Lambda:
    > AWS Lambda is a serverless computing service that automatically runs code in response to events, managing the underlying compute infrastructure. It allows you to execute your code without provisioning or managing servers, enabling you to focus solely on your application logic. Here are the main concepts and components of AWS Lambda:
    > A **Lambda function** is the core concept of AWS Lambda. It is a piece of code that you write and deploy, which AWS Lambda automatically executes in response to events or triggers.

    -   **Lambda Definition in Terraform**:

        ```ini
        resource "aws_lambda_function" "sqs_processor" {
            function_name    = "sqs-processor"
            description      = "Processes messages from SQS and performs analysis tasks"
            runtime          = "python3.9"
            role             = aws_iam_role.lfn_analysis_role.arn
            handler          = "lambda_handler.sqs_processor_handler"
            filename         = data.archive_file.lambda_zip.output_path
            source_code_hash = data.archive_file.lambda_zip.output_base64sha256

            memory_size = 512 # Default is 128 MB, can be set between 128 MB and 10,240 MB
            timeout     = 120 # Default is 3 seconds, can be set up to 900 seconds (15 minutes)

            architectures = ["x86_64"] # Default is "x86_64", other option is "arm64"

            ## Reserved Concurrency (max limit)
            #   reserved_concurrent_executions = 9

            # Whether to publish creation/change as new Lambda Function Version. Defaults to false.
            publish = false

            layers = [aws_lambda_layer_version.lfn_layer.arn]
            vpc_config {
                # subnet_ids         = [for s in aws_subnet.detf_subnets : s.id]
                subnet_ids         = values(var.subnets)
                security_group_ids = [aws_security_group.lambda_analysis_sg.id]
            }

            file_system_config {
                arn              = aws_efs_access_point.lfn_analysis_file_access_point.arn
                local_mount_path = "/mnt/efs"
            }

            # Increase `/tmp` storage to 5GB
            ephemeral_storage {
                size = 512 # Default is 512 MB, can be set up to 10,240 MB (10 GB)
            }

            # Enable SnapStart for faster cold starts
            snap_start {
                apply_on = "None" # Default is "None"; other option is "PublishedVersions"
            }

            environment {
                variables = {
                INPUT_QUEUE_URL   = aws_sqs_queue.input_queue.id
                FAILURE_QUEUE_URL = aws_sqs_queue.failure_queue.id
                SUCCESS_TOPIC_ARN = aws_sns_topic.success_topic.arn
                PROJECT           = "Lambda Analysis"
                }
            }

            tags = {
                Name    = "sqs-processor"
                Project = "${var.project}-sqs-processor"
            }

            depends_on = [aws_efs_mount_target.lfn_analysis_efs_mnt_target]
        }

        ```

    -   **Components**:

        -   **Code**: Written in supported languages (Python, Node.js, Java, Go, Ruby, C#, etc.).
        -   **Handler**: The entry point of the Lambda function, where the execution begins.
        -   **Deployment Package**: Includes your code and any dependencies in a zip file or a container image (if using container-based Lambda).

    -   <details><summary style="font-size:20px;color:Magenta">Function Configuration</summary>

        Each Lambda function has a set of configurations that define how it behaves, including memory, timeout, and concurrency settings.

        1. **Basic Settings**

            - **Function Name**:

                - The name assigned to the function, which must be unique within an AWS Region and account.

            - **Runtime**:

                - Specifies the programming language and version that the Lambda function will use (e.g., Python 3.9, Node.js 18.x, Java 11).
                - AWS Lambda manages and updates runtimes, but deprecated versions eventually lose support, so updating periodically is crucial.

            - **Execution Role & Policies**:

                - Lambda functions require an **Identity and Access Management (IAM) role** with permissions to interact with AWS resources.
                - The role grants the function access to resources such as S3 buckets, DynamoDB tables, or the CloudWatch Logs service where function logs are stored.
                - Following the principle of least privilege, the role should have the minimum permissions needed.
                - `Resource-Based Policies`: Lambda functions can have resource-based policies to control which AWS accounts or services can invoke the function. This is especially useful for cross-account or cross-service access, like allowing an S3 bucket from another account to trigger a Lambda function.

            - **Handler**:
                - Defines the entry point of the function. The handler is a function within your code that AWS Lambda calls to start execution.
                - The format is typically `filename.method_name` (e.g., `lambda_function.lambda_handler`), where `lambda_function` is the filename and `lambda_handler` is the method name.

        2. **Memory and Timeout**

            - **Memory Allocation**:

                - The memory (in MB) allocated to a Lambda function can range from 128 MB to 10 GB, in increments of 1 MB.
                - More memory usually results in more **CPU** and **network bandwidth** allocation, which can speed up execution but also increase costs.
                - Lambda pricing is based on memory and execution time, so optimizing memory for performance and cost balance is essential.

            - **Timeout**:

                - The maximum time that a Lambda function can run per invocation, with a range from 1 second to 15 minutes (900 seconds).
                - If the function exceeds the timeout, it is terminated, so setting an appropriate timeout based on expected execution duration is critical to prevent early termination.
                - Specifies the maximum duration for function execution. Lambda terminates the function if it exceeds this time, ensuring resource cleanup and preventing long-running executions.

            - **Retry Policies**:
                - You can configure retry policies for asynchronous invocations and event source mappings. These are useful for automatically handling transient failures, allowing your function more opportunities to complete.

        3. **Environment Variables**

            - Key-value pairs used to store configuration data or secrets needed by the function, such as API keys, database credentials, or resource configurations.
            - **Environment Variable Encryption**: By default, Lambda encrypts environment variables using AWS Key Management Service (KMS). You can also specify a custom KMS key for added security.

        4. **Networking**: AWS Lambda can be configured to run inside a **Virtual Private Cloud (VPC)**, allowing your function to access private resources like RDS or EC2 instances.

            - When you configure a Lambda function to connect to a VPC, you specify subnets and security groups to control network access.
            - Note that adding VPC connectivity may impact Lambda’s cold start time because it requires additional network setup.
            - `VPC Subnets`: Functions running in VPC can interact with private subnets and on-premises resources through a VPN or Direct Connect.
            - `VPC Endpoints`: Can be used to access AWS services privately without internet access.

        </details>

    -   <details><summary style="font-size:20px;color:Magenta">Event Source Mapping</summary>

        An **AWS Lambda Event Source Mapping (ESM)** is a Lambda resource that acts as a **managed poller** to connect stream-based and queue-based event sources to a Lambda function.

        It is a key component in Lambda's architecture that enables the **"Pull" model** for certain services, relieving you of the burden of writing and managing your own polling or consumption logic.

        ```ini
        resource "aws_lambda_event_source_mapping" "sqs_trigger" {
            function_name    = aws_lambda_function.sqs_processor.arn
            event_source_arn = aws_sqs_queue.input_queue.arn
            batch_size       = 10
            enabled          = true
            # 👉 Together, they define the retry policy: Lambda retries until either retry attempts are exhausted OR record age expires, whichever comes first.
            maximum_retry_attempts        = 0  # How many times to retry failed batches
            maximum_record_age_in_seconds = 60 # Maximum age of a record that Lambda sends to a function for processing; default is 60 seconds
        }
        ```

        ##### The Pull Model vs. Push Model

        The concept of the Event Source Mapping is best understood in the context of Lambda's two fundamental event invocation models:

        1. **The Push Model** (Direct Invocation): In this model, the AWS service itself is configured to **directly invoke** your Lambda function when an event occurs. The service "pushes" the event to Lambda.

            - **Examples:** Amazon S3 (on file upload), Amazon SNS, Amazon API Gateway, Amazon EventBridge.
            - **Role:** The invoking service is responsible for sending the event and handling invocation details (synchronous or asynchronous).

        2. **The Pull Model** (Event Source Mapping): In this model, the **Lambda service** is responsible for actively **reading (polling)** records or messages from the source and then invoking your function. The Event Source Mapping is the resource that defines this polling connection.
            - **Event Source Mapping:** This is the AWS resource you create. It tells the Lambda service:
                - _Where_ to poll (e.g., an SQS queue ARN or Kinesis Stream ARN).
                - _Which_ Lambda function to invoke with the records.
                - _How_ to handle the records (e.g., batch size, filtering, error handling).
            - **Examples:** Amazon DynamoDB Streams, Amazon Kinesis Data Streams (KDS), Amazon Simple Queue Service (SQS), Amazon Managed Streaming for Apache Kafka (Amazon MSK), Amazon MQ.

        ##### How Event Source Mapping Works

        For services that use the Pull Model, the ESM manages the following internal process:

        3.  **Polling:** The Lambda service creates dedicated **event pollers** (highly available and auto-scaling resources) that continuously poll the configured stream or queue for new records/messages.
        4.  **Batching and Filtering:** The pollers collect the messages into a **batch** based on your configured settings. Before invoking the function, you can optionally apply **filter criteria** to the batch payload to discard records that don't match your rules, which can reduce cost and complexity.
            -   **Batch Size:** The maximum number of records to include in a single invocation (e.g., up to 10,000 for SQS).
            -   **Batching Window:** The maximum amount of time Lambda waits to collect records before invoking the function (up to 300 seconds).
        5.  **Invocation:** Once a batch is ready (either the maximum size is reached, the batching window expires, or the payload size reaches 6 MB), the Lambda service **synchronously invokes** your Lambda function with the batch of records as the input event.
        6.  **Checkpointing/Deletion:**
            -   For **Streams** (Kinesis/DynamoDB), Lambda automatically manages the **iterator/checkpoint** for the stream shard. If processing is successful, the checkpoint is advanced.
            -   For **Queues** (SQS), if the function returns successfully (no error), Lambda automatically **deletes** the messages from the queue.

        ##### Error Handling and Control

        A major benefit of the ESM is its built-in error handling and flow control for the pull model sources:

        -   **Retries:** For streams (KDS/DynamoDB), if a function fails, the ESM automatically **retries** the batch. You can configure the number of retries (`MaximumRetryAttempts`) and whether to split the batch (`BisectBatchOnFunctionError`).
        -   **Maximum Age:** For streams, you can set the `MaximumRecordAgeInSeconds` to discard records that are too old, preventing a single bad record from blocking the processing of newer records (a "poison pill").
        -   **Concurrency Control:** You can control the number of concurrent batches processed from each shard (for streams) using the `ParallelizationFactor`.
        -   **Destinations:** For certain services (Kinesis, DynamoDB, SQS), you can configure an **on-failure destination** (e.g., an SNS topic or SQS queue) where the entire failed batch record is sent after all retries are exhausted.

        </details>

    -   <details><summary style="font-size:20px;color:Magenta">Synchronous Invocation & Asynchronous Invocation</summary>

        AWS Lambda functions can be invoked in two fundamental ways: **Synchronously** and **Asynchronously**. The choice between the two depends heavily on the application's requirements for response time, error handling, and whether an immediate response is required by the caller.

        ##### Synchronous Invocation

        In a **synchronous** invocation, the caller makes a request, the function is executed immediately, and the caller **waits** for the function to complete and return a response. This is the default invocation type.

        -   **How it Works**:

            1.  **Caller Sends Request:** The client (e.g., API Gateway, AWS CLI, AWS SDK, or another Lambda function) calls the Lambda `Invoke` API with `InvocationType` set to `RequestResponse` (the default).
            2.  **Immediate Execution:** AWS Lambda executes the function's code immediately.
            3.  **Caller Waits:** The calling client's connection remains open until the function finishes execution or times out.
            4.  **Response/Error:** When the function completes, Lambda returns the function's response payload (including the result or any error details) directly back to the caller. The API response HTTP status code is typically $\mathbf{200}$ for a successful invocation, regardless of errors within the function's code.

        -   **Key Characteristics**:

            -   **Response Time:** You get an **immediate** response with the result.
            -   **Error Handling:** The **caller is responsible** for handling function errors and implementing any necessary retry logic.
            -   **Payload Size:** Maximum input payload is **6 MB**.
            -   **Common Integrations:** AWS services that require an immediate response often use synchronous invocation, such as **Amazon API Gateway** (for REST APIs), **Elastic Load Balancers (ELB)**, and **AWS Step Functions**.
            -   **Use Case:** Ideal for real-time, user-facing operations like web APIs, data transformations where the result is immediately needed, or request-response style workflows.

        ##### Asynchronous Invocation

        In an **asynchronous** invocation, the caller makes a request, and the Lambda service takes the event, queues it for processing, and **returns an immediate acceptance response** without waiting for the function to execute. The function runs in the background.

        -   **How it Works**:

            1.  **Caller Sends Request:** The client calls the Lambda `Invoke` API with `InvocationType` set to `Event`.
            2.  **Lambda Queues Event:** The Lambda service immediately places the event onto an **internal, managed queue**.
            3.  **Immediate Response:** The caller receives an immediate $\mathbf{202}$ **ACCEPTED** status code, confirming the event was successfully queued, but containing no information about the function's execution result.
            4.  **Background Processing:** A separate Lambda process reads the event from the queue and invokes the function.
            5.  **Error Handling (Retries):** If the function fails (e.g., returns an error or times out), the Lambda service automatically **retries** the invocation **up to two more times** by default.
            6.  **Destinations:** For both successful and failed asynchronous executions (after all retries), you can configure **Lambda Destinations** (e.g., SQS, SNS, EventBridge, or another Lambda function) to receive an **invocation record** detailing the outcome.

        -   **Key Characteristics**:

            -   **Response Time:** The caller receives an **immediate** $\mathbf{202}$ status code; execution happens in the background.
            -   **Error Handling:** The **Lambda service manages retries**. Failed events can be sent to a **Dead-Letter Queue (DLQ)** or an **on-failure Destination** after retries are exhausted.
            -   **Payload Size:** Maximum input payload is **1 MB**.
            -   **Common Integrations:** AWS services that inherently operate in an event-driven, fire-and-forget manner, such as **Amazon S3** (on object creation), **Amazon SNS**, and **Amazon EventBridge**.
            -   **Use Case:** Perfect for background jobs, long-running processes (up to 15-minute timeout), non-critical tasks like sending emails, processing log files, or data aggregation where the caller doesn't need an immediate result.

        ##### Summary Comparison Table 📊

        | Feature                  | Synchronous Invocation                                  | Asynchronous Invocation                                                   |
        | :----------------------- | :------------------------------------------------------ | :------------------------------------------------------------------------ |
        | **Invocation Type**      | `RequestResponse` (Default)                             | `Event`                                                                   |
        | **Caller Waits**         | **Yes** (Blocks until execution finishes or times out)  | **No** (Returns immediately)                                              |
        | **Response Code**        | $\mathbf{200}$ (Includes function result/error details) | $\mathbf{202}$ (Accepted/Queued)                                          |
        | **Retry Responsibility** | **Caller** must implement retries                       | **Lambda Service** manages retries (up to 2 attempts for function errors) |
        | **Intermediary**         | None (Direct Call)                                      | **Internal Queue** managed by Lambda                                      |
        | **Max Payload Size**     | 6 MB                                                    | 1 MB                                                                      |
        | **Recommended For**      | Real-time APIs, user-facing requests                    | Background tasks, event-driven workflows, long-running processes          |

        </details>

    -   <details><summary style="font-size:20px;color:Magenta">AWS Lambda Destinations</summary>

        AWS Lambda Destinations is a powerful feature that provides **visibility, routing, and control** over the results of a Lambda function's **asynchronous invocation**. It allows you to automatically send a detailed **execution record** to a downstream service based on whether the function invocation was successful or failed, all without writing extra code in your function.

        ```ini
        resource "aws_lambda_function_event_invoke_config" "lambda_destinations" {
            function_name = aws_lambda_function.gpc_cuckoo.function_name

            # 👉 Together, they define the retry policy: Lambda retries until either retry attempts are exhausted OR event age expires, whichever comes first.
            maximum_event_age_in_seconds = 21600 # Event age (in seconds) after which Lambda discards the event. Default is 6 hours (21600 seconds)
            maximum_retry_attempts       = 0     # Retry attempts (0 means no retry) on failure

            destination_config {
                on_failure { destination = aws_sqs_queue.failure_queue.arn }
                on_success { destination = aws_sns_topic.success_topic.arn }
            }
        }
        ```

        ##### Primary Purpose and Scope

        The core function of Lambda Destinations is to simplify the building of **event-driven workflows** and enhance **error handling** for non-real-time applications.

        -   **Applicable Invocations:** Destinations are primarily for **asynchronous invocations** (when using `InvocationType: Event`), where the caller doesn't wait for the result (e.g., from SNS, S3, or a direct asynchronous invoke).
        -   **Execution Record:** Instead of just sending the original event, the destination receives a full **invocation record** which is a JSON document containing:
            -   The **request payload** (the original event).
            -   The **response payload** (the function's return value on success, or error details like stack traces on failure).
            -   Contextual information (source ARN, destination ARN, Request ID, function version).
        -   **Zero Code Integration:** The routing is configured entirely on the Lambda function itself, decoupling the post-execution logic from the function's business logic.

        ##### Configuration and Targets

        You can configure two separate destinations for a single Lambda function:

        1. **On Success (`OnSuccess`)**: If the function is invoked asynchronously and successfully completes (returns without an exception) after all retries are exhausted, the execution record is sent to this destination.

            - **Use Cases:** Chaining functions together asynchronously, notifying a successful completion, or logging the final result.

        2. **On Failure (`OnFailure`)**: If the function is invoked asynchronously and fails (throws an exception or times out) after exhausting the configured retry attempts or exceeding the maximum event age, the failure record is sent to this destination.

            - **Use Cases:** Automated error investigation, sending a notification to an operations team, or triggering a cleanup workflow.

        -   **Supported Destination Targets**: Lambda Destinations can route the execution record to the following services:

            | Destination Target          | Data Format                                                          |
            | :-------------------------- | :------------------------------------------------------------------- |
            | **Another Lambda Function** | The record is passed as the **payload** to the destination function. |
            | **Amazon SQS**              | The record is passed as the **message body** to the queue.           |
            | **Amazon SNS**              | The record is passed as the **message** to the topic.                |
            | **Amazon EventBridge**      | The record is passed as the **Detail** in the `PutEvents` call.      |

        ##### Destinations vs. Dead Letter Queues (DLQ)

        Lambda Destinations are generally the **preferred solution** for asynchronous error handling, offering significant advantages over the older Dead Letter Queue (DLQ) mechanism configured directly on the function.

        | Feature              | Lambda Destination (OnFailure)                                                        | Dead Letter Queue (DLQ)                                                 |
        | :------------------- | :------------------------------------------------------------------------------------ | :---------------------------------------------------------------------- |
        | **Triggered When**   | Failure after **all retries** are exhausted (or event age is exceeded).               | Failure after **all retries** are exhausted (or event age is exceeded). |
        | **Targets**          | Lambda Function, SQS, SNS, EventBridge.                                               | SQS or SNS only.                                                        |
        | **Payload Content**  | **Execution Record** (includes original event **and** function response/stack trace). | **Original Event Payload** only.                                        |
        | **Success Handling** | **Supported** via `OnSuccess` configuration.                                          | **Not Supported** (Failure only).                                       |

        While a DLQ is simpler, a Destination gives you the full context of _why_ the function failed (the stack trace) and _what_ the original request was, enabling much richer error handling and automated recovery.

        </details>

    -   <details><summary style="font-size:20px;color:Magenta">Concurrency and Scaling</summary>

        **Concurrency** in AWS Lambda refers to the number of instances (or executions) of a function that can run simultaneously. AWS Lambda is inherently scalable and can handle multiple invocations in parallel, but understanding how concurrency works is crucial for ensuring predictable scaling behavior. You can manage concurrency to control costs and limit resource usage. AWS Lambda’s concurrency and scaling capabilities are essential for building scalable, serverless applications. Here’s a breakdown of key terms and concepts related to concurrency and scaling in AWS Lambda:

        1.  **Concurrency Limit**:

            -   AWS Lambda has default concurrency limits, which can be adjusted within AWS account settings. This limit is important for managing the maximum number of concurrent executions your account can have across all Lambda functions.
            -   Concurrency settings help ensure that Lambda functions don't overwhelm downstream services, databases, or other resources by invoking too many instances at once.

        2.  **Reserved Concurrency**:

            -   Reserved concurrency is the maximum number of concurrent executions that a specific Lambda function can handle. This is an optional configuration that isolates a portion of account-wide concurrency for a specific Lambda function.
            -   For example, if you reserve concurrency of `50` for one Lambda function, AWS guarantees that up to 50 concurrent executions of that function will run, while preventing it from using more than 50 concurrent executions and consuming resources that other functions need.

        3.  **Provisioned Concurrency**:

            -   Provisioned concurrency is a feature designed to reduce the latency of Lambda functions. It pre-warms a specific number of instances to ensure they are immediately available when requests arrive, preventing cold starts (the delay from initializing resources when a function is first invoked).
            -   This is particularly useful for applications where low latency is critical, such as interactive applications or APIs that require consistent response times.

        4.  **Cold Start**

            -   A **cold start** occurs when AWS Lambda needs to initialize a new environment for an incoming request. When a Lambda function is invoked, AWS must set up resources such as the execution environment, runtime, and dependencies.
            -   Cold starts can lead to latency in the initial request. For functions that require low latency, cold starts can be mitigated by using **Provisioned Concurrency** or by periodically invoking the function to keep it "warm."

        5.  **Auto Scaling**

            -   AWS Lambda automatically scales based on the number of incoming requests and concurrency limits. When more requests arrive than existing Lambda instances can handle, AWS Lambda automatically scales up by creating new instances.
            -   This process is automatic and can handle bursts of traffic efficiently, but scaling is limited by **concurrency configurations**, **reserved concurrency**, and **account-wide concurrency quotas**.

        6.  **Burst Concurrency**

            -   **Burst concurrency** is the initial scaling capacity that AWS Lambda provides within a short time for functions within a particular AWS Region.
            -   AWS Lambda can initially handle a burst of 500 to 3000 concurrent requests per second (depending on the Region). After this burst, Lambda gradually scales up at a rate of 500 additional concurrent invocations per minute until it reaches the maximum concurrency limit of the AWS account.

        7.  **Throttling**

            -   Throttling occurs when AWS Lambda exceeds its maximum concurrency limit (either at the account level or at the function level through reserved concurrency).
            -   When throttling happens, additional requests to a Lambda function are rejected with a `429 TooManyRequests` error. To handle this, the calling service (like API Gateway or SQS) can implement retry logic, or you can increase concurrency limits if throttling is frequent.

        8.  **Scaling Behavior and Invocation Model**

            -   **Synchronous Invocations**:
                -   In synchronous invocations (like those triggered by API Gateway, AWS SDK, or application integrations), Lambda returns the response immediately after execution, and the caller waits for the function to complete.
                -   When the request rate exceeds the function’s concurrency limit, new synchronous invocations are throttled.
            -   **Asynchronous Invocations**: For asynchronous invocations (like those triggered by S3 or CloudWatch Events), Lambda queues the events. It then retries these events if they fail or are throttled until they succeed or until Lambda exhausts the retry limit.
            -   **Event Source Mapping**: When integrating Lambda with services like Amazon SQS or Kinesis (stream-based services), Lambda reads and processes events as they arrive in the source. The scaling of Lambda for these integrations is determined by the event source's processing characteristics and partitioning.

        9.  **Lambda Scaling with Event Sources**

            -   **Amazon SQS**: Lambda can process up to 10 messages at a time from a single Amazon SQS queue and scales horizontally as the number of messages increases, limited by concurrency.
            -   **Amazon Kinesis and DynamoDB Streams**:
                -   Lambda scaling with Kinesis or DynamoDB streams is partitioned. AWS Lambda processes records from each shard or partition concurrently, but only one Lambda instance can process data from a specific shard at a time.
                -   The number of shards defines the maximum concurrency Lambda can achieve with these sources, so you may need to increase the shard count if the function requires greater concurrency.

        10. **Concurrency Scaling Considerations**: Concurrency affects costs, latency, and performance, so configuring concurrency properly is key to balancing efficiency and cost in AWS Lambda:

            -   **Cost**: Each instance adds cost, so unbounded concurrency can lead to high expenses. Reserved and provisioned concurrency options give finer control over costs.
            -   **Latency**: Low-latency applications may need provisioned concurrency to avoid cold starts.
            -   **Throttling Impact**: Throttling at peak times can cause delays or errors in applications, making it important to monitor concurrency usage and plan capacity according to traffic patterns.

        11. **Monitoring and Scaling Metrics**: AWS provides metrics in CloudWatch that help in monitoring and tuning Lambda function scaling:
            -   **ConcurrentExecutions**: Shows the total concurrent executions in the account.
            -   **UnreservedConcurrentExecutions**: Reflects concurrency left after reserved concurrency allocations.
            -   **Throttles**: Indicates throttling events due to exceeded concurrency limits, helping identify scaling needs.

        </details>

    -   <details><summary style="font-size:20px;color:Magenta">Lambda Throttling</summary>

        Lambda throttling is a mechanism used in AWS Lambda to limit the rate at which function executions can occur. This mechanism helps protect your resources and ensures the smooth operation of your AWS infrastructure by preventing a Lambda function from being overwhelmed with excessive requests. AWS Lambda provides two types of throttling:

        -   `Concurrent Execution Throttling`:

            -   Concurrent execution throttling limits the number of function executions that can run simultaneously. AWS imposes a default concurrency limit on your AWS account and can adjust this limit upon request.
            -   When the limit is reached, AWS will queue any additional invocation requests. These queued requests will be processed as soon as existing executions complete and resources become available. Throttled invocations do not result in errors; they are simply delayed.
            -   You can view and modify the concurrent execution limit for a specific function in the AWS Lambda Management Console.

        -   `Invocation Throttling`:

            -   Invocation throttling occurs when you send too many requests to invoke a Lambda function in a short period. This can happen when you repeatedly call the function with a high request rate.
            -   AWS enforces soft limits on the number of requests per second (RPS) that can be sent to a function. If you exceed these soft limits, AWS may throttle your requests, resulting in delays and retries.
            -   To mitigate invocation throttling, you can:
                -   Implement exponential backoff and retries in your code to handle throttled requests gracefully.
                -   Request a limit increase from AWS Support if your workload requires a higher request rate.

        -   `Implement Retries`: Build retry logic with exponential backoff into your Lambda client code to handle throttled requests and retries automatically.
        -   `Error Handling`: Check for error codes in the Lambda response to detect throttled invocations and take appropriate action.
        -   `Throttle Metrics`: Monitor CloudWatch metrics, such as `Throttles` and `ThrottleCount` to gain insight into the rate of throttled invocations.
        -   `Limit Increases`: If you anticipate higher traffic, request a concurrency limit increase from AWS Support. Ensure that your architecture and resource usage can handle the increased load.
        -   `Batch Processing`: If you're processing large numbers of records, consider batch processing to reduce the rate of function invocations.
        -   `Distributed Workloads`: Distribute workloads across multiple Lambda functions to avoid overwhelming a single function.
        -   `Provisioned Concurrency`: Consider using AWS Lambda Provisioned Concurrency to pre-warm your functions, ensuring that they can handle surges in traffic without experiencing cold start delays.

        </details>

    -   <details><summary style="font-size:20px;color:Magenta">Terms & Concepts</summary>

        1. **Dead Letter Queue (DLQ)**

            - Specifies an Amazon SQS queue or an Amazon SNS topic as a **Dead Letter Queue** for asynchronous invocation errors.
            - When a Lambda function cannot process an event after a certain number of retries, the event is sent to the DLQ for later analysis or reprocessing.
            - Useful for handling errors gracefully, ensuring events aren’t lost.

        2. **Error Handling and Retry Policies**

            - **Asynchronous Invocation**: Lambda automatically retries asynchronous invocations (e.g., from S3, SNS, CloudWatch) up to two times if there’s an error. You can configure the retry attempts to 0, 1, or 2.
            - **Event Source Mapping**: For sources like SQS, Kinesis, and DynamoDB streams, Lambda retries until the message expires, is processed successfully, or is moved to a **destination** or **DLQ** after a set number of attempts.
            - **Destinations**: With **AWS Lambda destinations**, you can route successful or failed asynchronous invocations to an SNS topic, SQS queue, EventBridge, or another Lambda function, which allows for advanced error handling and processing workflows.

        3. **Logging and Monitoring**: AWS Lambda integrates with **Amazon CloudWatch** for logging, monitoring, and observability.

            - `CloudWatch Logs`: Every function invocation produces logs, which can be viewed and monitored through CloudWatch. Lambda sends logs of function execution (including errors, timeouts, and custom logs) to Amazon CloudWatch by default. These logs are useful for debugging, monitoring, and performance tuning.
            - `X-Ray Tracing`: AWS X-Ray provides insights into function performance and latency by tracing requests as they pass through the application. It helps pinpoint bottlenecks, understand dependencies, and monitor overall performance.

            - `Invocations`: The number of times a function is called.
            - `Errors`: The number of errors that occurred during function execution.
            - `Duration`: The time it took for the function to execute.
            - `Throttles`: The number of times the function was throttled due to reaching the concurrency limit.

        4. **File System (EFS) Configuration**

            - **Amazon EFS (Elastic File System)**:
                - Allows Lambda functions to access a persistent file system across function invocations. This is helpful for functions that require shared storage, such as large models or datasets.
                - EFS can be mounted on Lambda functions configured within a VPC, and it’s useful for stateful workloads or functions with large code dependencies that exceed Lambda’s 10 GB limit.

        5. **Function Code Configuration**

            - **Deployment Package**:
                - A Lambda function’s deployment package contains the function code and dependencies, packaged in a `.zip` file or container image.
                - **Layers**: Lambda layers let you share code, libraries, or binaries across multiple Lambda functions without including them in each function’s deployment package. Up to 5 layers can be used per function, reducing package size and simplifying maintenance.
            - **Container Images**:
                - Lambda supports container images up to 10 GB, allowing you to package code and dependencies in Docker images for more complex applications or specific runtime requirements.
                - Images are stored in Amazon ECR and provide a way to deploy large applications with custom runtimes or dependencies.

        6. **Aliases and Versions**

            - **Versions**: Lambda functions can be versioned, with each published version being immutable. Versions allow you to reference specific function code and configuration states, providing stability for production applications.
            - **Aliases**: An alias is a pointer to a specific function version, often used to manage different environments (e.g., `dev`, `test`, `prod`). Aliases allow routing traffic between versions and enable canary deployments by splitting traffic to different versions.

        7. **Event Sources / Triggers**: **Event sources** are AWS services or external systems that generate events that can trigger a Lambda function to execute. These triggers define when and how Lambda functions are invoked.

            - **Common Event Sources**:
                - **S3**: Lambda can trigger when an object is created or deleted in an S3 bucket.
                - **API Gateway**: Lambda can be invoked via HTTP requests, making it suitable for serverless APIs.
                - **SNS (Simple Notification Service)**: Lambda can process messages from SNS.
                - **SQS (Simple Queue Service)**: Lambda can process messages from SQS queues.
                - **CloudWatch Events**: Lambda can trigger on scheduled events or based on system events (e.g., EC2 instance state change).
                - **DynamoDB Streams**: Lambda can trigger on changes in DynamoDB tables.

        8. **Lambda Execution Environment**: The **execution environment** is the runtime in which Lambda functions run. AWS Lambda automatically manages the environment that runs your code, scaling it based on demand.

            - **Features**:
                - **Isolated environment**: Functions run in isolated environments to ensure security.
                - **Runtime management**: AWS manages the language runtime and updates it.
                - **Environment variables**: Allows the use of environment variables for dynamic configuration.

        9. **Lambda Layers**: **Lambda layers** allow you to package external libraries, dependencies, or configuration files separately from your function code. These layers can be shared across multiple Lambda functions, reducing code duplication and improving maintainability.

            - **Features**:
                - You can include libraries, custom runtimes, or configuration data.
                - You can use up to 5 layers per Lambda function.
                - Layers can be reused by multiple Lambda functions or shared across accounts.

        10. **Lambda Pricing Model**: AWS Lambda follows a pay-per-use model, where you're charged based on the number of function invocations and the compute time used.

            - **Pricing Factors**:
                - **Number of invocations**: Charged for every request.
                - **Compute time**: Charged based on the function's memory and execution duration, measured in milliseconds.

        11. **AWS Lambda@Edge**: **Lambda@Edge** is an extension of AWS Lambda that allows you to run code closer to users (at Amazon CloudFront edge locations), reducing latency for global users.

            - **Features**:
                - Modify content delivery and customize responses for users.
                - Perform operations like URL rewrites, header manipulations, and cache key customizations.

        </details>

    -   <details><summary style="font-size:20px;color:Magenta">Features of Lambda Function</summary>

        -   `Serverless Execution`: AWS Lambda allows you to run your code without managing servers. You upload your code, and AWS Lambda takes care of provisioning and scaling the infrastructure needed to execute it.
        -   `Event-Driven Execution`: Lambda functions can be triggered by various AWS services or custom events. Examples of triggers include changes to data in an S3 bucket, updates to a DynamoDB table, or HTTP requests through API Gateway.
        -   `Supported Runtimes`: Lambda supports multiple programming languages, known as runtimes. These include Node.js, Python, Java, Ruby, Go, .NET, and custom runtimes through the use of custom execution environments.
        -   `Automatic Scaling`: Lambda automatically scales your applications in response to incoming traffic. Each function can scale independently, and you pay only for the compute time consumed.
        -   `Built-in Fault Tolerance`: AWS Lambda maintains compute capacity, and if a function fails, it automatically retries the execution. If a function execution fails repeatedly, Lambda can be configured to send the event to a Dead Letter Queue (DLQ) for further analysis.
        -   `Integrated Logging and Monitoring`: Lambda provides built-in logging through Amazon CloudWatch. You can monitor the performance of your functions, view logs, and set up custom CloudWatch Alarms to be notified of specific events or issues.
        -   `Environment Variables`: Lambda allows you to set environment variables for your functions. These variables can be used to store configuration settings or sensitive information, such as API keys.
        -   `Execution Role and Permissions`: Each Lambda function is associated with an IAM (Identity and Access Management) role that defines the permissions needed to execute the function and access other AWS resources.
        -   `Stateless Execution`: Lambda functions are designed to be stateless. However, you can store persistent data using other AWS services like Amazon S3, DynamoDB, or AWS RDS.
        -   `Cold Starts and Warm Containers`: Cold starts occur when a function is invoked for the first time or when there is a need to scale. Subsequent invocations reuse warm containers, reducing cold start times.
        -   `VPC Integration`: Lambda functions can be integrated with a VPC, allowing them to access resources inside a VPC, such as databases, and allowing private connectivity.
        -   `Cross-Region Execution`: You can configure Lambda functions to run in different AWS regions, providing flexibility and redundancy.
        -   `Versioning and Aliases`: Lambda supports versioning and aliases, allowing you to manage different versions of your functions and direct traffic to specific versions.
        -   `Maximum Execution Duration`: Each Lambda function has a maximum execution duration (timeout) that can be set. If the function runs longer than the specified duration, it is terminated.
        -   `Immutable Deployment Packages`: Once a Lambda function is created, its deployment package (code and dependencies) becomes immutable. If you need to make changes, you create a new version of the function.

        </details>

    -   <details><summary style="font-size:20px;color:Magenta">Limitation on Lambda Functions</summary>

        -   `Execution timeout`: The maximum execution time for a Lambda function is `900 seconds (15 minutes)`.
        -   `Concurrent executions`: By default, there is a soft `limit of 1,000 concurrent executions per account per region`. However, you can request a higher limit if you need it.
        -   `Environment variables`: You can set environment variables for your Lambda function, but `the maximum size of all environment variables combined is 4 KB`.

        -   `Deployment package size`: `The maximum compressed deployment package size for a Lambda function is 50 MB`. There are some exceptions for certain runtimes, as outlined in my previous answer.

            -   Uncompressed code & dependencies < 250 MB
            -   Compressed function package < 50MB
            -   Total function packages in a region < 75 GB
            -   Ephemeral storage < 512 MB
            -   Maximum execution duration < 900 seconds
            -   Concurrent Lambda functions < 1000

        -   `Memory allocation`: Up to 10 GB of memory to a Lambda function. The amount of memory you allocate also determines the amount of CPU and network resources that the function gets.
            -   `Memory allocation`: Up to 10 GB of memory starting from 128 MB with CPU 3GB.
        -   `Execution environment`: Lambda functions run in a stateless execution environment, so you can't store data on the local file system. However, you can use other AWS services like S3 or DynamoDB to store data.
        -   `Function invocations`: You can trigger a Lambda function in several ways, including through `API Gateway`, `S3 events`, `SNS notifications`, and more. However, there may be some limits or quotas on the number of invocations you can make in a given period.

        </details>

    -   <details><summary style="font-size:20px;color:Magenta">Usecases of Lambda</summary>

        AWS Lambda is a serverless compute service that lets you run code without provisioning or managing servers. It's often used for various use cases across different industries. Here are the top five most common use cases for AWS Lambda:

        -   **Event-Driven Processing**: AWS Lambda is frequently used to process events from various AWS services, such as Amazon S3, Amazon DynamoDB, Amazon SNS, Amazon SQS, and more. For example, you can trigger Lambda functions to process new objects uploaded to an S3 bucket, process messages from an SQS queue, or react to changes in a DynamoDB table.

        -   **Real-time File Processing**: Lambda functions can be used for real-time processing of data streams. For instance, you can use Lambda to analyze streaming data from Amazon Kinesis Data Streams or process logs from Amazon CloudWatch Logs in real-time.

        -   **Backend for Web Applications**: Lambda functions can serve as the backend for web applications, providing scalable and cost-effective compute resources. You can build APIs using AWS API Gateway and trigger Lambda functions to handle incoming HTTP requests, allowing you to build serverless web applications without managing infrastructure.

        -   **Scheduled Tasks and Cron Jobs**: Lambda functions can be scheduled to run at specific intervals using AWS CloudWatch Events. This allows you to automate tasks such as data backups, log archiving, or regular data processing jobs without needing to maintain dedicated servers or cron jobs.

        -   **Data Processing and ETL**: Lambda functions are commonly used for data processing and ETL (Extract, Transform, Load) tasks. You can trigger Lambda functions to process data as soon as it becomes available, perform transformations on the data, and then load it into a data warehouse or database. This approach enables real-time or near-real-time data processing without the need for complex infrastructure.

        </details>

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">EC2</summary>

    -   [DigitalCloud: EC2](https://www.youtube.com/watch?v=8bIW7qlldLg&t=108s)

    Amazon Elastic Compute Cloud (Amazon EC2) is a web service provided by Amazon Web Services (AWS) that allows users to rent virtual servers on which they can run their applications. Below are some key terms and concepts associated with AWS EC2:

    Amazon EC2 (Elastic Compute Cloud) is a central service in AWS that provides scalable computing capacity in the cloud. It allows users to launch virtual servers (instances) with flexible configurations. Below is an explanation of all the components and concepts associated with AWS EC2:

    -   **EC2 Instance**: An instance is a virtual server in the cloud. It represents the computing resources (CPU, memory, storage, etc.) that you can rent from AWS. Instances are the fundamental building blocks of EC2.

        -   **Definition**: A virtual server that runs on the AWS cloud infrastructure. You can choose the hardware specifications, OS, and applications.
        -   **Purpose**: EC2 instances provide compute resources for running applications, processing data, or hosting services.
        -   **Key Attributes**:
            -   **vCPU**: Virtual CPU capacity.
            -   **RAM**: Memory for applications.
            -   **Network**: Networking performance (low, medium, or high bandwidth).

    -   **Amazon Machine Image (AMI)**: An AMI is a pre-configured template used to create instances. It contains the necessary information to launch an instance, including the operating system, application server, and applications.

        -   **Definition**: A pre-configured template containing the operating system, application server, and applications for launching EC2 instances.
        -   **Purpose**: AMIs allow you to create consistent EC2 instances based on a saved image.
        -   **Types**:
            -   **AWS-provided**: Amazon offers base AMIs (e.g., Amazon Linux, Ubuntu).
            -   **Custom**: Users can create custom AMIs with specific software configurations.
            -   **Marketplace AMIs**: Third-party vendors offer AMIs with specific software solutions.

    -   **Instance Types**

        -   **Definition**: Pre-defined combinations of CPU, memory, storage, and network performance. Different instance types suit different workloads.
        -   **Purpose**: Helps users choose the right compute power based on their application needs.
        -   **Categories**:
            -   **General Purpose (e.g., t2.micro, m5.large)**: Balanced compute, memory, and networking resources.
            -   **Compute Optimized (e.g., c5.large)**: Designed for compute-intensive tasks.
            -   **Memory Optimized (e.g., r5.xlarge)**: Ideal for memory-intensive applications.
            -   **Storage Optimized (e.g., i3.xlarge)**: High-performance for applications needing fast local storage.
            -   **Accelerated Computing (e.g., p3.xlarge)**: Instances with GPUs for machine learning and graphic-intensive tasks.

    -   **Elastic Block Store (EBS)**: EBS provides block-level storage volumes that you can attach to EC2 instances. It is used for data that requires persistent storage. EBS volumes can be used as the root file system or attached to an instance as additional storage.

        -   **Definition**: A block-level storage service used to attach persistent storage to EC2 instances.
        -   **Purpose**: Provides scalable, durable storage volumes that can be attached to instances. These volumes persist independently of the instance lifecycle.
        -   **Types**:
            -   **General Purpose SSD (gp2/gp3)**: Balanced performance and cost.
            -   **Provisioned IOPS SSD (io1/io2)**: High performance for I/O-intensive workloads.
            -   **Magnetic (st1/sc1)**: Cost-effective for sequential access workloads like logging or backup.

    -   **Elastic IP Address (EIP)**

        -   **Definition**: A static, public IPv4 address that you can allocate and associate with your EC2 instance.
        -   **Purpose**: Ensures your instance retains a consistent public IP address even if the instance is stopped and restarted.

    -   **Security Groups**: Security groups act as virtual firewalls for instances. They control inbound and outbound traffic based on rules that you define. Each instance can be associated with one or more security groups.

        -   **Definition**: Virtual firewalls that control inbound and outbound traffic to EC2 instances.
        -   **Purpose**: Security groups allow or block traffic based on rules defined by IP address, protocol, and port.
        -   **Stateful**: Security groups remember allowed traffic for responses without needing separate rules.

    -   **Key Pairs**: A key pair consists of a public key and a private key. It is used for securely connecting to an EC2 instance. The public key is placed on the instance, and the private key is kept secure.

        -   **Definition**: A public-private key pair used for SSH access to EC2 instances.
        -   **Purpose**: The public key is stored on the instance, and the private key is used by the user to securely connect to the instance.

    -   **Elastic Load Balancing (ELB)**: ELB automatically distributes incoming application traffic across multiple EC2 instances. It enhances the availability and fault tolerance of your application.

        -   **Definition**: A service that automatically distributes incoming traffic across multiple EC2 instances.
        -   **Purpose**: Ensures high availability and reliability by distributing incoming requests to healthy instances.
        -   **Types**:
            -   **Application Load Balancer**: Layer 7 load balancing (for HTTP/HTTPS traffic).
            -   **Network Load Balancer**: Layer 4 load balancing (for TCP/UDP traffic).
            -   **Gateway Load Balancer**: Enables third-party virtual appliances.

    -   **Placement Groups**

        -   **Definition**: Logical grouping of instances to influence how EC2 instances are placed on the underlying hardware.
        -   **Purpose**: Enhances performance for specific workloads.
        -   **Types**:
            -   **Cluster Placement Group**: Instances are grouped closely in a single Availability Zone for low-latency, high-throughput networking.
            -   **Spread Placement Group**: Instances are distributed across underlying hardware to reduce simultaneous failures.
            -   **Partition Placement Group**: Divides instances into partitions where they are placed on distinct sets of racks to minimize correlated failures.

    -   **Launch Template**

        -   **Definition**: A configuration template that defines how to launch EC2 instances.
        -   **Purpose**: Standardizes the instance creation process by including configurations like instance types, AMIs, key pairs, and security groups.

    -   **Elastic Network Interface (ENI)**

        -   **Definition**: A network interface that can be attached to an EC2 instance to manage multiple IP addresses.
        -   **Purpose**: Allows instances to have multiple private and public IP addresses, multiple security groups, and can be detached/reattached across instances.

    -   **Network Address Translation (NAT) Gateway**

        -   **Definition**: A managed gateway that allows instances in private subnets to connect to the internet while preventing incoming traffic from reaching them.
        -   **Purpose**: Enables private EC2 instances to download updates or access public internet resources securely.

    -   **Elastic GPUs**

        -   **Definition**: A feature that allows you to attach GPU resources to existing EC2 instances.
        -   **Purpose**: Adds GPU capability to instances for tasks like graphics rendering, machine learning, and other GPU-intensive operations.

    -   **IPv4 and IPv6 Addresses**

        -   **Definition**: Public and private IP addresses assigned to EC2 instances for communication.
        -   **Purpose**: IP addresses allow EC2 instances to communicate with other instances, on-premises networks, or the internet.

    -   **Region**: AWS divides the world into geographic areas called regions. Each region contains multiple Availability Zones. Examples of regions include us-east-1 (North Virginia), eu-west-1 (Ireland), and ap-southeast-2 (Sydney).
    -   **Availability Zone (AZ)**: An Availability Zone is a data center or a collection of data centers within a region. Each Availability Zone is isolated but connected to the others. Deploying instances across multiple Availability Zones increases fault tolerance.
    -   **Auto Scaling**: Auto Scaling allows you to automatically adjust the number of EC2 instances in a group based on demand. It helps maintain application availability and ensures that the desired number of instances are running.
    -   **Placement Groups**: Placement groups are logical groupings of instances within a single Availability Zone. They are used to influence the placement of instances to achieve low-latency communication.
    -   **Spot Instances**: Spot Instances are spare EC2 capacity that is available at a lower price. You can bid for this capacity, and if your bid is higher than the current spot price, your instances will run. However, they can be terminated if the spot price exceeds your bid.
    -   **On-Demand Instances**: On-Demand Instances allow you to pay for compute capacity by the hour or second with no upfront costs. This is a flexible and scalable pricing model suitable for variable workloads.
    -   **Reserved Instances**: Reserved Instances offer significant savings over On-Demand pricing in exchange for a commitment to a one- or three-year term. They provide a capacity reservation, ensuring availability.

    -   <details><summary style="font-size:20px;color:Magenta">EC2 Resources</summary>

        The AWS Elastic Compute Cloud (EC2) service is built upon a variety of core resources and features that enable you to run virtual servers in the cloud.

        ## 💻 Core Compute Resources

        These are the fundamental building blocks for running a virtual machine:

        -   **EC2 Instances**: The **virtual servers** themselves. You choose the operating system, the hardware profile, and the location (VPC, Subnet, Availability Zone).
        -   **Amazon Machine Images (AMIs)**: Templates that contain a **software configuration** (operating system, application server, applications). You use an AMI to launch an instance.
        -   **Instance Types**: Defines the hardware profile of your virtual server, including the **CPU, memory, storage, and networking capacity**. They are grouped into families like General Purpose (M), Compute Optimized (C), Memory Optimized (R), etc.
        -   **Key Pairs**: A set of security credentials, consisting of a **public key** (stored by AWS) and a **private key** (stored by you), used to securely connect to your Linux instances.
        -   **Launch Templates/Configurations**: Used to **define the parameters** for launching an EC2 instance or an entire Auto Scaling Group (e.g., AMI, instance type, key pair, security groups).

        ## 💾 Storage Resources

        These resources provide persistent and temporary storage for your EC2 instances:

        -   **Amazon Elastic Block Store (EBS) Volumes**: **Durable, block-level storage** volumes that can be attached to a running EC2 instance. They persist independently of the life of the instance.
            -   **EBS Snapshots**: Point-in-time backups of EBS volumes, stored in Amazon S3.
        -   **Instance Store**: **Temporary block-level storage** physically located on the host machine of the EC2 instance. The data is lost if the instance is stopped or terminated.
        -   **Amazon Elastic File System (EFS)**: A **scalable, elastic file storage** service for EC2 instances. It provides a shared file system that multiple EC2 instances can access concurrently. _While not exclusively EC2, it's a common resource used with it._

        ***

        ## 🔒 Networking and Security Resources

        These resources control the connectivity and security boundaries for your EC2 environment:

        -   **Virtual Private Cloud (VPC)**: The **isolated virtual network** where your EC2 instances are launched.
        -   **Subnets**: A range of IP addresses in your VPC, placed within a single Availability Zone.
        -   **Security Groups**: **Virtual firewalls** that control inbound and outbound traffic for one or more EC2 instances.
        -   **Elastic Network Interfaces (ENIs)**: Virtual network cards that can be attached to an instance, providing a consistent network address.
        -   **Elastic IP Addresses (EIPs)**: **Static public IPv4 addresses** designed for dynamic cloud computing. They are associated with your AWS account, not a specific instance, allowing you to quickly remap the address to another instance.

        ***

        ## 📈 Scaling and Management Resources

        These resources help manage and scale your fleet of instances:

        -   **EC2 Auto Scaling**: Automatically adjusts the number of EC2 instances in a group based on demand, using **Launch Configurations** or **Launch Templates**.
        -   **Elastic Load Balancing (ELB)**: Distributes incoming application traffic across multiple EC2 instances to increase application availability and fault tolerance.
        -   **Capacity Reservations**: Allows you to reserve compute capacity for your EC2 instances in a specific Availability Zone for any duration.
        -   **EC2 Fleet/Spot Fleet**: Allows you to request and manage a large number of EC2 instances across different instance types, Availability Zones, and purchasing options.

        ***

        ## 💵 Purchasing Options (Pricing Models)

        The way you pay for the compute capacity is also considered a resource type in managing your EC2 usage:

        -   **On-Demand Instances**: Pay for compute capacity by the hour or second, with no long-term commitment.
        -   **Reserved Instances (RIs)**: Commitment to a specific instance configuration for a 1- or 3-year term in exchange for a significant discount.
        -   **Spot Instances**: Request spare AWS compute capacity for up to a 90% discount off the On-Demand price. Instances can be interrupted with a two-minute warning.
        -   **Dedicated Hosts**: Physical servers dedicated for your use, which can help with licensing requirements.
        -   **Dedicated Instances**: EC2 instances that run on hardware dedicated to a single customer.

        An **AWS EC2 Instance Profile** is a container for an **AWS Identity and Access Management (IAM) role** that you can use to pass the role information to an Amazon Elastic Compute Cloud (EC2) instance when the instance starts.

        Its core purpose is to allow applications running on your EC2 instance to **securely access other AWS services** (like S3, DynamoDB, or CloudWatch) without needing to store long-term security credentials (like access keys and secret keys) directly on the instance.

        The EC2 instance uses the credentials provided by the instance profile, which are **temporary security credentials** that AWS automatically generates and rotates. The instance retrieves these credentials via the Instance Metadata Service (IMDS).

        ***

        ## 🏗️ How it Works

        1.  You create an **IAM Role** with the necessary permissions (e.g., read-only access to an S3 bucket).
        2.  An **Instance Profile** is created (often automatically by the AWS Console when creating the role for an EC2 service) and associated with that IAM role.
        3.  You attach the **Instance Profile** to your EC2 instance during launch or modification.
        4.  Applications/AWS SDKs on the EC2 instance can then query the IMDS for the temporary credentials associated with the attached role, allowing them to make API calls to the permitted AWS services.

        ***

        ## 🗺️ Scenarios Where Instance Profiles are Used

        Instance Profiles are considered an AWS security best practice and are primarily used in scenarios where an EC2 instance needs secure, managed access to other AWS resources.

        | Scenario                       | Use Case                                                                                                                                                                                                                               | Security Benefit                                                                                                                           |
        | :----------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------- |
        | **Data Access**                | An application on an EC2 instance needs to **read or write data** to an **Amazon S3 bucket** (e.g., storing user uploads, fetching configuration files).                                                                               | The instance only has temporary, limited access based on the IAM role, avoiding hardcoded, permanent S3 keys.                              |
        | **Logging & Monitoring**       | The EC2 instance needs to **send logs** to **Amazon CloudWatch** or **Amazon Kinesis**.                                                                                                                                                | Ensures the logging agent has _only_ the permission to write logs to the specified resource, adhering to the principle of least privilege. |
        | **Configuration Management**   | The instance needs to retrieve configuration parameters or secrets from **AWS Systems Manager Parameter Store** or **AWS Secrets Manager**.                                                                                            | Securely fetches sensitive information at runtime without the secrets ever residing on the instance's file system.                         |
        | **Automation & Orchestration** | An instance is part of an **Auto Scaling Group** or a deployment service like **AWS CodeDeploy/Elastic Beanstalk**, and it needs to make calls to other AWS services (e.g., updating a DynamoDB table, interacting with an SQS queue). | Grants the required service-specific permissions for automated workflows to function correctly.                                            |
        | **Database Connectivity**      | The EC2 instance needs to retrieve an **IAM authentication token** to connect to an **Amazon RDS** or **Amazon Aurora** database instance that uses IAM database authentication.                                                       | Provides a secure, short-lived token for database access, instead of managing long-lived database passwords.                               |

        The compute resources of an **AWS EC2 instance** are the fundamental components that define its processing power, memory, storage, and networking capacity. These resources are configured in different combinations to create the wide selection of EC2 **Instance Types** (like `t3.micro` or `c5.xlarge`).

        The core compute resources are:

        ***

        ## 💻 1. Central Processing Unit (CPU)

        The CPU provides the processing power for the instance.

        -   **vCPUs (Virtual CPUs):** Each EC2 instance is allocated a specific number of vCPUs. A vCPU is an abstraction of the underlying physical CPU core, usually represented as a thread.
        -   **Processor Type:** Instances use different processors, including:
            -   **Intel Xeon** and **AMD EPYC** processors (x86 architecture).
            -   **AWS Graviton** processors (Arm architecture), which are custom-designed by AWS and often offer better price/performance for certain workloads.
        -   **CPU Credit System (Burstable Instances):** Burstable performance instances (like the **T-family**) use a CPU credit mechanism. They provide a **baseline CPU performance** with the ability to **burst** to higher CPU usage when needed, using accumulated credits.

        ***

        ## 🧠 2. Memory (RAM)

        This is the volatile, high-speed working memory available to the instance's operating system and applications.

        -   **RAM Capacity:** Instances are provisioned with a fixed amount of GiB (Gigabytes) of RAM, which is one of the primary differentiators between instance types (e.g., Memory Optimized instances have a very high RAM-to-vCPU ratio).

        ***

        ## 💾 3. Storage

        EC2 instances use two main types of storage resources.

        -   **Amazon Elastic Block Store (EBS):** This is **persistent** block storage that you attach to the instance. The EBS volume exists independently of the instance's lifecycle (data remains even if the instance is stopped). EBS performance is measured in IOPS (Input/Output Operations Per Second) and throughput.
        -   **Instance Store (Ephemeral Storage):** This provides **temporary** block storage from disks physically attached to the host machine. Data in the Instance Store is **lost** when the instance is stopped, terminated, or fails. It's ideal for temporary scratch space, buffer/cache, or data replicated across a cluster.

        ***

        ## 🌐 4. Networking

        This resource determines the instance's connectivity and bandwidth capabilities.

        -   **Network Performance:** Instances are classified by their network performance, ranging from "Low" (e.g., older T2 instances) to dedicated bandwidth tiers (e.g., 25, 50, or 100 Gbps for high-end instances).
        -   **Elastic Network Adapter (ENA):** ENA is a network interface that supports high-performance networking capabilities, offering high throughput and low-latency networking.
        -   **Elastic Fabric Adapter (EFA):** A network device that you can attach to an EC2 instance to accelerate High-Performance Computing (HPC) and machine learning applications.

        ***

        The way these resources are packaged and prioritized leads to the different **Instance Families**:

        | Instance Family                     | Resource Focus                              | Example Use Cases                                                                 |
        | :---------------------------------- | :------------------------------------------ | :-------------------------------------------------------------------------------- |
        | **General Purpose (M, T)**          | Balance of all resources                    | Web servers, small/medium databases, development/test environments.               |
        | **Compute Optimized (C)**           | High-performance CPU                        | Batch processing, media transcoding, scientific modeling, dedicated game servers. |
        | **Memory Optimized (R, X)**         | High RAM capacity                           | High-performance databases (in-memory), distributed web-scale caches.             |
        | **Storage Optimized (I, D)**        | High sequential I/O and large local storage | Data warehousing, transactional databases, big data processing.                   |
        | **Accelerated Computing (P, G, F)** | Hardware accelerators (GPUs/FPGAs)          | Machine learning training/inference, graphics-intensive applications.             |

        The **Virtual CPU (vCPU)** is the fundamental unit of compute power provisioned to an AWS EC2 instance. It represents a share of the underlying physical CPU resources on the host server.

        Understanding vCPUs requires knowing its components, its relationship to physical hardware, and how it is managed by AWS.

        ***

        ## ⚙️ Core Components and Architecture

        The vCPU is not a one-to-one mapping with a physical core but is an abstraction managed by AWS's virtualization technology.

        ### 1. The Physical Processor (Host CPU)

        -   **Physical Cores:** The underlying host server is equipped with high-core-count physical CPUs (like Intel Xeon, AMD EPYC, or AWS Graviton).
        -   **Threads (Hyper-Threading/SMT):** Modern Intel/AMD x86 processors often use Simultaneous Multi-Threading (SMT), known by Intel as Hyper-Threading. This technology allows a single physical core to execute **two threads** concurrently, improving overall throughput.
        -   **AWS Graviton Difference:** AWS Graviton processors (based on Arm architecture) are typically designed to be single-threaded per core. For these instances, **1 vCPU maps to 1 physical core**.

        ### 2. The vCPU Definition (Abstraction Layer)

        -   **x86 Architecture (Intel/AMD):** For most instances using Intel or AMD processors, **1 vCPU is defined as one thread** of an x86-based processor core.
            -   This means an instance with **2 vCPUs** generally corresponds to **1 physical core** with SMT/Hyper-Threading enabled.
        -   **Arm Architecture (Graviton):** For instances using AWS Graviton processors, **1 vCPU is defined as one physical core**. This means an instance with **2 vCPUs** corresponds to **2 physical cores**.

        ### 3. The AWS Nitro System

        The **AWS Nitro System** is the dedicated hardware and software that powers the virtualization of modern EC2 instances. It is a critical component for managing vCPUs and their resources:

        -   **Hypervisor:** The Nitro Hypervisor is lightweight and isolates the guest OS (your EC2 instance) from the host hardware, allocating CPU, memory, and networking resources efficiently and securely.
        -   **Resource Allocation:** By offloading many virtualization functions to dedicated hardware, the Nitro system ensures that nearly **all the host's compute and memory resources** are available to the customer's instance.

        ***

        ## 📊 Resources and Configuration Options

        The resources associated with vCPUs are defined by the EC2 instance type and can sometimes be customized.

        ### 1. Dedicated vs. Shared vCPUs

        -   **Dedicated (Most Instance Types):** For most instance families (C, R, M, P, etc.), the vCPUs you select are **dedicated** to your instance on the host machine. You get the guaranteed performance of that vCPU allocation.
        -   **Shared/Burstable (T-Family):** For **T-family (Burstable)** instances, vCPUs are shared among multiple tenants on the host. These instances have a **baseline level of CPU performance** and use a **CPU Credit** system.
            -   They **accrue credits** when under the baseline usage.
            -   They **spend credits** to **burst** to a higher vCPU utilization when needed.

        ### 2. Customizing CPU Options

        For newer EC2 instance types, you can customize the vCPU allocation to manage software licensing costs or optimize performance for specific workloads:

        -   **Core Count:** You can specify the total number of **CPU Cores** for your instance.
        -   **Threads per Core:** You can specify the number of **threads per core** (usually 1 or 2). Setting this to **1** effectively **disables SMT/Hyper-Threading**, which can be necessary for certain security- or performance-critical high-performance computing (HPC) workloads.

        </details>

    -   <details><summary style="font-size:20px;color:Magenta">EC2 Auto Scaling Groups</summary>

        -   **Auto Scaling Group**: AWS **Auto Scaling Groups (ASG)** is a key component of AWS Auto Scaling that ensures the right number of Amazon EC2 instances are running to handle application load efficiently. ASG helps maintain availability, improve performance, and optimize costs by automatically scaling instances based on demand.

            -   Manages the group of EC2 instances based on policies.
            -   Key properties:
                -   **Minimum Capacity:** Minimum number of instances that must run.
                -   **Desired Capacity:** The ideal number of instances at a given time.
                -   **Maximum Capacity:** The upper limit of instances that can be launched.

        #### Components of ASGs

        1. **Launch Template or Launch Configuration**

            - Defines the settings for EC2 instances within the Auto Scaling Group.
            - Includes:
                - **AMI (Amazon Machine Image):** The base image for instances.
                - **Instance Type:** The hardware specifications (CPU, RAM, etc.).
                - **Key Pair:** SSH key for remote access.
                - **Security Groups:** Controls inbound/outbound traffic.
                - **IAM Role:** Grants permissions to instances.
                - **User Data Script:** Custom startup commands.

        2. **Scaling Policies**

            - Determines when and how ASG should scale in or out.
            - Types of Auto Scaling Policies:
                - **Dynamic Scaling**: Adjusts instances based on real-time metrics.
                    - **Target Tracking Scaling**: Maintains a CloudWatch target metric (e.g., CPU usage at 50%).
                    - **Step Scaling**: Scales in increments (e.g., add 2 instances if CPU > 70%) and out decrement.
                    - **Simple Scaling**: Adds/removes a fixed number of instances based on a single alarm.
                - **Predictive Scaling**: Uses machine learning to anticipate scaling needs.
                - **Scheduled Scaling**:

        3. **Health Checks**

            - Ensures that unhealthy instances are terminated and replaced.
            - Types:
                - **EC2 Health Check:** Checks if instance responds to system status checks.
                - **ELB Health Check:** Checks if the instance is responsive to an Elastic Load Balancer.
            - **Health Check Grace Period**:

        4. **Load Balancer Integration**

            - **Elastic Load Balancer (ELB)** ensures traffic is distributed among instances.
            - Auto Scaling Group automatically registers/deregisters instances.

        5. **Termination Policies**

            - Determines which instance is terminated first during scale-in.
            - Options include:
                - **Default (Oldest Launch Template First):** Terminates instances from the oldest launch template.
                - **Oldest Instance:** Terminates the longest-running instance first.
                - **Newest Instance:** Terminates the most recently launched instance.
                - **Closest to Billing Hour:** Optimizes cost by terminating instances nearing their next billing hour.
            - Termination Protection

        6. **Lifecycle Hooks**

            - Allows custom actions before an instance is launched or terminated.
            - Common use cases:
                - Pre-installing software before making the instance active.
                - Sending logs before terminating an instance.

        7. **Warm Pools**

            - Keeps pre-initialized instances on standby to speed up scaling.
            - Reduces boot time by allowing instances to be launched partially configured.

        #### Key Concepts of AWS Auto Scaling Groups

        8. **Cooldowns**:
        9. **Standby State**:
        10. **Lifecycle Hooks**:

        11. **Elasticity**

            - Automatically adjusts capacity to meet traffic demands.
            - Ensures availability during peak times and cost savings during low traffic.

        12. **High Availability**

            - Auto Scaling Group distributes instances across multiple **Availability Zones (AZs)**.
            - Prevents application downtime due to hardware failure.

        13. **Cost Optimization**

            - Ensures that only the necessary number of instances are running.
            - Uses **Spot Instances** for cost savings when appropriate.

        14. **Fault Tolerance**

            - Automatically replaces failed instances to maintain application health.

        15. **Region and Availability Zone Awareness**

            - ASG can span multiple **Availability Zones (AZs)** but remains within a single **AWS Region**.

            - **Web Applications:** Scale based on incoming HTTP traffic.
            - **Batch Processing:** Scale based on queued jobs.
            - **Big Data Analytics:** Scale based on compute needs.
            - **Microservices:** Adjusts instances for each service independently.

        Auto Scaling in the context of AWS EC2 is a robust, fully managed service that automatically adjusts the number of Amazon EC2 instances in your application to meet demand fluctuations, ensuring optimal performance, availability, and cost efficiency. It primarily performs **horizontal scaling** (adding or removing instances).

        Here is a vivid and detailed explanation of how it works and its core components:

        ***

        ### The Core Components

        EC2 Auto Scaling is centered around three primary components working in tandem:

        #### 1. Auto Scaling Group (ASG)

        The ASG is the **logical grouping** of EC2 instances that are treated as a single unit for scaling and management. It is the central configuration for your fleet of servers.

        -   **Min/Max/Desired Capacity:**

            -   **Minimum Capacity:** The lowest number of instances the group will _ever_ scale down to. This maintains essential application availability.
            -   **Maximum Capacity:** The highest number of instances the group will _ever_ scale out to. This acts as a protective cap against runaway costs or resource limits.
            -   **Desired Capacity:** The number of instances the ASG attempts to maintain under normal conditions.

        -   **Health Checks and Maintenance:** The ASG continuously monitors the health of its instances using EC2 status checks or Elastic Load Balancer (ELB) health checks. If an instance fails a health check, the ASG automatically **terminates the unhealthy instance** and launches a replacement to maintain the **Desired Capacity**. This provides self-healing and fault tolerance.

        #### 2. Launch Template (or Launch Configuration)

        This component acts as the **blueprint** for creating new EC2 instances. When the ASG needs to launch a new instance (a "scale-out" event), it uses this template.

        The Launch Template defines:

        -   **AMI (Amazon Machine Image):** The operating system and pre-installed software for the instance.
        -   **Instance Type:** The hardware configuration (e.g., $t2.micro$, $m5.large$).
        -   **Key Pair:** For secure login.
        -   **Security Groups:** Firewall rules controlling access.
        -   **User Data:** A script to run upon launch for bootstrapping the application (e.g., installing software, pulling code).

        #### 3. Scaling Policies

        These are the **rules** that dictate _when_ and _how_ the ASG should increase or decrease the number of instances. They translate application demand into capacity adjustments. Scaling policies rely on **Amazon CloudWatch alarms** to monitor metrics (like CPU utilization, network traffic, or custom metrics).

        ***

        ### Types of Scaling Policies

        AWS EC2 Auto Scaling offers several sophisticated methods to handle different demand patterns:

        #### A. Dynamic Scaling (Reactive)

        This is the most common type, reacting to real-time changes in load.

        1.  **Target Tracking Scaling:**

            -   **How it works:** You define a target value for a specific metric (e.g., "Maintain average CPU utilization at 50%").
            -   **Analogy:** Like a home thermostat. The policy calculates the necessary capacity change to keep the metric as close to the target value as possible. This is the simplest and often most effective method.

        2.  **Step Scaling:**

            -   **How it works:** You define a series of scaling adjustments (steps) that are triggered when a metric crosses various thresholds.
            -   **Example:**
                -   If CPU $> 70\%$: Add 1 instance.
                -   If CPU $> 90\%$: Add 3 instances.
            -   This provides a nuanced, graduated response to rapidly increasing or decreasing load.

        3.  **Simple Scaling (Legacy):**
            -   **How it works:** Similar to Step Scaling but with a single, fixed scaling adjustment for a single threshold breach. It is generally recommended to use Target Tracking or Step Scaling instead.

        #### B. Scheduled Scaling (Predictive)

        This is ideal for **predictable load changes** (e.g., a massive traffic spike every Monday at 9 AM).

        -   **How it works:** You define a date, time, and new Min/Max/Desired capacity for the group. The scaling action executes at the scheduled time.
        -   **Benefit:** Allows the application to scale **proactively** before the spike hits, avoiding performance degradation that reactive dynamic scaling might experience while new instances boot up.

        #### C. Predictive Scaling (Advanced)

        This uses machine learning to **forecast future load** based on up to two weeks of historical metrics.

        -   **How it works:** It generates a forecast of future demand and schedules scaling actions in advance to ensure capacity is available _before_ the traffic arrives.
        -   **Benefit:** Combines the proactive scaling of Scheduled Scaling with the precision of Dynamic Scaling, great for applications with recurring but complex traffic patterns.

        ***

        ### The Auto Scaling Process in Action

        1.  **Initial Launch:** The ASG launches the **Desired Capacity** of instances using the **Launch Template**.
        2.  **Load Increase (Scale-Out):**
            -   Application load increases (e.g., web traffic spikes).
            -   **CloudWatch** detects the defined metric (e.g., CPU utilization) has breached the threshold specified in a **Scaling Policy** (e.g., Target Tracking).
            -   The Scaling Policy instructs the **ASG** to increase the **Desired Capacity** by a calculated amount (but not above **Maximum Capacity**).
            -   The ASG uses the **Launch Template** to provision and launch new EC2 instances.
        3.  **Load Decrease (Scale-In):**
            -   Application load drops (e.g., the workday ends).
            -   CloudWatch detects the metric has dropped below the lower threshold (e.g., CPU $< 30\%$).
            -   The Scaling Policy instructs the ASG to decrease the **Desired Capacity** (but not below **Minimum Capacity**).
            -   The ASG terminates one or more instances, preferentially choosing the ones with the least connections or based on a defined **Termination Policy**.

        AWS EC2 Auto Scaling uses **Cooldowns**, the **Standby State**, and **Lifecycle Hooks** to provide control and stability over the automatic scaling of your EC2 instances.

        ***

        ## Cooldowns

        A **Cooldown** is a configurable waiting period after a scaling activity (either launching or terminating instances) completes, during which the Auto Scaling group suspends any subsequent scaling activities that are triggered by **simple scaling policies** or **manual scaling**.

        -   **Purpose:** To prevent rapid, unnecessary, or runaway scaling actions that could result in over- or under-provisioning. It gives the newly launched instances time to warm up, complete essential configuration tasks, start processing traffic, and for the related CloudWatch metrics to stabilize and reflect the current load.
        -   **Mechanism:** Once a scaling action finishes, the Auto Scaling group enters the cooldown period. During this time, it ignores other scaling triggers from simple scaling policies.
        -   **Note:** Cooldowns primarily apply to **simple scaling policies**. **Target tracking** and **step scaling policies** use a similar concept called **Instance Warmup** to manage scaling frequency based on when new instances are ready to handle traffic.

        ***

        ## Standby State

        The **Standby State** is a feature that allows you to temporarily remove an instance from the active service set of your Auto Scaling group for maintenance or troubleshooting, without the Auto Scaling group terminating the instance or attempting to replace it.

        -   **Purpose:** To allow a user to perform updates, patching, or debugging on an instance while keeping it within the Auto Scaling group's management, but preventing it from being served traffic (if integrated with a Load Balancer) or being terminated during a scale-in event.
        -   **Mechanism:**
            1.  You move a running instance from the **`InService`** state to the **`Standby`** state.
            2.  If the Auto Scaling group is attached to a load balancer, the instance is **deregistered** and stops receiving traffic.
            3.  You can choose to **decrement the desired capacity** of the group (no replacement instance is launched) or **not to decrement it** (a replacement instance is launched to maintain the original capacity).
            4.  The instance is still counted against the group's `MinSize` and `MaxSize` limits.
            5.  When finished, you manually move the instance back to the **`InService`** state, and it is re-registered with any attached load balancers.

        ***

        ## Lifecycle Hooks

        **Lifecycle Hooks** give you the ability to pause an instance as it launches or terminates, allowing you to perform custom actions before the instance is fully put into service or completely terminated.

        -   **Purpose:** To inject custom logic into the instance lifecycle, ensuring your instances are fully configured before handling traffic (on launch) or that all necessary cleanup is performed (on termination).
        -   **Mechanism:**
            -   **Instance Launching:** A new instance launches and enters a **`Pending:Wait`** state instead of going straight to `InService`. This pause allows a custom script, AWS Lambda function, or other process (often triggered by an Amazon Simple Notification Service (SNS) or Amazon EventBridge event) to perform final configuration like software installation, data synchronization, or registration with third-party services. Once the action is complete, the process sends a signal (`CompleteLifecycleAction`) to the Auto Scaling group to move the instance to `InService`.
            -   **Instance Terminating:** An instance targeted for termination enters a **`Terminating:Wait`** state. This pause allows for actions like draining connections, saving application logs, or deregistering from a custom service discovery system. A signal is then sent to complete the termination.
        -   **Configuration:** You define a heartbeat timeout (up to 7200 seconds or 2 hours) which specifies how long the instance can remain in the `*Wait` state. If the custom action does not send a `CompleteLifecycleAction` signal before the timeout, the Auto Scaling group proceeds based on a configured `DefaultResult` (either `CONTINUE` or `ABANDON`).

        </details>

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">ECS</summary>

    -   [amazon-ecs-and-eks](https://digitalcloud.training/amazon-ecs-and-eks/)

    > Amazon Elastic Container Service (**ECS**) is a fully managed container orchestration service that makes it easy for you to deploy, manage, and scale Docker containers on AWS. It abstracts away the complexity of managing the underlying infrastructure, allowing you to focus on building and running your applications. ECS eliminates the need to install, operate, and scale your own container management infrastructure. AWS ECS offers different ways to run your containers, catering to various needs and levels of control:


    -   <details><summary style="font-size: 25px;color:#C71585">Cluster</summary>

        > A **Cluster** is a logical grouping of the resources that run your containerized applications. It acts as the organizational boundary for your ECS components.

        -   **Logical Grouping:** It groups the compute capacity (either Amazon EC2 instances or AWS Fargate) on which your tasks and services run.
        -   **Availability:** Clusters are region-specific, but they facilitate high availability by allowing tasks to be spread across multiple **Availability Zones** within that region.
        -   **Analogy:** Think of the Cluster as the **datacenter** or the overall collection of compute resources dedicated to your applications.

        </details>

    -   <details><summary style="font-size: 25px;color:#C71585">Service (The Manager) </summary>

        > An **ECS Service** is a mechanism used to manage and ensures that a specified number of Tasks (instances of a Task Definition) are always running in the cluster.

        -   **Core Responsibilities:**
            -   **Maintenance and Self-Healing:** The Service acts as a scheduler and manager. If a Task fails, stops, or becomes unhealthy for any reason, the Service automatically replaces it to maintain the **Desired Count** of running Tasks.
            -   **Load Balancing:** Services can integrate with Elastic Load Balancing (ELB) to distribute incoming application traffic across the running Tasks. Tasks launched directly (standalone tasks) cannot use a load balancer.
            -   **Scaling:** Services manage scaling—either manually or automatically via Auto Scaling policies—to increase or decrease the number of running Tasks based on demand.
            -   **Deployment:** Services handle rolling updates when you deploy a new Task Definition revision, replacing old Tasks with new ones in a controlled manner.

        | Feature                   | Task Definition                          | Task                                     | Service                                                |
        | :------------------------ | :--------------------------------------- | :--------------------------------------- | :----------------------------------------------------- |
        | **Purpose**               | Blueprint/Template                       | Single running instance of the blueprint | Manager for long-running Tasks                         |
        | **Output**                | A JSON configuration file                | A running set of container(s)            | Continuous operation and scaling of Tasks              |
        | **Typical Use**           | Defining an application's resource needs | One-off jobs, batch scripts              | Web servers, microservices, highly available apps      |
        | **High Availability**     | No                                       | No (single run/unmanaged)                | Yes (maintains desired count)                          |
        | **Load Balancer Support** | Defines ports for mapping                | No                                       | Yes (manages LB registration for all associated Tasks) |

        </details>

    -   <details><summary style="font-size: 25px;color:#C71585">Task (The Running Instance)</summary>

        A **Task** is an _instantiation_ (a running instance) of a **Task Definition**. It represents one or more running containers that are configured and launched based on the blueprint provided by the Task Definition.

        -   **Lifecycle:**
            -   A Task is created when you run a Task Definition directly (a _standalone task_) or when a **Service** launches it.
            -   **Standalone Tasks** are typically used for one-off jobs, batch processing, or scheduled tasks (like cron jobs). Once the containers in a standalone task finish their work or stop, they are not automatically replaced.
        -   **Analogy:** If the Task Definition is the _recipe_, the Task is the _cooked meal_ following that recipe.

        </details>

    -   <details><summary style="font-size: 25px;color:#C71585">Task Definition (The Blueprint)</summary>

        > The **Task Definition** acts as a blueprint or template for your application. It is a JSON file that specifies all the necessary configurations for one or more containers that should run together as a single application unit.

        -   The **Docker images** to use for each container.
        -   **CPU and memory** allocation for the entire task and for individual containers.
        -   **Networking** configuration (like port mappings).
        -   **IAM roles** for the task to access other AWS services.
        -   **Logging** configuration, environment variables, and data volume mounts.
        -   **Revisioning:** Task Definitions are versioned (or "revisioned"). When you change a definition, ECS creates a new revision, allowing for rollbacks.

        </details>

    -   <details><summary style="font-size: 25px;color:#C71585">Container Instance</summary>

        A **Container Instance** is a single **Amazon EC2 instance** that is registered to an ECS Cluster. This is the host machine that provides the computing power (CPU, memory, storage) for your containers.

        -   **ECS Agent:** Each Container Instance must run the **ECS Container Agent** software. This agent is the crucial piece of middleware that communicates with the ECS control plane. It is responsible for:
            -   Registering the EC2 instance with the cluster.
            -   Reporting the instance's current resource utilization.
            -   Starting and stopping containers (Tasks) as instructed by the ECS scheduler.
        -   **Note:** If you use the **AWS Fargate** launch type, you don't manage Container Instances, as Fargate is a serverless compute engine that abstracts away the underlying infrastructure.

        </details>

    -   <details><summary style="font-size: 25px;color:#C71585">Task Placement Constraints & Task Placement Strategies</summary>

        ##### Task Placement Constraints

        > **Constraints** are _hard-and-fast rules_ used to filter the list of eligible Container Instances. An instance must meet all specified constraints to be considered for task placement.

        | Constraint             | Description                                                                        | Use Case                                                                                   |
        | :--------------------- | :--------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------- |
        | **`memberOf`**         | Places tasks only on instances that satisfy an expression.                         | Run tasks only on instances with a specific instance type (`t2.*`) or custom attribute.    |
        | **`distinctInstance`** | Ensures that each running copy of a task is placed on a unique Container Instance. | Achieve high availability by preventing two tasks from failing due to a single host issue. |

        ##### Task Placement Strategies

        > **Strategies** are _algorithms_ used to select the final instance from the list of eligible instances remaining after the constraints have been applied. They define _how_ tasks are distributed.

        | Strategy      | Goal                                                                                                             | Use Case                                                                                                   |
        | :------------ | :--------------------------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------- |
        | **`binpack`** | Maximize resource utilization by placing tasks on the instance with the least available memory or CPU.           | Cost optimization: Consolidate tasks to minimize the number of running instances.                          |
        | **`spread`**  | Distribute tasks evenly across a specified attribute (e.g., Availability Zone, instanceId, or custom attribute). | High availability and fault tolerance: Ensure that a failure in one area doesn't take down multiple tasks. |
        | **`random`**  | Places tasks on instances randomly.                                                                              | Used when placement does not matter or for one-off jobs.                                                   |


        </details>

    -   <details><summary style="font-size: 25px;color:#C71585">Auto Scalling for ECS: Launch Types and Capacity Providers</summary>

        -   **Service Auto Scalling**: **Service Auto Scaling in AWS ECS** is the process of automatically increasing or decreasing the **number of running tasks** in an ECS service based on application demand. It can scale based on metrics such as **CPU utilization, memory utilization, or ALB request count**.
            > **Service Auto Scaling = How many application tasks should be running?**

        -   **Cluster Auto Scalling**: **Cluster Auto Scaling in AWS ECS** is the process of automatically increasing or decreasing the **compute capacity available in an ECS cluster**, typically by adding or removing EC2 instances through an ECS Capacity Provider and Auto Scaling Group.
            > **Cluster Auto Scaling = How many EC2 machines are needed to run those tasks?**

        -   <details><summary style="font-size: 18px;color:#C71585">Launch Type Abstraction</summary>

            > **Launch Type Abstraction** standardize how ECS interacts with the two main compute options:


            1. **AWS Fargate (Serverless Launch Type)**: **AWS Fargate** is a **serverless compute engine** for containers that removes the need for you to provision, configure, or manage the underlying virtual machines (EC2 instances). You simply define the CPU and memory requirements for your containerized application, and AWS handles the rest.
                > **AWS Fargate:** Uses **Fargate** and **Fargate Spot** capacity, abstracting infrastructure management entirely.

                - **Infrastructure Management:** **Fully managed by AWS**. You focus only on the container tasks; AWS manages the instance fleet, scaling, patching, and security hardening of the container hosts.
                - **Resource Allocation:** **Per-Task Granularity**. You specify the exact vCPU and memory (e.g., 0.5 vCPU and 4 GB memory) your **Task** needs, rather than selecting a fixed instance type. This leads to better resource utilization and less over-provisioning.
                - **Scalability:** **Automatic**. Fargate automatically provisions and scales the compute resources to meet the demand of your running tasks, making it ideal for variable, spiky, or unpredictable workloads.
                - **Current State:** For pure Fargate, using the Fargate Launch Type is functionally equivalent to using the **Fargate Capacity Provider**, but using the Capacity Provider is the **recommended best practice** as it enables strategies.
                - **Control/Customization:** **Low**. You have no access to the host operating system (OS), which simplifies security but restricts the use of host-level features (like DaemonSets or specific kernel configurations).
                - **Pricing:** **Pay-per-use**. You are billed for the requested vCPU and memory resources for the duration your tasks are running (billed per second). There is no cost for idle EC2 instances.

                - **When to Choose Fargate**:
                    - When **operational simplicity** and speed of deployment are the top priorities.
                    - For **bursty, unpredictable workloads** or short-lived jobs (like batch processing), where paying per-second for only what you use provides cost efficiency.
                    - For **microservices** where tasks are independent and can be scaled quickly.
                    - When your team has **limited operational expertise** in managing EC2 clusters and Auto Scaling Groups.

            2. **Amazon EC2 (Customer-Managed Launch Type)**: The **Amazon EC2 Launch Type** requires you to manage a cluster of EC2 instances that host your containers. ECS uses these instances to place and run your container tasks.
                > **EC2 Auto Scaling Group:** Manages scaling for EC2 capacity. The Capacity Provider ensures the Auto Scaling Group scales _in_ and _out_ based on task demand.

                - **Infrastructure Management:** **Customer-Managed**. You are responsible for provisioning, configuring, scaling (via Auto Scaling Groups), patching the OS, and security hardening the EC2 instances that form the cluster.
                - **Resource Allocation:** **Instance-Level**. You choose a fixed EC2 instance type (e.g., `c5.large`, `t3.medium`) and utilize the aggregate resources of the entire instance fleet. ECS then "bin-packs" container tasks onto the available instances.
                - **Scalability:** **Manual/Configured**. Scaling is managed through **Auto Scaling Groups (ASG)** which use CloudWatch metrics to add or remove instances based on demand. Requires careful setup and maintenance.
                - **Pre-Capacity Providers:** This was the only way to run containers on your own VMs in ECS, requiring separate, manual Auto Scaling Group setup.
                - **Control/Customization:** **High**. You have full control over the EC2 instance type (allowing for GPU, high I/O, or custom network configuration), the OS, and can install custom software or agents directly on the host.
                - **Pricing:** **Pay-per-instance**. You pay for the EC2 instance capacity and associated EBS storage regardless of how much of that capacity is actually utilized by your containers. Cost optimization requires careful capacity planning (using Reserved Instances or Savings Plans).

                - **When to Choose EC2**:
                    - When **cost optimization** is paramount for **long-running, predictable, high-utilization workloads** (where Reserved Instances provide significant savings).
                    - When your workload requires **specific instance types** (e.g., GPU acceleration, specialized hardware).
                    - When you need **OS-level access** or advanced networking and security configurations not exposed by Fargate.
                    - When you need to run **DaemonSet-like agents** or security software directly on the container host.

            -   **AWS Fargate (Serverless Launch Type)** vs **Amazon EC2 (Customer-Managed Launch Type)**:

                | Feature               | AWS Fargate                                  | Amazon EC2                                              |
                | :-------------------- | :------------------------------------------- | :------------------------------------------------------ |
                | **Operational Model** | **Serverless**                               | **Customer-Managed VM**                                 |
                | **Infrastructure**    | Managed by AWS                               | Managed by Customer/ASG                                 |
                | **Resource Billing**  | Per-Task (vCPU/Memory per second)            | Per-Instance (Fixed hourly rate)                        |
                | **Cost Efficiency**   | Better for **spiky/low-utilization**         | Better for **high/steady-state utilization**            |
                | **Control**           | Low (No host access)                         | High (Full OS/Instance control)                         |
                | **Scaling**           | Automatic and seamless                       | Configured via Auto Scaling Group                       |
                | **Ideal For**         | Microservices, batch jobs, dynamic workloads | Predictable long-running services, specialized hardware |

            -   **External Launch Type (ECS Anywhere):** This allows you to register external instances (like on-premises servers or VMs) with your ECS clusters. This provides a consistent way to manage container workloads across hybrid environments.

            </details>

        -   <details><summary style="font-size: 18px;color:#C71585">Capacity Providers</summary>

            > **Capacity Providers** simplify the management and scaling of the compute capacity that your ECS tasks use. They automate the process of provisioning and scaling the underlying infrastructure (EC2 instances or Fargate).

            -   **Capacity Provider Strategy:** This is a key feature that allows you to define how tasks are distributed across **multiple Capacity Providers** (e.g., 80% on Fargate, 20% on Fargate Spot). This distribution is controlled by two parameters:
                -   **Base:** The minimum number of tasks to run on a specific capacity provider.
                -   **Weight:** The relative portion of the _remaining_ desired task count that should be placed on a capacity provider.

            > Capacity Providers shift the focus from managing the compute layer to simply defining the **desired capacity ratio** for your application.

            -   **Capacity Providers** (Modern Approch): AWS recommends using **Capacity Providers** as the modern way to manage compute in an ECS cluster, allowing you to define the infrastructure capacity in a flexible way and use both **Fargate** and **EC2** capacity within the same cluster.

                -   Capacity Providers enable **automatic managed scaling** for EC2, and allow ECS to use a **capacity provider strategy** to determine which capacity type (Fargate or EC2) to use when placing a new task.
                -   **Fargate Capacity Provider:** Points to the AWS Fargate infrastructure.
                -   **EC2 Capacity Provider:** Points to an Auto Scaling Group (ASG) of EC2 instances that you manage. ECS automatically manages the scaling of the ASG and the registration of instances into the cluster.

                - **Managed Scaling for EC2:** The primary benefit of EC2 Capacity Providers is **managed scaling**. ECS automatically integrates with the EC2 Auto Scaling Group (ASG), scaling the ASG **in response to task placement needs** (i.e., when a task is pending but there is no room) and managing instance draining for scale-in. This replaces the complex, separate ASG configuration required by the old EC2 Launch Type.
                - **Capacity Provider Strategies:** This is the most powerful feature. It allows you to define **how ECS should spread tasks** across multiple, heterogeneous capacity pools.
                    - You can assign **weights** (to determine the ratio of tasks) and **base** (to define the minimum tasks) to different providers.
                    - **Example:** A strategy might be: "Run 5 minimum tasks on `FARGATE` (base), and then distribute all remaining tasks 80% to `EC2_Spot` and 20% to `EC2_OnDemand` (weights)."
                - **Fargate and Fargate Spot:** Dedicated capacity providers exist for Fargate and Fargate Spot, enabling the use of strategies to easily mix and match these options.

                -   If you use a **Capacity Provider Strategy** when creating an ECS service, you do not specify a Launch Type; the Capacity Provider effectively handles that designation as part of its definition.

                -   The modern best practice is to **always use Capacity Providers** instead of explicitly setting a **Launch Type** on a service or task.

                    | Feature           | Launch Type                                          | Capacity Provider                                                                                                   |
                    | :---------------- | :--------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------ |
                    | **Defines**       | The **type** of compute (EC2 or Fargate).            | The **pool** of compute and **how it scales**.                                                                      |
                    | **Configuration** | Set directly on the **service** or **task** (**old way**).       | Configured on the cluster, then referenced by a strategy on the service/task.                                       |
                    | **Scaling**       | EC2 requires external ASG setup. Fargate is managed. | **Managed scaling** is built-in for both Fargate and EC2 capacity.                                                  |
                    | **Flexibility**   | Binary choice (only one type per service).           | Allows **Capacity Provider Strategies** to use multiple capacity types (e.g., Fargate and EC2 Spot) simultaneously. |
                    | **Best Practice** | **Legacy/Discouraged** for EC2.                      | **Recommended approach** for all new deployments.                                                                   |

                -   **Launch Types** vs **Capacity Providers**: The relationship between **Launch Types** and **Capacity Providers** in AWS ECS is one of an older and foundational concept (**Launch Types**) being largely superseded and enhanced by a newer, more flexible, and automated concept (**Capacity Providers**). **Launch Types define _what kind of_ infrastructure your tasks run on**, while **Capacity Providers define not only _whatkind of_ but also _how that_ infrastructure is managed, scaled, and distributed**.

                -   **Capacity Providers** were introduced to decouple the task placement logic from the capacity management logic. They are attached to an ECS Cluster and represent the available infrastructure pools.

            </details>


        </details>

    -   <details><summary style="font-size: 25px;color:#C71585">Networking Mode</summary>

        AWS ECS offers several **network modes** that determine how your containerized tasks receive IP addresses, communicate with other resources, and are accessed externally. The choice of network mode is a critical design decision, especially when using the **EC2 launch type**.

        1. **`awsvpc` Network Mode (Recommended)**: `awsvpc` is the most flexible and recommended mode, and the **only option for AWS Fargate** tasks. It provides a level of network isolation comparable to running separate EC2 instances.

            | Aspect           | Details                                                                                                                                                                                                |
            | :--------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
            | **Networking**   | ECS creates and manages a dedicated **Elastic Network Interface (ENI)** for **each task**.                                                                                                             |
            | **IP Address**   | Each task receives its **own private IP address** directly from your **VPC subnet**.                                                                                                                   |
            | **Security**     | Each task can be assigned its **own security group**, offering **granular, task-level security** rules.                                                                                                |
            | **Port Mapping** | Containers within the same task share the ENI and IP. You only specify the **container port** (no need for host port mapping), and you won't face port conflicts for different tasks on the same host. |
            | **Use Case**     | **Microservices, Load Balancing, and Fargate.** Ideal for applications requiring robust network isolation, simplified networking, and where every task needs a unique, identifiable IP within the VPC. |
            | **Limitation**   | For EC2-backed clusters, the number of tasks on a single instance is limited by the maximum number of ENIs (and secondary IPs) the EC2 instance type supports.                                         |

            - `awsvpc` mode + `ip` target type allows the ECS Service to automatically handle load balancing without tying the target group to the underlying EC2 instance ASG.
            - Your `aws_ecs_service` contains a `network_configuration` block, which is designed to assign Task-level security groups and subnets, which only works with awsvpc network mode.

        2. **`bridge` Network Mode (EC2 Launch Type Only)**: The `bridge` mode uses the Docker daemon's built-in virtual network to facilitate communication.

            | Aspect           | Details                                                                                                                                                                                                                                                                                                                                    |
            | :--------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
            | **Networking**   | The task uses the Docker **`docker0` bridge** on the host. Containers get a private, internal IP address on the virtual bridge network, separate from the EC2 instance's IP.                                                                                                                                                               |
            | **IP Address**   | Containers have an internal-only IP (e.g., from the `172.17.0.0/16` range by default) and **share the EC2 host's ENI**.                                                                                                                                                                                                                    |
            | **Port Mapping** | Requires explicit **Port Mapping** defined in the Task Definition, where a container port is mapped to a **Host Port** on the EC2 instance (e.g., `containerPort:8080` maps to `hostPort:49153`). You can use **Dynamic Port Mapping** (`hostPort: 0`) to let the ECS agent automatically assign an available, ephemeral port on the host. |
            | **Security**     | All tasks on the EC2 instance share the EC2 host's **single security group**. Security rules are applied at the EC2 instance level, not the task level.                                                                                                                                                                                    |
            | **Use Case**     | Traditional Docker deployments, high container density (not limited by ENI count), and situations where the infrastructure layer (EC2) manages security.                                                                                                                                                                                   |
            | **Limitation**   | Only one task on the same host can use the same static host port, and security control is less granular.                                                                                                                                                                                                                                   |

            - When using bridge mode, the task's networking is handled entirely by the host's EC2 instance and Docker, so you cannot specify task-level subnets or security groups in the service definition.

        3. **`host` Network Mode (EC2 Launch Type Only)**: The `host` mode provides the least isolation and gives the container direct access to the host's networking stack.

            | Aspect           | Details                                                                                                                                                                                                                                  |
            | :--------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
            | **Networking**   | The container **bypasses the Docker network stack** and shares the host machine's network namespace directly.                                                                                                                            |
            | **IP Address**   | The container uses the **IP address of the EC2 host itself**.                                                                                                                                                                            |
            | **Port Mapping** | No port mapping is used. The container binds directly to the ports on the host. If the container listens on port 80, it is accessible via the host's IP address on port 80.                                                              |
            | **Use Case**     | **High-performance/low-latency** applications where the minimal network overhead is critical, or for tasks that need to inspect or control the host's network.                                                                           |
            | **Limitation**   | **Severe port conflicts** (only one task can run on a host using a given port) and **low task density**. It also has security risks, as the container has heightened access to the host network. **Not recommended** for most use cases. |

        4. **`none` Network Mode (EC2 Launch Type Only)**: The `none` network mode provides complete network isolation.

            | Aspect           | Details                                                                                                                                                |
            | :--------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------- |
            | **Networking**   | The container is attached to an internal loopback interface only.                                                                                      |
            | **Connectivity** | The task has **no external network connectivity** (ingress or egress).                                                                                 |
            | **Use Case**     | Tasks that process pre-downloaded data and save the output to a mounted volume, or security-sensitive containers that should never access the network. |
            | **Limitation**   | Requires an external mechanism (like shared storage) for data transfer.                                                                                |

        </details>

    -   <details><summary style="font-size: 25px;color:#C71585">Dynamic Port Mapping</summary>

        **Dynamic Port Mapping** in AWS Elastic Container Service (ECS) is a feature that drastically improves resource utilization and simplifies container deployment by eliminating port conflicts on the underlying host.

        It allows **multiple tasks** (containers from the same service or different services) that expose the **same container port** to run on the **same EC2 instance** within your ECS cluster.

        The core of dynamic port mapping is the clever use of ephemeral ports on the host and integration with a modern AWS Load Balancer:

        1. **The Task Definition Setup**

            - In your **ECS Task Definition**, when defining the **Port Mappings** for your container, you specify the **Container Port** (the port your application inside the container listens on, e.g., `8080`).
            - Crucially, for the **Host Port** (the port on the EC2 instance the container port maps to), you set it to **`0`**. This value signals to the ECS container agent to dynamically select an **available, unused ephemeral port** on the host when the task is launched.

        2. **Task Launch and Port Assignment**

            - When the ECS service scheduler launches a new task on an EC2 instance, the ECS container agent checks for available ports in the ephemeral port range (typically 32768–65535 on Linux).
            - It then **dynamically assigns a unique, random host port** from this range (e.g., `49153`) to the container's fixed port (e.g., `8080`).
                - **Mapping Example:** `Host:49153` $\to$ `Container:8080`

        3. **Load Balancer Integration (The Key)**

            - Dynamic port mapping is almost always used in conjunction with an **Application Load Balancer (ALB)** or **Network Load Balancer (NLB)**:

                - When you create the ECS Service, you associate it with the load balancer and specify a **Target Group**.
                - The load balancer's Target Group is configured to perform health checks and forward traffic to the dynamic port assigned to the running task.
                - The ECS service automatically registers the new task's target (the EC2 instance IP + the dynamically assigned host port) with the load balancer's Target Group. This creates a complete routing path:
                - $$\text{Internet} \to \text{Load Balancer (Port 80/443)} \to \text{EC2 Instance IP}:\mathbf{\text{Dynamic Port}} \to \text{Container}:\text{Container Port}$$

            - Because each task gets a **unique host port**, multiple tasks from the same service (all listening on `8080` internally) can coexist on the same EC2 instance without port conflict.

        -   **Launch Type Considerations**:

            | Launch Type | Network Mode Support                                        | Dynamic Port Mapping Support                                                                                                                                                                                                                    |
            | :---------- | :---------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
            | **EC2**     | **Bridge** or **User-Defined** networks (use `hostPort: 0`) | **Fully Supported**. Essential for high EC2 density.                                                                                                                                                                                            |
            | **Fargate** | **`awsvpc`** mode **only**                                  | **Not Applicable/Necessary**. Each task gets its own Elastic Network Interface (ENI) with a unique IP address. Since each task has its own network stack and IP, they don't share ports on the same host, so dynamic port mapping isn't needed. |

        -   **Benefits**:

            -   **Increased Density and Utilization:** The primary advantage is being able to run multiple instances of the same service on a single EC2 container instance. This maximizes the utilization of your computing resources and reduces costs.
            -   **Simplified Scaling:** You can scale your service up or down without worrying about which EC2 instances have available, unused, static ports. ECS simply finds an available ephemeral port.
            -   **Zero Downtime Deployment:** Dynamic port mapping, combined with an ALB, facilitates rolling updates and blue/green deployments by allowing new tasks to launch on the same instance as old tasks (on a new dynamic port) before the old ones are terminated.

        </details>

    -   <details><summary style="font-size: 25px;color:#C71585">ECS Container Agent</summary>

        The **ECS Container Agent** is software that runs on every EC2 instance registered to an ECS cluster (the **Container Instance**). It acts as the intermediary, communicating between the **ECS control plane** (the management service in AWS) and the local Docker daemon on the host.

        -   **Core Responsibilities:**
            -   **Registration:** Registers the EC2 instance with the ECS cluster, making it available to run tasks.
            -   **Status Reporting:** Reports the instance's available resources (CPU, memory) and the state/health of running tasks back to the ECS control plane for scheduling decisions.
            -   **Task Management:** Polls the ECS API for new **Task Definitions** and translates those instructions into local Docker commands (create, start, stop, delete containers).
            -   **Resource Management:** Manages networking configurations and, in the case of the `awsvpc` network mode, handles the assignment and attachment of Elastic Network Interfaces (ENIs) to the task.

        </details>

    -   <details><summary style="font-size: 25px;color:#C71585">IAM Roles in AWS ECS</summary>

        AWS ECS uses a strict separation of duties, enforced through three primary IAM roles, each granting permissions for different entities:

        | IAM Role Name                      | Entity Assuming the Role                                  | Purpose / Scope of Permissions                                                                                                                                                                                                                                   | Launch Type   |
        | :--------------------------------- | :-------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------ |
        | **1. Task IAM Role**               | **The Application Code** inside the container.            | Allows the application code to access other AWS services (e.g., read/write to S3, query DynamoDB, publish to SQS). This grants **application-level** permissions.                                                                                                | EC2 & Fargate |
        | **2. Task Execution IAM Role**     | **The ECS Agent** or the **ECS Service**.                 | Grants the permissions necessary for the ECS service to perform its own tasks, such as: **Pulling Docker images** from Amazon ECR, **Pushing container logs** to Amazon CloudWatch Logs, and **Retrieving secrets** from AWS Secrets Manager or Parameter Store. | EC2 & Fargate |
        | **3. Container Instance IAM Role** | **The EC2 Host/ECS Agent** (via an EC2 Instance Profile). | Grants the permissions necessary for the host instance and the ECS Agent to communicate with the ECS control plane, specifically for **registering the instance** to the cluster and **reporting health/status**.                                                | **EC2 only**  |

        -   **Key Distinction**: Task Role vs. Task Execution Role

            -   **Task Execution Role:** Used for setting up the container and managing the task's environment. If the task fails to start (e.g., cannot pull the image), the Execution Role is the one lacking permissions.
            -   **Task IAM Role:** Used after the container is running by the application code itself. If the application runs but can't save a file to S3, the Task IAM Role is the one lacking permissions.

        </details>

    #### Features of AWS ECS

    ECS offers a rich set of features for container orchestration:

    -   **Fully Managed Service:** AWS handles the control plane, scaling, and availability of the ECS service itself.
    -   **Choice of Compute Options:** Flexibility to choose between EC2 (more control) and Fargate (serverless).
    -   **Docker Compatibility:** Natively supports Docker containers.
    -   **Scalability:** Easily scale the number of tasks up or down based on demand. ECS integrates with Auto Scaling for both the underlying infrastructure (for EC2) and the number of tasks in a service.
    -   **Load Balancing:** Seamless integration with Elastic Load Balancing (Application Load Balancer, Network Load Balancer, and Classic Load Balancer) to distribute traffic across container instances.
    -   **Service Discovery:** Integrates with AWS Cloud Map (Service Discovery) to allow containers to discover and communicate with each other using DNS names. Also offers ECS Service Connect for simplified service-to-service communication.
    -   **Security:**
        -   **IAM Roles for Tasks:** Allows you to grant specific AWS permissions to containers.
        -   **Task Execution IAM Role:** Grants ECS permissions to pull container images and manage resources on your behalf.
        -   **VPC Integration:** Launch tasks directly into your VPC for network isolation.
        -   **Security Groups:** Control inbound and outbound traffic at the task level (with `awsVpc` networking mode).
        -   **AWS Secrets Manager and Parameter Store Integration:** Securely manage sensitive data and configuration.
    -   **Monitoring and Logging:** Integration with Amazon CloudWatch for metrics and logs.
    -   **Deployment Options:** Supports various deployment strategies like rolling updates and blue/green deployments for zero-downtime updates.
    -   **Task Networking:** Offers different networking modes to suit various application requirements.
    -   **Hybrid Deployments (ECS Anywhere):** Extend ECS to manage containers on your own infrastructure.
    -   **Integration with AWS Ecosystem:** Deep integration with other AWS services like IAM, VPC, CloudWatch, Auto Scaling, ECR, Cloud Map, and more.
    -   **Container Auto-Recovery:** ECS automatically restarts unhealthy containers to maintain the desired count.

    #### Configurations in AWS ECS

    Configuring ECS involves defining various aspects of your containerized applications and the environment they run in:

    1.  **Cluster Configuration:**

        -   Choosing a network configuration for the cluster's VPC.
        -   Enabling Container Insights for monitoring.
        -   Configuring Service Connect defaults.
        -   Associating Capacity Providers (for EC2 launch type).

    2.  **Task Definition Configuration:**

        -   Specifying container images and their settings (CPU, memory, ports, environment variables, etc.).
        -   Defining networking mode.
        -   Setting up volume mounts.
        -   Configuring health checks.
        -   Assigning IAM roles.
        -   Defining resource requirements (GPUs, etc.).
        -   Specifying logging drivers (e.g., `awslogs` for CloudWatch Logs).

    3.  **Service Configuration:**

        -   Choosing the task definition to run.
        -   Specifying the desired number of tasks.
        -   Selecting a task placement strategy and constraints.
        -   Configuring load balancing integration (target groups, listener ports).
        -   Setting up service auto scaling policies (based on CPU utilization, memory utilization, custom metrics, etc.).
        -   Defining deployment configurations (rolling update, blue/green).
        -   Configuring service discovery integration.
        -   Enabling task scale-in protection.

    4.  **Capacity Provider Configuration (for EC2):**

        -   Associating an Auto Scaling Group with the capacity provider.
        -   Defining managed scaling settings (target capacity, minimum/maximum scaling steps).
        -   Configuring managed termination protection.

    5.  **Networking Configuration:**

        -   Choosing the VPC and subnets for your ECS tasks (especially important for `awsVpc` networking mode).
        -   Configuring security groups to control access to your containers.
        -   Setting up network load balancers or application load balancers to expose your services.
        -   Configuring DNS settings for service discovery.

    6.  **Scaling Configuration:**

        -   Setting up Auto Scaling policies for ECS services based on various metrics.
        -   Configuring scaling based on custom metrics.
        -   Using predictive scaling.

    7.  **Security Configuration:**
        -   Defining IAM roles for tasks and task execution.
        -   Managing sensitive data using AWS Secrets Manager or Parameter Store.
        -   Applying the principle of least privilege to container permissions.

    #### Use Cases for AWS ECS

    > ECS is a versatile service suitable for a wide range of applications:

    -   **Microservices Architectures:** Easily deploy and manage distributed microservices with service discovery and load balancing.
    -   **Web Applications:** Host scalable and highly available web applications.
    -   **Batch Processing:** Run and manage batch jobs efficiently.
    -   **Machine Learning Inference:** Deploy and scale containerized machine learning models for real-time inference.
    -   **Hybrid Environments:** Manage container workloads consistently across the cloud and on-premises with ECS Anywhere.
    -   **Modernizing Legacy Applications:** Containerize and migrate existing applications to a more scalable and manageable platform.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">DNS (Domain Name System)</summary>

    #### DNS (Domain Name System)

    **DNS (Domain Name System)** is a hierarchical, distributed system that translates human-readable domain names (e.g., `example.com`) into machine-readable IP addresses (e.g., `192.168.1.1`). It functions like the phonebook of the internet, allowing users to access websites using domain names instead of numerical IP addresses.

    #### How DNS Works

    When you enter a domain name in your browser, DNS follows these steps to resolve it to an IP address:

    1. **User Request (DNS Query)**:

        - A user enters `example.com` in their browser.
        - The browser checks its local DNS cache for a stored IP address.
        - If no cached record exists, the query is sent to a Recursive DNS Resolver.

    2. **Recursive DNS Resolver (ISP-Level Resolver)**:

        - The recursive resolver (often managed by your Internet Service Provider (ISP)) looks up the domain in its cache.
        - If the IP address is not found, it queries the Root DNS Server.

    3. **Root DNS Server**: The Root Server directs the resolver to the appropriate TLD (Top-Level Domain) Name Server based on the domain extension (`.com`, `.org`, `.net`, etc.).

    4. **TLD Name Server**: The TLD (Top Level Domain) Server (e.g., `.com` Name Server) directs the resolver to the Authoritative Name Server responsible for the domain.

    5. **Authoritative Name Server**:

        - The **Authoritative Name Server** provides the final IP address of `example.com`.
        - The resolver caches this result for future queries and returns the IP to the browser.

    6. **Connecting to the Web Server**:
        - The browser connects to the retrieved IP address and loads the website content.

    #### Domain Name

    A Domain Name is a human-readable address used to identify and access resources on the internet, such as websites, web services, and APIs. It is mapped to an IP address through the Domain Name System (DNS), allowing users to access websites without remembering complex numerical IP addresses. It serves as a user-friendly alias for an IP address (e.g., `192.168.1.1` → `example.com`). A domain name consists of multiple parts, separated by dots (`.`), organized in a hierarchical structure.

    -   **Top-Level Domains (TLDs)**

        -   The highest level of the domain name hierarchy.
        -   Managed by ICANN (Internet Corporation for Assigned Names and Numbers).
        -   Examples:
            -   `Generic TLDs (gTLDs)`: `.com`, `.org`, `.net`, `.info`
            -   `Country-Code TLDs (ccTLDs)`: `.us` (United States), `.uk` (United Kingdom), `.ca` (Canada)
            -   `Sponsored TLDs (sTLDs)`: `.edu` (education), `.gov` (government), `.mil` (military)

    -   **Naked Domain**: `google.com`
    -   **Second-Level Domains (SLDs)**

        -   The main identifier of a domain name.
        -   In `google.com`, `google` is the second-level domain.
        -   Users can register custom second-level domains through domain registrars.

    -   **Subdomains**

        -   A subdivision of a domain used for organizing different services.
        -   Example:
            -   `blog.example.com` → Subdomain for a blog.
            -   `api.example.com` → Subdomain for an API service.

    -   **Fully Qualified Domain Name (FQDN)**: A Fully Qualified Domain Name refers to the complete and absolute domain name that specifies a precise location in the DNS hierarchy. It is made up of multiple components, separated by dots, from the most specific to the least specific:

        1. **Hostname** – The specific name of a server or service (e.g., `www`, `mail`).
        2. **Subdomain (optional)** – A division under the primary domain (e.g., `blog.example.com`).
        3. **Second-Level Domain (SLD)** – The main domain name registered (e.g., `example`).
        4. **Top-Level Domain (TLD)** – The domain extension (e.g., `.com`, `.org`, `.net`).
        5. **Root Domain (.)** – The implied, invisible dot at the end, representing the root of the DNS hierarchy.

    #### DNS Record

    A **DNS Record** is a rule stored in DNS servers that defines how a domain or subdomain is resolved to an IP address or another service.

    -   **Common Types of DNS Records:**

        -   **A Record (Address Record)** → Maps a domain to an IPv4 address (`example.com` → `192.168.1.1`).
        -   **CNAME Record (Canonical Name)** → Maps a domain to another domain (`www.example.com` → `example.com`).
        -   **AAAA Record** → Maps a domain to an IPv6 address.
        -   **MX Record (Mail Exchange)** → Specifies the mail servers for email routing.
        -   **TXT Record** → Stores text information (used for SPF, DKIM, and verification purposes).
        -   **NS Record (Name Server)** → Specifies the authoritative name servers for a domain.

    -   **Example DNS Records for `example.com`**:

        ```plaintext
        example.com.   A     192.168.1.1
        www            CNAME example.com
        mail           MX    10 mail.example.com
        ```

    #### DNS Server

    A DNS (Domain Name System) Server is a specialized server responsible for translating domain names (e.g., `example.com`) into IP addresses (e.g., `192.168.1.1`). This translation process allows users to access websites and online services using human-readable domain names instead of remembering numerical IP addresses.

    1. **Recursive DNS Resolver (Caching Name Server)**

        - A Recursive Resolver is the first stop when a user requests a website.
        - It searches for the requested domain's IP address by querying other DNS servers.
        - If it has a cached record of the IP, it returns the result immediately.
        - Examples:
            - Your Internet Service Provider’s (ISP) DNS resolver
            - Public DNS resolvers like Google DNS (8.8.8.8), Cloudflare DNS (1.1.1.1), OpenDNS

    2. **Root DNS Server**

        - The Root Server is the top-level DNS server in the hierarchy.
        - It directs queries to the appropriate Top-Level Domain (TLD) Name Server based on the domain extension (`.com`, `.org`, `.net`, etc.).
        - There are **a total of 13 root DNS servers globally**. These servers are identified by the letters A through M and are operated by different organizations. While there are only 13 primary root servers, each is replicated multiple times around the world, resulting in hundreds of physical servers

    3. **TLD (Top-Level Domain) Name Server**

        - This server handles queries for domain extensions like `.com`, `.org`, `.net`.
        - It directs the request to the Authoritative Name Server responsible for the domain.
        - Example: The `.com` TLD name server manages domains like `amazon.com`, `google.com`.

    4. **Authoritative DNS Server**

        - It responds with the final IP address for the requested domain.
        - This server holds the official DNS records for a domain (like `example.com`).
        - If a website uses a DNS hosting service, its authoritative DNS is managed by providers like:
            - **AWS Route 53**
            - Cloudflare
            - Google Cloud DNS
            - GoDaddy

    #### MISC

    -   **Types of DNS Lookups**

        -   `Forward DNS Lookup`: Translates a domain name (`example.com`) to an IP address (`192.168.1.1`).
        -   `Reverse DNS Lookup`: Maps an IP address (`192.168.1.1`) back to a domain name (`example.com`).

    -   **Types of DNS Resolution Methods**

        -   `Recursive Resolution` → The resolver handles the entire lookup process and returns the final IP address.
        -   `Iterative Resolution` → The resolver queries multiple DNS servers, each returning the next step until the final IP is found.

    -   **DNS Caching and Performance**: To improve efficiency, DNS results are cached at different levels:

        -   `Browser Cache` → Stores previously resolved domains to reduce lookup times.
        -   `OS Cache` → The operating system caches DNS records to avoid frequent lookups.
        -   `ISP Resolver Cache` → The ISP caches results to speed up internet access.
        -   `Global DNS Caching` → Content Delivery Networks (CDNs) cache DNS responses to improve performance worldwide.

    -   **DNS Services & Management**: Popular DNS service providers:

        -   `Cloud-Based DNS` → AWS Route 53, Google Cloud DNS, Azure DNS.
        -   `Public DNS Resolvers` → Google Public DNS (`8.8.8.8`), Cloudflare DNS (`1.1.1.1`), OpenDNS.
        -   `Private/Internal DNS` → Used within corporate networks for managing internal domains.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Route-53</summary>

    > AWS Route 53 is a highly available and scalable Domain Name System (DNS) web service provided by Amazon Web Services (AWS). It is designed to route end-user requests efficiently by translating domain names into numerical IP addresses used for internet communication.

    -   **How AWS Route 53 Works**:
        -   **Step 1: Domain Registration (Optional)**: Register a domain using AWS Route 53 or transfer an existing domain.
        -   **Step 2: Create a Hosted Zone**: Create either a **Public** or **Private Hosted Zone** for managing DNS records.
        -   **Step 3: Configure DNS Records**: Add **A, CNAME, MX, TXT, or Alias Records** to route traffic appropriately.
        -   **Step 4: Update Name Servers (If Using an External Registrar)**: Update the domain’s **NS Records** to point to AWS Route 53.
        -   **Step 5: Configure Routing Policies**: Select the appropriate routing policy (e.g., Simple, Weighted, Failover).
        -   **Step 6: Set Up Health Checks (Optional)**: Monitor application availability and enable failover mechanisms.
        -   **Step 7: Test and Validate**: Verify domain resolution using tools like `nslookup`, `dig`, or AWS console.

    -   **Domain Name Registration**:
        -   Allows users to purchase and manage domain names directly from AWS.
        -   Supports automatic DNS configuration with AWS-hosted services.
        -   Provides domain transfer and renewal options.

    -   **Hosted Zone**: A **Hosted Zone** is an essential component of DNS (Domain Name System), specifically within AWS Route 53. It represents a container for managing DNS records associated with a specific domain or subdomain.

        - A Hosted Zone is an AWS Route 53 configuration that holds DNS records for a domain (e.g., `example.com`).
        - It acts as a DNS database, defining how traffic is routed for that domain.
        - Each Hosted Zone contains multiple DNS record sets that map domain names to IP addresses, AWS resources, or other services.

        - **Public Hosted Zone**:

            - Used for domains accessible on the public internet.
            - It is required when you want your website (`example.com`) to be publicly available.
            - Stores records like A, AAAA, CNAME, MX, TXT, etc.
            - Example: A public Hosted Zone for `example.com` resolves `www.example.com` to an AWS Elastic Load Balancer (ELB).

        - **Private Hosted Zone**:
            - Used for internal DNS resolution within an AWS VPC.
            - It is not publicly accessible but helps resolve domain names within a private AWS environment.
            - Used when instances inside a VPC need custom domain names.
            - Example: `internal.example.com` resolves to private EC2 instances.

    -   **Hosted Zone Components**: Each Hosted Zone contains:

        - **DNS Records**: A DNS record is a structured entry in the DNS database that defines how to handle queries for a domain or subdomain. It Controls how domain names are mapped to IPs or AWS services.

            - `A Record` → An A Record maps a domain name to an **IPv4 address** (which is 32 bits).
            - `AAAA Record` → Maps a domain to an **IPv6 address** (which is 128 bits = 4 × 32 bits = 4A where A → IPv4 (32 bits)).
            - `CNAME Record` → Maps a domain to another domain (e.g., `www.example.com` → `example.com`).
            - `MX Record` → **Mail Exchange Record** specifies mail servers for handling emails.
            - `TXT Record` → Stores arbitrary text data, often used for verification and security keys.
            - `NS Record` → **Name Server Record** Assigns AWS Route 53 name servers for the domain. These servers are responsible to route your traffic according to DNS Records.
            - `SOA Record` → **Start of Authority Record** defines essential details about the domain, including primary name server and **TTL** (Time-To-Live).
            - **Alias Records**: While standard DNS only permits pointing a name to a hardcoded string or IP address, Route 53 includes a highly specialized internal component: Alias Records.
                - Maps domain names to AWS resources like ELB, CloudFront, and S3.
                - Unlike CNAME records, alias records work at the root domain level.

            - **Sample Route-53 DNS Record Set**:

                | **Record Name**         | **Routing Policy**   | **Differentiator**        | **Type**  | **Alias** | **Value / Route traffic to**            |
                | ----------------------- | -------------------- | ------------------------- | --------- | --------- | --------------------------------------- |
                | `example.com.`          | Simple               | —                         | A         | No        | `192.0.2.10`                            |
                | `www.example.com.`      | Simple               | —                         | CNAME     | No        | `example.com.`                          |
                | `api.example.com.`      | Weighted             | Weight: 80                | A         | No        | `203.0.113.5`                           |
                | `api.example.com.`      | Weighted             | Weight: 20                | A         | No        | `203.0.113.6`                           |
                | `cdn.example.com.`      | Simple (Alias)       | CloudFront Distribution   | A (Alias) | Yes       | `d1234abcd.cloudfront.net`              |
                | `static.example.com.`   | Simple (Alias)       | S3 Static Website Hosting | A (Alias) | Yes       | `s3-website-us-east-1.amazonaws.com`    |
                | `example.com.`          | Simple               | —                         | TXT       | No        | `"v=spf1 include:_spf.google.com ~all"` |
                | `us.example.com.`       | Geolocation          | Location: US              | A         | No        | `192.0.2.55`                            |
                | `eu.example.com.`       | Geolocation          | Location: Europe          | A         | No        | `192.0.2.66`                            |
                | `failover.example.com.` | Failover (Primary)   | Failover: Primary         | A         | No        | `198.51.100.10`                         |
                | `failover.example.com.` | Failover (Secondary) | Failover: Secondary       | A         | No        | `198.51.100.20`                         |
                | `latency.example.com.`  | Latency-based        | Region: us-east-1 latency | A         | No        | `192.0.2.101`                           |

        -   **Routing Policies**:

            -   **Simple Routing**
                -   Maps a single domain name to a single resource.

            -   **Weighted Routing**
                -   Distributes traffic based on assigned weights (percentage).
                -   Useful for A/B testing and gradual deployments.

            -   **Failover Routing**
                -   Directs traffic to a secondary resource if the primary fails.
                -   Requires health checks to monitor resource availability.

            -   **Latency-Based Routing**
                -   Routes DNS queries to the AWS Region with the lowest latency for the user.
                -   To optimize performance for users by serving content from the nearest (fastest) AWS region.
                -   Useful when you have multiple endpoints (e.g., EC2, ELB) across different regions and want to deliver the best possible experience based on geography and network conditions.
                -   Enhances user experience by reducing response time.

            -   **Geolocation Routing**
                -   Routes traffic based on the geographic location of the user.
                -   Useful for content localization and regulatory compliance.

            -   **Geoproximity Routing**
                -   Adjusts routing based on the user's geographic location and bias settings.
                -   Allows shifting traffic dynamically to preferred locations.

            -   **Multivalue Answer Routing**
                -   Returns multiple IP addresses for a domain.
                -   Provides basic load balancing without an additional load balancer.


       -   **Health Checks and Monitoring**: A component linking a record to an Route 53 Health Check. If the health check flags an endpoint as down, the hosted zone automatically stops returning that record and falls back to a healthy resource.

           -   Monitors the health of websites, servers, or applications by sending periodic requests.
           -   Configurable with HTTP, HTTPS, and TCP health checks.
           -   Can trigger failover mechanisms when a resource becomes unresponsive.

    -   **DNSSEC (Domain Name System Security Extensions)**: DNSSEC ensures that DNS responses come unchanged from their authoritative source by using digital signatures. It is a security feature that helps protect your domain from DNS spoofing, cache poisoning, and man-in-the-middle attacks by enabling cryptographic verification of DNS data.

        -   Protects against DNS spoofing and cache poisoning attacks.
        -   Provides cryptographic signatures to validate DNS responses.
        -   **When DNSSEC is enabled**:
            -   Your hosted zone (via Route 53) signs DNS records with private keys.
            -   DNS resolvers validate those signatures using public keys stored in the parent zone (like .com).
            -   If a response is tampered with, validation will fail, and the client will discard it.

    -   **Integration with AWS Services**:

        -   Works seamlessly with EC2, S3, CloudFront, Elastic Load Balancer (ELB), AWS WAF, and Shield.
        -   Supports routing to AWS resources using Alias Records, reducing query costs.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Load balancer</summary>

    > A **Load Balancer** is a managed service provided by Elastic Load Balancing (ELB) that automatically distributes incoming application traffic across multiple targets, such as EC2 instances, containers, IP addresses, and Lambda functions, in one or more Availability Zones. This ensures high availability, fault tolerance, and scalability for your applications. AWS provides the following types of load balancers, each suited to different use cases:

    -   **Hosted zone (CanonicalHostedZoneId)**: The Amazon Route 53 hosted zone ID associated with a Load Balancer depends on the type of load balancer and the AWS region it's deployed in. AWS manages these hosted zones for its ELBs internally.

    -   <details><summary style="font-size:20px;color:#FF1493">Classification of Load Balancer</summary>

        1. **Application Load Balancer (ALB)**
            - Designed for HTTP and HTTPS traffic.
            - Operates at **Layer 7** (Application Layer) of the OSI model.
            - Content-based or path-based routing (e.g., route based on URL path or hostname).
            - WebSocket and HTTP/2 support.
            - Authentication using OIDC, Cognito, or other mechanisms.
            - Advanced request-routing capabilities (e.g., based on headers or query strings).
            - Integration with AWS Web Application Firewall (WAF).

        2. **Network Load Balancer (NLB)**
            - Designed for **TCP, UDP, and TLS** traffic.
            - Operates at **Layer 4** (Transport Layer).
            - High-performance handling of millions of requests per second.
            - Static IP addresses or Elastic IPs for the load balancer.
            - Ability to preserve client source IP addresses.
            - Ideal for low-latency, high-throughput workloads.

        3. **Gateway Load Balancer (GWLB)**
            - Designed for deploying and managing third-party virtual appliances (e.g., firewalls, monitoring tools).
            - Operates at **Layer 3** (Network Layer).
            - Scalable and elastic traffic distribution for appliances.
            - Integrates with Virtual Private Cloud (VPC) Ingress Routing.

        4. **Classic Load Balancer (CLB)**
            - Legacy load balancer that supports both **Layer 4** and **Layer 7** traffic.
            - Limited features compared to ALB and NLB.
            - Basic routing and health checks.
            - Supports legacy applications.

        -   **AWS ALB vs. NLB**: Component-by-component comparison of the differences between an AWS NLB and ALB

            -   **Core Architecture and Layer**:
                -   **Application Load Balancer (ALB):** Operates at **Layer 7 (Application)** of the OSI model. It terminates connections and inspects individual HTTP/HTTPS headers, cookies, content types, and payloads to make routing decisions.
                -   **Network Load Balancer (NLB):** Operates at **Layer 4 (Transport)** of the OSI model. It routes raw network packets purely based on protocol, source IP address, and destination port without looking inside the application payload.

            -   **Performance and Scalability**:
                -   **Application Load Balancer (ALB):** Engineered to handle millions of requests per second. Because it performs deep packet inspection and manages connection pools, it introduces a slight amount of processing latency compared to Layer 4 routing.
                -   **Network Load Balancer (NLB):** Engineered for **ultra-low, sub-millisecond latency**. It scales instantaneously to handle tens of millions of concurrent requests per second, making it the choice for massive, volatile traffic spikes.

            -   **IP Address and Network Layout**:
                -   **Application Load Balancer (ALB):** Uses **Dynamic IP Addresses**. As the ALB auto-scales up or down to handle load, AWS changes its underlying IP addresses. Because of this, you must **always route traffic to an ALB using its assigned DNS name** rather than a hardcoded IP.
                -   **Network Load Balancer (NLB):** Uses **Static IP Addresses**. It provides one fixed, unchanging IP address per enabled Availability Zone. You can also assign your own **Elastic IP (EIP)** to each zone, allowing external clients to easily whitelist your load balancer in their firewalls.

            -   **Traffic Routing Capabilities**:
                -   **Application Load Balancer (ALB):** Features **Advanced Content-Based Routing**. You can write rules to send traffic to different backend target groups based on:
                    -   URL paths (e.g., `/api` vs `/static`)
                    -   Hostnames (e.g., `api.example.com` vs `web.example.com`)
                    -   HTTP headers, cookies, query parameters, or source IP ranges

                -   **Network Load Balancer (NLB):** Features **Connection-Based Routing**. It cannot read URLs or headers. It takes incoming connections and forwards them directly to targets based purely on the listener port and protocol.

            -   **Client IP Preservation**:
                -   **Application Load Balancer (ALB):** Modifies the packet headers. Because the ALB terminates the client connection, the backend target sees the ALB's internal IP as the source. The ALB automatically injects the original client IP into the **`X-Forwarded-For`** and **`X-Forwarded-Proto`** HTTP headers.
                -   **Network Load Balancer (NLB):** Preserves the network packet. It routes packets transparently to the backend. Your backend servers see the **exact public client IP address** directly at the operating system or network socket layer (when utilizing IP target types or instance targets without proxy protocol).

            -   **Supported Protocols and Targets**:
                -   **Application Load Balancer (ALB):** Strictly handles **HTTP, HTTPS, and HTTP/2** (including gRPC). Targets include EC2 instances, ECS container tasks, private IP addresses, and AWS Lambda functions.
                -   **Network Load Balancer (NLB):** Handles **TCP, UDP, and TLS** traffic. This makes it ideal for non-web protocols like **FTP**, **SMTP**, **MQTT** (IoT setups), streaming protocols, or raw WebSockets. Targets include EC2 instances, ECS tasks, private IPs, and other Application Load Balancers.

            -   **Detailed Comparison Table**:

                | Feature Component       | Application Load Balancer (ALB)            | Network Load Balancer (NLB)               |
                | ----------------------- | ------------------------------------------ | ----------------------------------------- |
                | **OSI Layer**           | Layer 7 (Application)                      | Layer 4 (Transport)                       |
                | **Primary Use Case**    | Web applications, REST APIs, Microservices | High throughput, TCP/UDP apps, Static IPs |
                | **Latency Profile**     | Low (milliseconds)                         | Ultra-low (sub-milliseconds)              |
                | **IP Management**       | Dynamic IPs (Requires DNS routing)         | Static IPs (Supports Elastic IPs)         |
                | **Client IP Strategy**  | Injected into `X-Forwarded-For` header     | Preserved directly in the network packet  |
                | **Sticky Sessions**     | Supported via cookies                      | Supported via Source IP Affinity          |
                | **Routing Options**     | Path, Host, Header, and Query rules        | Port and Protocol rules only              |
                | **Supported Protocols** | HTTP, HTTPS, HTTP/2, gRPC                  | TCP, UDP, TLS                             |

            -   **Architectural Flow Summary**:
                -   **Choose an ALB** when you are building modern microservices, containerized web applications (like a Django web app), or APIs that require intelligent routing rules, path-based mapping, or direct integration with AWS Lambda.
                -   **Choose an NLB** when your application requires extreme performance, handles raw TCP/UDP traffic, needs to expose a single whitelistable static/Elastic IP address to your clients, or needs to preserve client source IPs all the way to the OS layer of your backend instances.


        </details>

    -   <details><summary style="font-size:20px;color:#FF1493">Components of Load Balancer</summary>

        1. **Scheme**: The Scheme of an AWS Elastic Load Balancer (ELB) determines how the load balancer is exposed — whether it's **internet-facing** or **internal-only**.

        2. **Listeners**: A listener is a process configured on the load balancer to check for incoming client connection requests. It listens for connections using a specified protocol and port and forwards these requests to the appropriate targets based on the rules configured.

            - **Protocols Supported**:
                - HTTP/HTTPS (Application Load Balancer)
                - TCP/TLS/UDP (Network Load Balancer)

            - **Ports**:
                - Common ports include **80** (HTTP) and **443** (HTTPS).
                - You can define custom ports if needed.

            - **Rules**: Define how the load balancer routes traffic to different target groups.

                - `Criteria`: Rules can be based on various criteria.
                    - _Path_: Route traffic based on the path of the incoming request (e.g., `/api`, `/images`).
                    - _Host Header_: Route traffic based on the host header in the request (e.g., `www.example.com`).
                    - _HTTP Headers_: Route traffic based on specific HTTP headers in the request.
                    - _Query Parameters_: Route traffic based on query parameters in the request URL.

                - `Example`: In ALB, rules can include host-based routing (e.g., `www.example.com`) or path-based routing (e.g., `/api`).

            - **Use Cases**:
                - For ALB: You can configure a listener to route traffic for multiple services running on different paths or domains.
                - For NLB: Use listeners to route traffic at a network level for high-throughput applications.

        3. **Target Groups**: A Target Group is a configuration object used by Elastic Load Balancing (ELB) to route requests to one or more registered targets (e.g., `EC2 instances`, `Lambda functions`, `IP addresses`, or `ALB/NLB`). Target groups are central to how Application Load Balancers (ALBs) and Network Load Balancers (NLBs) direct traffic.

            - **Types of Targets**:
                - **Instances**: Routes traffic to specific EC2 instances.
                - **IP Addresses**: Targets specific IP addresses. Useful for hybrid architectures.
                - **Lambda Functions**: ALB supports invoking Lambda functions for serverless applications.

            - **Port**
                - Each target group has a default port (e.g., 80 or 443).
                - Traffic sent to registered targets uses this port unless overridden per target.

            - **Protocol**: Defines what protocol the load balancer uses to communicate with targets:
                - HTTP or HTTPS (for ALB)
                - TCP, TLS, UDP, or TCP_UDP (for NLB)

            - **Health Checks**:
                - Automatically perform health checks on the targets to ensure only healthy ones receive traffic.
                - Parameters include the protocol, ping path, interval, and thresholds.

            - **Routing**: You can associate multiple target groups with different listeners and rules to route traffic intelligently.

            - **Example**:
                - A web app running on multiple EC2 instances can have a target group configured with all those instances.
                - A microservices architecture could have separate target groups for APIs, user interfaces, and static content.

            - **NOTE**:
                - API Gateway is not designed to function behind a load balancer.
                - API Gateway itself is designed to manage traffic, apply security policies, rate limiting, and integrate with AWS services. A Load Balancer in front of API Gateway is **redundant**.

        4. **Load Balancer Nodes**: Load balancer nodes are the actual physical or virtual machines that handle the traffic within AWS. They are managed by AWS and operate behind the scenes to distribute traffic effectively.
            - **Distributed Across AZs**: ELB automatically deploys load balancer nodes in multiple Availability Zones (AZs) for high availability and fault tolerance.

            - **Scaling**:
                - Load balancer nodes automatically scale to handle increases in traffic.
                - When traffic reduces, nodes are scaled down.

            - **Connection Handling**: These nodes terminate client connections and forward requests to the target.

            - **How It Works**:
                - A DNS name (e.g., `my-load-balancer-12345.elb.amazonaws.com`) is provided by AWS.
                - This name resolves to the IP addresses of the load balancer nodes.
                - Clients connect to these nodes, which distribute the traffic to healthy targets.

        </details>

    -   <details><summary style="font-size:20px;color:#FF1493">Features of Load Balancer</summary>

        1. **Health Checks**: Health checks are critical for ensuring that traffic is only sent to healthy targets. ELB continuously monitors the health of targets in a target group and routes traffic to only those that are healthy.

            - **Health Check Configuration**:
                - **Protocol**: HTTP, HTTPS, TCP, or UDP.
                - **Port**: The port on which the health check is performed.
                - **Path**: The specific path for HTTP/HTTPS checks (e.g., `/healthcheck`).

            - **Interval and Timeout**:
                - The interval defines how often the health check is performed.
                - The timeout specifies the time allowed for the target to respond.

            - **Thresholds**:
                - Healthy threshold: Number of consecutive successful responses required to mark the target as healthy.
                - Unhealthy threshold: Number of consecutive failures required to mark the target as unhealthy.

            - **Example**: A target is considered healthy if it returns a `200 OK` HTTP response for 3 consecutive health check requests within the interval.

        2. **Security Groups**: Security groups act as virtual firewalls that control inbound and outbound traffic for the load balancer.
            - **Inbound Rules**: Specify the type of traffic allowed to reach the load balancer (e.g., allow HTTP traffic on port 80 or HTTPS on port 443).
            - **Outbound Rules**: Define the type of traffic that the load balancer can send to targets.
            - **Granular Control**: You can restrict access to specific IP ranges, CIDR blocks, or other AWS resources.

            - **Example**:
                - For an internet-facing ALB, configure a security group to allow public traffic on ports 80 and 443.
                - For an internal-only NLB, restrict traffic to your VPC CIDR range.

        3. **Access Logs**: Access logs provide detailed information about requests processed by the load balancer. These logs are invaluable for debugging, analyzing traffic patterns, and monitoring security.
            - **Stored in S3**: Logs are automatically saved in an S3 bucket that you specify.
            - **Log Contents**: Includes information like the request time, client IP, target details, response status, latency, and more.
            - **Analysis**: Can be analyzed using tools like Amazon Athena, AWS Glue, or third-party log analysis tools.

            - **Use Cases**:
                - Troubleshoot issues with specific clients or requests.
                - Monitor and analyze application performance.

        4. **Elastic IPs (NLB Only)**: Elastic IPs (EIPs) are static IP addresses that can be assigned to the Network Load Balancer for predictable and consistent access.
            - **Static IPs**: NLB can assign Elastic IPs to its nodes in each AZ.
            - **Use Cases**:
                - Simplifies DNS management when clients require fixed IPs.
                - Useful for firewall configurations and hybrid environments.

        5. **DNS Name**: AWS ELB provides a DNS name for each load balancer, which clients use to send requests. The DNS name is associated with the IPs of the load balancer nodes.
            - **Dynamic Resolution**:
                - The DNS name resolves to the IP addresses of the load balancer nodes.
                - AWS handles changes in the underlying infrastructure automatically.
            - **Example**: `my-load-balancer-12345.us-west-2.elb.amazonaws.com`.

        6. **Sticky Sessions (Session Affinity)**: Sticky sessions, Also known as **session affinity**, ensure that requests from the same client are routed to the same target for the duration of the session.
            - **Session Duration**: Controlled by cookies (either AWS-generated or custom).
            - **Use Cases**: Applications that maintain session state (e.g., user login or shopping cart).

        7. **Host-Based and Path-Based Routing (ALB)**:
            - `Host-based routing`: Route requests to different target groups based on the **Host** header (e.g., `api.example.com` vs. `app.example.com`).
            - `Path-based routing`: Route requests based on the URL path (e.g., `/api` vs. `/login`).

        8. **SSL/TLS Termination**:
            - Load balancers can terminate SSL/TLS connections, offloading the encryption and decryption process from the targets.
            - Managed using **AWS Certificate Manager (ACM)** or custom certificates.

        9. **Cross-Zone Load Balancing**: Distributes traffic evenly across all targets in all enabled AZs, regardless of the AZ in which the load balancer node resides.

        10. **Load Balancer Capacity Units (LCU)**:

        11. **Load Balancer Attributes**:

        </details>

    -   <details><summary style="font-size:20px;color:#FF1493">ALB Metrics</summary>

        -   **1. Traffic Metrics**: These reflect the amount of request/response traffic handled by the ALB.

            | **Metric Name**    | **Description**                       | **Unit** |
            | ------------------ | ------------------------------------- | -------- |
            | `RequestCount`     | Number of HTTP(S) requests received   | Count    |
            | `ProcessedBytes`   | Total bytes processed by the ALB      | Bytes    |
            | `IPv6RequestCount` | Number of requests received over IPv6 | Count    |

        -   **3. Error Metrics**: These help identify issues like client or server-side errors.

            | **Metric Name**                  | **Description**                          | **Unit** |
            | -------------------------------- | ---------------------------------------- | -------- |
            | `HTTPCode_ELB_4XX_Count`         | Count of 4XX errors generated by the ALB | Count    |
            | `HTTPCode_ELB_5XX_Count`         | Count of 5XX errors generated by the ALB | Count    |
            | `HTTPCode_Target_2XX_Count`      | 2XX responses from targets               | Count    |
            | `HTTPCode_Target_3XX_Count`      | 3XX responses from targets               | Count    |
            | `HTTPCode_Target_4XX_Count`      | 4XX responses from targets               | Count    |
            | `HTTPCode_Target_5XX_Count`      | 5XX responses from targets               | Count    |
            | `TargetConnectionErrorCount`     | Target connection failures               | Count    |
            | `TargetTLSNegotiationErrorCount` | TLS negotiation errors with targets      | Count    |

        -   **4. Health Check Metrics**: Used to monitor target health within target groups.

            | **Metric Name**      | **Description**             | **Unit** |
            | -------------------- | --------------------------- | -------- |
            | `HealthyHostCount`   | Number of healthy targets   | Count    |
            | `UnHealthyHostCount` | Number of unhealthy targets | Count    |

        -   **6. Rule and Listener Metrics**

            | **Metric Name**      | **Description**                             | **Unit** |
            | -------------------- | ------------------------------------------- | -------- |
            | `RuleEvaluations`    | Number of rule evaluations done by ALB      | Count    |
            | `RedirectCount`      | Number of HTTP redirects issued by rules    | Count    |
            | `FixedResponseCount` | Number of fixed responses sent by ALB rules | Count    |

        -   **8. Target Group-Level Metrics**: Every target group can emit these metrics separately.

            | **Metric Name**             | **Description**                                  | **Unit** |
            | --------------------------- | ------------------------------------------------ | -------- |
            | `TargetResponseTime`        | Average time for a target to respond             | Seconds  |
            | `HTTPCode_Target_XXX_Count` | Per-target-group response codes (2XX, 4XX, etc.) | Count    |
            | `RequestCountPerTarget`     | Average requests per target during the period    | Count    |

            > 💡 All target-level metrics can be filtered by **TargetGroup** and **LoadBalancer** dimensions.

        ##### Performance Metrics of AWS ALB

        -   **1. Latency Metrics**

            | **Metric**                                   | **Description**                                                 | **Unit** |
            | -------------------------------------------- | --------------------------------------------------------------- | -------- |
            | `TargetResponseTime`                         | Time from ALB forwarding request to target → receiving response | Seconds  |
            | `ELBResponseTime` _(custom via access logs)_ | Time ALB takes before forwarding to target                      | Seconds  |

            > 🔹 **Performance Impact:** Higher values indicate slow target responses or backend issues.

        -   **2. Throughput Metrics (Traffic Volume)**

            | **Metric**       | **Description**                             | **Unit** |
            | ---------------- | ------------------------------------------- | -------- |
            | `RequestCount`   | Number of HTTP(S) requests received         | Count    |
            | `ProcessedBytes` | Total bytes processed (in + out) by the ALB | Bytes    |

            > 🔹 **Performance Impact:** Indicates how much load your ALB is handling.

        -   **3. Load Distribution Metrics**

            | **Metric**              | **Description**                         | **Unit** |
            | ----------------------- | --------------------------------------- | -------- |
            | `RequestCountPerTarget` | Avg requests per target in target group | Count    |
            | `HealthyHostCount`      | Number of healthy targets               | Count    |
            | `UnHealthyHostCount`    | Number of unhealthy targets             | Count    |

            > 🔹 **Performance Impact:** Too many requests per target = possible overload.

        -   **5. Connection Metrics**: Used to monitor ALB connections and reuse efficiency.

            | **Metric Name**                  | **Description**                                       | **Unit** |
            | -------------------------------- | ----------------------------------------------------- | -------- |
            | `ActiveConnectionCount`          | Number of active TCP connections                      | Count    |
            | `ClientTLSNegotiationErrorCount` | Number of TLS negotiation failures from clients       | Count    |
            | `NewConnectionCount`             | Number of new TCP connections established             | Count    |
            | `RejectedConnectionCount`        | Rejected connections due to listener or config errors | Count    |

            > 🔹 **Performance Impact:** Connection spikes or rejections can degrade ALB performance.

        -   **7. TLS/SSL Metrics**

            | **Metric Name**                  | **Description**                                | **Unit** |
            | -------------------------------- | ---------------------------------------------- | -------- |
            | `TLSNegotiationErrorCount`       | TLS negotiation errors (client or target side) | Count    |
            | `ClientTLSNegotiationErrorCount` | Errors during TLS negotiation with clients     | Count    |
            | `TargetTLSNegotiationErrorCount` | Errors during TLS negotiation with targets     | Count    |

            > 🔹 **Performance Impact:** TLS negotiation issues delay or fail request handling.

        </details>

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">API Gateways</summary>

    ![API Gateway](../assets/aws/APIGateway.png)

    AWS API Gateway is a fully managed service that makes it easy for developers to create, publish, and manage APIs at any scale. It provides a way to create **RESTful APIs**, **WebSocket APIs**, and **HTTP APIs** that can be used to interact with back-end services, such as AWS Lambda, Amazon EC2, and other AWS services, as well as with third-party services.
    AWS API Gateway is a fully managed service that enables developers to create, publish, and manage **RESTful APIs**, **WebSocket APIs**, and **HTTP APIs** at any scale. It serves as a front-door to various backend services like AWS Lambda, EC2, or any web application. Here are the crucial concepts and components of **AWS REST API Gateway**:
    These components and concepts make API Gateway a robust and scalable solution for creating and managing REST APIs, with seamless integration into the AWS ecosystem. API Gateway allows you to build secure, flexible, and scalable APIs that can interact with a variety of backends, including serverless services like AWS Lambda.
    The **REST API** in API Gateway allows developers to create RESTful web services that can interact with a wide range of backend services. API Gateway acts as an intermediary between the client and the backend.

    -   **Components**:

        -   **Stages**: Different deployment environments (e.g., dev, test, prod) with unique URLs.
        -   **Resources**: Logical endpoints in your API that represent entities or operations.
        -   **Methods**: HTTP methods (e.g., GET, POST, PUT, DELETE) applied to resources.

    -   <details><summary style="font-size:20px;color:#FF1493">Terms and Concepts</summary>

        ##### Stages:

        A **stage** in API Gateway is a logical separation of your API for different environments such as development, testing, or production.

        -   **Features**:

            -   **Stage Variables**: Similar to environment variables, used to define values specific to the stage (e.g., `api_key`, backend endpoint).
            -   **Stage URLs**: Each stage has a unique URL, for example, `https://api-id.execute-api.aws-region.amazonaws.com/prod/`.

        ##### Resources:

        **Resources** represent individual endpoints in your API, which map to a particular functionality or entity in your application.
        A resource is an object that represents an entity, such as a customer, order, or product, in the context of an API. Each resource is associated with one or more methods, such as GET, POST, PUT, DELETE, that can be used to access or manipulate the resource's data.

        -   **Path Parameters**: Resources can include path parameters (e.g., `/users/{user_id}`) to pass variables within the URL.
        -   **Nested Resources**: You can create hierarchical resource paths (e.g., `/users/{user_id}/orders`) to organize related API endpoints.

        ##### Methods:

        Each resource in a REST API can have one or more **HTTP methods** associated with it, defining how the resource can be interacted with (e.g., GET, POST, PUT, DELETE).
        A method is an action that can be performed on a resource, such as retrieving, updating, or deleting data. Each method is associated with an HTTP verb, such as GET, POST, PUT, or DELETE, that indicates the type of action that is being performed.

        -   **Integration with Backends**: Methods define how the API Gateway interacts with backend services, such as AWS Lambda functions, Amazon EC2, or HTTP endpoints.
        -   **Input/Output Mapping**: Request and response payloads can be transformed or mapped to fit the backend’s format using **mapping templates**.

        ##### Integration Types:

        API Gateway allows you to integrate the frontend API with various backend services via different integration types:

        -   **Lambda Integration**: Direct integration with AWS Lambda functions, allowing you to run serverless functions as API endpoints.
        -   **HTTP/HTTP_PROXY Integration**: API Gateway can route requests to HTTP-based backends such as web servers or third-party APIs.
        -   **AWS Service Integration**: Integrate with other AWS services like DynamoDB, SNS, or SQS directly, without requiring Lambda.

        ##### Proxy Integration

        In AWS API Gateway, **Proxy Integration** is a feature that allows the API to pass through all HTTP requests directly to an AWS Lambda function or another HTTP endpoint without configuring each method, parameter, or mapping. It creates a streamlined and flexible setup, especially useful for microservices architectures. Followings are the key points of proxy integration with aws lambda

        1. **Direct Pass-through of Requests**: API Gateway passes the entire request payload to the Lambda function, including the request's headers, query parameters, HTTP method, and body as a JSON object. Lambda receives it in a standard format, making it versatile for different types of requests.
        2. **Single Lambda Handler for All Requests**: With Proxy Integration, a single Lambda function can handle all endpoints and HTTP methods in the API. This reduces the need for defining individual integrations and mappings for each API resource.
        3. **Simplified Deployment**: It streamlines the process of setting up APIs because there’s no need to configure API Gateway resources like request/response templates or parameter mappings. This is especially beneficial for quickly deploying microservices.
        4. **Flexible Response**: The Lambda function returns a response with headers, status codes, and body, which API Gateway then relays back to the client.
        5. **Reduced Configuration**: Since Proxy Integration requires fewer manual configurations, it’s less prone to configuration errors and is generally easier to manage.

        In contrast, **Non-Proxy Integration** involves more detailed configurations for each endpoint and allows for customized mapping and transformations. However, Proxy Integration is typically preferred for simpler, JSON-based APIs that don’t need intricate transformations.

        ##### Endpoints and Custom Domain Names:

        API Gateway provides default **API endpoints** but also allows you to associate your API with a **custom domain name**.

        -   **Features**:
            -   **Regional Endpoints**: Serve requests from specific AWS regions.
            -   **Edge-Optimized Endpoints**: Uses CloudFront to serve requests to globally distributed users.
            -   **Custom Domain**: Map your custom domain name (e.g., `api.yourdomain.com`) to your API Gateway endpoint.

        ##### Authorization:

        API Gateway supports several types of authorization to secure access to your APIs:

        -   **IAM Roles**: Use AWS IAM roles to authorize access to your API based on user identity and policies.
        -   **Cognito User Pools**: Use Amazon Cognito to control access via OAuth2 or JWT-based token authentication.
        -   **Lambda Authorizer**: Use a custom Lambda function to authenticate and authorize requests based on custom logic (e.g., checking API keys, tokens).
        -   **API Keys**: Restrict access to your API using **API keys**, which are passed in the request headers.

        ##### Caching:

        API Gateway provides **caching** at the **stage level** to reduce the latency of your API and improve performance.

        -   **Features**:
            -   Store responses from your backend services in an API Gateway cache.
            -   Specify TTL (Time to Live) for cache data.
            -   Cache data per method and per request, based on query strings or headers.

        ##### Monitoring and Metrics:

        API Gateway integrates with **Amazon CloudWatch** for monitoring, logging, and alerting, giving insights into API performance and usage.

        -   **CloudWatch Metrics**: API Gateway automatically publishes metrics such as **latency**, **error rates**, **cache hits/misses**, and **throttling** counts to CloudWatch.
        -   **CloudWatch Logs**: API Gateway can be configured to log request/response data and error details for debugging.

        ##### Throttling and Rate Limiting:

        API Gateway allows you to control the rate of incoming requests to prevent overloading your backend services.

        -   **Default Throttling**: Set default limits for request rates and burst limits for your API.
        -   **Usage Plans**: Use API keys with usage plans to apply throttling rules and quota limits to individual users or applications.

        ##### API Gateway VPC Link:

        **VPC Link** allows API Gateway to integrate with private resources inside a **VPC**, such as internal web services or databases.

        -   **Features**:
            -   **Private Integration**: Allows API Gateway to access services running in a private VPC without exposing them to the public internet.
            -   Ideal for accessing backend services like EC2, ECS, or load balancers that are hosted in a private subnet.

        ##### Mock Integration:

        **Mock Integration** is used to return static responses without sending requests to any backend. It’s useful for testing and prototyping.

        -   **Features**:
            -   Simulate API responses.
            -   Set up static responses based on incoming requests.
            -   No backend services involved.

        ##### Deployment:

        API Gateway provides the ability to **deploy** APIs to various stages (e.g., dev, test, prod) and manage different versions of your APIs.

        -   **Features**:
            -   **Deployment** creates a snapshot of your API configuration and methods at a specific point in time.
            -   You can **roll back** to previous versions of the API if needed.
            -   Each stage has a unique URL for accessing the deployed API.

        ##### Cross-Origin Resource Sharing (CORS):

        **CORS** is a security feature implemented by browsers to restrict web applications from making requests to a domain different from the one that served the web page.

        -   **Features**:
            -   API Gateway supports **CORS** to allow restricted resources to be accessed on a domain different from the origin.
            -   You can configure **CORS** settings to control which origins and methods are allowed for your API.

        ##### OpenAPI (Swagger) Support:

        API Gateway supports the **OpenAPI Specification (formerly known as Swagger)** for defining your API structure.

        -   **Features**:
            -   Import and export your API definitions using OpenAPI/Swagger files.
            -   Simplifies API development by providing a standard, machine-readable format.
            -   Use OpenAPI definitions for documentation or collaboration purposes.

        ##### API Gateway Policies:

        API Gateway supports **resource policies** that allow you to control access to your API at the **resource level**.

        -   **Features**:
            -   You can restrict access to specific IP ranges, VPCs, or AWS accounts.
            -   Resource policies are useful for implementing fine-grained access control to APIs.

        ##### SDK Generation:

        API Gateway can automatically generate **SDKs (Software Development Kits)** for various programming languages (e.g., JavaScript, iOS, Android) based on your API definitions.

        -   **Features**:
            -   Simplifies the integration of APIs into client applications.
            -   Generates client-side code that can handle API calls, including authentication and request/response handling.

        ##### Error Handling:

        API Gateway allows you to define custom error responses, enabling better error handling in your API.

        -   **Features**:
            -   You can set up custom response templates to format error messages.
            -   Define specific HTTP status codes based on the response from the backend (e.g., 4xx for client errors, 5xx for server errors).

        ##### Access Logs:

        API Gateway provides **detailed access logs** to monitor API usage and analyze performance.

        -   **Features**:

            -   Logs include detailed information such as request timestamps, IP addresses, request/response payloads, and latency.
            -   Access logs can be stored in CloudWatch Logs for long-term analysis.

        </details>

    -   <details><summary style="font-size:20px;color:#FF1493">Features of AWS APIGateway</summary>

        Amazon API Gateway is a fully managed service that acts as a **"front door"** for applications to access data, business logic, or functionality from your backend services. It handles all the tasks involved in accepting and processing up to hundreds of thousands of concurrent API calls, offering a comprehensive set of features for API management. Here are the detailed features of AWS API Gateway:

        -   **API Types and Protocols**: API Gateway supports building and deploying three main types of APIs, each optimized for different use cases:

            -   **REST APIs (RESTful):**
                -   Creates APIs using resources and methods that support standard HTTP methods (GET, POST, PUT, DELETE, etc.).
                -   Offers a full suite of API management features, including API keys, usage plans, and request/response transformations.
                -   Provides higher flexibility and more fine-grained control over the API request/response lifecycle.
            -   **HTTP APIs:**
                -   A lighter-weight, lower-latency, and more cost-effective option for building RESTful APIs.
                -   Optimized for serverless workloads (like AWS Lambda) and public HTTP endpoints.
                -   Best suited for use cases that don't require the full API management features of REST APIs.
            -   **WebSocket APIs:**
                -   Enables **stateful, full-duplex communication** between a client and the server using the WebSocket protocol.
                -   Ideal for real-time, two-way communication applications like chat apps, streaming dashboards, and real-time gaming.

        -   **Security and Access Control**: API Gateway provides robust security features to protect your APIs from unauthorized access and attacks:

            -   **Authentication and Authorization:**
                -   **AWS IAM:** Uses IAM roles and policies to control who can create, deploy, and invoke your APIs.
                -   **Lambda Authorizers (Custom Authorizers):** You can write a custom AWS Lambda function to authorize API requests using bearer tokens (like JWT) or other custom schemes.
                -   **Amazon Cognito User Pools:** Allows using Amazon Cognito as an identity provider to manage user sign-up and sign-in, and secure access to your REST APIs.
                -   **JWT Authorizers:** Natively supports authorization using JSON Web Tokens (JWTs) for HTTP APIs via OpenID Connect (OIDC) and OAuth 2.0.
            -   **Resource Policies:** Uses JSON policies attached to the API to control access based on source IP address ranges (CIDR blocks) or specified AWS accounts/principals.
            -   **AWS WAF Integration:** Seamlessly integrates with **AWS Web Application Firewall (WAF)** to protect your APIs from common web exploits (like SQL injection and cross-site scripting) that could affect availability, compromise security, or consume excessive resources.
            -   **Mutual TLS (mTLS):** For both REST and HTTP APIs, mTLS ensures that both the client and the API Gateway verify each other's identity using certificates.
            -   **Private APIs:** Allows you to expose your APIs only to resources within your Amazon Virtual Private Cloud (VPC) using VPC endpoints.

        -   **Traffic Management and Performance**: Features designed to ensure your APIs can handle high load reliably and performantly:

            -   **Scalability:** API Gateway is an **always-on, scalable service** that automatically handles large traffic volumes without requiring you to manage infrastructure.
            -   **Throttling:** Allows you to define request limits (**rate limits**) and burst capacities at the account, stage, or individual method level to prevent API backend services from being overwhelmed.
            -   **Caching:** For **REST APIs**, you can enable caching to store responses for a specified time-to-live (TTL), reducing the number of calls to your backend and lowering latency.
            -   **Edge Optimization (via Amazon CloudFront):** Uses the **Amazon CloudFront** global edge network to cache and accelerate API requests and responses, providing low latency for end users worldwide.
            -   **Request/Response Transformation:** Supports data mapping and transformation using **Apache Velocity Template Language (VTL)** to convert the request payload before it reaches the backend and the response payload before it's sent back to the client.
            -   **CORS Support:** Provides built-in support for **Cross-Origin Resource Sharing (CORS)**, allowing web applications loaded in one domain to interact with resources from a different domain.

        -   **Integration and Deployment**: API Gateway simplifies the connection to various backend services:

            -   **Backend Integrations:**
                -   **AWS Lambda:** Simplifies building **serverless APIs** by directly invoking Lambda functions.
                -   **HTTP/VPC Link:** Allows integration with any publicly accessible HTTP endpoint or private resources (like an Application Load Balancer or EC2 instance) within a VPC using a VPC Link.
                -   **Other AWS Services:** Native integration with services like Amazon DynamoDB, Amazon S3, AWS Step Functions, and more.
                -   **Mock Integrations:** Allows you to test your API methods without calling the backend, returning a mocked response directly from the Gateway.
            -   **API Management and Lifecycle:**
                -   **Stages:** Allows you to deploy your API to multiple environments (e.g., `dev`, `test`, `prod`) by creating stages, each with its own configuration.
                -   **Canary Release Deployments (REST APIs):** Supports canary release deployments to safely roll out changes by splitting traffic between a current stage and a new stage revision.
                -   **Custom Domain Names:** Enables mapping your custom domain name (e.g., `api.example.com`) to your API endpoint.
                -   **OpenAPI Support:** Supports importing and exporting APIs using **OpenAPI (formerly Swagger) specification** versions 2 and 3.

        -   **Monitoring and Observability**: API Gateway provides tools to monitor and troubleshoot your APIs:

            -   **Amazon CloudWatch Metrics:** Automatically sends detailed performance metrics (like call counts, latency, and error rates) to CloudWatch, allowing you to monitor API usage and set custom alarms.
            -   **CloudWatch Logging:** Supports logging of API execution and access logging to CloudWatch Logs, aiding in debugging and auditing.
            -   **AWS X-Ray Integration:** Integrates with **AWS X-Ray** to provide end-to-end tracing and a visual map of all components involved in an API request, helping to analyze and triage performance issues.
            -   **Usage Plans (REST APIs):** Allows you to manage client usage by defining **usage plans**, including daily or monthly quotas and throttling limits, tied to unique **API keys** issued to third-party developers.

        </details>

    -   <details><summary style="font-size:20px;color:#FF1493">Request-Response Flow</summary>

        The AWS API Gateway **Request-Response Flow** for REST APIs is structured around four main components: **Method Request**, **Integration Request**, **Integration Response**, and **Method Response**. These components allow you to define the external API contract, transform data, enforce security, and map backend results to client responses.

        This intricate setup, often called a **Custom Integration** or **Non-Proxy Integration**, provides the highest degree of control over the data flow between the client and the backend service.

        1. **Method Request (The Client Contract)**: The **Method Request** defines the public-facing contract of your API method. It specifies what API Gateway expects to receive from the client and what validation and authorization checks to perform before routing the request further.

            - **HTTP Method and Resource Path:** The combination (e.g., `GET /users/{id}`).
            - **Authorization:** Defines how the client is authenticated and authorized.
                - **Authorization Type:** Includes AWS_IAM, Cognito User Pools, Lambda Authorizers, or NONE (public access).
                - **Authorization Scopes:** Used with Cognito User Pools to restrict access based on defined scopes.
            - **Request Parameters:** Defines which parameters API Gateway should expect from the client. These can be:
                - **Path Parameters:** (e.g., `{id}` in `/users/{id}`).
                - **Query String Parameters:** (e.g., `?limit=10`).
                - **Headers:** (e.g., `Authorization`, `X-Custom-Header`).
                - **Required Flag:** Specifies whether the parameter is mandatory.
            - **Request Body:** Defines the expected structure of the request body (e.g., for a POST or PUT method).
                - **Request Models:** Associates a **JSON Schema Model** (defined in API Gateway) with a specific Content-Type (e.g., `application/json`).
                - **Request Validation:** Allows you to enable validation of required parameters and/or the request body against the defined models, preventing malformed requests from reaching the backend.

        2. **Integration Request (Request Transformation to Backend)**: The **Integration Request** acts as the crucial translator between the client-facing format (**Method Request**) and the format required by the backend service (the **Integration Endpoint**).

            - **Integration Type:** The service API Gateway will connect to:
                - **AWS:** Connects to an AWS service (e.g., Lambda, DynamoDB, SQS).
                - **HTTP:** Connects to an external HTTP/HTTPS endpoint.
                - **MOCK:** Returns a response directly from API Gateway without hitting a backend.
                - **VPC LINK:** Connects to a private resource in your VPC (e.g., an ALB/NLB).
            - **Integration Endpoint URI:** The exact address of the backend service (e.g., a Lambda ARN, an SQS queue URL, or an external URL).
            - **Credentials/Role:** The **IAM Role** that API Gateway will assume to call the backend service (critical for AWS service integrations like Lambda or DynamoDB).
            - **Request Mapping Templates (The Core Transformation):**
                - These are templates written in **Velocity Template Language (VTL)**.
                - They define how the data collected in the **Method Request** (parameters, headers, body, and **Context variables** like client IP or stage) should be transformed into the payload that the backend expects.
                - _Example:_ Transforming a simple JSON body from the client into the complex DynamoDB `PutItem` JSON structure.
            - **Parameter Mapping:** Maps headers, query string parameters, or path variables from the Method Request to the **Integration Request** parameters (headers, query strings, or path variables) before the VTL transformation.

        3. **Integration Response (Response from Backend)**: The **Integration Response** defines how API Gateway handles the raw response, status codes, and body received from the backend service. It is the first step in translating the backend's internal response format back to a client-friendly API response.

            - **HTTP Status Regex:** This is the most important part. It uses a **regular expression** (regex) to match the HTTP status code or an error message pattern from the backend response.
                - _Example:_ A regex of `2\d{2}` matches any $2\text{xx}$ success code.
                - **Selection:** Based on the match, API Gateway selects the appropriate **Integration Response** configuration.
            - **Response Mapping Templates (Backend-to-Client Transformation):**
                - VTL templates that transform the raw response body received from the backend into the desired client response body format.
                - _Example:_ A Lambda function might return a JSON object like `{"db_status": "OK", "data": {...}}`. The VTL can extract and reformat this to just `{"result": {...}}` for the client.
            - **Header Mappings:** Allows you to extract values from the backend response and map them to new, specific **Integration Response Headers**.

        4. **Method Response (The Final Client Response)**: The **Method Response** defines the final structure of the response that is returned to the client and represents the API's documented output contract. It receives the transformed data from the Integration Response and packages it for delivery.

            - **HTTP Status Code:** Defines the status codes the client will receive (e.g., 200, 201, 400, 500). **A Method Response must be defined for every status code the API can return.**
            - **Response Headers:** Defines which headers will be included in the final response sent to the client. The values for these headers are typically mapped from the **Integration Response** headers.
            - **Response Models:** Associates a JSON Schema Model with the response body for a given status code and Content-Type. This serves primarily for documentation and validation purposes (though response validation is less common than request validation).

            The process completes when the data and headers from the selected **Integration Response** are mapped to the final headers and body of the corresponding **Method Response** structure, which is then sent back to the original client.

        </details>

    -   <details><summary style="font-size:20px;color:#FF1493">Mapping Templates</summary>

        Mapping Templates in AWS API Gateway are the core mechanism for **data transformation** and **mediation** between the external API client and the internal backend service. They are essential for **non-proxy integrations** where you need precise control over the request and response payloads.

        Mapping templates are written using the **Velocity Template Language (VTL)**, which allows you to use simple scripting logic to modify the JSON, XML, or other text payloads.

        ##### Where Mapping Templates are Used

        Mapping templates are used at two critical points in the request-response cycle:

        1. **Integration Request Mapping Template**: This template transforms the incoming client request (the **Method Request**) into the format required by the backend service (the **Integration Request**).

            - **Role:** Translator from **client API contract** to **backend service format**.
            - **Input Data:** Accesses the original request body, headers, query parameters, path parameters, and **context variables** (like the caller's IP or authentication details).
            - **Output Data:** The final payload sent to the backend (e.g., the JSON event for a Lambda function, or the specific JSON structure for a direct DynamoDB API call).
            - **Primary Use Cases:**
                - **Lambda Invocation:** Capturing all request details (headers, body, query strings) and packaging them into a single JSON object that is easy for a Lambda function to parse.
                - **AWS Service Integration:** Transforming a simple HTTP request into the complex JSON required to call an AWS SDK action (e.g., converting a `GET /user/{id}` request into the DynamoDB `GetItem` action format).

        2. **Integration Response Mapping Template**: This template transforms the raw response received from the backend service back into a format suitable for the API client (the **Method Response**).

            - **Role:** Translator from **backend service response** to **client API contract**.
            - **Input Data:** The raw response body received from the backend service (e.g., the JSON object returned by Lambda).
            - **Output Data:** The final response body sent to the client.
            - **Primary Use Cases:**
                - **Flattening/Simplifying:** Removing unnecessary metadata (like AWS service wrappers, DynamoDB data type descriptors, or Lambda function execution context) from the backend's response before sending it to the client.
                - **Error Transformation:** Changing the error body from a backend service into a clean, standardized error message the client understands.
                - **Response Code Override:** Using VTL logic to inspect the backend response body and dynamically override the HTTP status code that API Gateway returns to the client (e.g., inspecting a Lambda response for an "Error" field and changing the status code from 200 to 400).

        -   **Content-Type Handling**:

            -   Mapping templates are associated with **content types**. You can create different templates based on content types like `application/json` or `application/xml`, allowing you to support multiple client formats.
            -   API Gateway then selects the appropriate mapping template based on the content type specified in the client’s request.

        ##### Velocity Template Language (VTL)

        VTL is a simple templating engine that powers the mapping templates. It provides the syntax to access data and apply basic logic.

        -   **VTL Syntax Fundamentals**

            | Syntax   | Description                                            | Example                       |
            | :------- | :----------------------------------------------------- | :---------------------------- |
            | **`#`**  | Used for directives (logic, loops, setting variables). | `#set`, `#if`, `#foreach`     |
            | **`$`**  | Used for variables and references.                     | `$input`, `$context`, `$util` |
            | **`##`** | Used for single-line comments.                         | `## This line is a comment`   |

        -   **Key VTL Variables Available**: You access data within the VTL templates using three main object references:

            | Variable       | Description                                                                                      | Example Usage                                                 |
            | :------------- | :----------------------------------------------------------------------------------------------- | :------------------------------------------------------------ |
            | **`$input`**   | Provides methods to access the **request body and parameters**.                                  | `$input.json('$.user.name')` (selects a field using JSONPath) |
            | **`$context`** | Provides information about the **API execution context**.                                        | `$context.identity.sourceIp` (gets the client IP)             |
            | **`$util`**    | Provides **utility functions** for tasks like JSON parsing, base64 encoding, and error handling. | `$util.base64Encode($input.body)`                             |

        -   **Common VTL Examples**

            1. **Extracting/Selecting Data**: The most common use is to extract specific parts of the request payload using the `$input.path()` or `$input.json()` methods:

            ```vtl
            ## Integration Request to Lambda
            #set($body = $input.json('$'))
            {
            "userId": "$input.params('id')",
            "requestBody": $body,
            "callerIp": "$context.identity.sourceIp"
            }
            ```

            2. **Conditional Logic**: VTL allows for simple conditional checks, useful for handling missing optional fields or dynamic status codes:

            ```vtl
            ## Conditional check for a required header
            #if($input.params('X-Customer-ID') == '')
            #set($context.responseOverride.status = 400)
            #end
            ```

            3. **Looping**: You can iterate over arrays in the payload, which is useful for transforming `application/x-www-form-urlencoded` data or reformatting data structures.

            ```vtl
            ## Used to process an array of items in the request body
            #foreach($item in $input.path('$.items'))
            {
            "itemName": "$item.name"
            }
            #if($foreach.hasNext),#end
            #end
            ```

        Using VTL mapping templates is crucial for achieving **loose coupling** in your architecture, as it allows the external client-facing API and the internal backend service implementation to evolve independently.

        </details>

    -   <details><summary style="font-size:20px;color:#FF1493">JSON Schema (APIGateway Model)</summary>

        JSON Schemas, referred to as **Models** in AWS API Gateway, are reusable, powerful JSON documents that define the **structure, format, and constraints** of the request and response payloads for your API methods. They are defined once per API and can be referenced by multiple methods, serving a dual purpose: **request body validation** and **code generation/documentation**.

        API Gateway Models use the **JSON Schema Draft 4** syntax.

        ##### Primary Functions of API Gateway Models

        1. **Request Body Validation (The Main Use Case)**: This is the most critical function. By associating a Model with a **Method Request** and enabling a **Request Validator**, API Gateway performs schema validation _before_ forwarding the request to your backend service (like a Lambda function).

            - **How it Works:** When a client sends a request with a body, API Gateway checks if the payload adheres to the rules defined in the associated JSON Schema Model (for the specified Content-Type, e.g., `application/json`).
            - **Benefits:**
                - **Offloads Validation:** Moves basic structural validation (type checking, required fields, constraints) from your backend code (e.g., Lambda) to the API Gateway layer. This saves execution time and costs for invalid requests.
                - **Immediate Feedback:** If the request body fails validation, API Gateway immediately returns a $\mathbf{400}$ **Bad Request** error to the client without ever invoking the backend integration.
                - **Security:** Enforces strict data types and prevents unexpected payload structures that could potentially lead to injection or unexpected runtime errors in the backend.

        2. **Payload Transformation Guidance**: When defining a **Mapping Template** (using VTL), you can ask API Gateway to generate a _starter template_ based on the defined Model. This gives you a pre-filled VTL template with all the fields and paths defined in the schema, simplifying the process of writing complex transformation logic.

        3. **Documentation and SDK Generation**: Models serve as essential input for API Gateway's documentation and SDK generation features:

            - They provide a formalized, machine-readable contract for your API's input and output data structures.
            - When you use API Gateway to generate client SDKs (for languages like JavaScript, Android, or iOS), the Models are used to create the corresponding data structures in the target programming language.

        ##### JSON Schema Fundamentals

        API Gateway Models are implemented as JSON objects adhering to the JSON Schema Draft 4 specification. Key keywords define the rules:

        | Keyword                     | Purpose                                                                                                                                                                                                           | Example                                                |
        | :-------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----------------------------------------------------- |
        | **`type`**                  | Defines the data type of the value (e.g., `object`, `array`, `string`, `number`, `integer`, `boolean`).                                                                                                           | `"type": "object"`                                     |
        | **`properties`**            | Used for `type: object`. Defines the fields the object is expected to have.                                                                                                                                       | `"properties": {"name": {"type": "string"}}`           |
        | **`required`**              | An array of property names that **must** be present in the request body.                                                                                                                                          | `"required": ["name", "email"]`                        |
        | **`pattern`**               | A regular expression constraint used for string validation.                                                                                                                                                       | `"pattern": "^[a-zA-Z]+$"` (must contain only letters) |
        | **`minimum`/`maximum`**     | Numeric constraints for `type: number` or `type: integer`.                                                                                                                                                        | `"minimum": 18`                                        |
        | **`maxLength`/`minLength`** | Length constraints for `type: string` or `type: array`.                                                                                                                                                           | `"maxLength": 50`                                      |
        | **`additionalProperties`**  | A boolean (default `true`). Setting this to **`false`** ensures the client cannot include any properties in the payload that are _not_ defined in the `properties` list. This is highly recommended for security. | `"additionalProperties": false`                        |
        | **`$ref`**                  | Used to reference another defined model within the same API, enabling the creation of complex or nested data structures.                                                                                          | `"items": {"$ref": "https://.../models/ItemModel"}`    |

        -   **Example Model (JSON Schema)**: This schema validates a request body for creating a user:

            ```json
            {
                "$schema": "http://json-schema.org/draft-04/schema#",
                "title": "NewUserRequest",
                "type": "object",
                "properties": {
                    "username": {
                        "type": "string",
                        "minLength": 4,
                        "maxLength": 30
                    },
                    "email": {
                        "type": "string",
                        "format": "email"
                    },
                    "age": {
                        "type": "integer",
                        "minimum": 18
                    }
                },
                "required": ["username", "email"],
                "additionalProperties": false
            }
            ```

        ##### Model Integration Steps

        1.  **Create the Model:** Define the JSON Schema in the API Gateway **Models** section.
        2.  **Create a Request Validator:** In the API Gateway console, you create a Request Validator and specify whether it should validate the request body, query parameters, or both.
        3.  **Apply to Method:** In the **Method Request** settings for a specific resource and HTTP verb (e.g., `POST /users`):
            -   Set the **Request Validator** to the one created in step 2.
            -   Under **Request Body**, associate the Model with a **Content-Type** (e.g., map the `NewUserRequest` Model to the content type `application/json`).

        Once these steps are complete, API Gateway will automatically check all incoming `POST /users` requests against the defined schema and reject invalid requests with a $\mathbf{400}$ error before execution even begins.

        </details>

    -   <details><summary style="font-size:20px;color:#FF1493">Usage Plans</summary>

        Usage Plans in AWS API Gateway are a powerful mechanism to control access to your APIs, manage request traffic, and often serve as the foundation for **API monetization and tiered access** for different customers. They bundle together **API Stages**, **Throttling limits**, and **Quotas**, and link them to individual **API Keys**.

        A Usage Plan governs how a client is permitted to interact with your deployed APIs. It is defined by three main components:

        -   **API Stages**: The usage plan defines exactly which deployed API stages it applies to. A single Usage Plan can grant access to **one or more API stages** across one or more REST APIs.

            -   **Example:** A "Premium" usage plan might grant access to the `v2/prod` stage of the `DataAPI` and the `beta` stage of the `AnalyticsAPI`.

        -   **Throttling (Rate Limiting)**: Throttling controls the rate at which clients can submit requests to prevent your backend systems from being overwhelmed by traffic spikes or misuse.

            -   **Rate:** The steady-state average rate, defined as the number of requests per second (RPS) that API Gateway allows.
            -   **Burst:** The maximum number of concurrent requests that API Gateway will service before returning an HTTP **429 Too Many Requests** error. This is based on the **Token Bucket Algorithm**, allowing a client to temporarily exceed the stable rate for short bursts of activity.
            -   **Granularity:** Throttling can be applied at the **API Stage level** and, more importantly, at the **Per-Client/Per-Key level** within the Usage Plan, allowing you to set different throttle limits for different customer tiers (e.g., 10 RPS for Basic, 100 RPS for Gold).

        -   **Quota**: The quota defines the **total number of requests** that an individual client (identified by an API Key) can make within a specified time period.

            -   **Requests:** The total request count limit (e.g., 10,000 requests).
            -   **Period:** The time interval over which the request count is tracked (e.g., day, week, or month).
            -   **Enforcement:** Once a client's request count exceeds the quota for the period, API Gateway will reject subsequent requests with an HTTP **403 Forbidden** error until the next period begins. You can also grant an **extension** to the quota for a specific API Key if needed.

        -   **The Role of API Keys**: Usage Plans are enforced on a per-client basis through **API Keys**.

            -   **API Key Creation:** You create a unique API Key (an alphanumeric string) for each client or customer.
            -   **Association:** Each API Key is explicitly associated with a Usage Plan.
            -   **Client Usage:** When a client makes a request, they must include their API Key in a designated header (usually `x-api-key`).
            -   **Method Requirement:** To enable Usage Plan enforcement, you must explicitly configure individual API methods (or the entire API Stage) to require an API Key. If a method does not require an API Key, it will bypass the usage plan's throttling and quota limits.

            | Plan        | Throttling (RPS)     | Quota (Requests/Month) | Associated API Keys |
            | :---------- | :------------------- | :--------------------- | :------------------ |
            | **Basic**   | Rate: 10, Burst: 5   | 100,000                | Client A, Client B  |
            | **Premium** | Rate: 100, Burst: 50 | 10,000,000             | Client C, Client D  |

        -   **Important Implementation Details and Limitations**:

            -   **Not for Authentication/Authorization:** API Keys should **not** be used for general authentication or authorization (i.e., verifying _who_ a user is or _what_ resources they can access). For that, use mechanisms like **IAM**, **Lambda Authorizers**, or **Cognito User Pools**. API Keys are purely for **usage metering, throttling, and quota enforcement**.
            -   **Best-Effort Enforcement:** Usage plan quotas and throttling are applied on a **best-effort basis**. They are not hard, guaranteed limits, especially under extremely high load. AWS recommends using services like **AWS WAF** for strict request blocking and **AWS Budgets** to monitor costs.
            -   **Viewing Usage:** API Gateway provides a console view to track the usage data for each API Key linked to a Usage Plan, helping you monitor customer consumption.

        </details>

    -   <details><summary style="font-size:20px;color:#FF1493">API KEY</summary>

        API Keys in AWS API Gateway are long, uniquely generated strings used primarily for **tracking, metering, and controlling access rates** to your REST and WebSocket APIs. They act as a token required to identify the calling client and associate that client with a **Usage Plan**.

        **Crucially, AWS strongly recommends against using API Keys alone for authentication or fine-grained authorization.** They are best used as a mechanism for **monetization** and **traffic management**.

        ##### Purpose and Mechanism

        The core function of an API Key is to link an API client to a **Usage Plan**, which dictates how much traffic that client is allowed to send to the API.

        1. **Usage Plans**: An API Key must be associated with a **Usage Plan**. The Usage Plan is where the actual controls are defined:

            - **Throttling:** Sets the steady-state **rate limit** (requests per second) and the maximum **burst limit** (maximum concurrent requests allowed in a short period).
            - **Quota:** Sets the total number of requests a client can make within a specific time period (e.g., 10,000 requests per month).

        2. **The Flow**
            1. **Client Request:** A client sends a request to an API Gateway method that is configured to require an API key, including the key in a specified header (usually `x-api-key`).
            2. **Key Check:** API Gateway checks the provided key against its database of valid keys.
            3. **Usage Plan Association:** If the key is valid, API Gateway identifies the associated **Usage Plan** and **API Stage**.
            4. **Enforcement:** API Gateway checks the client's current usage against the plan's defined **throttling** and **quota** limits.
            5. **Execution/Rejection:**
                - If the limits are exceeded, the request is immediately rejected with a $\mathbf{429}$ **Too Many Requests** status code.
                - If the limits are honored, the request is passed to the backend integration, and the request count for that key is logged.

        ##### Configuration Steps

        To use an API key, you must configure three components:

        3. **Create the API Key**: You generate a unique API key directly within the API Gateway console or via API/CLI. This key is then distributed to the API consumers.

        4. **Configure the API Method**: For each method (`GET`, `POST`, etc.) on a resource that you want to protect, you must explicitly set the **API Key Required** setting to **`true`** in the **Method Request** configuration.

        5. **Create and Associate the Usage Plan**:

            - **Create Usage Plan:** Define the desired Rate, Burst, and Quota.
            - **Associate Stage:** Link the Usage Plan to the specific **API Stage** (e.g., `prod`, `dev`) that contains your API methods.
            - **Associate API Key:** Add the newly created API Key to the Usage Plan. A single API key can grant access to multiple API stages/APIs if they are all included in the same Usage Plan.

        -   **API Key Source**: You can configure where API Gateway looks for the key in the request:
            -   **`HEADER` (Default):** The key is expected in the standard `X-API-KEY` header of the request.
            -   **`AUTHORIZER`:** The key is returned by an identity source (like a Lambda Authorizer) and can be checked against a usage plan.

        ##### API Keys vs. Authorization

        It is crucial to understand the difference between API Keys and true authorization mechanisms:

        | Feature           | API Key                                                                   | IAM or Lambda Authorizer                                                                   |
        | :---------------- | :------------------------------------------------------------------------ | :----------------------------------------------------------------------------------------- |
        | **Primary Goal**  | **Metering and Throttling** (traffic management).                         | **Authentication and Authorization** (identity and permission).                            |
        | **Identity**      | Identifies the **consumer account** or **application**.                   | Identifies the **individual user** (e.g., Jane Doe).                                       |
        | **Granularity**   | Coarse-grained. Checks if the key is **valid** for _any_ API in the plan. | Fine-grained. Checks if the user has permission to access _this specific_ resource/method. |
        | **Best Practice** | Use for **SaaS APIs, Billing, and Rate Limiting**.                        | Use for **User Logon, Role-Based Access Control (RBAC)**, and sensitive data protection.   |

        **API Keys are not sufficient for security.** If a malicious user steals a key, they gain access to all APIs associated with that key's Usage Plan. For security, you should use **IAM Roles**, **Lambda Authorizers**, or **Cognito User Pools** for authentication and authorization, often **in conjunction with** an API Key for metering.

        </details>

    -   <details><summary style="font-size:20px;color:#FF1493">RESTful APIs:</summary>

        RESTful APIs in AWS API Gateway allow you to build, deploy, and manage RESTful APIs at scale. They adhere to the principles of REST (Representational State Transfer) architecture.

        AWS API Gateway is a fully managed service that allows developers to **create, publish, maintain, monitor, and secure REST, HTTP, and WebSocket APIs at any scale**. A RESTful API in API Gateway acts as the "front door" for client applications to access backend services like AWS Lambda, EC2, or other public web services.

        The REST API type in API Gateway is the feature-rich, low-latency option that provides granular control over the API lifecycle.

        -   **Core Concepts and Components**:A REST API in API Gateway is fundamentally structured as a collection of **Resources** and **Methods**.

            1. **API (The Container)**: The top-level entity that contains all the resources and methods for your web service. It is deployed to a specific **Stage** and uses an **Endpoint Type**.

            2. **Resource**: A **Resource** is a logical entity that is accessible via a path and typically maps to a data model (e.g., `/users`, `/products/{id}`).

                - **Resource Path:** The URI component used to access the resource (e.g., `/products`).
                - **Path Parameters:** Variables embedded in the resource path (e.g., `{id}` in `/products/{id}`). These are extracted by API Gateway and passed to the backend.

            3. **Method**: A **Method** is a request handler attached to a **Resource** that corresponds to a standard HTTP verb (**GET, POST, PUT, DELETE, PATCH**). It defines the entry point for a client request and the contract for the response.

            4. **Integration (The Communication Layer)**: The most critical part of the Method, the **Integration** defines how API Gateway communicates with the backend service. It is composed of two main phases:

                | Component                | Description                                                                                                                                                                                                        |
                | :----------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
                | **Method Request**       | The **client-facing interface**. Defines the data expected from the client (path params, query strings, headers, body) and includes **Authorization** and **Request Validation** settings.                         |
                | **Integration Request**  | The **backend-facing configuration**. This is the request API Gateway sends to the backend. It includes data **transformation** using VTL (Velocity Template Language) and specifies the backend endpoint.         |
                | **Integration Response** | The **backend response configuration**. Defines how the response from the backend is handled, including mapping backend status codes to API Gateway status codes and performing **response transformation** (VTL). |
                | **Method Response**      | The **client-facing response**. Defines the expected HTTP status codes, headers, and body models returned to the client.                                                                                           |

        -   **Integration Types**:API Gateway offers several ways to integrate with a backend, giving you flexibility over control and development speed.

            | Integration Type  | Description                                                                                                                                                                                                       | Granular Control? | Use Case                                                                                      |
            | :---------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :---------------- | :-------------------------------------------------------------------------------------------- |
            | **Lambda Proxy**  | A simplified, recommended approach for AWS Lambda. API Gateway sends the entire client request as a single JSON object to Lambda and expects a specific JSON structure in return.                                 | No (Simplified)   | Standard serverless applications (e.g., reading from DynamoDB).                               |
            | **Lambda Custom** | Gives you **full control** over the request and response mapping using **VTL**. API Gateway transforms the request before invoking Lambda and transforms the response before sending it back to the client.       | Yes (Granular)    | Advanced scenarios where you need to integrate with legacy systems or non-standard protocols. |
            | **HTTP Proxy**    | API Gateway acts as a simple pass-through proxy to any **HTTP endpoint** (e.g., a server on EC2, an external third-party API). The client request is forwarded as-is, and the backend response is returned as-is. | No (Pass-Through) | Integrating with existing web services or microservices.                                      |
            | **AWS Service**   | Allows API Gateway to directly call an AWS service action (e.g., DynamoDB's `PutItem`, SQS's `SendMessage`) without needing an intermediary Lambda function. Requires VTL mapping.                                | Yes (Granular)    | Directly interacting with AWS infrastructure to optimize latency and remove Lambda overhead.  |
            | **Mock**          | API Gateway responds immediately without forwarding the request to any backend.                                                                                                                                   | N/A               | Testing, returning static data, or implementing temporary error responses.                    |
            | **Private**       | Used with a **VPC Link** to securely integrate with resources in your Amazon VPC, such as Application Load Balancers (ALBs) or Network Load Balancers (NLBs).                                                     | Yes/No            | Internal APIs for corporate or private applications.                                          |

        -   **Key Features and Advanced Concepts**:

            1. **Deployment and Stages**: An API must be **deployed** to a **Stage** before it can be invoked.

                - **Stage:** A logical reference to a lifecycle state of your API (e.g., `prod`, `dev`, `beta`).
                - **Stage Variables:** Key-value pairs defined in a Stage that can be referenced in the Integration configuration (e.g., to point a `dev` stage to a `DevLambda` function and a `prod` stage to a `ProdLambda` function).

            2. **Authorization and Authentication**: API Gateway offers robust security mechanisms:

                - **IAM Authorization:** Uses AWS Identity and Access Management (IAM) permissions for authenticated calls, typically for clients within the AWS ecosystem.
                - **Lambda Authorizers (Custom Authorizers):** A Lambda function you write to execute authorization logic (e.g., validating custom tokens or session IDs) and return an IAM policy to API Gateway.
                - **Cognito User Pool Authorizer:** Integrates directly with an Amazon Cognito User Pool to manage authentication (signing in users) and authorize API access using tokens (ID and Access Tokens).
                - **API Keys & Usage Plans:** Used for metering, throttling, and controlling access to your APIs.

            3. **Traffic Management**

                - **Throttling:** Limits the number of requests per second for the entire API or for individual methods to protect the backend service from being overwhelmed.
                - **Caching:** Enables caching of API responses to improve latency and reduce the load on your backend. You configure the Time-To-Live (TTL) for cached responses.

            4. **Transformation and Validation**

                - **Mapping Templates (VTL):** Used in the Integration Request and Integration Response to transform the request body/parameters between the client's format and the backend's required format. This is where you can manually map, extract, or compute data.
                - **Request Validation:** Allows you to define JSON Schemas (**Models**) for the request body and validate incoming client requests before they hit the backend. This offloads input validation from your backend service.

            5. **Endpoint Types**: Defines the client-facing public address of your API:
                - **Edge-Optimized (Default):** The API requests are routed through the **Amazon CloudFront** content delivery network (CDN) to minimize latency for geographically dispersed clients.
                - **Regional:** The API is deployed only in the current AWS region. Best for clients primarily in the same region, or when you use your own CDN.
                - **Private:** The API is accessible only from within your Amazon VPC using an **Interface VPC Endpoint**. Best for internal-only applications.

        ##### Terms & Concepts:

        -   `Resource-Based Architecture`: RESTful APIs in AWS API Gateway follow a resource-based architecture where resources (e.g., objects, data) are exposed as endpoints (e.g., URLs) and support standard CRUD operations (Create, Read, Update, Delete) on these resources.
        -   `HTTP Methods`: You can define HTTP methods (e.g., GET, POST, PUT, DELETE) for each resource, allowing clients to interact with the API through these methods.
        -   `Integration`: RESTful APIs can integrate with backend services such as AWS Lambda functions, AWS Elastic Beanstalk applications, or HTTP endpoints. Integration options include Lambda functions, HTTP endpoints, AWS services, and AWS Lambda Proxy integration.
        -   `Security`: API Gateway provides features like AWS IAM authorization, resource policies, and usage plans to secure and control access to your RESTful APIs. You can configure API keys, IAM roles, and resource policies for authentication and authorization.
        -   `Monitoring and Analytics`: You can monitor API usage, performance metrics, and logs using Amazon CloudWatch and Amazon API Gateway's built-in logging and monitoring features. API Gateway provides detailed metrics, access logs, and execution logs for monitoring and troubleshooting.
        -   `Use Cases`: RESTful APIs are suitable for building web services, microservices, and mobile backends where resources need to be exposed and accessed via standard HTTP methods. They are ideal for building CRUD-based applications and adhering to REST architectural principles.

        ##### RESTful APIs Features:

        -   `Protocol Support`:
            -   REST APIs provide comprehensive support for building RESTful APIs according to the principles of Representational State Transfer (REST).
            -   They support HTTP/1.1 and HTTPS protocols.
        -   `Custom Domain Names`:
            -   REST APIs support custom domain names, allowing you to provide a branded API endpoint with your own domain name.
            -   You can configure custom domain names directly within API Gateway without additional mappings.
        -   `Resource-Based Routing`:
            -   REST APIs offer resource-based routing, allowing you to define hierarchical resource structures using paths and HTTP methods (e.g., GET /users, POST /users/{id}).
            -   They follow RESTful design principles, making it easy to organize and expose your API resources.
        -   `Integration Types`:
            -   REST APIs support a variety of integration types, including Lambda functions, HTTP endpoints, AWS services, and AWS Step Functions.
            -   You can choose the integration type that best fits your use case, allowing you to integrate with various backend systems and services.
        -   `API Keys and IAM Roles`:
            -   REST APIs support API keys and AWS Identity and Access Management (IAM) roles for controlling access to your APIs.
            -   You can use API keys to throttle and monitor API usage, and IAM roles to grant fine-grained access permissions to API resources.

        ##### RESTful APIs Limitations:

        While REST APIs in AWS API Gateway offer a wide range of features for building RESTful APIs, they also have some limitations to consider. Here are some of the key limitations of REST APIs in AWS API Gateway:

        -   `Cold Start Latency`: Like other serverless architectures, REST APIs using Lambda functions may experience cold start latency, where the initial invocation of a function takes longer due to resource provisioning. This latency can impact the responsiveness of the API.
        -   `Integration Limits`: REST APIs have integration limits, such as a maximum of 30 integration responses per method, a maximum of 10 authorizers per method, and a maximum payload size of 10 MB for request and response bodies. These limits may impact the complexity and scalability of your API design.
        -   `Rate Limiting Constraints`: While API Gateway supports rate limiting for controlling access to APIs, there are limitations on the granularity of rate limiting configurations. For example, you cannot specify rate limits based on specific API keys or client IPs, and the default rate limit is applied globally to all clients.
        -   `API Gateway Throttling`: API Gateway imposes throttling limits on API requests to prevent abuse and ensure system stability. While throttling is necessary for protecting backend resources, it can lead to temporary service interruptions if request rates exceed the configured limits.
        -   `Payload Transformations`: API Gateway supports payload transformations for modifying request and response payloads using mapping templates. However, these transformations are limited in functionality compared to dedicated transformation services, and complex transformations may require additional processing.
        -   `CORS Configuration`: Cross-Origin Resource Sharing (CORS) configuration in API Gateway has limitations, such as a maximum of 30 CORS configurations per API and restrictions on wildcard (\*) usage. This may impact the flexibility of CORS policies for enabling cross-origin requests.
        -   `Monitoring and Logging Limits`: While API Gateway provides monitoring and logging capabilities for tracking API usage and performance, there are limits on the volume of logs and metrics that can be stored and retained. This may require additional monitoring solutions for long-term data retention and analysis.
        -   `Integration Timeout`: API Gateway imposes integration timeouts for API requests to backend services. If the backend service does not respond within the specified timeout period, the request may fail with a timeout error. Configuring appropriate timeout values is important for handling varying backend response times.
        -   `Integration Response Mapping`: Mapping integration responses to HTTP status codes and headers in API Gateway can be complex, especially for APIs with multiple integration responses. Managing response mappings and error handling logic may require careful configuration and testing.

        </details>

    -   <details><summary style="font-size:20px;color:#FF1493">HTTP APIs:</summary>

        HTTP APIs in AWS API Gateway offer a more lightweight and cost-effective alternative to traditional RESTful APIs. They are optimized for serverless workloads and provide features tailored to modern web applications.

        -   `Simplified Configuration`: HTTP APIs in AWS API Gateway offer a more lightweight and cost-effective alternative to traditional RESTful APIs. They provide simplified configuration options for defining routes, methods, and integrations, making it easier to build and manage APIs.
        -   `Built-in CORS Support`: HTTP APIs provide built-in Cross-Origin Resource Sharing (CORS) support, allowing you to define CORS policies to control access from web browsers. CORS settings can be configured at the API level or the route level.
        -   `JWT Authorizers`: HTTP APIs support JWT (JSON Web Token) authorizers for authentication and authorization. You can use JWT tokens to authenticate and authorize requests, simplifying the implementation of authentication in serverless applications.
        -   `Payload Validation`: HTTP APIs support payload validation, allowing you to validate request and response payloads against JSON schemas or OpenAPI definitions. You can define request and response models and validate incoming and outgoing payloads against these models.
        -   `Cost-Effective`: HTTP APIs offer a lower cost structure compared to RESTful APIs, making them suitable for serverless applications with high traffic volume. They provide a cost-effective option for building modern web applications and serverless microservices.
        -   `Use Cases`: HTTP APIs are well-suited for building modern web applications, single-page applications (SPAs), and serverless microservices where simplicity, scalability, and cost-effectiveness are priorities. They are ideal for scenarios where traditional RESTful APIs may be too complex or costly to manage.

        #### HTTP APIs Features:

        -   `Protocol Support`:
            -   HTTP APIs are designed to provide a low-latency and low-cost option for building HTTP-based APIs.
            -   They support HTTP/1.1 and HTTP/2 protocols.
        -   `API Mapping`:
            -   HTTP APIs offer simplified API mapping, allowing you to map multiple custom domain names to a single API endpoint.
            -   They do not support custom domain names directly; instead, you configure API mappings using API Gateway stages.
        -   `WebSocket Support`:
            -   HTTP APIs support WebSocket connections, making it easy to build real-time, bidirectional communication applications such as chat apps, gaming platforms, and IoT applications.
            -   They provide native WebSocket support, allowing you to handle WebSocket connections without the need for additional services.
        -   `Lambda Proxy Integration`:
            -   HTTP APIs support Lambda proxy integration, where the integration request and response payloads are passed directly to and from Lambda functions.
            -   This simplifies the integration setup and enables you to build serverless applications with Lambda functions as the backend.
        -   `OAuth 2.0 and JWT Authorizers`:

            -   HTTP APIs support OAuth 2.0 and JSON Web Token (JWT) authorizers for authenticating and authorizing API requests.
            -   You can use OAuth 2.0 or JWT tokens to protect your APIs and control access based on user identities or custom claims.

        #### HTTP APIs Limitations:

        -   `Limited Protocol Support`: HTTP APIs support HTTP/1.1 and HTTP/2 protocols but do not support older protocols such as HTTP/1.0. This may limit compatibility with some legacy systems or clients.
        -   `Limited Integration Options`: HTTP APIs have limited integration options compared to REST APIs. They primarily support Lambda functions and HTTP endpoints as backend integrations. While Lambda proxy integration is convenient for serverless architectures, it may not be suitable for complex integration scenarios.
        -   `Limited Deployment Options`: HTTP APIs are only available in the API Gateway version 2.0, which means they do not support the previous version 1.0 deployment options. This may impact migration efforts or compatibility with existing API Gateway features.
        -   `Limited Customization`: HTTP APIs offer fewer customization options compared to REST APIs. For example, they do not support custom domain names directly; instead, you must use API mappings to map custom domain names to API endpoints.
        -   `No Stage Variables`: HTTP APIs do not support stage variables, which are commonly used in REST APIs to define environment-specific configuration values. This may require alternative approaches for managing environment-specific settings.
        -   `No Resource Policies`: HTTP APIs do not support resource policies, which are used in REST APIs to control access to API resources based on IP address or VPC endpoint. This may limit security controls for certain use cases.
        -   `Limited Monitoring and Logging`: HTTP APIs offer basic monitoring and logging capabilities compared to REST APIs. While you can enable logging and monitoring for HTTP APIs, the available metrics and logs may be limited compared to REST APIs.
        -   `Limited API Gateway Features`: Some advanced API Gateway features, such as AWS WAF integration, caching, and request/response transformations, are not fully supported or may have limitations when using HTTP APIs.

        </details>

    -   <details><summary style="font-size:20px;color:#FF1493">WebSocket APIs:</summary>

        WebSocket APIs in AWS API Gateway enable real-time, bidirectional communication between clients and servers over a single TCP connection. They provide full-duplex communication channels.

        -   `Real-time Communication`: WebSocket APIs support low-latency, real-time communication between clients and servers, making them ideal for applications requiring real-time updates and notifications.
        -   `Persistent Connection`: WebSocket APIs establish a persistent connection between clients and servers, allowing both parties to send messages to each other asynchronously.
        -   `Serverless Integration`: You can integrate WebSocket APIs with AWS Lambda functions to handle WebSocket messages and execute business logic in a serverless environment.
        -   `Security`: WebSocket APIs support authentication and authorization mechanisms to secure connections and control access to resources.
        -   `Scalability`: AWS API Gateway automatically scales WebSocket APIs to handle high volumes of concurrent connections and messages.
        -   `Use Cases`: WebSocket APIs are commonly used in applications such as chat applications, multiplayer games, real-time collaboration tools, and financial trading platforms.
        </details>

    -   <details><summary style="font-size:20px;color:#FF1493">Use Cases of API Gateway</summary>

        AWS API Gateway has several practical use cases in data engineering, especially in creating and managing APIs that interface with various data pipelines and processes. Here are some common use cases:

        1. **Exposing Data Processing Pipelines as APIs**

            - **Use Case**: Create APIs for external or internal users to submit data for processing.
            - **Example**: An API that receives data from clients and triggers an AWS Lambda function, which preprocesses and loads the data into AWS S3, DynamoDB, or RDS. This can be used in ETL pipelines.

        2. **Real-Time Data Ingestion for Streaming Pipelines**

            - **Use Case**: Provide a scalable, low-latency endpoint for ingesting streaming data.
            - **Example**: API Gateway can front Amazon Kinesis to ingest real-time event data, such as IoT sensor data, which can then be processed and analyzed in real time.

        3. **Orchestrating Data Jobs via API**

            - **Use Case**: Expose APIs to trigger specific data engineering jobs or workflows.
            - **Example**: Use API Gateway to trigger AWS Step Functions, which orchestrate complex ETL pipelines involving services like Lambda, Glue, or EMR for data processing and transformations.

        4. **Data Enrichment as a Service**

            - **Use Case**: Provide an API to enhance datasets with additional data from external or internal sources.
            - **Example**: An API Gateway that fronts a Lambda function to enrich customer records by calling external APIs (e.g., validating address details or credit scores).

        5. **Secure Data Access for Analytics**

            - **Use Case**: Securely expose APIs to provide controlled access to datasets stored in S3, DynamoDB, or RDS.
            - **Example**: An internal API that returns filtered data from S3 buckets or a database (PostgreSQL/MySQL) based on user roles or other security constraints using AWS Identity and Access Management (IAM) and API Gateway custom authorizers.

        6. **Serverless Microservices for Data Transformation**

            - **Use Case**: Enable microservices architecture for data transformation logic.
            - **Example**: API Gateway can be used to invoke Lambda functions that handle data transformations (e.g., format conversion, aggregations) before persisting the data into a data lake or a data warehouse.

        7. **REST API for Querying and Fetching Data**

            - **Use Case**: Create APIs for querying datasets for downstream applications.
            - **Example**: Use API Gateway to expose a REST API for querying a dataset stored in Amazon Redshift or DynamoDB, enabling data retrieval for dashboards or analytics apps.

        8. **Data Validation and Preprocessing Layer**

            - **Use Case**: Validate incoming data before ingestion into the data pipeline.
            - **Example**: API Gateway can expose an API that receives raw data, performs basic validation (via Lambda), and then forwards the valid data to S3 or a Kinesis stream.

        9. **Monitoring and Logging of Data APIs**

            - **Use Case**: Implement monitoring and logging for data ingestion and processing APIs.
            - **Example**: API Gateway can be used with AWS CloudWatch to monitor API performance, logging, and error tracking for APIs that ingest and process data in real-time systems.

        10. **API Gateway as Proxy for Third-Party Data Sources**

            - **Use Case**: Use API Gateway as a proxy to fetch or send data to third-party APIs.
            - **Example**: API Gateway can proxy requests to external services (e.g., payment processors, data providers) and integrate their data into internal pipelines.

        11. **Public Data APIs for External Partners or Customers**

            - **Use Case**: Expose specific datasets or aggregated data as APIs for external customers or partners.
            - **Example**: A data product that exposes aggregated reports or analytics data via API Gateway to allow external partners to query specific metrics or KPIs.

        12. **Rate Limiting and Throttling for Ingestion APIs**

            - **Use Case**: Control the flow of data ingestion by applying rate limits or throttling.
            - **Example**: API Gateway allows you to set up throttling policies to control the number of requests per second to prevent overloading downstream services like Kinesis, S3, or RDS.

        </details>

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Firewall Manager</summary>

    AWS Firewall Manager (FMS) is a security management service that acts as a **central administration point** for configuring and managing firewall rules and security policies across your accounts and applications within **AWS Organizations**.

    Its core value is providing **consistency, compliance, and centralized control** over various AWS security services at scale.

    Here is a detailed breakdown of its components, resources, features, and concepts.

    #### Core Concepts and Prerequisites

    -   **Centralized Management**:

        -   **Concept:** Instead of logging into dozens or hundreds of individual AWS accounts to configure WAF rules, Security Groups, or Network Firewalls, FMS allows a security administrator to define a single set of policies and automatically deploy them across the entire organization.

    -   **AWS Organizations Integration (Prerequisite)**:

        -   **Concept:** FMS **requires** integration with AWS Organizations. This allows FMS to discover all member accounts and Organizational Units (OUs), which are then used as the scope for applying security policies.
        -   **Delegated Administrator:** You must designate a specific member account (the best practice is not the Management Account) as the **Firewall Manager administrator**. This account is used to create and manage the FMS security policies.

    -   **AWS Config (Prerequisite)**:

        -   **Concept:** FMS uses AWS Config to continuously monitor resources in the member accounts. If a resource becomes non-compliant with the central security policy (i.e., someone locally modifies a firewall rule), AWS Config detects the drift, and FMS can then take remediation action.

    #### The Primary Resource: The Firewall Manager Policy

    The **Policy** is the main resource in FMS. It defines the "What," "Where," and "How" of your security enforcement.

    | Component                              | Description                                                                                                                                                                                                                                                                                                                                                                          |
    | :------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
    | **Security Service Type** (The "What") | The specific AWS security service the policy governs (e.g., WAF, Network Firewall, Shield Advanced, Security Groups).                                                                                                                                                                                                                                                                |
    | **Policy Scope** (The "Where")         | Defines which accounts and resources the policy applies to. You can scope policies by: \<ul\>\<li\>**AWS Accounts / Organizational Units (OUs)**\</li\>\<li\>**Resource Type** (e.g., Application Load Balancer, CloudFront Distribution, VPC)\</li\>\<li\>**Resource Tags** (e.g., apply only to resources tagged `Environment:Production`)\</li\>\</ul\>                           |
    | **Policy Content** (The "Rule")        | The actual security configuration to be enforced (e.g., the specific AWS WAF Web ACL to deploy, or the set of allowed Security Group rules).                                                                                                                                                                                                                                         |
    | **Remediation Action** (The "How")     | Defines the action FMS takes when non-compliant resources are discovered: \<ul\>\<li\>**Auto-Remediate:** FMS automatically reverts the resource back to the compliant state (e.g., re-applies the missing WAF rule).\</li\>\<li\>**Notify Only:** FMS only sends a notification (via SNS) about the non-compliance, leaving manual intervention to the security team.\</li\>\</ul\> |

    #### Centrally Managed Security Services

    FMS centralizes the management of five primary types of AWS security resources, ensuring a consistent security posture across the entire organization.

    | Managed Service                           | Policy Type             | Enforcement/Use Case                                                                                                                                                                                                                                      |
    | :---------------------------------------- | :---------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
    | **AWS WAF**                               | WAF Policy              | Deploys a specified Web ACL or WAF Rule Group to Application Load Balancers, CloudFront, API Gateways, and AppSync.                                                                                                                                       |
    | **AWS Shield Advanced**                   | Shield Advanced Policy  | Automatically enables Shield Advanced protection on designated resources (e.g., Elastic IPs, Load Balancers, CloudFront distributions) across the organization.                                                                                           |
    | **Amazon VPC Security Groups**            | Security Group Policy   | **Content Audit:** Audits existing SGs for overly permissive rules (e.g., port 22 open to `0.0.0.0/0`). **Primary SG:** Enforces a mandatory "primary" security group on all EC2 instances. **Usage Audit:** Finds and cleans up unused or redundant SGs. |
    | **AWS Network Firewall**                  | Network Firewall Policy | Centrally deploys Network Firewall endpoints and associated rule groups into VPCs across accounts, enabling consistent Layer 3-7 traffic filtering across the network perimeter.                                                                          |
    | **Amazon Route 53 Resolver DNS Firewall** | DNS Firewall Policy     | Associates centralized DNS filtering rule groups with VPCs across accounts to block DNS queries to known malicious domains.                                                                                                                               |
    | **Third-Party Firewalls**                 | Third-Party Policies    | Manages policies for firewalls from AWS Marketplace sellers, such as Palo Alto Networks Cloud NGFW or Fortigate CNF.                                                                                                                                      |

    #### Key Features and Concepts in Detail

    -   **Hierarchical Rule Enforcement**:

        -   **Concept:** Allows security teams to enforce a global, mandatory baseline while enabling local application teams to add their own application-specific rules.
        -   **Mechanism:** With WAF policies, for example, FMS can deploy a central rule group (e.g., a "Block known bots" rule) into a local Web ACL without overwriting the application team's existing rules. FMS continuously monitors to ensure the central rules are not removed or tampered with.

    -   **Automatic and Continuous Compliance**:

        -   **Day-Zero Protection:** FMS is integrated with AWS Organizations, meaning that the moment a new account is created or an application team launches a new resource (e.g., an ALB), FMS automatically detects it and applies the relevant policy.
        -   **Compliance Dashboard:** Provides a single-pane-of-glass view showing the compliance status of all accounts and resources against all active FMS policies, complete with non-compliance notifications.

    -   **Multi-Account Resource Groups**:

        -   **Concept:** You can define logical groups of resources across accounts based on common criteria (e.g., all ALBs in accounts belonging to the "eCommerce" OU). Policies are then applied to these resource groups, rather than individual account numbers, simplifying management.

    -   **Remediation Granularity**:

        -   **Audit vs. Auto-Remediate:** Policies can be configured to only _audit_ non-compliant resources, providing a report, or to automatically _remediate_ the resource back to the defined compliant state, enforcing the security policy automatically.

    By leveraging AWS Organizations and continuous compliance features, AWS Firewall Manager moves security governance from a manual, per-account operation to an **automated, organization-wide capability.**

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">WAF</summary>

    AWS WAF (Web Application Firewall) is a security service that helps protect web applications from common web exploits, unauthorized access, and malicious traffic by filtering and monitoring HTTP/HTTPS requests based on defined rules.

    It integrates with **Amazon CloudFront**, **Application Load Balancer (ALB)**, and **API Gateway**, allowing businesses to apply security protections at the edge, before requests reach the application.

    AWS WAF (Web Application Firewall) is a cloud-native service that helps protect your web applications and APIs from common web exploits that may affect availability, compromise security, or consume excessive resources.

    #### Core Components and Concepts

    The architecture of AWS WAF is built around a few central resources that define your protection strategy:

    -   **Rules**: A rule defines the criteria for inspecting a web request and the action to take if the criteria are met. Rules are processed in a specified **Priority** order.

        -   **Criteria (Statements):** Rules contain one or more statements that specify which parts of a web request to inspect (e.g., IP address, HTTP header, body, URI, query string) and the conditions to match (e.g., specific string, regex, SQLi signature, XSS signature).
        -   **Actions:** The action taken when a request matches a rule's criteria can be:
            -   **Allow:** Passes the request to the protected resource.
            -   **Block:** Prevents the request from reaching the resource, returning an HTTP 403 Forbidden response.
            -   **Count:** Tracks the request for logging and metrics but continues processing the request against the remaining rules.
            -   **CAPTCHA / Challenge:** Presents a CAPTCHA puzzle or a silent challenge to the client before allowing the request to proceed, which helps verify human users.

    -   **Rule Groups**: A reusable set of rules that you can include in a Web ACL. They are useful for organizing rules and sharing common logic across multiple Web ACLs.

        -   **AWS Managed Rule Groups:** Pre-built, maintained, and automatically updated sets of rules provided by AWS (e.g., covering the OWASP Top 10 vulnerabilities, Bot Control, or IP reputation lists).
        -   **AWS Marketplace Rule Groups:** Rule groups created and maintained by third-party security vendors.
        -   **Custom Rule Groups:** Rule groups that you create and manage yourself.

    -   **Web Access Control List (Web ACL)**: This is the top-level, primary resource for your WAF configuration. A Web ACL is a collection of rules and rule groups that you want AWS WAF to check against incoming web requests.

        -   **Action:** It includes a **Default Action** (either **Allow** or **Block**) that is applied to any request that does not match any of the rules within the ACL. Typically, the default action is set to **Allow**, and rules are configured to **Block** specific malicious traffic.
        -   **Association:** A single Web ACL is associated with one or more protected AWS resources.
        -   **Web ACL** can be associated with various WAS services like ALB, APIGateway, CloudFront etc
        -   **Web ACL** can have Rules and Rule Groups.

    -   **Web ACL Capacity Units (WCUs)**: A unit of measurement for the operational cost and complexity of a WAF rule, rule group, or Web ACL. AWS WAF limits are based on the total WCUs you consume. More complex rules (like those with advanced regex or body inspection) consume more WCUs.

    #### Features and Terms

    AWS WAF provides several specialized rule types and features to combat specific threats:

    | Feature/Term              | Explanation                                                                                                                                                                                                                                       |
    | :------------------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
    | **Rate-based Rules**      | Automatically block or count requests from an IP address when the number of requests exceeds a specified threshold within a configurable five-minute period. Excellent for mitigating brute-force or application-layer DDoS attacks (HTTP Flood). |
    | **IP Sets**               | Reusable lists of trusted or malicious IP addresses (CIDR ranges) that can be referenced by one or more rules in a Web ACL to explicitly allow or block traffic.                                                                                  |
    | **Geo Match**             | Allows you to allow or block requests based on the country of origin of the web request.                                                                                                                                                          |
    | **Bot Control**           | A Managed Rule Group that provides visibility and control over common and pervasive bot traffic, such as scrapers, scanners, and crawlers. It can distinguish between common bots (like search engines) and malicious ones.                       |
    | **Fraud Control**         | Includes specialized managed rule groups like **Account Takeover Prevention (ATP)** and **Application Fraud Prevention** to protect login pages and other critical areas from credential stuffing and automated fraud attempts.                   |
    | **Tokens and Challenges** | WAF can issue a **Token** to a client after they successfully complete a **CAPTCHA** or **Challenge**. The token is then inspected in subsequent requests, allowing the client to bypass other challenging rules for a short period.              |
    | **Text Transformations**  | Modifications performed on a request component (e.g., normalizing casing, decoding HTML entities) before WAF inspects it for a pattern. This helps prevent attackers from bypassing protection by encoding or obfuscating malicious payloads.     |
    | **Labels**                | A custom string that a rule can apply to a web request when it matches. Subsequent rules in the Web ACL can then inspect these labels and take actions based on the labels applied by prior rules.                                                |

    #### Protected Resources

    AWS WAF is designed to integrate seamlessly with several AWS services that expose your applications to the internet:

    -   **Amazon CloudFront:** Use WAF at the edge for global protection and lower latency.
    -   **Application Load Balancer (ALB):** Protects web applications running on EC2 or other compute services behind an ALB.
    -   **Amazon API Gateway (REST APIs and HTTP APIs):** Secures your APIs against web attacks and abuse.
    -   **AWS AppSync (GraphQL APIs):** Provides protection specifically for GraphQL workloads.
    -   **Amazon Cognito User Pools:** Helps secure user authentication flows.
    -   **AWS App Runner:** Secures web applications deployed with App Runner.

    #### Key Components of AWS WAF

    -   **Web ACL (Web Access Control List)**: A **Web ACL** is the core component of AWS WAF. It acts as a **firewall policy** and consists of **rules** that define how AWS WAF should handle incoming web requests.

        -   **Attach to:** CloudFront, ALB, or API Gateway.
        -   **Each Web ACL consists of:**
            -   **Rules** → Define specific security conditions.
            -   **Rule Groups** → Collections of related rules.
            -   **Default Action** → Allow or Block requests that don’t match any rule.

    -   **Rules**: Rules define conditions that filter traffic based on various attributes. You can create custom rules or use **AWS Managed Rules**.

        -   **Rules Priority**:
        -   **Web ACL Capacity Unit (WCU)**:
        -   `Rate-Based Rule`: Blocks IPs sending excessive requests (prevents DDoS).
        -   `IP Set Rule`: Allows or blocks requests from a list of IPs.
        -   `String Matching Rule`: Filters requests based on headers, body, or query parameters.
        -   `Regex Match Rule`: Matches specific patterns in request data.
        -   `Size Constraint Rule`: Blocks requests exceeding defined size limits.
        -   `Geographical Match Rule`: Blocks requests from specific countries.
        -   `Bot Control Rule`: Detects and blocks bot traffic.

    -   **Rule Groups**: Rule Groups are collections of related rules that can be shared across multiple Web ACLs.

        -   `AWS Managed Rule Groups`:Pre-configured rules for common attacks (e.g., SQL Injection, XSS).
        -   `Custom Rule Groups`:User-defined rules for specific security needs.

    -   **Conditions** : define **how AWS WAF evaluates a request**. Common conditions include:

        -   **IP Match Condition** (specific IP addresses).
        -   **String Match Condition** (specific query strings, URIs, or headers).
        -   **SQL Injection Condition** (SQL attack patterns).
        -   **Cross-Site Scripting (XSS) Condition** (malicious JavaScript).

    -   **Actions**: When a request matches a rule, AWS WAF takes one of the following actions:

        -   `Allow`: Permits the request to pass through.
        -   `Block`: Completely denies the request.
        -   `Count`: Logs the request for monitoring but does not block it.
        -   `CAPTCHA`: Challenges the user with a CAPTCHA test.

    #### AWS WAF Advanced Features

    -   **AWS Managed Rules**: AWS provides pre-configured rule sets to **protect against known vulnerabilities**:

        -   `Core Rule Set (CRS)`:Protects against SQL Injection, XSS, and other common exploits.
        -   `IP Reputation List`:Blocks traffic from known malicious IP addresses.
        -   `Amazon Threat Intelligence Feeds`:Uses AWS security data to block suspicious traffic.

    -   **AWS WAF Logging & Metrics**

        -   Logs traffic data to **Amazon S3**, **CloudWatch Logs**, or **Kinesis Data Firehose**.
        -   Provides insights into attack patterns and blocked requests.

    -   **AWS WAF Rate Limiting (DDoS Protection)**

        -   **Rate-Based Rules** help prevent **Distributed Denial-of-Service (DDoS) attacks** by blocking IPs sending too many requests.
        -   Example: Block IPs that send **more than 2000 requests per 5 minutes**.

    -   **AWS WAF and Shield Integration**

        -   **AWS Shield Standard:** Provides basic DDoS protection (included with AWS WAF).
        -   **AWS Shield Advanced:** Offers enhanced DDoS protection with automated attack mitigation.

    #### AWS WAF Deployment Options

    -   **With Amazon CloudFront (Edge Protection)**

        -   Best for **global applications** and content delivery.
        -   Blocks threats before they reach your application.
        -   Reduces latency by filtering traffic at AWS edge locations.

    -   **With Application Load Balancer (ALB)**

        -   Best for **internal AWS applications and microservices**.
        -   Provides security at the load balancer level.
        -   Works with multiple EC2 instances and containers.

    -   **With API Gateway**

        -   Best for **securing RESTful APIs**.
        -   Protects APIs from attacks like **API scraping, bot abuse, and SQL Injection**.

    #### Summary Table

    | AWS WAF Component     | Description                                                      |
    | --------------------- | ---------------------------------------------------------------- |
    | **Web ACL**           | Defines firewall rules and actions (Allow, Block, Count)         |
    | **Rules**             | Defines specific security conditions                             |
    | **Rule Groups**       | Collections of rules (Managed or Custom)                         |
    | **Actions**           | What to do when a request matches a rule (Allow, Block, CAPTCHA) |
    | **Managed Rules**     | AWS-provided rule sets for common threats                        |
    | **Rate-Based Rules**  | Blocks excessive traffic from a single IP                        |
    | **Logging & Metrics** | Provides insights into blocked requests                          |
    | **Deployment**        | Works with CloudFront, ALB, and API Gateway                      |
    | **DDoS Protection**   | Works with AWS Shield to mitigate large-scale attacks            |

    -   <details><summary style="font-size:20px;color:#FF1493">APIGateway WAF</summary>

        In AWS, **API Gateway WAFs** refer to the integration of **AWS Web Application Firewall (AWS WAF)** with **Amazon API Gateway** to protect API endpoints from security threats, such as SQL injection, cross-site scripting (XSS), bot attacks, and other common web exploits.

        -   **How AWS WAF Works with API Gateway**
            -   **AWS WAF** acts as a **security layer** in front of **Amazon API Gateway**.
            -   You can define **WAF rules** to allow, block, or monitor (count) HTTP(S) requests before they reach your API.
            -   AWS WAF filters incoming requests based on various criteria, such as **IP addresses, request headers, query strings, request body size, or specific attack signatures**.

        ### Key Components of API Gateway WAFs

        -   **1. Web ACL (Web Access Control List)**

            -   A **Web ACL** is a set of rules that define the filtering logic.
            -   It can be associated with **API Gateway**, **CloudFront**, or an **Application Load Balancer (ALB)**.
            -   Rules inside the Web ACL determine which requests are allowed, blocked, or monitored.
            -   **Web ACL Capacity Units** (WCU):
            -   **Rules Priority**:

        -   **2. WAF Rules**

            -   Rules specify conditions that incoming API requests must meet.
            -   Example rule types:
                -   **IP-based rules** (Block requests from specific IP addresses or countries)
                -   **Rate limiting** (Prevent DDoS-like attacks by limiting requests from a single source)
                -   **SQL Injection/XSS rule sets** (Detect and block malicious input)
                -   **Custom rules** using regex patterns, headers, and query string filtering.

        -   **3. Rule Groups**

            -   Collections of pre-defined WAF rules.
            -   AWS provides **Managed Rule Groups** to protect against common attacks.

        -   **4. Logging and Monitoring**

            -   AWS WAF logs can be sent to **Amazon CloudWatch**, **Amazon S3**, or **Amazon Kinesis Data Firehose** for further analysis.
            -   You can use **AWS Shield Advanced** for additional **DDoS protection**.

        -   **How to Attach AWS WAF to an API Gateway**

            1. **Create a Web ACL** in the **AWS WAF console**.
            2. **Define WAF rules** within the Web ACL.
            3. **Associate the Web ACL** with your API Gateway stage:
                - Navigate to API Gateway in AWS Console.
                - Select your **API** → Go to **Stages**.
                - Under **Web Application Firewall (WAF)** settings, attach the Web ACL.

        -   **Benefits of Using AWS WAF with API Gateway**
            -   **Protect APIs from common web attacks** (SQL Injection, XSS, etc.).
            -   **Limit abusive traffic** (Rate limiting, bot mitigation).
            -   **Improve security compliance** (Helps meet security standards).
            -   **Reduce backend load** (Blocks malicious traffic before reaching your API).

        </details>

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">CloudFront</summary>

    AWS CloudFront is a Content Delivery Network (CDN) service that securely delivers data, videos, applications, and APIs to users with low latency and high transfer speeds. It caches content at globally distributed edge locations to optimize performance and reduce load on origin servers.

    #### Key Concepts

    -   **Content Delivery Network (CDN)**

        -   Distributes content globally for low-latency access.
        -   Caches content at edge locations to reduce origin server load.

    -   **Edge Locations**

        -   Data centers positioned globally to cache and deliver content.
        -   Reduces latency for users by serving requests from the nearest edge location.

    -   **Regional Edge Caches**

        -   Intermediate caching layer between origin servers and edge locations.
        -   Optimizes cache hit ratio and reduces origin fetch requests.

    -   **Origin Server**

        -   The original source of content, such as an S3 bucket, an EC2 instance, or an on-premises server.
        -   CloudFront fetches data from the origin when needed.

    -   **Distributions**
        -   Defines how CloudFront delivers content.
        -   Two types:
            -   **Web Distribution** – Used for websites, APIs, and static/dynamic content.
            -   **RTMP Distribution** – Used for streaming media (deprecated).

    #### CloudFront Components

    -   **Behaviors**

        -   Rules that define how CloudFront handles requests.
        -   Configurable per path pattern, including caching policies, origin request settings, and HTTPS enforcement.

    -   **Cache Control**

        -   Managed via headers such as `Cache-Control` and `Expires`.
        -   Determines how long content is stored at edge locations.

    -   **Invalidations**

        -   Allows forced updates by removing objects from cache before expiration.
        -   Can be triggered manually to refresh content immediately.

    -   **Lambda@Edge**

        -   Serverless computing at edge locations.
        -   Used for request/response modifications, authentication, and dynamic content generation.

    -   **Field-Level Encryption**

        -   Encrypts sensitive user data before forwarding to origin.
        -   Ensures security by allowing only authorized applications to decrypt.

    -   **Signed URLs and Signed Cookies**
        -   Restricts access to content using time-limited access control.
        -   Signed URLs apply per file, while signed cookies apply to multiple files.

    #### Security Features

    -   **Origin Access Control (OAC)**

        -   Securely restricts CloudFront access to S3 origins.
        -   Prevents direct access to S3 buckets from outside CloudFront.

    -   **HTTPS and SSL/TLS**

        -   Supports secure content delivery with HTTPS.
        -   Custom SSL certificates can be deployed using AWS Certificate Manager (ACM).

    -   **AWS WAF Integration**
        -   Protects applications from DDoS attacks and malicious traffic.
        -   Blocks suspicious requests at the CloudFront layer.

    #### Logging and Monitoring

    -   **CloudFront Access Logs**

        -   Captures request details for analytics and security monitoring.
        -   Stored in S3 and can be analyzed with AWS Athena or other tools.

    -   **Real-time Metrics and Monitoring**
        -   CloudWatch provides insights into request counts, cache hit ratios, and data transfer usage.
        -   Custom alarms can be set for performance tracking.

    ### How AWS CloudFront Works

    1. **User Request:** A user accesses content (e.g., a webpage, image, or video).
    2. **Edge Location Check:** CloudFront checks if the content is cached at the nearest edge location.
        - If cached, CloudFront serves the content directly.
        - If not cached, CloudFront fetches it from the origin and caches it for future requests.
    3. **Content Delivery:** The user receives the content with low latency.

    </details>

---

