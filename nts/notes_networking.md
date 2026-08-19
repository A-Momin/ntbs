<details open><summary style="font-size:25px;color:Orange;text-align:left">Networking</summary>

### Networking Terms & Concepts:

In software engineering, networking refers to the practice of designing, implementing, and maintaining the communication infrastructure that allows different software components, systems, or devices to exchange information. Understanding key terms and concepts in networking is crucial for software engineers working on applications that rely on network communication. Here are some fundamental terms and concepts in the context of networking:

-   **Host**: A "host" refers to any device that has a unique identifier and is connected to a network. A host can be a computer, server, router, printer, or any other networked device capable of sending or receiving data within a network. The concept of a host is fundamental to understanding how devices communicate in a networked environment. Here are key points related to the term "host" in networking:

    -   `Networked Device`: A host is any device that is part of a network and has a unique identifier, often represented by an IP address. This identifier is essential for routing data to and from the device within the network.
    -   `Unique Identifier`: Each host on a network is assigned a unique identifier to distinguish it from other devices. In Internet Protocol (IP) networks, this identifier is an IP address. For example, in IPv4, an IP address looks like "192.168.1.1."
    -   `Endpoints in Communication`: Hosts act as endpoints in network communication. When data is transmitted over a network, it originates from one host and is destined for another host. These endpoints are identified by their unique IP addresses.
    -   `Hostnames`: In addition to IP addresses, hosts are often associated with human-readable names known as hostnames. Hostnames are mapped to IP addresses through Domain Name System (DNS) resolution. For example, the hostname "example.com" might map to the IP address "203.0.113.1."
    -   `Server and Client Hosts`: In client-server architectures, the terms "server" and "client" are often used to distinguish between hosts. A server is a host that provides services or resources, while a client is a host that requests and consumes those services or resources.
    -   `Networked Services`: Hosts on a network provide various services, such as web services, file sharing, email, and more. Servers, in particular, are hosts dedicated to providing specific services to other hosts on the network.

-   **Network**: A network is a collection of interconnected devices or nodes that can communicate with each other. Networks can be local (LAN) or global (WAN) and can use various technologies like Ethernet, Wi-Fi, or cellular networks.
-   **IP Address**: An IP (Internet Protocol) address is a unique numeric identifier assigned to each device on a network. It allows devices to locate and communicate with each other on the Internet or within a local network.

-   **Repeater**: A repeater is a network device that operates at the physical layer (Layer 1) of the OSI model. Its primary function is to regenerate and amplify signals, allowing them to travel longer distances without loss of quality.

    -   `Use Case`: Repeaters are commonly used in network environments where the distance between network segments exceeds the maximum cable length or to overcome signal degradation in long-distance communication.
    -   `Key Characteristics`:
        -   Operates at Layer 1 (Physical Layer).
        -   Regenerates and amplifies signals.
        -   Extends the reach of a network.

-   **Hub**: A hub is a simple networking device that also operates at the physical layer (Layer 1). It is used to connect multiple devices in a local area network (LAN), allowing them to communicate with each other.

    -   `Use Case`: Hubs are basic connectivity devices that are now less common in modern networks. They are often replaced by switches for better performance.
    -   `Key Characteristics`:
        -   Operates at Layer 1 (Physical Layer).
        -   Broadcasts incoming data to all connected devices.
        -   Lacks intelligence to selectively forward data to specific devices.
        -   Shared bandwidth among connected devices, leading to collisions.

-   **Bridge**: A bridge is a network device that operates at the data link layer (Layer 2) of the OSI model. Its primary function is to filter and forward data based on MAC addresses, creating separate collision domains.

    -   `Use Case`: Bridges are used to segment a LAN into smaller, more manageable parts, reducing the overall network traffic and improving performance. They are particularly useful in larger Ethernet networks.
    -   `Key Characteristics`:
        -   Operates at Layer 2 (Data Link Layer).
        -   Uses MAC addresses to forward data between segments.
        -   Segments LAN into collision domains, reducing collisions.
        -   Learns MAC addresses dynamically to build a forwarding table.

