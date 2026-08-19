- Menifest
- Artifacts
- Assets

-   <details><summary style="font-size:25px;color:Orange"> Software Version System </summary>

    Software versioning is a system of assigning unique identifiers (version numbers) to different releases of a software product. These versions help in tracking changes, managing updates, and ensuring compatibility.

    #### Versioning Schemes
    - **Semantic Versioning (SemVer)**: Uses a structured `MAJOR.MINOR.PATCH` format:
        - **MAJOR** (`X.0.0`) → Increments when there are breaking changes.
            - `1.0.0` → Initial stable release
            - `2.0.0` → Breaking changes introduced
        - **MINOR** (`1.X.0`) → Increments when new features are added in a backward-compatible manner.
            - `1.1.0` → Added new feature (backward-compatible)
        - **PATCH** (`1.0.X`) → Increments when bug fixes and minor improvements are made.
            - `1.1.1` → Bug fix release

    - **Date-Based Versioning**: Uses the release date as the version number, typically `YYYY.MM.DD` or `YYYY.R` (where `R` is the release number for that year). Example: `2024.1`, `2024.02.15`
    - **Incremental Versioning**: Uses a simple incremental number (`1`, `2`, `3`, etc.). Example: Windows 10, Windows 11

    #### Versioning Terminology
    - **Pre-Release Versions**: These are versions released before the final stable version and usually include experimental or test features.
        - **Alpha (`alpha`)** → Very early-stage, unstable version for internal testing. Example: `1.0.0-alpha.1`
        - **Beta (`beta`)** → More stable than Alpha, but still under development. Example: `1.0.0-beta.2`
        - **Release Candidate (`rc`)** → A version that is almost final, pending last-minute testing. Example: `1.0.0-rc.1`

    - **Stable Release**: Official, fully tested version ready for production use. Example: `1.0.0`
    - **Long-Term Support (LTS)**: A version supported for a longer period with security and bug fixes. Example: `Node.js 18 LTS`
    - **Hotfix**: A minor release to fix a critical issue. Example: `1.0.1`
    - **Deprecated Version**: A version that is no longer supported and should not be used.

    #### Other Versioning Concepts
    - **Backward Compatibility** → New versions work with older data or APIs.
    - **Forward Compatibility** → Older versions can work with new data or APIs.
    - **Rolling Release** → Continuous software updates without distinct version numbers (e.g., Arch Linux).

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">API paradigms</summary>

    -   [ByteByteGo: Top 6 Most Popular API Architecture Styles](https://www.youtube.com/watch?v=4vLxWqE94l4&t=20s)

    API paradigms refer to the different styles or architectural patterns used in designing and implementing Application Programming Interfaces (APIs). Each paradigm has its own principles, use cases, and communication models. Here’s a list of the most common API paradigms:

    #### REST (Representational State Transfer)

    -   **Principles**: RESTful APIs are based on the principles of stateless communication, where each request from a client to a server must contain all the information the server needs to fulfill the request. REST uses standard HTTP methods (GET, POST, PUT, DELETE) and is resource-oriented.
    -   **Data Format**: Typically JSON or XML.
    -   **Use Cases**: Web services, CRUD operations, microservices.
    -   **Advantages**: Simplicity, scalability, statelessness, and wide adoption.

    #### gRPC (Google Remote Procedure Call)

    -   **Principles**: RPC-based APIs allow clients to execute a function or procedure on a remote server as if it were local. The communication typically involves calling a method with parameters, and the server returns the result.
    -   **Variants**:
        -   **JSON-RPC**: Uses JSON for encoding messages.
        -   **XML-RPC**: Uses XML for encoding messages.
        -   **gRPC**: A modern RPC framework developed by Google that uses Protocol Buffers (protobuf) for message serialization.
    -   **Data Format**: JSON, XML, Protocol Buffers.
    -   **Use Cases**: Distributed systems, microservices, performance-critical applications.
    -   **Advantages**: Efficient, supports multiple languages, easy-to-understand method-based calls.

    #### SOAP (Simple Object Access Protocol)

    -   **Principles**: SOAP is a protocol for exchanging structured information in web services. It uses XML as its message format and relies on various other protocols like HTTP, SMTP, and more.
    -   **Data Format**: XML.
    -   **Use Cases**: Enterprise applications, legacy systems, complex transactions, and environments requiring strict standards (e.g., banking, healthcare).
    -   **Advantages**: Strong standards (security, transaction management), language-agnostic, supports complex operations.

    #### GraphQL

    -   **Principles**: Developed by Facebook, GraphQL is a query language for APIs that allows clients to request exactly the data they need. Unlike REST, where multiple endpoints might be needed to get related data, a single GraphQL query can fetch all the required data in one request.
    -   **Data Format**: JSON (for requests and responses).
    -   **Use Cases**: Modern web and mobile applications, real-time data fetching, scenarios where minimizing the number of requests is crucial.
    -   **Advantages**: Flexible queries, reduced over-fetching or under-fetching of data, strong typing, introspection.

    #### WebSockets

    -   **Principles**: WebSocket is a communication protocol that provides full-duplex communication channels over a single, long-lived connection. It’s often used for real-time, two-way interaction between clients and servers.
    -   **Data Format**: Typically JSON, but can support binary data.
    -   **Use Cases**: Real-time applications (e.g., chat applications, live notifications, gaming), IoT, streaming data.
    -   **Advantages**: Low latency, real-time communication, efficient for use cases requiring constant updates.

    #### Event-Driven APIs

    -   **Principles**: Event-driven APIs work by emitting and listening to events. When a particular event occurs, the system reacts by executing a predefined action. This paradigm is often used in real-time or asynchronous systems.
    -   **Data Format**: JSON, XML, or custom formats depending on the implementation.
    -   **Use Cases**: Real-time notifications, streaming data, IoT, complex workflows with triggers and actions.
    -   **Advantages**: Decoupled systems, scalability, real-time processing, asynchronous communication.

    #### WebHooks

    -   **Principles**: WebHooks are a lightweight paradigm where a server-side application makes an HTTP POST request to a specified URL in response to some event. They are often used to notify other systems of events like new data being available.
    -   **Data Format**: JSON, XML, or any format that can be sent via HTTP POST.
    -   **Use Cases**: Integration between services (e.g., triggering CI/CD pipelines, notifications, updates).
    -   **Advantages**: Simplicity, efficient for event notifications, no need for polling.

    #### Pub/Sub (Publish/Subscribe)

    -   **Principles**: In a Pub/Sub model, messages are published to a topic, and subscribers to that topic receive the messages. The publisher and subscriber are decoupled and do not communicate directly.
    -   **Data Format**: JSON, XML, Protocol Buffers, or other formats depending on the implementation.
    -   **Use Cases**: Real-time messaging, event-driven architectures, distributed systems.
    -   **Advantages**: Scalability, decoupling of components, support for complex event processing.

    #### Summary

    -   **REST**: Resource-based, HTTP methods, simple and widely adopted.
    -   **RPC**: Function calls, method-based, efficient, often used in microservices.
    -   **SOAP**: Protocol-based, strong standards, XML, used in enterprise systems.
    -   **GraphQL**: Flexible queries, minimizes over-fetching, strong typing.
    -   **WebSockets**: Real-time, full-duplex communication.
    -   **Event-Driven APIs**: Asynchronous, real-time, decoupled.
    -   **WebHooks**: Event notifications via HTTP POST, simple integration.
    -   **Pub/Sub**: Decoupled messaging, real-time, scalable.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">APIs, HTTP APIs & REST APIs</summary>

        - [REST API Caching Strategies Every Developer Must Know](https://www.youtube.com/watch?v=TV-xsNjbx_g)

    #### APIs (Application Programming Interface)

    -   [Top 6 Most Popular API Architecture Styles](https://www.youtube.com/watch?v=4vLxWqE94l4)
    -   [APIs for Beginners 2023 - How to use an API (Full Course / Tutorial)](https://www.youtube.com/watch?v=WXsD0ZgxjRw&t=5570s)
    -   [Introduction to web APIs](https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Client-side_web_APIs/Introduction)
    -   [HTTP](https://en.wikipedia.org/wiki/HTTP)

    API stands for "Application Programming Interface." An API is a set of rules and protocols that allows one software application to interact with another. It defines the methods and data formats that applications can use to request and exchange information. APIs are used to enable the integration of different software systems, allowing them to communicate and work together. Here are key aspects of APIs:

    -   **Communication between Software Components**: APIs define how different software components should interact. They act as a bridge, allowing one application to access the functionality or data of another.
    -   **Abstraction Layer**: APIs provide an abstraction layer that hides the internal complexities of the system or service, exposing only what is necessary for external users or applications.
    -   **Methods and Endpoints**: APIs expose methods (functions) and endpoints (URLs or URIs) that define the operations or resources available for interaction. These methods and endpoints are like the building blocks that developers can use.
    -   **Data Formats**: APIs define the data formats in which information is exchanged. Common formats include JSON (JavaScript Object Notation) and XML (eXtensible Markup Language).
    -   **HTTP and RESTful APIs**: Many APIs use HTTP (Hypertext Transfer Protocol) as the communication protocol. REST (Representational State Transfer) is a commonly used architectural style for designing networked applications, and RESTful APIs adhere to REST principles.
    -   **Authentication and Authorization**: APIs often include mechanisms for authentication and authorization to control access to resources. This ensures that only authorized users or applications can make use of the API.
    -   **Third-Party Integration**: APIs are crucial for enabling third-party developers to integrate their applications or services with existing platforms, services, or data sources.
    -   **Web APIs vs. Library APIs**: Web APIs are typically accessed over the internet using standard protocols, while library APIs are sets of routines or tools for building software and are often used within the same programming language.
        -   `Web APIs`: Services like Twitter, Google Maps, or OpenWeatherMap provide APIs that developers can use to access their data or functionality.
        -   `Library APIs`: Libraries in programming languages, like the Standard Template Library (STL) in C++ or the Python Standard Library, expose APIs for developers to use predefined functions and classes. APIs play a fundamental role in modern software development by facilitating the creation of modular, interoperable, and scalable applications. They enable the integration of different systems and contribute to the development of a vibrant ecosystem of interconnected applications and services.

    #### HTTP (Hypertext Transfer Protocol) APIs

    -   [HTTP: Hypertext Transfer Protocol](https://developer.mozilla.org/en-US/docs/Web/HTTP)

    An HTTP API (HyperText Transfer Protocol Application Programming Interface) is a way for applications to communicate with each other over the web using the HTTP protocol. It allows clients (such as web browsers, mobile apps, or other servers) to send requests to a server, which then processes the requests and sends back responses.

    In essence, an HTTP API exposes certain endpoints (URLs) that clients can interact with, using standard HTTP methods like GET (to retrieve data), POST (to send data), PUT (to update data), and DELETE (to remove data). This interaction facilitates the exchange of data and services between different software systems.

    HTTP, or Hypertext Transfer Protocol, is a fundamental protocol used for communication on the World Wide Web. It is an application layer protocol that facilitates the transfer of hypertext, which includes text, images, videos, and other multimedia files, over the internet. Here are key terms and concepts associated with HTTP:

    -   **Client and Server**: In the context of HTTP, the client is typically a web browser or a similar application that requests resources, while the server is a computer hosting those resources and responding to client requests.
    -   **Request-Response Model**: HTTP follows a request-response model. The client sends an HTTP request to the server, and the server responds with the requested data or an error message.
    -   **URL (Uniform Resource Locator)**: A URL is a string of characters that provides the address used to access a resource on the web. It includes the protocol (e.g., http://), the domain name, and the path to the resource.
    -   <details><summary><b style="color:white">HTTP Methods</b>: HTTP methods or verbs are some action words or methods which indicate the desired action to be performed on a resource. Common HTTP methods include:</summary>

        -   <b style="color:#C71585">GET</b>: Retrieve data from a resource.

            -   `Idempotent`: Yes. Repeated GET requests should have the same effect as a single request.
            -   `Example`: Fetch the details of a product by requesting GET `/products/123`.
                -   `$ curl http://localhost:8000/products/123`

        -   <b style="color:#C71585">POST</b>: Used to submit data to be processed to a specified resource. It can also be used to create a new resource.

            -   `Idempotent`: No. Repeated POST requests with the same data will create multiple resources.
            -   `Example`: Create a new product by sending data to POST `/products`.
                -   `$ curl -X POST -H "Content-Type: application/json" -d '{"name": "New Product", "price": 19.99}' http://localhost:8000/products/`

        -   <b style="color:#C71585">PUT</b>: The PUT method is used to update or create a resource at a specific URI. It essentially replaces the current representation of the target resource with the request payload.

            -   `Use Case`: PUT is typically used when the client has the full representation of the resource and wants to replace the existing resource at the specified URI.
            -   `Idempotent`: Yes. Multiple identical PUT requests will result in the same resource state; if you put the same data multiple times, the result will remain unchanged after the first request.
            -   `Example 0`: Update product information by sending data to PUT `/products/123` using curl.
                -   `$ curl -X PUT -H "Content-Type: application/json" -d '{"name": "Updated Product", "price": 24.99}' http://localhost:8000/products/123/`
            -   `Example 1`: Update product information by sending data to PUT `/products/123` in Django.

                ```python
                # views.py
                from django.shortcuts import get_object_or_404
                from rest_framework.views import APIView
                from rest_framework.response import Response
                from rest_framework import status
                from .models import Product
                from .serializers import ProductSerializer

                class ProductDetailView(APIView):
                    def put(self, request, pk):
                        product = get_object_or_404(Product, pk=pk)
                        serializer = ProductSerializer(product, data=request.data)

                        if serializer.is_valid():
                            serializer.save()
                            return Response(serializer.data, status=status.HTTP_200_OK)

                        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
                ```

            -   `Example 2`: Update product information by sending data to PUT `/products/123` in Django.

                ```python
                # views.py
                from django.shortcuts import get_object_or_404, render, redirect
                from .models import Product
                from .forms import ProductForm

                def product_detail(request, pk):
                    product = get_object_or_404(Product, pk=pk)

                    if request.method == 'PUT':
                        form = ProductForm(request.PUT, instance=product)
                        if form.is_valid():
                            form.save()
                            return redirect('product_detail', pk=pk)
                    else:
                        form = ProductForm(instance=product)

                    return render(request, 'product_detail.html', {'form': form})
                ```

            -   `Example 3`: Update product information by sending data to PUT `/products/123` in Django.

                ```python
                # views.py
                from django.shortcuts import get_object_or_404, render, redirect
                from django.http import HttpResponse
                from django.views.decorators.csrf import csrf_exempt
                from .models import Product
                import json

                @csrf_exempt
                def product_detail(request, pk):
                    product = get_object_or_404(Product, pk=pk)

                    if request.method == 'PUT':
                        # Retrieve and decode JSON data from the request body
                        try:
                            data = json.loads(request.body.decode('utf-8'))
                        except json.JSONDecodeError:
                            return HttpResponse("Invalid JSON data", status=400)

                        # Update the product with the data
                        product.name = data.get('name', product.name)
                        product.price = data.get('price', product.price)
                        product.save()

                        return HttpResponse("Product updated successfully", status=200)

                    return render(request, 'product_detail.html', {'product': product})
                ```

        -   <b style="color:#C71585">PATCH</b>: The PATCH method is used to apply partial modifications to a resource. Unlike PUT, which replaces the entire resource, PATCH is specifically designed for partial updates.

            -   `Use Case`: PATCH is used when the client wants to apply changes to specific fields of a resource without affecting the entire representation. It is more bandwidth-efficient when dealing with large resources.
            -   `Idempotent`: It depends on the implementation. While PATCH is intended to be idempotent, achieving true idempotence can be challenging since the server must interpret the partial update in a consistent manner.
            -   `Example`: Update only the email address of a user by sending data to PATCH `/users/123`.

                ```python
                @csrf_exempt  # For demonstration purposes; CSRF should be handled properly in production
                def patch_my_model(request, pk):
                    try:
                        user = get_object_or_404(User, pk=pk)
                    except User.DoesNotExist:
                        return JsonResponse({'error': 'Instance not found'}, status=404)

                    if request.method == 'PATCH':
                        data = json.loads(request.body.decode('utf-8'))
                        # Update only the fields present in the request
                        for key, value in data.items():
                            setattr(user, key, value)
                        instance.save()
                        return JsonResponse({'message': 'Instance updated successfully'})
                    else:
                        return JsonResponse({'error': 'Unsupported method'}, status=400)
                ```

        -   <b style="color:#C71585">DELETE</b>: Remove a resource from the server.

            -   `Idempotent`: Yes. Deleting the same resource multiple times will have the same effect as deleting it once. If the resource is already deleted, subsequent DELETE requests will typically return a success status indicating the resource does not exist.
            -   `Example`: Delete a user by sending a request to DELETE `/users/123`. Sending the same DELETE request again won't change the fact that the resource has already been deleted. This characteristic simplifies error handling and makes it safer to retry requests without worrying about unintended side effects.

        -   <b style="color:#C71585">HEAD</b>: The HEAD method is used to retrieve the headers of a resource without fetching its body. It is essentially a way to request metadata about a resource without the need to transfer the entire representation. The "HEAD" method allows clients to retrieve metadata about a resource, such as its size or modification date, without downloading the entire content.

            -   `Response`: The server responds to a HEAD request with the headers that would be returned for a corresponding GET request, but without the actual data.
            -   `Use Case`: If a client is interested in obtaining information like the last modification time (Last-Modified), content type, or content length of a resource without downloading the entire resource, a HEAD request can be useful.
            -   `Idempotent`: Yes. Repeated HEAD requests should have the same effect as a single request.
            -   `Example`: Get the headers of a resource without downloading its content using HEAD `/products`.
                -   `$ curl -I http://localhost:8000/products/`

        -   <b style="color:#C71585">OPTIONS</b>: Retrieve information about the communication options for a resource. For example, a Cross-Origin requests may trigger a preflight OPTION request to checks what HTTP methods and headers are allowed by the server.

            -   `Purpose`: The OPTIONS method is used to retrieve the communication options for a given resource or server. It is often used for service discovery and to determine the allowed methods, headers, and other configuration details of an API.
            -   `Response`: The server responds to an OPTIONS request with information about the allowed methods (e.g., GET, POST, PUT, DELETE), headers, and any other details that help a client understand how to interact with the resource.
            -   `Use Cases`:

                -   `CORS (Cross-Origin Resource Sharing)`: The OPTIONS request is crucial in the context of CORS, where a browser may send a pre-flight OPTIONS request to check if it is allowed to make a subsequent request to a different domain.
                -   `Service Discovery`: In some cases, an OPTIONS request can be used to discover the capabilities of an API, helping clients understand what operations are supported.
                -   `Example`:
                    -   `$ curl -X OPTIONS http://localhost:8000/products/`
                -   `Example`:

                    ```http
                    OPTIONS /api/resource/123 HTTP/1.1
                    Host: example.com
                    ```

                    -   The server responds with information about the allowed methods, headers, etc.

                    ```http
                    HTTP/1.1 200 OK
                    Allow: GET, HEAD, POST, OPTIONS
                    Access-Control-Allow-Origin: *
                    Access-Control-Allow-Methods: GET, POST, OPTIONS
                    ```

            -   `Idempotent`: Yes. Repeated OPTIONS requests should have the same effect as a single request.
            -   `Example`: Determine the available methods and capabilities for a resource using OPTIONS /resource.

        -   <b style="color:#C71585">CONNECT</b>: Used for setting up a network connection to a resource, typically used for proxy servers.

            -   `Purpose`: The CONNECT method is used to establish a tunnel to the server identified by the target resource. It is typically used with the HTTP Secure (HTTPS) protocol to establish a secure connection through an intermediary (such as a proxy server).
            -   `Use Cases`: The primary use case for CONNECT is when a client wants to establish a secure connection to a server through a proxy server. The CONNECT method is used to request that the proxy create a tunnel, and subsequent data is sent over the established tunnel without interpretation by the proxy.
            -   `Idempotent`: No. Since the CONNECT method is often used for setting up connections and tunnels, and the effects may vary (e.g., establishing a new connection or tunnel each time), it is considered non-idempotent. Making multiple CONNECT requests may result in multiple connections being established, and the repeated execution may have different effects.
            -   `Example`: Rarely used directly in RESTful APIs.

                ```http
                CONNECT server.example.com:443 HTTP/1.1
                Host: server.example.com:443
                ```

            -   The client sends a CONNECT request to the proxy server, requesting a tunnel to `server.example.com` on port 443 for establishing a secure connection.
            -   The server responds with a success status if the tunnel is established.

        -   <b style="color:#C71585">TRACE</b>: Used for diagnostic purposes, allows a client to retrieve a diagnostic trace of the actions taken by intermediate servers.

            -   `Purpose`:The TRACE method is used for diagnostic purposes. When a server receives a TRACE request, it echoes the received request back to the client. This can be useful for troubleshooting and understanding how intermediate servers modify the request.

            -   `Use Cases`:Debugging: The primary use case for TRACE is debugging and diagnosing issues in the communication between the client and the server. It allows the client to see how the request is modified as it travels through different proxies and servers.

            -   `Example`: Rarely used directly in RESTful APIs.

                ```http
                TRACE /path/to/resource HTTP/1.1
                Host: example.com
                ```

                -   The server echoes the received request back to the client, and the client can inspect how the request was processed by intermediate servers.

            -   `Idempotent`: Yes.

        </details>

    -   <details><summary><b style="color:white">HTTP Response</b>: HTTP responses include status codes that indicate the result of the server's attempt to process the request. Common status code categories include:</summary>

        -   <b style="color:#C71585">1xx Informational</b>: These status codes indicate that the server has received the request and is processing it. They are mainly used for communication purposes and do not represent a final response.

            -   `100 Continue`: The server has received the initial part of the request and expects the client to continue sending the rest of it.
            -   `101 Switching Protocols`: The server is changing the protocol used in the request.

        -   <b style="color:#C71585">2xx Success</b>: These status codes indicate that the request was successfully received, understood, and accepted by the server.

            -   `200 OK`: The request was successful, and the server is returning the requested resource.
            -   `201 Created`: The request was successful, and a new resource was created as a result.

        -   <b style="color:#C71585">3xx Redirection</b>: These status codes indicate that the client needs to take additional steps to complete the request.

            -   `301 Moved Permanently`: The requested resource has been permanently moved to a new location.
            -   `302 Found`: The requested resource has been temporarily moved to a different location.

        -   <b style="color:#C71585">4xx Client Error</b>: These status codes indicate that there was an error on the client's side, and the request cannot be fulfilled.

            -   `400 Bad Request`: The server cannot understand the request due to malformed syntax or other client-side errors.
            -   `401 Unauthorized`: Authentication is required to access the resource, but no valid credentials were provided.
            -   `402 Payment Required`: Reserved for future use, typically for payment-related actions.
            -   `403 Forbidden`: The server understood the request, but the client does not have permission to access the requested resource.
            -   `404 Not Found`: The requested resource could not be found on the server.

        -   <b style="color:#C71585">5xx Server Error</b>: These status codes indicate that there was an error on the server's side, and the request could not be fulfilled.

            -   `500 Internal Server Error`: A generic server error occurred, indicating that something went wrong on the server.
            -   `502 Bad Gateway`: The server acting as a gateway or proxy received an invalid response from an upstream server.

        </details>

    -   <details><summary><b style="color:white">HTTP Headers</b>: HTTP headers provide additional information about the request or the response. They include metadata such as content type, content length, and caching directives.</summary>

        1. **Authentication Headers**:

            - `Authorization`: This header is used to pass authentication credentials to the server, typically for securing API endpoints.
                - Example: `Authorization: Bearer <token>` (JWT-based)
            - `WWW-Authenticate`: A response header that defines the authentication method to be used to access a resource.
                - Example: `WWW-Authenticate: Basic realm="Access to the site"`

        2. **Content Headers**:

            - **Content-Type**: Indicates the media type of the resource or the data that is being sent (e.g., JSON, XML).
                - Example: `Content-Type: application/json`
            - **Content-Length**: The size of the request body in bytes. Useful when streaming large files or data to ensure that the content is properly received.
                - Example: `Content-Length: 348`

        3. **Caching Headers**:

            - **Cache-Control**: Specifies caching mechanisms between client and server. It defines how the resource should be cached.
                - Example: `Cache-Control: no-cache, no-store, must-revalidate`

        4. **Client Hints & Context Headers**:

            - **User-Agent**: Identifies the client (browser, mobile app, etc.) that is making the request. In Django, this can be accessed from the `request.META['HTTP_USER_AGENT']` attribute.
                - Example: `User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64)`
            - **Accept**: Informs the server about the content types that the client is willing to receive.
                - Example: `Accept: application/json`
            - **Accept-Encoding**: Lists the compression methods that the client can handle. Django handles this automatically but can be used for optimizing network payload.
                - Example: `Accept-Encoding: gzip, deflate`

        5. **Redirection and Location Headers**:

            - **Location**: Used in responses to specify the URL to which a browser should redirect. In Django, it can be set in responses like `HttpResponseRedirect` or `redirect()`.
                - Example: `Location: https://example.com/new-page`

        6. **Request-Control Headers**:

            - **Host**: The domain name of the server (used for virtual hosting). In Django, you can control domain-based logic using `request.get_host()`.
                - Example: `Host: www.example.com`
            - **Origin**: Indicates where the request originates, used primarily in cross-origin resource sharing (CORS) scenarios.
                - Example: `Origin: https://client-site.com`
            - **Referer**: The URL of the page that linked to the resource being requested.
                - Example: `Referer: https://google.com`

        7. **Cookie Headers**: Used to send stored cookies from the client to the server.:

            - Example: `Cookie: sessionid=38afes7a8fe3; csrftoken=1a2b3c4d5e`
            - Django has built-in cookie handling for sessions and CSRF tokens.

        8. **Security Headers**:
            - **X-Frame-Options**: Prevents clickjacking by controlling whether a page can be framed. In Django, you can configure it via the `X_FRAME_OPTIONS` setting.
                - Example: `X-Frame-Options: DENY`
            - **Strict-Transport-Security (HSTS)**: Informs browsers to only access the site over HTTPS. Django provides built-in support for HSTS via the `SECURE_HSTS_SECONDS` setting.
                - Example: `Strict-Transport-Security: max-age=31536000; includeSubDomains`

        </details>

    -   **Cookies**: Cookies are small pieces of data sent from a server and stored on the client's browser. They are commonly used for user authentication, tracking, and session management.
    -   **Session**: A session is a way to persist information across multiple requests and responses between a client and a server. Sessions are often managed using cookies or URL parameters.
    -   **Statelessness**: HTTP is a stateless protocol, meaning each request from a client to a server is independent, and the server does not retain information about the client's state between requests. Session management mechanisms are used to overcome this limitation.
    -   **HTTPS (Hypertext Transfer Protocol Secure)**: HTTPS is a secure version of HTTP that encrypts the data transmitted between the client and the server. It uses SSL/TLS protocols to ensure the confidentiality and integrity of the communication.
    -   **Websockets**: Websockets provide a full-duplex communication channel over a single, long-lived connection. This enables real-time communication between a client and a server.
    -   **REST (Representational State Transfer)**: REST is an architectural style for designing networked applications. It often uses HTTP as the communication protocol and relies on a stateless, client-server interaction.
    -   **API Request**: A REST API request is how the client communicates with the server to perform actions like creating, reading, updating, or deleting resources. Each request typically contains:
    -   **Query Parameters**: Query parameters are optional key-value pairs appended to the endpoint after a question mark (`?`). They are commonly used to filter, sort, or paginate data. For example:
    -   **Path Parameters**: Path parameters are variables within the URL path itself, often used to specify a resource ID. For example, in `/users/123`, `123` is a path parameter representing a specific user.
    -   **Endpoint (URL)**: The endpoint, or Uniform Resource Locator (URL), is the address of the resource on the server. It often includes a **base URL** (e.g., `https://api.example.com`) and a **path** to specify the resource (e.g., `/users` or `/products/123`).
    -   **Request Validator**: In some APIs, request validators ensure that the incoming request conforms to specific criteria, such as having required fields or matching a defined schema.

    Understanding these HTTP terms and concepts is essential for web developers, system administrators, and anyone involved in working with web technologies. HTTP forms the foundation of communication on the internet, and knowledge of its principles is crucial for effective web development and troubleshooting.

    #### REST (Representational State Transfer)

    -   [Rest API Master Course](https://www.youtube.com/playlist?list=PLqwmiTs6Z6PG9-0JT_Zt_gKCxyshjCwEA)

    REST (Representational State Transfer) is an architectural style for designing networked applications. It was introduced by Roy Fielding in his doctoral dissertation in 2000 and has since become a popular choice for building web services and APIs (Application Programming Interfaces).

    -   **REpresentational**: The format in which resources are represented (e.g., JSON, XML).
    -   **State**: The condition or data of the resource at a given point, managed by the client.
    -   **Transfer**: The act of sending and receiving resource representations between client and server over a network.

    REST API (Representational State Transfer) is a specific type of HTTP API that follows a set of architectural principles to make it more efficient, scalable, and maintainable. REST API uses a client-server model and is based on the HTTP protocol. It uses standard HTTP methods such as GET, POST, PUT, and DELETE, and it employs a set of conventions to define resources, URIs, and responses. REST API aims to make the client-server communication stateless and cacheable, and it uses hypermedia (links) to navigate between resources. Here are key terms and concepts associated with REST:

    -   **Resource**: In REST, everything is considered a resource. A resource can be a physical object (like an entity in a database), a service, or any other concept that can be identified and addressed.

    -   **Uniform Resource Identifier (URI)**:

        -   Resources in REST are identified by URIs.
        -   A URI is a string of characters that uniquely identifies a particular resource.
        -   URIs can be further classified into URLs (Uniform Resource Locators) when they specify the location of the resource, and URNs (Uniform Resource Names) when they only provide a unique name.
        -   URIs are used to identify and interact with resources on the internet.

        -   `Uniform Resource Locator (URL)`:

            -   A URL is a specific type of URI that provides the means to locate and retrieve a resource on the internet.
            -   It includes the protocol used to access the resource (e.g., HTTP or HTTPS), the domain or IP address where the resource is hosted, and the path to the specific resource on that server.
            -   URLs are the most common type of URIs and are used when you want to specify the location of a resource.

    -   **HTTP Methods (Verbs)**: RESTful services use standard HTTP methods to perform operations on resources.

    -   **Representation**: Representations are the different ways a resource can be presented or represented. In REST, a resource can have multiple representations, such as JSON, XML, HTML, or others. Clients interact with resources by exchanging representations. For example, a client might request a user resource and receive a JSON representation of that user.

    -   **Idempotence**: An operation is considered idempotent if it produces the same result regardless of how many times it is applied. For example, a GET request is idempotent because retrieving a resource multiple times does not change the resource.

    -   [**Content Negotiation**](https://www.youtube.com/watch?v=vP9HU1o3zsE): Content negotiation is the process of selecting the appropriate representation of a resource based on the client's preferences. This is often done using the Accept header in HTTP requests.

    -   **API Versioning**: To manage changes in an API, versioning is often employed. This can be done through the URI, headers, or other mechanisms, allowing clients to specify the version of the API they wish to use.

    #### RESTfull Principles:

    -   [Rest API - Best Practices - Design](https://www.youtube.com/watch?v=1Wl-rtew1_E)

    RESTful principles are a set of constraints that guide the design of RESTful systems to ensure simplicity, scalability, and uniformity. The key principles of REST are:

    1.  **Client-Server Architecture**:

        -   The client and server are separate entities that communicate over a network.
        -   The client is responsible for the user interface and user experience, while the server is responsible for processing requests, managing resources, and handling business logic.

    2.  **Statelessness**:

        -   Statelessness" refers to the fact that the server does not store any client state between requests. Each request from a client to the server must contain all the information necessary for the server to understand and fulfill that request.
        -   The server treats each request it receives as an independent and complete transaction, without relying on any previous requests. This means that there is no dependency accross the requests from clients.

    3.  **Uniform Interface**: "Uniform Interface" is one of the key principles of REST architectural style. It defines a standard way for clients and servers to interact with each other. The uniform interface principle is designed to promote simplicity, scalability, and evolvability in distributed systems. It consists of several constraints:

        1.  `Resource Identification`: Resources are identified by unique URIs (Uniform Resource Identifiers). Each resource, whether it's data, a service, or anything else, should have its own URI. The URI serves as the address or identifier for accessing or manipulating the resource.
        2.  `Resource Manipulation through Representations`: In a RESTfull API, clients interact with resources by exchanging representations. When a client requests a resource, it receives a representation of that resource from server, and it can modify or delete the resource by sending the server a new representation. Resources are decoupled from their representation, allowing them to be represented in different formats such as JSON, XML, HTML, etc. The server provides the data and the client can choose how to represent it.

        3.  `Self-Descriptive Messages`: In a RESTful system, communication (request and response messages) between clients and servers should be self-descriptive. This means that request and response messages include all the information needed for the recipient to understand and process the message. For example, headers may specify the content type, allowing the recipient to interpret the body correctly. There are typically two main types of messages exchanged: requests from clients to servers and responses from servers to clients.

            -   `HTTP Request Message (Client to Server)`:

                -   `Method`: The HTTP method (or verb) indicates the desired action to be performed on the resource. Common methods include GET (retrieve a resource), POST (create a new resource), PUT (update a resource), DELETE (remove a resource), etc.
                -   `URI (Uniform Resource Identifier)`: Specifies the identifier of the resource on which the action should be performed. It uniquely identifies the resource within the system.
                -   `Headers`: Additional information about the request, such as content type, accepted response formats, authentication credentials, etc.
                -   `Body (optional)`: In some cases, a request may include a message body. For example, in a POST or PUT request, the body contains data to create or update a resource.

            -   `HTTP Response Message (Server to Client)`:

                -   `Status Code`: Indicates the outcome of the server's attempt to process the request. Common status codes include 200 OK (successful), 201 Created (resource successfully created), 404 Not Found (resource not found), 500 Internal Server Error (server encountered an error), etc.
                -   `Headers`: Provide additional information about the response, such as content type, cache control directives, server information, etc.
                -   `Body (optional)`: Contains the representation of the resource or additional information. For example, in a successful GET request, the body might contain the requested resource in the desired format (JSON, XML, HTML, etc.).

        4.  [`Hypermedia as the Engine of Application State (HATEOAS)`](https://www.youtube.com/watch?v=NK3HNEwDXUk): Server should includes hypermedia controls within API responses to enable dynamic navigation and discoverability. The client navigates through the application by following links in the representations returned by the server. This makes the application more discoverable, enable to have stateless interactions between client and server and allows changes to be made on the server without affecting clients that rely on the hypermedia links. Hence reduce coupling.
            **Hypermedia** is a term that encompasses various media types (such as HTML, XML, or JSON) that support hyperlinks, allowing clients to navigate through the API dynamically.
            **hypermedia controls** refer to the mechanisms by which the server provides information to clients about the available actions or state transitions that can be performed at any given point in the application. Key Concepts of Hypermedia in RESTful API are followings.

            -   `Hypermedia Controls`: The server includes hypermedia controls (links, forms, etc.) within the representations it sends to clients. These controls provide information about the available actions, resources, and state transitions that clients can access.

            -   `Discoverability`: Since hypermedia links provided in the responses, clients can dynamically discover and navigate the API by following those links instead of hardcoding URLs.

            -   `Stateless Interaction`: In RESTful architecture hypermedia supports stateless interactions by including all the necessary information for clients to navigate and interact within each response and clients maintain the state of the application based on the information provided in the hypermedia controls.

            -   `Reduced Coupling`: Since clients only rely on the information provided in the hypermedia links, server can make any changes without affecting clients that rely on the hypermedia links.

            -   `Media Types`: a "media type" refers to a standardized way of indicating the type of data being transmitted between a client and a server. It specifies the format and structure of the data, allowing both parties to understand how to interpret and process the information.

            -   <details><summary><b style="color:white">Links and Link Relations</b>: Link relations in HATEOAS play a crucial role in defining the semantics of hypermedia links. A link relation is a way to express the meaning or purpose of a link. It provides a standardized way for clients to understand the relationship between the current resource and linked resources. Some common link relations used in HATEOAS include:</summary>

                -   **Self (self)**: The self link relation is used to provide a link back to the current resource. It allows the client to retrieve information about the current state or resource.

                    ```json
                    {
                        "links": [
                            { "rel": "self", "href": "/api/resource/123" }
                        ],
                        "data": {
                            /* ... */
                        }
                    }
                    ```

                -   **Related (related)**: The related link relation is used to indicate a related resource. It might provide links to associated resources that can be useful for the client.

                    ```json
                    {
                        "links": [
                            { "rel": "related", "href": "/api/other_resource" }
                        ],
                        "data": {
                            /* ... */
                        }
                    }
                    ```

                -   **Next (next) and Previous (prev)**: These link relations are often used in paginated results to navigate to the next or previous set of resources.

                    ```json
                    {
                        "links": [
                            { "rel": "next", "href": "/api/resources?page=2" },
                            { "rel": "prev", "href": "/api/resources?page=1" }
                        ],
                        "data": [
                            /* ... */
                        ]
                    }
                    ```

                -   **Create (create), Update (update), and Delete (delete)**: These link relations may be used to indicate the actions a client can take to create, update, or delete a resource.

                    ```json
                    {
                        "links": [
                            {
                                "rel": "create",
                                "href": "/api/resources",
                                "method": "POST"
                            },
                            {
                                "rel": "update",
                                "href": "/api/resource/123",
                                "method": "PUT"
                            },
                            {
                                "rel": "delete",
                                "href": "/api/resource/123",
                                "method": "DELETE"
                            }
                        ],
                        "data": {
                            /* ... */
                        }
                    }
                    ```

                -   **Profile (profile)**: The profile link relation can be used to indicate a link to a resource that provides additional information about the resource's representation format or profile.

                    ```json
                    {
                        "links": [
                            {
                                "rel": "profile",
                                "href": "/api/profiles/resource_profile"
                            }
                        ],
                        "data": {
                            /* ... */
                        }
                    }
                    ```

                -   Other Common link relations include "first," "last," and custom relations specific to the API.
                </details>

    4.  **Cacheability**:

        -   Responses from the server can be explicitly marked as cacheable or non-cacheable.
        -   Caching can improve performance and reduce the load on servers by allowing clients to reuse previously fetched representations.

    5.  **Layered System**:

        -   The architecture can be composed of multiple layers, with each layer having a specific responsibility and interacting only with adjacent layers.
        -   This helps to achieve scalability, flexibility, and easier maintenance.

    6.  **Code-On-Demand (Optional)**:

        -   Servers can temporarily extend the functionality of a client by transferring logic in the form of applets or scripts.
        -   This constraint is optional and not always used in RESTful architectures.

    #### HTTP API vs REST API

    HTTP API and REST API are terms often used interchangeably, but they represent different concepts. Let's clarify the distinctions between them:

    -   `HTTP API`:

        -   An HTTP API (Application Programming Interface) is a general term for an interface that allows one software application to interact with another over the HTTP protocol.
        -   It doesn't prescribe a specific architectural style or set of constraints.
        -   An HTTP API can use various design patterns and data formats for communication, including SOAP (Simple Object Access Protocol), XML-RPC, or custom protocols.
        -   It may not adhere to the principles of REST (Representational State Transfer) and might not leverage HTTP methods and status codes in a RESTful manner.

    -   `REST API`:

        -   REST, on the other hand, is a specific architectural style for designing networked applications, and a REST API is an API that follows the principles of REST.
        -   RESTful APIs use standard HTTP methods (GET, POST, PUT, DELETE, etc.) to perform operations on resources, and they often use standard HTTP status codes to indicate the result of a request.
        -   REST APIs typically involve stateless communication, a uniform and consistent interface, resource-based URLs, and support for various representation formats (JSON, XML).
        -   HATEOAS (Hypermedia as the Engine of Application State) is a key concept in RESTful APIs, where clients interact with the application entirely through hypermedia provided dynamically by application servers.

    In summary, while an HTTP API refers to any API that uses the HTTP protocol for communication, a REST API specifically adheres to the principles of REST. RESTful APIs leverage the standard features of HTTP and follow a set of constraints to achieve a scalable, maintainable, and uniform architecture. It's important to note that not all APIs that use HTTP are necessarily RESTful, and the distinction lies in whether they follow the principles of REST.

    #### OpenAPI

    OpenAPI, formerly known as Swagger, is a specification for building APIs (Application Programming Interfaces). It provides a standardized way to describe RESTful APIs, allowing both humans and computers to understand the capabilities of a service without access to its source code. OpenAPI is often used to design, document, and consume APIs. Here are key aspects of OpenAPI:

    1. **Specification Format**:
        - `YAML or JSON`: OpenAPI specifications can be written in either YAML (YAML Ain't Markup Language) or JSON (JavaScript Object Notation). YAML is often preferred for its human-readable and clean syntax.
    2. **API Documentation**:
        - `Human-Readable Documentation`: OpenAPI specifications serve as a comprehensive documentation for APIs. Developers can easily understand how to interact with the API, including available endpoints, request/response formats, authentication methods, and more.
        - `Interactive Documentation`: Tools like Swagger UI or ReDoc can generate interactive documentation directly from the OpenAPI specification, allowing users to explore and test API endpoints interactively.
    3. **API Design**:
        - `Design-First Approach`: OpenAPI encourages a design-first approach to building APIs. Developers can create the API specification before implementing the actual service, fostering collaboration between development teams and stakeholders.
    4. **Key Components**:
        - `Paths and Operations`: Define endpoints (paths) and operations (HTTP methods) supported by the API.
        - `Parameters`: Specify parameters for requests, including path parameters, query parameters, headers, and request bodies.
        - `Responses`: Describe the possible responses from API endpoints, including status codes and response bodies.
        - `Security Definitions`: Define security requirements and authentication mechanisms.
    5. **Code Generation**:
        - `Client Code`: OpenAPI specifications can be used to generate client code in various programming languages, reducing the effort required to consume an API.
        - `Server Code`: Some tools can also generate server-side code skeletons based on the OpenAPI specification, facilitating the implementation of API services.
    6. **Tool Ecosystem**:
        - `Validation Tools`: Tools can validate whether an API implementation conforms to its OpenAPI specification.
        - `Code Generators`: Various code generators can produce client libraries, server stubs, and documentation based on the OpenAPI specification.
        - `Testing Tools`: OpenAPI specifications can be used to generate tests for API endpoints.
    7. **Standardization**:
        - `Industry Standard`: OpenAPI is widely adopted as an industry standard for API specifications. Many API-related tools and platforms support OpenAPI, making it easier to integrate and work with different services.

    OpenAPI plays a crucial role in promoting API standardization, collaboration, and understanding between different parties involved in the API lifecycle, from design to consumption.

    #### OAuth (Open Authorization)

    -   [Udacity: Authentication & Authorization: OAuth](https://www.udacity.com/enrollment/ud330)
    -   [24. OAuth 2.0: Explained with API Request and Response Sample | High Level System Design](https://www.youtube.com/watch?v=3Gx3e3eLKrg)
    -   [ByteByteGo: OAuth 2 Explained In Simple Terms](https://www.youtube.com/watch?v=ZV5yTm4pT8g)
    -   [ByteMonk: OAuth 2.0 explained with examples](https://www.youtube.com/watch?v=ZDuRmhLSLOY&t=288s)

    OAuth (Open Authorization) is an open standard and framework that allows secure third-party access to resources on behalf of a resource owner, without sharing the resource owner's credentials directly. It is commonly used for granting access to web and mobile applications to interact with APIs and services on behalf of users. OAuth provides a standardized way for users to grant limited access to their resources (such as data or services) to another party without exposing their credentials. Key concepts and components of OAuth include:

    -   **Roles**:

        -   `Resource Owner`: The entity that owns the protected resource, typically a user.
        -   `Client`: The application requesting access to a protected resource on behalf of the resource owner.
        -   `Authorization Server`: The server that authenticates the resource owner and issues access tokens after obtaining authorization.
        -   `Resource Server`: The server hosting the protected resources that the client wants to access.

    -   **Flows/Grant Types**:

        -   `Authorization Code Grant`: Used by web applications where the client can securely retrieve an authorization code by directing the user's browser to an authorization endpoint. The authorization code is then exchanged for an access token.
        -   `Implicit Grant`: Designed for mobile and browser-based applications where the client obtains an access token directly without an intermediate authorization code.
        -   `Client Credentials Grant`: Used when the client is the resource owner and requests access to its resources.
        -   `Resource Owner Password Credentials Grant`: Involves the resource owner's credentials being directly used by the client to obtain an access token.

    -   **Access Tokens**:

        -   `Bearer Tokens`: The most common type of access token in OAuth. It is a string representing the authorization granted to the client.
        -   `Token Lifespan`: Access tokens have a limited lifespan and may be short-lived. Refresh tokens can be used to obtain a new access token without requiring the user to re-authenticate.

    -   **Scopes**:

        -   `Scope`: A parameter that defines the specific permissions or access levels requested by the client. It allows resource owners to control the scope of access granted.

    -   **Endpoints**:

        -   `Authorization Endpoint`: Where the resource owner grants authorization to the client.
        -   `Token Endpoint`: Where the client exchanges the authorization code or credentials for an access token.
        -   `Redirection URI`: The URI to which the authorization server redirects the user-agent (browser) after granting or denying access.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">RPC</summary>

    -   [REST vs RPC](https://blog.algomaster.io/p/106604fb-b746-41de-88fb-60e932b2ff68)

    Remote Procedure Call (RPC) is a protocol or architectural concept that allows a program to execute a procedure (or function/method) on a remote server as if it were a local function call. This abstraction simplifies the process of building distributed applications, as developers can invoke remote services without worrying about the underlying network communication.

    #### Key Concepts and Components of RPC

    1. **Client-Server Model**:

        - **Client**: The entity that makes the RPC request, asking the server to perform a particular action.
        - **Server**: The entity that receives the RPC request, executes the requested procedure, and sends the result back to the client.

    2. **Procedure Call**:

        - In a traditional local procedure call, a program calls a function or method within the same process. With RPC, this concept is extended to call functions on a remote machine, abstracting the complexities of network communication.

    3. **Marshalling and Unmarshalling**:

        - **Marshalling**: The process of converting the procedure parameters into a format that can be transmitted over the network. This typically involves serializing the data into a byte stream.
        - **Unmarshalling**: The reverse process, where the byte stream received from the network is converted back into the original data format (i.e., deserialized) that can be used by the server or client.

    4. **Stub or Proxy**:

        - **Client Stub (Proxy)**: A local object that represents the remote function. When a client calls this stub, it handles the marshalling of the parameters and sends the request to the server.
        - **Server Stub (Skeleton)**: On the server side, the stub receives the request, unmarshals the parameters, and calls the actual procedure. After the procedure is executed, it marshals the response and sends it back to the client.

    5. **Transport Layer**:

        - RPC relies on a transport protocol to send the request from the client to the server and return the response. Common transport protocols include TCP/IP, HTTP, and sometimes lower-level protocols depending on the implementation.

    6. **Communication Flow**:

        - **Step 1**: The client makes a call to a remote procedure as if it were a local function.
        - **Step 2**: The client stub (proxy) marshals the procedure parameters and sends a request message to the server.
        - **Step 3**: The server receives the message, and the server stub (skeleton) unmarshals the parameters.
        - **Step 4**: The server stub calls the actual procedure on the server.
        - **Step 5**: The server procedure executes and returns a result.
        - **Step 6**: The server stub marshals the result and sends it back to the client.
        - **Step 7**: The client stub receives the response, unmarshals it, and passes the result back to the client application.

    7. **Error Handling**:
        - RPC introduces new challenges for error handling because the client and server are in different processes, potentially on different machines. Errors can occur due to network issues, server downtime, or failures during marshalling/unmarshalling. RPC systems typically need to provide robust mechanisms for handling timeouts, retries, and reporting errors back to the client.

    #### Types of RPC

    8. **Synchronous RPC**:

        - The client sends a request and waits (blocks) for the server to process the request and return the response. This is the most common type of RPC.

    9. **Asynchronous RPC**:

        - The client sends a request and does not wait for the response immediately. The response is processed in the background, allowing the client to continue executing other tasks.

    10. **Batch RPC**:
        - Multiple RPC requests are grouped together and sent to the server in a single message, reducing the overhead of multiple network calls. The server processes each request and sends back a batch response.

    #### Protocols and Implementations

    11. **JSON-RPC**:

        -   A lightweight RPC protocol using JSON for message encoding. It’s commonly used for web applications and services where simplicity and human-readable formats are desirable.

    12. **XML-RPC**:

        -   Similar to JSON-RPC but uses XML for encoding the request and response messages. It is older and less common than JSON-RPC.

    13. **gRPC**:

        -   A modern, high-performance RPC framework developed by Google. gRPC uses Protocol Buffers (protobufs) for serializing structured data and supports multiple programming languages. It also supports features like authentication, load balancing, and streaming.

    14. **SOAP (Simple Object Access Protocol)**:
        -   An older protocol that uses XML for message formatting and typically operates over HTTP/HTTPS. Although SOAP is more complex than modern RPC systems like gRPC, it is still used in enterprise environments due to its support for WS-\* standards (e.g., security, transactions).

    #### Advantages of RPC

    15. **Simplicity**:

        -   RPC abstracts the complexity of network communication, making distributed programming easier. Developers can call remote procedures as if they were local functions, without needing to manage sockets, serialization, or protocols directly.

    16. **Language Agnostic**:

        -   Many RPC systems (like gRPC) support multiple programming languages, making it easier to build services that interact with clients written in different languages.

    17. **Performance**:
        -   Modern RPC frameworks like gRPC are optimized for performance, with efficient serialization formats (e.g., Protocol Buffers) and support for streaming, which can reduce latency and improve throughput.

    #### Disadvantages of RPC

    18. **Tight Coupling**:

        -   RPC can lead to tight coupling between the client and server since clients need to know the exact methods available on the server. This can make it harder to evolve the API over time.

    19. **Complex Error Handling**:

        -   Since RPC involves network communication, it introduces new failure modes that are not present in local function calls. Handling these errors requires additional complexity.

    20. **Scalability Challenges**:
        -   RPC can be less scalable than other architectures like REST, especially in scenarios requiring stateless, cacheable, and scalable interactions typical of large web applications.

    #### RPC vs. Other Paradigms

    -   **RPC vs. REST**: RPC is procedure-oriented, focusing on invoking remote methods, while REST is resource-oriented, focusing on manipulating resources via standard HTTP methods. REST is typically more scalable and loosely coupled, while RPC is often more efficient for fine-grained operations.

    -   **RPC vs. Message Queue**: While RPC focuses on direct calls to remote procedures, message queues (like RabbitMQ) are used for asynchronous communication between distributed components. Message queues are more suitable for decoupling components and handling spikes in workload through buffering.

    #### Conclusion

    RPC is a powerful paradigm for building distributed systems that require direct, synchronous communication between clients and servers. While it simplifies distributed programming by abstracting the details of network communication, it also introduces challenges related to error handling, coupling, and scalability. Modern implementations like gRPC have addressed many of these challenges, making RPC a viable option for high-performance, cross-language services.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">SOAP</summary>

    SOAP (Simple Object Access Protocol) is a protocol for exchanging structured information in the implementation of web services. It uses XML for its message format and relies on application layer protocols, most commonly HTTP or SMTP, for message negotiation and transmission.

    #### Key Characteristics of SOAP

    1. **Protocol-Based Communication**: SOAP defines a standard protocol specification for exchanging structured information between web services. It is protocol-agnostic, meaning it can work over any transport protocol such as HTTP, SMTP, TCP, etc.
    2. **XML-Based Messaging**: SOAP messages are encoded in XML, making them platform-independent and ensuring that they can be read and understood by any system that understands XML. A typical SOAP message includes an envelope, a header, and a body.
    3. **Strict Standards and Specifications**: SOAP follows strict standards defined by the W3C, ensuring a high level of interoperability between different systems and programming languages. It includes standards for security (WS-Security), transactions (WS-AtomicTransaction), and more.
    4. **Built-in Error Handling**: SOAP has built-in error handling through its fault elements, allowing for detailed error reporting and handling mechanisms in the communication process.
    5. **Extensibility**: SOAP's XML-based protocol can be extended to support different message exchange patterns, such as request/response, one-way messages, and more complex interactions.

    #### Components of SOAP

    1. **SOAP Envelope:**

        - The envelope is the root element of a SOAP message and defines the start and end of the message. It contains a header and a body.
        - Example:
            ```xml
            <soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope">
            <soap:Header>
                <!-- Optional headers go here -->
            </soap:Header>
            <soap:Body>
                <!-- Body containing the actual message -->
            </soap:Body>
            </soap:Envelope>
            ```

    2. **SOAP Header:**

        - The header is an optional element that contains application-specific information (like security credentials or transaction IDs) about the SOAP message.
        - Example:
            ```xml
            <soap:Header>
            <authToken>12345</authToken>
            </soap:Header>
            ```

    3. **SOAP Body:**

        - The body is a mandatory element that contains the actual message intended for the recipient. It can include request or response data.
        - Example:
            ```xml
            <soap:Body>
            <m:GetBookDetails xmlns:m="http://example.org/book">
                <m:ISBN>1234567890</m:ISBN>
            </m:GetBookDetails>
            </soap:Body>
            ```

    4. **SOAP Fault:**
        - The fault element is used for error handling and appears within the body of the SOAP message if there is an error in processing the message.
        - Example:
            ```xml
            <soap:Body>
            <soap:Fault>
                <faultcode>soap:Client</faultcode>
                <faultstring>Invalid ISBN</faultstring>
            </soap:Fault>
            </soap:Body>
            ```

    #### Summary

    SOAP is a protocol for exchanging structured information in web services. It uses XML for message formatting and relies on a variety of network protocols, such as HTTP or SMTP, for message negotiation and transmission.

    -   **Key Points**:

        -   1. **XML-Based:** Messages are formatted in XML, making them platform-independent.
        -   2. **Protocol-Agnostic:** Can work over different network protocols (e.g., HTTP, SMTP).
        -   3. **Structured Format:** Consists of an envelope, header, body, and fault elements for errors.
        -   4. **Standardized:** Follows W3C standards for high interoperability.
        -   5. **Error Handling:** Built-in mechanisms for error reporting.

    SOAP (Simple Object Access Protocol) is a protocol used in API design to facilitate the exchange of structured information in web services. It employs XML for message formatting, follows strict standards for interoperability, and includes built-in mechanisms for extensibility and error handling. SOAP can operate over various transport protocols and is known for its robustness and ability to work in diverse and complex enterprise environments.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">OpenAPI</summary>


    > **OpenAPI** (formerly known as the Swagger Specification) is a standardized, machine-readable API description format for RESTful APIs. It allows humans and computers to understand the capabilities of a service without access to the source code, additional documentation, or network traffic inspection.

    > Think of an OpenAPI document as a **blueprint or a contract** written in YAML or JSON. Once you write this blueprint, you can use automated tools to generate interactive documentation (like Swagger UI), generate SDKs/code clients in dozens of languages, and automate API testing.


    - OpenAPI specification
    - OpenAPI Defination
    - Benefits of OpenAPI
      - Standarize Format
        - Readable by Human/Machine
      - Guidance
        - understand the API
        - Extend REST API with tooling
          - API Validatator
          - API Doc generator
          - SDK Generator


    -   **The Core Components of an OpenAPI Document**:

        > An OpenAPI file is structured into several root-level objects. Here is a breakdown of all the primary components that make up a complete specification.

        1. **`openapi` (The Version)**: This is a required string that defines the semantic version of the OpenAPI Specification you are using (e.g., `openapi: 3.0.3` or `openapi: 3.1.0`). This tells tooling how to parse the rest of the document.

        2. **`info` (The Metadata)**: This section provides essential metadata about the API itself. It helps developers understand what the API does, who owns it, and how to get help.

            * **`title`:** The name of your API (e.g., "E-Commerce Shipping API").
            * **`version`:** The internal version of your actual API layout (e.g., `v1.0.2`).
            * **`description`:** A detailed markdown-supported summary of the API's purpose.
            * **`contact` / `license`:** Support emails, URLs, and legal usage licensing.

        3. **`servers` (The Base URLs)**: An array of objects specifying the connectivity information for your API. You can list multiple environments here, such as Production, Staging, and Local Development.

            * **Example:**
            ```yaml
            servers:
            - url: https://api.production.com/v1
                description: Production server
            - url: https://staging.api.com/v1
                description: Staging server for testing
            ```

        4. **`paths` (The Endpoints & Operations)**: This is the heart of your OpenAPI document. The `paths` object defines the relative endpoints (routes) of your API and the HTTP methods (GET, POST, PUT, DELETE) available on those endpoints.

            Each operation under a path contains:

            * **`summary` / `description`:** A short explanation of what the specific endpoint does.
            * **`parameters`:** Inputs passed via the URL path (e.g., `/users/{id}`), query strings (e.g., `?limit=10`), or headers.
            * **`requestBody`:** Required for POST, PUT, and PATCH requests. It describes the payload data the client must send to the server, including the content type (e.g., `application/json`).
            * **`responses`:** A container for the HTTP status codes returned by the server (e.g., `200 OK`, `404 Not Found`). Each response details what data type or schema is returned in the response body.

        5. **`components` (The Reusable Objects)**: To avoid repeating yourself (DRY principle), OpenAPI features a `components` section. You define your data structures, security schemes, and parameters here once, and then reference them throughout the `paths` section using JSON References (`$ref`).

            `components` can hold several sub-objects:

            * **`schemas`:** The data models. For example, you define what a `User` object looks like (e.g., it must have an integer `id`, a string `email`, and a string `name`).
            * **`securitySchemes`:** Defines how your API is protected. It supports API Keys, HTTP Authentication (Basic/Bearer JWT), OAuth2, and OpenID Connect.
            * **`parameters` / `requestBodies` / `responses`:** Reusable query parameters or standard error responses (like a generic 500 Server Error block) used across multiple endpoints.

        6. **`security` (Global Requirements)**: While `components.securitySchemes` *defines* how security works, the root-level `security` array actually *applies* those schemes to the API. If placed at the root level, it enforces that security method globally across every single endpoint unless explicitly overridden on an individual path.

        7. **`tags` (The Organization)**: An array of objects used to group and categorize your endpoints. Interactive documentation tools use tags to split your endpoints into clean, logical user-interface folders (e.g., grouping all endpoints related to "/orders" under an "Orders" tag).


    -   **A Visualizing Example: Putting it Together**:

        -   Here is a simplified visual representation of how these pieces connect in a real file:

            ```yaml
            openapi: 3.0.0
            info:
            title: Quickstart API
            version: 1.0.0
            servers:
            - url: https://api.example.com
            paths:
            /users/{userId}:
                get:
                summary: Get user by ID
                parameters:
                    - name: userId
                    in: path
                    required: true
                    schema:
                        type: integer
                responses:
                    '200':
                    description: Successful response
                    content:
                        application/json:
                        schema:
                            $ref: '#/components/schemas/User' # <--- References the component below
            components:
            schemas:
                User: # <--- Reusable definition
                type: object
                properties:
                    id:
                    type: integer
                    name:
                    type: string
            ```

    </details>