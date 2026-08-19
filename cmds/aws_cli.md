### IAM Commands:

-   `$ aws iam list-users`

### S3 Commands:

The AWS Command-Line Interface (CLI) offers a wide range of commands for interacting with Amazon S3 (Simple Storage Service). Here are some of the most commonly used and useful AWS CLI commands for working with S3:

-   `List Buckets`:

    -   `aws s3 ls`
        -   Lists all the S3 buckets in your AWS account.

-   `Create a Bucket`:

    -   `aws s3 mb s3://bucket-name`
        -   Creates a new S3 bucket.

-   `List Objects`:

    -   `aws s3 ls s3://bucket-name`
        -   Lists objects within a specific S3 bucket.

-   `Copy Objects`:

    -   `aws s3 cp source-filename s3://bucket-name/destination-filename`
        -   Copies a local file to an S3 bucket.
    -   `aws s3 cp s3://source-bucket/source-filename s3://destination-bucket/destination-filename`
        -   Copies an object from one S3 bucket to another.

-   `Upload Objects`:

    -   `aws s3 cp source-filename s3://bucket-name`
        -   Uploads a local file to an S3 bucket.

-   `Download Objects`:

    -   `aws s3 cp s3://bucket-name/source-filename destination-filename`
        -   Downloads an object from an S3 bucket to the local file system.

-   `Sync Folders`:

    -   `aws s3 sync source-directory s3://bucket-name`
        -   Synchronizes a local directory with an S3 bucket, uploading or downloading files as needed.

-   `Delete Objects`:

    -   `aws s3 rm s3://bucket-name/object-key`
        -   Deletes an object from an S3 bucket.
    -   `aws s3 rb s3://bucket-name`
        -   Deletes an empty S3 bucket.
    -   `aws s3 rb s3://bucket-name --force`
        -   Deletes an S3 bucket and all of its contents.

-   `Set Object Permissions`:

    -   `aws s3api put-object-acl --bucket bucket-name --key object-key --acl public-read`
        -   Sets the ACL (Access Control List) for an S3 object to make it publicly readable.

-   `Set Bucket Policy`:

    -   `aws s3api put-bucket-policy --bucket bucket-name --policy file://policy.json`
        -   Sets a bucket policy to define permissions for the entire bucket.

-   `List Bucket Policy`:

    -   `aws s3api get-bucket-policy --bucket bucket-name`
        -   Retrieves the bucket policy for an S3 bucket.

-   `Presign URLs`:

    -   `aws s3 presign s3://bucket-name/object-key`
        -   Generates a pre-signed URL for temporary access to an S3 object.

-   `List Multipart Uploads`:

    -   `aws s3api list-multipart-uploads --bucket bucket-name`
        -   Lists all ongoing multipart uploads in an S3 bucket.

-   `Abort Multipart Upload`:

    -   `aws s3api abort-multipart-upload --bucket bucket-name --key object-key --upload-id upload-id`
        -   Aborts an in-progress multipart upload.

-   `Enable Versioning`:

        -   `aws s3api put-bucket-versioning --bucket bucket-name --versioning-configuration Status=Enabled`
            -   Enables versioning for an S3 bucket.

### CloudWatch:

-   `$ aws logs describe-log-groups --log-group-name-prefix /aws/lambda/`