-   **Switching**: Switching is a fundamental concept in computer networking that involves the use of network switches to connect devices within a local area network (LAN). Unlike traditional hubs, which operate at the physical layer (Layer 1) and broadcast data to all connected devices, switches operate at the data link layer (Layer 2) of the OSI model. Switching is a more intelligent and efficient way to forward data in a network. Here are key points to understand about switching in networking:

    -   `Switch Operation`: A network switch is a hardware device that uses MAC addresses to forward data frames within a LAN. Each device connected to a switch has a unique MAC address.
    -   `MAC Address Learning`: Switches dynamically learn the MAC addresses of devices connected to their ports. As devices communicate through the switch, the switch builds a table (known as a MAC address table or forwarding table) that maps MAC addresses to specific switch ports.
    -   `MAC Address Forwarding`: When a switch receives a data frame, it looks at the destination MAC address. Using its MAC address table, the switch determines the appropriate port to which the frame should be forwarded. This enables the switch to forward the frame only to the port where the destination device is connected, rather than broadcasting it to all ports.
    -   `Broadcast and Unknown Unicast Handling`: Switches handle broadcasts differently from hubs. Broadcast frames are forwarded to all ports except the one on which the frame was received. Additionally, if a switch receives a unicast frame with a destination MAC address not in its table, it will forward the frame to all ports (flooding) until it learns the correct port.
    -   `Collision Domains`: Switches create separate collision domains for each port, unlike hubs that share a common collision domain. This segmentation helps reduce collisions and enhances the overall efficiency of the network.
    -   `Full-Duplex Operation`: Switches support full-duplex communication, allowing data to be transmitted and received simultaneously on a port. This contrasts with half-duplex communication used in traditional Ethernet networks.
    -   `Microsegmentation`: Switches enable microsegmentation by creating individual collision domains for each switch port. This improves network performance by minimizing collisions and maximizing available bandwidth for connected devices.
    -   `Performance Benefits`: Switching offers significant performance benefits compared to older technologies like hub-based Ethernet networks. It enables faster and more efficient communication by reducing unnecessary traffic and collisions.
    -   Switching has become the standard for LAN connectivity, and modern Ethernet networks primarily rely on network switches for efficient data forwarding. Advanced switches, such as managed switches, offer additional features like VLAN support, Quality of Service (QoS), and security features, making them versatile tools for building and managing complex networks.

-   **NIC (Network Interface Card)**: It is a hardware component that provides the physical connection between a computer or other devices and a network. The NIC is responsible for interfacing with the network media, such as Ethernet cables or wireless signals, and facilitating the transmission and reception of data between the device and the network. Here are key points about NICs in networking:

    -   `Functionality`: The primary function of a Network Interface Card is to enable network communication for a device. It provides the necessary hardware to transmit and receive data over a network.
    -   `Physical Connection`: NICs can be designed for various types of physical connections, including wired connections (Ethernet) or wireless connections (Wi-Fi). Wired NICs typically use Ethernet ports, while wireless NICs use radio frequency signals.
    -   `MAC Address`: Each NIC is assigned a unique Media Access Control (MAC) address, which is a hardware address burned into the NIC's firmware. The MAC address is used to identify the device on the network.
    -   `Communication Protocols`: NICs support specific communication protocols, such as Ethernet. The NIC is responsible for formatting data into frames, adding necessary headers, and handling error checking.
    -   `Drivers`: To operate efficiently, NICs require software known as drivers. These drivers are installed on the operating system of the device and provide the necessary instructions for the NIC to function correctly.
    -   `Connection Speed`: NICs come with varying connection speeds, commonly measured in megabits per second (Mbps) or gigabits per second (Gbps). Common Ethernet NIC speeds include 10/100/1000 Mbps, indicating support for 10, 100, or 1000 megabits per second, respectively.
    -   `Types of NICs`: NICs can be categorized based on their connection types.
        -   Wired NICs: Connected through Ethernet cables.
        -   Wireless NICs (Wi-Fi): Connect to networks using wireless signals.
        -   Fiber NICs: Designed for fiber-optic connections, offering high-speed and long-distance communication.
    -   `Integration`: NICs can be integrated into the motherboard of a computer (onboard NIC) or added as a separate expansion card. Laptops often have built-in wireless NICs.
    -   `Duplex Mode`: NICs can operate in either half-duplex or full-duplex mode. In half-duplex, the NIC can either send or receive data at a time, while in full-duplex, it can perform both tasks simultaneously.
    -   `Auto-Negotiation`: Many modern NICs support auto-negotiation, allowing them to automatically determine the optimal connection speed and duplex mode when connected to a network.

-   **DNS (Domain Name System)**: DNS is a system that translates human-readable domain names (e.g., www.example.com) into IP addresses. It plays a crucial role in enabling users to access websites using domain names rather than numeric IP addresses.
-   **Latency and Bandwidth**: Latency is the delay between the initiation of a network request and the receipt of the corresponding response. Bandwidth refers to the maximum rate at which data can be transmitted over a network.

