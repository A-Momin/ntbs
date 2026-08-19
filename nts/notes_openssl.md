-   [HTTPS, SSL, TLS & Certificate Authority Explained](https://www.youtube.com/watch?v=EnY6fSng3Ew)
-   [How to encrypt/decrypt data with AWS KMS and OpenSSL?](https://www.youtube.com/watch?v=w_rpeiG7xjQ)

-   <details><summary style="font-size:25px;color:Orange">SSL/TLS Certificate</summary>

    An **SSL/TLS certificate** is a digital certificate that authenticates a website’s identity and enables an encrypted connection between a client (browser) and a server. It ensures that data transmitted over the internet remains **secure, encrypted, and tamper-proof** by using **SSL (Secure Sockets Layer)** or **TLS (Transport Layer Security)** protocols.

    #### Components of an SSL/TLS Certificate

    1. **Public Key (Leaf Certificate)**

        - A cryptographic key embedded in the certificate.
        - Used for encrypting data sent from the client (browser) to the server.
        - Part of the **asymmetric encryption process** (public-private key pair).

    2. **Private Key**

        - A **secret key** stored securely on the server.
        - Used to **decrypt** data encrypted by the public key.
        - Never shared publicly, ensuring security of communication.

    3. **Certificate Chain (Chain of Trust)**

        - A hierarchy that links a server’s SSL/TLS certificate to a **trusted root CA**.
        - Includes:
            - **Root Certificate**: Issued by a trusted CA.
            - **Intermediate Certificates**: Bridge between the Root CA and the end-user certificate.
            - **Leaf Certificate**: The actual SSL/TLS certificate installed on the website.

    4. **Certificate Authority (CA)**

        - A **trusted organization** that issues and verifies SSL/TLS certificates.
        - Ensures the legitimacy of a domain or organization.
        - Examples: **DigiCert**, **Let’s Encrypt**, **GlobalSign**, **Sectigo**.

    5. **Digital Signature**

        - A cryptographic signature by the CA that proves the certificate’s authenticity.
        - Verifies that the certificate has not been altered or compromised.

    6. **Common Name (CN) / Subject Alternative Name (SAN)**

        - **Common Name (CN)**: The domain name the certificate is issued for (e.g., `example.com`).
        - **Subject Alternative Name (SAN)**: Additional domains/subdomains covered under a single certificate (e.g., `www.example.com`, `mail.example.com`).

    7. **Validity Period**

        - Specifies the **start and expiration date** of the certificate.
        - Typically valid for **90 days (Let's Encrypt) to 1-2 years (Commercial CAs)**.

    8. **Fingerprint / Hashing Algorithm**

        - A unique **hash value** (e.g., **SHA-256**) generated for the certificate.
        - Used for integrity verification to detect tampering.

    #### Types of SSL/TLS Certificates

    1. **Domain Validated (DV) Certificates**

        - Provides **basic encryption** and verifies only domain ownership.
        - **Issued quickly** (usually within minutes).
        - Ideal for **blogs, personal websites, and small businesses**.

    2. **Organization Validated (OV) Certificates**

        - Verifies both **domain ownership** and **organization details** (e.g., company name, location).
        - Requires manual verification by the CA.
        - Suitable for **business websites and e-commerce stores**.

    3. **Extended Validation (EV) Certificates**

        - Provides **highest level of authentication and trust**.
        - Verifies **business identity, legal status, and physical existence**.
        - Displays a **company name in the browser address bar** (on some browsers).
        - Ideal for **banks, financial institutions, and large enterprises**.

    4. **Wildcard Certificates**

        - Secures a **primary domain and all its subdomains**.
        - Example: A wildcard certificate for `*.example.com` covers:
            - `www.example.com`
            - `mail.example.com`
            - `blog.example.com`

    5. **Multi-Domain (SAN) Certificates**

        - Protects multiple different domain names under a single certificate.
        - Useful for organizations managing **multiple websites**.

    6. **Self-Signed Certificates**

        - Generated internally without a trusted CA.
        - **Not recommended for public websites** due to browser security warnings.
        - Used for **internal testing and development environments**.

    #### SSL/TLS Handshake Process

    1. **Client Hello**: The browser sends a request to the server, listing supported SSL/TLS versions and cipher suites.
    2. **Server Hello**: The server responds with an SSL/TLS certificate and chosen encryption method.
    3. **Certificate Verification**: The browser verifies the certificate’s authenticity against the CA.
    4. **Key Exchange**:
        - For **RSA encryption**, the client encrypts a session key using the server’s **public key**.
        - For **ECDHE (Elliptic Curve Diffie-Hellman)**, both client and server generate a shared key.
    5. **Session Key Generation**: The server decrypts the session key using its **private key**.
    6. **Secure Communication Established**: Both client and server use the session key for encrypted communication.

    #### Common SSL/TLS Terms and Concepts

    1. **TLS vs. SSL**:

        - **SSL (Secure Sockets Layer)** is the older protocol (SSL 2.0, SSL 3.0).
        - **TLS (Transport Layer Security)** is the modern and secure version (TLS 1.2, TLS 1.3).
        - **TLS 1.3** is the latest version, offering improved performance and security.

    2. **Cipher Suites**: A set of cryptographic algorithms used for securing SSL/TLS connections.

        - Includes:
            - **Key Exchange Algorithm** (RSA, ECDHE)
            - **Symmetric Encryption Algorithm** (AES, ChaCha20)
            - **Hashing Algorithm** (SHA-256, SHA-384)

    3. **Perfect Forward Secrecy (PFS)**: Ensures that **compromising a single session key does not affect past or future sessions**.

        - Uses **Diffie-Hellman key exchange** (DHE, ECDHE).

    4. **SSL/TLS Offloading**: Offloads SSL encryption/decryption to a **load balancer or CDN** (e.g., AWS CloudFront, AWS ELB).

    5. **HSTS (HTTP Strict Transport Security)**: Forces all traffic to use **HTTPS** to prevent downgrade attacks.

    6. **Certificate Transparency (CT)**: A Google initiative to detect fraudulent SSL certificates.

    #### How to Obtain and Install an SSL/TLS Certificate

    1.  **Generate a Certificate Signing Request (CSR)**:

        -   Run the following command to generate a **CSR and private key**:
            ```bash
            openssl req -new -newkey rsa:2048 -nodes -keyout private_key.pem -out csr.pem
            ```
        -   Provide details like **Common Name (CN), Organization, and Country**.

    2.  **Submit CSR to a Certificate Authority (CA)**:

        -   Choose a trusted CA (e.g., Let's Encrypt, DigiCert, Sectigo).
        -   Upload the **CSR file** and complete domain verification.

    3.  **Install the Certificate on the Server**:

        -   Upload the issued certificate (`certificate.crt`) and CA bundle (`ca_bundle.crt`).
        -   Configure the web server to use SSL:

            **For Apache**:

            ```bash
            SSLCertificateFile /path/to/certificate.crt
            SSLCertificateKeyFile /path/to/private_key.pem
            SSLCertificateChainFile /path/to/ca_bundle.crt
            ```

            **For Nginx**:

            ```bash
            ssl_certificate /path/to/certificate.crt;
            ssl_certificate_key /path/to/private_key.pem;
            ```

    4.  **Verify the SSL/TLS Installation**:

        -   Test using an SSL checker like [SSL Labs](https://www.ssllabs.com/ssltest/).

    #### Certificate Pinning

    **Certificate pinning** is a security technique used in applications to **prevent man-in-the-middle (MITM) attacks** by **associating a host with a specific certificate or public key**.

    -   **What It Does**: Instead of trusting any certificate issued by a trusted Certificate Authority (CA), certificate pinning tells your application to **only trust a specific certificate** (or public key) when connecting to a server.

    -   **How It Works**:

        -   When an app (or client) connects to a server (like an API or a website), it receives the server’s SSL/TLS certificate.
        -   Normally, the client checks if this certificate is trusted by verifying it against the CA chain.
        -   With **pinning**, the client compares the server’s certificate or public key **against a hardcoded “pinned” value**.
        -   If they match → the connection proceeds.
        -   If not → the connection is rejected, even if the certificate is otherwise valid.

    -   **Types of Pinning**:

        1. **Public Key Pinning:** Pins the server’s public key.
        2. **Certificate Pinning:** Pins the exact certificate.
        3. **SPKI Pinning:** Pins the Subject Public Key Info (used in many mobile apps).

    -   **Where It's Used**:

        -   **Mobile apps** (iOS, Android)
        -   **Browsers** (though HTTP Public Key Pinning (HPKP) is deprecated)
        -   **API clients** to ensure they’re talking to the correct server

    -   **Benefits**:

        -   Protects against:

        -   Compromised Certificate Authorities
        -   Fake certificates
        -   MITM attacks

    -   **Risks**:

        -   If the pinned certificate changes (e.g., server rotated certs) and the app isn’t updated, it will **fail to connect**.
        -   So it requires careful lifecycle and key management.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Useful OpenSSL Commands</summary>

    -   `$ openssl genpkey -algorithm RSA -out private_key.pem` -> Generate a new private key

    -   `$ openssl req -new -key private_key.pem -out request.csr` -> Generate a CSR (Certificate Signing Request)

    -   `$ openssl req -x509 -days 365 -key private_key.pem -in request.csr -out certificate.crt` -> Generate a self-signed certificate

    -   `$ openssl x509 -in certificate.crt -out certificate.pem -outform PEM` -> Convert a certificate to PEM format

    -   `$ openssl rsa -check -in private_key.pem` -> Check a private key

    -   `$ openssl x509 -text -noout -in certificate.crt` -> Validate the certificate

    -   Verify a certificate and key match

        -   `$ openssl x509 -in certificate.crt -text -noout

            -   `openssl x509 -noout -modulus -in certificate.crt`:

                -   Reads the certificate file (certificate.crt).
                -   Extracts the modulus (a large integer used in cryptographic key pairs).
                -   `-noout` ensures only the modulus is printed (no other metadata).

            -   `| openssl md5`:

                -   Computes the MD5 hash of the modulus for easier comparison.

        -   `$ openssl rsa -noout -modulus -in private_key.pem | openssl md5`

            -   `openssl rsa -noout -modulus -in private_key.pem`:

                -   Reads the private key file (private_key.pem).
                -   Extracts the modulus of the key.
                -   `-noout` ensures only the modulus is printed.

            -   `| openssl md5`:

                -   Computes the MD5 hash of the modulus for easier comparison.

    -   `$ openssl enc -aes-256-cbc -salt -in file.txt -out file.enc` -> Encrypt a file

    -   `$ openssl enc -d -aes-256-cbc -in file.enc -out file.txt` -> Decrypt a file

    -   `$ openssl pkcs12 -export -out certificate.pfx -inkey private_key.pem -in certificate.crt` -> Create a PKCS12 (PFX) file

    -   `$ openssl pkcs12 -in certificate.pfx -nocerts -out private_key.pem` -> Extract a private key from a PKCS12 (PFX) file

    -   `$ openssl pkcs12 -in certificate.pfx -clcerts -nokeys -out certificate.crt` -> Extract a certificate from a PKCS12 (PFX) file

    -   `$ openssl s_client -connect twitter.com:443` ->
    -   `$ openssl s_client -connect twitter.com:443 -showcerts -servername twitter.com` ->

    </details>