#### Protocol

A protocol is a set of rules and conventions that dictate how data is transmitted and received over a network. Examples include TCP/IP (Transmission Control Protocol/Internet Protocol) and HTTP (Hypertext Transfer Protocol).

-   **IP (Internet Protocol)**: IP, or Internet Protocol, is a fundamental communication protocol that is used for transmitting data across networks. It is an essential part of the Internet Protocol Suite, which encompasses a set of protocols that govern how data is sent, received, and routed between devices on a network. It works at the network layer (Layer 3) of the OSI model.

    The Internet Protocol is designed to facilitate communication between devices by assigning unique numerical addresses to each device connected to a network. These numerical addresses are known as IP addresses. There are two versions of IP currently in use: IPv4 (Internet Protocol version 4) and IPv6 (Internet Protocol version 6). IPv4 addresses are 32-bit numerical labels, expressed as four sets of decimal numbers separated by dots (e.g., 192.168.1.1), while IPv6 addresses are 128-bit labels, expressed in hexadecimal format.

    -   `Connectionless`: Unlike TCP, IP is connectionless and does not establish a continuous connection before transmitting data.
    -   `Routing`: IP addresses are used to route data between devices on different networks. Routers make decisions based on IP addresses to forward packets to their intended destinations.
    -   `Use Case`: IP is the foundation for all communication on the Internet. It enables devices to send and receive data across networks using IP addresses.

-   **ARP (Address Resolution Protocol)**: Address Resolution Protocol (ARP) is a protocol used in computer networks to map logical addresses (IP addresses) to physical addresses (MAC addresses). It plays a crucial role in facilitating communication between devices on a local network, particularly in Ethernet networks. ARP operates at the data link layer (Layer 2) of the OSI model. Here's an overview of how ARP works:

    -   `Objective`: The main purpose of ARP is to discover the physical (MAC) address associated with a given IP address on a local network.
    -   `ARP Table`: Each device on a network maintains an ARP table, also known as the ARP cache. This table keeps a record of IP-to-MAC address mappings for devices on the local network.
    -   `ARP Request`: When a device needs to communicate with another device on the same local network but does not have the MAC address corresponding to the IP address, it sends an ARP request broadcast message to all devices on the network.
    -   `ARP Reply`: The device with the specified IP address responds to the ARP request with its MAC address. This response is unicast, meaning it is sent directly to the requesting device.
    -   `ARP Cache Update`: Upon receiving the ARP reply, the requesting device updates its ARP table with the newly discovered IP-to-MAC address mapping. This information is then used for future communications with that device.
    -   `Address Resolution`: Once the ARP process is complete, the device has both the logical (IP) and physical (MAC) addresses needed to communicate with the target device on the local network.

    -   `Example ARP Request and Reply`: Suppose Device A wants to communicate with Device B, but it does not know Device B's MAC address. The following steps occur:
        -   Device A sends an ARP request broadcast on the local network, asking, "Who has the IP address for Device B?"
        -   All devices on the local network receive the ARP request, but only Device B responds directly to Device A with its MAC address.
        -   Device A receives the ARP reply from Device B, updates its ARP table with the IP-to-MAC mapping, and can now use this information for direct communication with Device B.
        -   ARP is a critical protocol for enabling communication within local networks, and it ensures that devices can dynamically discover the necessary information to forward data packets to their intended destinations.

-   **TCP (Transmission Control Protocol)**: TCP is one of the core protocols of the Internet Protocol Suite. It provides reliable, connection-oriented communication between devices over a network. TCP ensures that data is delivered in the correct order and without errors.

    -   `Connection-Oriented`: TCP establishes a connection before data transfer and ensures that the data is received in the correct order.
    -   `Reliability`: TCP includes mechanisms for error detection, correction, and flow control to ensure reliable data transfer.
    -   `Stream-oriented`: TCP operates as a stream of bytes, ensuring that data is delivered as a continuous stream without dividing it into packets.
    -   `Use Case`: TCP is commonly used for applications that require a reliable and ordered data delivery mechanism, such as file transfer (FTP), email (SMTP), and web browsing.

-   **UDP (User Datagram Protocol)**: User Datagram Protocol (UDP) is one of the core protocols in the Internet Protocol (IP) suite and operates at the transport layer. It is a connectionless, lightweight protocol designed for fast and efficient communication without the reliability mechanisms found in protocols like Transmission Control Protocol (TCP). Here are key characteristics and features of UDP:

    -   `Connectionless`: Unlike TCP, UDP does not establish a connection before sending data. Each UDP packet is sent independently, making it a connectionless protocol. This lack of connection setup reduces overhead but means there's no guarantee of delivery.
    -   `Unreliable`: UDP does not guarantee the delivery of packets, and it does not implement mechanisms for retransmission or acknowledgment. This makes UDP faster but less reliable compared to TCP.
    -   `Low Overhead`: UDP has lower overhead than TCP because it doesn't include features like flow control, error recovery, and congestion control. As a result, UDP is more suitable for applications where low latency and minimal delay are crucial.
    -   `Packet Structure`: UDP packets, often referred to as datagrams, have a simple structure. They consist of a header and data payload. The header includes source and destination port numbers, length information, and a checksum for error detection.
    -   `Port Numbers`: UDP uses port numbers to identify different services or processes on a device. Port numbers help in routing the data to the correct application.
    -   `Usage Scenarios`:
        -   `Real-Time Applications`: UDP is commonly used in real-time applications where low latency is crucial, such as online gaming, voice-over-IP (VoIP), and streaming media.
        -   `Broadcasts and Multicasts`: UDP is suitable for scenarios where broadcasting or multicasting is required.
        -   `Simple Request-Response Communication`: Applications that can tolerate occasional packet loss and don't require reliable, ordered delivery may choose UDP for simplicity.
        -   `Examples`: DNS (Domain Name System) uses UDP for name resolution, and various streaming protocols like RTP (Real-time Transport Protocol) use UDP for efficient data delivery.

-   **HTTP (Hypertext Transfer Protocol)**: HTTP is an application layer protocol that governs the transfer of hypertext, typically in the form of web pages. It operates on top of the TCP/IP stack and is used for communication between web clients (browsers) and servers.

    -   `Stateless`: Each request from a client to a server is independent, and the server does not retain information about the client's state between requests.
    -   `Text-Based`: HTTP messages are text-based, making them human-readable. Requests and responses consist of headers and, optionally, a message body.
    -   `Request-Response Model`: A client sends an HTTP request to a server, and the server responds with the requested resource or an error message.
    -   `Use Case:`HTTP is the foundation of data communication on the World Wide Web. It enables the retrieval of web pages, images, videos, and other resources.

-   **Relationship Between TCP, UDP, IP, and HTTP**:

    -   `Layered Architecture`:
        -   TCP and IP work together to provide end-to-end communication and routing across networks. TCP ensures reliable, ordered data delivery, while IP handles addressing and routing.
        -   HTTP operates at a higher layer (application layer) and utilizes the services of TCP/IP to transfer data reliably between web clients and servers.
    -   `Protocol Stack`:
        -   TCP and IP are foundational protocols in the TCP/IP protocol stack, which is the basis for communication on the Internet.
        -   HTTP operates on top of the TCP/IP stack, using TCP as its transport layer protocol to ensure reliable data transfer.

#### Subnetting

Subnetting involves dividing a larger network into smaller, more manageable sub-networks. It helps optimize network performance, improve security, and organize IP address assignments.

-   `Subnet`: A subnet, or subnetwork, is a logical subdivision of an IP network. This division is typically done to improve network performance, security, and management. Subnetting allows for the efficient use of IP addresses and helps in organizing and controlling network traffic. The size of a subnet is same as the size of it's CIDR block. To understand subnetting, it's important to grasp some key terms and concepts:
-   `IP Address`: An IP address is a numerical label assigned to each device connected to a computer network that uses the Internet Protocol for communication. It serves two main purposes - host or network identification and location addressing.
-   `Subnet Mask vs CIDR Notation`: Subnet masks and CIDR (Classless Inter-Domain Routing) notation are two different ways of representing network prefixes in IP addressing. They are used to define the boundaries between the network and host portions of an IP address. Both serve similar purposes but are expressed in different formats.

    -   `Subnet Mask`: A subnet mask is a 32-bit number that divides an IP address into network and host portions. It is represented using dotted decimal notation, just like an IP address. The subnet mask uses `1`s to represent the network portion of the address and `0`s for the host portion. For example, the subnet mask `255.255.255.0` means that the first 24 bits are used for network addressing and the remaining 8 bits are available for host addresses.

        -   Subnet masks are used to determine the range of IP addresses available for hosts within a specific subnet. Hosts with IP addresses falling within the same subnet share the same network characteristics.
        -   Routers use subnet masks to make routing decisions. When a router receives a packet, it looks at the destination IP address and subnet mask to determine the appropriate route to forward the packet.
        -   Subnet masks are often used in private network addressing (e.g., in a local area network) where certain address ranges are reserved for private use. Network Address Translation (NAT) is commonly used to map private addresses to a single public IP address when connecting to the internet.

    -   `CIDR (Classless Inter-Domain Routing)`: CIDR is a notation for representing a range/block of IP addresses with their associated `network prefix`. It allows for a more flexible allocation of IP addresses than the older class-based system (Class A, B, and C networks). CIDR notation includes both the IP address and the length of the network prefix, separated by a slash ("/"). For example, `10.0.0.0/16` indicates a network with a 16-bit prefix and represents a CIDR block with a range of IP addresses from 10.0.0.0 to 10.0.255.255. The size of a CIDR block is $2^{32 − Prefix Length} = 2^{32 − 16} = 2^16$
    -   `Network Prefix`: A network prefix, often referred to simply as a "prefix," is a part of an IP address that represents the network itself. It is used in conjunction with a subnet mask or CIDR notation to define the boundaries between the network and host portions of an IP address.
    -   `Examples 1`:
        -   IP Address: 192.168.1.10
        -   Subnet Mask: 255.255.255.0
        -   CIDR notation: 192.168.1.0/24
        -   Network Prefix Length: 24
    -   `Examples 2`:
        -   IP Address: 10.0.0.5
        -   Subnet Mask: 255.255.255.128
        -   CIDR notation: 10.0.0.0/25
        -   Network Prefix Length: 25

-   `Network Address`: The network address is the address representing the entire network. In a subnet, it is the base address, and typically the first usable IP address in a subnet is reserved for the network address.
-   `Broadcast Address`: The broadcast address is a special address that allows information to be sent to all devices within a specific subnet. It is the highest address in the range and is often reserved for broadcasting messages to all hosts on the subnet.
-   `Host Address Range`: The host address range represents the usable IP addresses within a subnet, excluding the network and broadcast addresses. This range is available for assignment to individual devices on the network.
-   `VLSM (Variable Length Subnet Masking)`: VLSM allows for the use of different subnet masks on the same network address space. This is particularly useful when subnetting a larger network into smaller subnets with varying size requirements.
-   `Supernetting`: Supernetting is the opposite of subnetting. It involves combining smaller network blocks into a larger, aggregated block. This can be useful for optimizing routing tables and reducing the number of entries in a routing table.

#### Routing

Routing is the process of directing data packets between different networks or sub-networks. Routers are devices that make routing decisions based on network topology and the destination IP address of the packets. Routing is a fundamental concept in computer networking that involves the process of determining the path for data to travel from its source to its destination across a network. Routing is crucial for the proper functioning of the internet and other interconnected networks. Here are key terms and concepts related to routing:

-   `Router`: A router is a networking device that forwards data packets between computer networks. Routers operate at the network layer (Layer 3) of the OSI model and use routing tables to make decisions about where to forward packets based on destination IP addresses.
-   `Routing Table`: A routing table is a data structure stored in a router that contains information about the available routes to various network destinations. The table includes entries specifying the next-hop router or the outgoing interface, along with metrics and other information used to determine the best path for packet forwarding.
-   `Routing Protocol`: A routing protocol is a set of rules that routers use to communicate with each other and share information about the network's topology. Common routing protocols include OSPF (Open Shortest Path First), RIP (Routing Information Protocol), BGP (Border Gateway Protocol), and EIGRP (Enhanced Interior Gateway Routing Protocol).
-   `Static Routing`: Static routing involves manually configuring the routing table on a router. Administrators define the routes and specify the next-hop router or outgoing interface. While simple, static routing can be less flexible and scalable compared to dynamic routing.
-   `Dynamic Routing`: Dynamic routing protocols allow routers to automatically exchange information about network changes. This enables routers to dynamically adjust their routing tables based on factors like link failures, congestion, or changes in network topology. Dynamic routing protocols enhance scalability and adaptability.
-   `Default Gateway`: The default gateway is the router that a device uses to reach destinations outside its own subnet. When a device wants to communicate with a host on another network, it sends the traffic to its default gateway, which then forwards the packets toward the destination.

#### Firewall

A firewall is a security device or software that monitors and controls incoming and outgoing network traffic based on predetermined security rules. It helps protect a network from unauthorized access and potential security threats. A firewall is a barrier designed to prevent unauthorized access to or from a private network while allowing authorized communications. It can be implemented in both hardware (physical devices) and software (programs running on servers or network devices). a firewall primarily operates at the network layer (Layer 3) and sometimes extends its functionality to the transport layer (Layer 4) and above.

-   `Network Layer (Layer 3)`:
    -   Firewalls often operate at the network layer, examining IP addresses and making decisions based on routing and packet filtering. This is where traditional packet-filtering firewalls function.
    -   The firewall may allow or block traffic based on source and destination IP addresses, as well as specific protocols (e.g., TCP, UDP, ICMP).
-   `Transport Layer (Layer 4)`:
    -   Some firewalls offer functionality at the transport layer, where they can inspect and control traffic based on port numbers. This is commonly known as a stateful firewall.
    -   Stateful firewalls keep track of the state of active connections, making decisions based on the context of the communication, such as whether a connection is part of an established session.
-   `Application Layer (Layers 5-7)`:
    -   While the primary role of firewalls is at the network and transport layers, application layer firewalls, often referred to as proxy firewalls, can operate at Layers 5-7.
    -   Proxy firewalls inspect and filter traffic at the application layer, making decisions based on the content of the data payload. This allows for more granular control and the ability to filter specific applications or services.
-   `Packet Filtering and ACLs`:
    -   In the context of the OSI model, firewalls use packet filtering and Access Control Lists (ACLs) to make decisions about whether to permit or deny traffic.
    -   Packet filtering involves examining the headers of individual packets to determine whether they meet the criteria defined in the firewall rules.
-   `Network Segmentation`:
    -   Firewalls are often used to segment networks into different security zones, creating isolated areas with controlled access.
    -   For example, a firewall may separate an internal network from the external internet or create demilitarized zones (DMZ) for hosting public-facing services.
-   `Virtual LANs (VLANs)`: Firewalls can be used in conjunction with Virtual LANs to enforce security policies between different VLANs within a network.

-   `Packet Filtering`: Packet filtering is a basic form of firewall functionality that examines packets of data and determines whether to allow or block them based on specified criteria. These criteria often include source and destination IP addresses, port numbers, and the protocol type.
-   `Stateful Inspection`: Stateful inspection, also known as dynamic packet filtering, goes beyond packet filtering by keeping track of the state of active connections. It makes decisions based on the context of the traffic, allowing or blocking packets based on their relationship to established connections.
-   `Proxy Server`: A proxy server acts as an intermediary between client devices and the internet. It intercepts requests and responses, forwarding them on behalf of the clients. This provides an additional layer of security by hiding the internal network structure and potentially filtering and caching content.
-   `Network Address Translation (NAT)`: NAT is a method used by firewalls to modify network address information in packet headers while in transit. It enables multiple devices on a local network to share a single public IP address, enhancing security and conserving IP address space.
-   `Application Layer Filtering`: Firewalls with application layer filtering operate at the application layer (Layer 7 of the OSI model) and can inspect and control specific applications or protocols. This allows for more granular control over the types of traffic permitted or denied.
-   `Intrusion Detection System (IDS) and Intrusion Prevention System (IPS)`: An IDS monitors network or system activities for malicious activities or security policy violations. An IPS goes a step further by actively preventing or blocking detected threats. Firewalls may incorporate IDS or IPS features for enhanced security.
-   `DMZ (Demilitarized Zone)`: A DMZ is a network segment that sits between an organization's internal network and an external network, such as the internet. Servers and services that need to be accessible from the internet, like web servers, are often placed in the DMZ, separated from the internal network by firewalls.
-   `Rule-Based Filtering`: Rule-based filtering involves defining a set of rules that dictate how the firewall should handle incoming and outgoing traffic. Rules can specify conditions such as source and destination IP addresses, port numbers, and the allowed protocols.
-   `VPN (Virtual Private Network) Support`: Firewalls often include VPN support to facilitate secure communication over public networks. VPNs use encryption and tunneling protocols to create a secure connection, allowing remote users or branch offices to connect to the corporate network.
-   `Logging and Auditing`: Firewalls maintain logs of network activity, which can be crucial for security analysis, troubleshooting, and compliance with regulations. Auditing features help organizations track and review firewall events and rule violations.
-   `Application Layer Gateways (ALG)`: ALGs are components of firewalls that understand specific applications or services and can interpret and control the associated traffic. For example, an FTP ALG can intelligently handle File Transfer Protocol traffic.

#### Secure Socket Layer/Transport Layer Security (SSL/TLS)

SSL/TLS protocols provide secure communication over a computer network. In software engineering, developers implement SSL/TLS to encrypt data transmitted between clients and servers, ensuring confidentiality and integrity during data transfer.
SSL (Secure Sockets Layer) and its successor TLS (Transport Layer Security) are cryptographic protocols designed to provide secure communication over a computer network, commonly the internet. SSL was developed by Netscape in the mid-1990s, and TLS is its standardized successor. These protocols ensure that the data exchanged between clients and servers remains private, integral, and secure. Here's how SSL/TLS contributes to network security:

-   `Handshake Protocol`: The SSL/TLS handshake is the initial step in establishing a secure connection. During the handshake, the client and server exchange information, including supported cryptographic algorithms, session keys, and digital certificates. This process ensures that both parties agree on the security parameters for the communication.
-   `Key Exchange`: SSL/TLS supports various methods of key exchange to establish a secure communication channel. This includes both asymmetric (public-key) and symmetric (shared secret) encryption. The key exchange methods are designed to secure the confidentiality of data during transmission.
-   `Digital Certificates`: Digital certificates are a critical component of SSL/TLS, providing a means of authenticating the identity of the server. The server presents a digital certificate, typically signed by a trusted Certificate Authority (CA), to prove its legitimacy. This helps users verify that they are connecting to the intended and legitimate server.
-   `Public-Key Infrastructure (PKI)`: SSL/TLS relies on a Public-Key Infrastructure for managing digital certificates and public/private key pairs. Certificate Authorities issue digital certificates, and clients use these certificates to verify the authenticity of the server's public key.
-   `Encryption Algorithms`: SSL/TLS supports various encryption algorithms for securing data during transmission. This includes symmetric key algorithms (such as AES) for encrypting the actual data and asymmetric key algorithms (such as RSA) for secure key exchange during the handshake.
-   `Session Management`: SSL/TLS can establish a secure session between a client and a server. Once the session is established, it allows for the efficient reuse of cryptographic parameters, reducing the overhead of repeated handshakes for subsequent connections.
-   `Data Integrity`: SSL/TLS uses cryptographic hash functions to ensure the integrity of transmitted data. This means that any unauthorized modification or tampering with the data during transit can be detected by the recipient.
-   `Cipher Suites`: A cipher suite is a combination of cryptographic algorithms used for key exchange, encryption, and authentication. SSL/TLS supports multiple cipher suites, and the negotiation during the handshake determines the most suitable one for the connection.
-   `Perfect Forward Secrecy (PFS)`: Some implementations of SSL/TLS support Perfect Forward Secrecy, ensuring that the compromise of a long-term secret key does not compromise past or future session keys. This enhances the security of communications even if long-term keys are compromised.
-   `HTTPS (HTTP Secure)`: SSL/TLS is commonly used to secure HTTP traffic, resulting in the HTTPS protocol. When a website uses HTTPS, the data exchanged between the user's browser and the server is encrypted and secured, providing a more secure browsing experience.
-   `SSL/TLS Versions`: Over time, SSL and TLS have seen multiple versions, with each version introducing improvements in security and performance. It's important to use the latest and most secure versions, as older versions may have vulnerabilities.

#### OSI ([Open Systems Interconnection](https://www.practicalnetworking.net/series/packet-traveling/osi-model/)):

The OSI (Open Systems Interconnection) model is a conceptual framework that standardizes the functions of a telecommunication or computing system into seven abstraction layers. Each layer represents a specific set of functions and protocols, and the model was developed to facilitate interoperability between different systems. Here are the seven layers of the OSI model along with key terms and concepts associated with each layer:

1. **Physical Layer (Layer 1)**: The physical layer deals with the transmission and reception of raw binary data over a physical medium such as cables or wireless signals. Key concepts include:

    - `Bit`: The basic unit of digital information, representing a 0 or 1.
    - `Voltage, Signal, Cable Types`: Physical aspects of data transmission.

2. **Data Link Layer (Layer 2, Hop to Hop)**: The data link layer provides error detection and correction, as well as framing and addressing of data packets. Key concepts include:

    - `Frames`: The data link layer organizes raw bits into frames, adding header and trailer information.
    - `MAC Address`: Media Access Control address uniquely identifies devices on a network.
    - `Switches and Bridges`: Devices operating at the data link layer to forward frames within a local network.

3. **Network Layer (Layer 3, End to End)**: The network layer is responsible for logical addressing, routing, and forwarding of packets between different networks. Key concepts include:

    - `IP Address`: Internet Protocol address used for network layer addressing.
    - `Routing`: Process of determining the best path for data to travel between source and destination networks.
    - `Routers`: Devices that operate at the network layer to route data between different networks.

4. **Transport Layer (Layer 4, Service to Service)**: The transport layer ensures end-to-end communication, error recovery, and flow control between devices on different networks. Key concepts include:

    - `Segments`: The transport layer breaks down data from the upper layers into segments.
    - `TCP (Transmission Control Protocol)`: Connection-oriented protocol providing reliable, ordered delivery of data.
    - `UDP (User Datagram Protocol)`: Connectionless protocol offering faster, but less reliable, data delivery.

5. **Session Layer (Layer 5)**: The session layer manages and terminates sessions (communication links) between applications. It establishes, maintains, and synchronizes the dialogue between two devices. Key concepts include:

    - `Dialog Control`: Manages sessions, allowing for full-duplex or half-duplex communication.
    - `Session Establishment, Maintenance, and Termination`: Handles the creation, maintenance, and closure of sessions.

6. **Presentation Layer (Layer 6)**: The presentation layer is responsible for data translation, encryption, and compression to ensure that data is presented in a readable format. Key concepts include:

    - `Data Encryption and Compression`: Ensures secure and efficient data transfer.
    - `Translation Services`: Converts data formats between the application and lower layers.

7. **Application Layer (Layer 7)**: The application layer provides a network interface for application software. It enables communication between software applications on different devices. Key concepts include:
    - `Network Services`: Provides network services directly to end-users or applications.
    - `Protocols`: Application layer protocols like HTTP, FTP, SMTP, and DNS.

Understanding the OSI model helps in conceptualizing the various functions and interactions that occur within a networked system. It serves as a reference framework for discussing and designing network architectures and protocols, aiding in the development of interoperable and modular networking technologies.

</details>

---

<details open><summary style="font-size:25px;color:Orange;text-align:left">Linux Networking</summary>

-   `$ ping google.com`
-   `$ ifconfig`
-   `$ `
-   `$ `
-   `$ netstat -i`
-   `$ netstat -ta`
</details>

---

<details open><summary style="font-size:25px;color:Orange">Interview Questions on Networking</summary>

<details><summary style="font-size:18px;color:#C71585">What is a computer network?</summary>

</details>

What is the purpose of SSL/TLS?
Explain the TCP/IP model.
Explain the difference between TCP and UDP.
Describe the differences between TCP and UDP headers.
What is the purpose of the TCP handshake process?
What are the layers of the OSI model?
What is the difference between a router and a switch?
What is the purpose of a subnet mask?
What is ARP (Address Resolution Protocol)?
Describe the purpose of ARP poisoning.
What is NAT (Network Address Translation)?
What is a VLAN (Virtual Local Area Network)?
Describe the concept of VLAN trunking.
Explain the concept of routing.
What is a gateway in networking?
Describe the role of a firewall in a network.
What is a proxy server and how does it work?
Explain the difference between half-duplex and full-duplex communication.
What is a subnet and why is it used?
What is a default gateway?
What is a broadcast domain?
Explain the difference between a hub and a switch.
What is the purpose of ICMP?
What is a packet sniffer?
What is the significance of the TTL (Time-to-Live) field in IP packets?
What is a loopback address?
Explain the purpose of NAT traversal techniques.
What is the difference between IPv4 and IPv6?
Describe the difference between static and dynamic IP addressing.
What is a subnet mask and how is it used in networking?
Explain the concept of Quality of Service (QoS).
What is a DMZ (Demilitarized Zone)?
Describe the difference between symmetric and asymmetric encryption.
What is a VPN (Virtual Private Network) and how does it work?
Explain the concept of port forwarding.
Explain the difference between static and dynamic routing.
Describe the process of IP fragmentation.
What is the purpose of a subnet calculator?
Explain the concept of multicast routing.

What is DHCP and how does it work?
What is the purpose of a DHCP relay agent?
What is a DHCP lease?

Describe the process of DNS resolution.
What is a DNS server and what role does it play in networking?
What is a DNS cache?

What is a MAC address?
What is a MAC table (CAM table)?
What is a MAC flooding attack?
What is a MAC address spoofing attack?

</details>
