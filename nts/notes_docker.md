-   <details><summary style="font-size:25px;color:Orange">Docker: Configuration</summary>

    -   ![Expose Docker REST API](../assets/docker/enable_docker_restapi.png)
    -   **Docker Daemon**:
    -   **Docker Socket**(`/var/run/docker.sock`):
    -   **Docker CLI**:

    -   `$ ps -ef | grep docker`

    -   **Expose/Enable Docker REST API at port `4243`**:

        -   Open docker service file (`/lib/systemd/system/docker.service`). Search for `ExecStart` and replace that line as following.

            -   `$ sudo vim /lib/systemd/system/docker.service`

                -   Replace `ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock` line by `ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock`
                    -   `-H tcp://0.0.0.0:4243`:
                        -   `-H`: Defines a host or socket on which the Docker daemon listens for API requests.
                        -   `tcp://0.0.0.0:4243`:
                            -   Protocol: `tcp` means the Docker daemon will listen on the TCP protocol.
                            -   `0.0.0.0`: Indicates that the daemon will accept connections from all IP addresses on the server (not restricted to localhost).
                            -   Port `4243`: The port on which the Docker API will be exposed.
                        -   Purpose:
                            -   Enables remote management of the Docker daemon via the Docker Remote API.
                            -   This can be used for Docker CLI commands, custom applications, or orchestration tools like Kubernetes or Docker Swarm.

        -   `$ sudo systemctl daemon-reload`
        -   `$ sudo service docker restart`

        -   `$ curl http://localhost:4243/version` -> Varify that you'r able to access Docker Host at Port#4243 from Docker Host Machine.
        -   `$ curl ec2-3-224-245-94.compute-1.amazonaws.com:4243/version` -> Varify that you'r able to access Docker Host at Port#4243 from a remote machine.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">MISC</summary>

    ### Tutorials:

    -   [Complete Docker Course](https://www.youtube.com/watch?v=RqTEHSBrYFw)
    -   [Nana: Docker Tutorial for Beginners [FULL COURSE in 3 Hours]](https://www.youtube.com/watch?v=3c-iBn73dDE&t=21s)
    -   [Learn Docker - DevOps with Node.js & Express](https://www.youtube.com/watch?v=9zUHg7xjIqQ&list=PLWKjhJtqVAbkzvvpY12KkfiIGso9A_Ixs&index=8)
    -   [Docker and Kubernetes Complete Tutorial](https://www.youtube.com/playlist?list=PL0hSJrxggIQoKLETBSmgbbvE4FO_eEgoB)
    -   [Dockerfile Components](https://github.com/wsargent/docker-cheat-sheet#dockerfile)
    -   [Docker Commands Cheat Sheet](https://buddy.works/tutorials/docker-commands-cheat-sheet#docker-container-commands)
    -   [Docker Cheat Sheet](https://intellipaat.com/blog/tutorial/devops-tutorial/docker-cheat-sheet/)
    -   [The Docker Handbook – 2021 Edition](https://www.freecodecamp.org/news/the-docker-handbook/)

        -   [the-docker-handbook](https://github.com/fhsinchy/the-docker-handbook)

    -   [unix:///var/run/docker.sock](https://www.youtube.com/watch?v=FcZ1Dh3X5JQ)

    -   [Linux: Install Docker Engine](https://docs.docker.com/engine/install/ubuntu/)

        -   [How to use Docker on CentOS 7](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-centos-7)
        -   [Install using the repository](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)
        -   [Install using the convenience script](https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script)
        -   [Container Dev: Develop from anywhere with Visual Studio Code](https://www.youtube.com/watch?v=CYObXaSjj78)

    -   The Docker daemon is located at `unix:///var/run/docker.sock` on Linux server
    -   `$ sudo systemctl status docker` → Check whether Docker is running or not on Linux machine.

    -   `$ docker --version`
    -   `$ docker version`
    -   `$ docker-compose --version`
    -   `$ ls /var/lib/docker/`
        -   `/aufs`
        -   `/containers`
        -   `/image`
        -   `/volumes`
    -   `$ docker info`
    -   `$ sudo service docker status`
    -   `$ systemctl is-active docker`
    -   `$ sudo vim /lib/systemd/system/docker.service`
    -   `$ sudo systemclt daemon-reload`
    -   `$ sudo service docker restart`

    ### Docker on Mac OS

    -   How to start Docke App from terminal on `MacOS` ONLY?
        -   `$ open -a Docker`
    -   How to stop Docke App from terminal on `MacOS` ONLY?

        1.  `$ ps aux | grep Docker`
        2.  `$ kil PIP`

    -   `~/Library/Containers/com.docker.docker/`: This is the base directory for Docker Desktop data on macOS. It contains configurations and other data for Docker Desktop.
    -   `Data/vms/0/`: Within the Data/vms/0/ directory, Docker stores the data for the virtual machine that runs the Docker engine, including containers, images, volumes, and other data.

    -   [Linux: Install Docker Engine]()

        -   `/home/airflow/.local/lib/python3.7/site-packages/airflow/example_dags/`
            -   Location of example dags in container
        -   Docker Desktop for macOS uses a lightweight Linux VM to run the Docker engine, so the actual location of Docker volumes on your Mac is within this VM. However, you can access the files stored in Docker volumes from the host machine using a specific mount path.

    -   Uninstall Docker Desktop:

        -   Open Docker Desktop.
        -   Go to the Docker menu in the status bar and select Preferences.
        -   Under the Reset tab, click Uninstall.

    -   Remove Docker-related files:

    ```sh
    uninstall_docker_on_mac(){

        # Remove Docker configuration and data files
        rm -rf ~/Library/Containers/com.docker.docker
        rm -rf ~/Library/Group\ Containers/group.com.docker
        rm -rf ~/Library/Logs/Docker\ Desktop
        rm -rf ~/Library/Preferences/com.docker.docker.plist
        rm -rf ~/Library/Saved\ Application\ State/com.electron.docker-frontend.savedState
        rm -rf ~/Library/Application\ Support/Docker\ Desktop
        rm -rf ~/Library/Logs/Docker\ Desktop

        # Remove Docker-related files in /usr/local/bin
        sudo rm -f /usr/local/bin/docker
        sudo rm -f /usr/local/bin/docker-compose
        sudo rm -f /usr/local/bin/docker-credential-osxkeychain
        sudo rm -f /usr/local/bin/docker-machine

        # Remove Docker directories
        sudo rm -rf /var/lib/docker
        sudo rm -rf /var/run/docker.sock

        # 4. Remove Virtual Machine files
        rm -rf ~/Library/Containers/com.docker.docker/Data/vms

        # Remove Docker-related plists
        sudo rm -f ~/Library/LaunchAgents/com.docker.helper.plist
        sudo rm -f /Library/LaunchDaemons/com.docker.vmnetd.plist
        sudo rm -f /Library/PrivilegedHelperTools/com.docker.vmnetd
    }
    ```

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Terms & Concepts</summary>

    -   [Glossary](https://docs.docker.com/glossary/)

    -   `Docker`: Docker is an open-source platform that enables developers to automate the deployment and management of applications within lightweight, isolated containers. It provides an efficient and consistent way to package software, its dependencies, and configurations into a portable unit called a container.
    -   `Container`: A container is a lightweight, standalone, and executable package that includes everything needed to run an application, including the code, runtime, system tools, libraries, and settings. Containers offer isolation and portability, enabling applications to run consistently across different environments.
    -   `Image`: An image is a read-only template or snapshot of a container. It contains the application's code, runtime, system tools, libraries, and dependencies. Images are used to create and run containers. They can be built from a Dockerfile or pulled from a registry, such as Docker Hub.
    -   `Dockerfile`: A Dockerfile is a text file that contains instructions to build a Docker image. It specifies the base image, the application code, runtime configurations, dependencies, and other settings required to create a containerized application. Dockerfiles follow a specific syntax and can be version-controlled alongside the application code.
    -   `Registry`: A registry is a repository for storing and sharing Docker images. Docker Hub is the default public registry provided by Docker, where users can find and share pre-built images. Private registries can also be set up to store custom images within an organization's infrastructure.
    -   `Containerization`: Containerization is the process of encapsulating an application and its dependencies within a container. It provides a lightweight and portable alternative to traditional virtualization, allowing applications to run consistently across different environments without worrying about compatibility issues.
    -   `docker-compose`: Docker Compose is a tool for defining and running multi-container Docker applications. It uses a YAML file (docker-compose.yml) to specify the services, networks, and volumes required for an application. Docker Compose simplifies the orchestration of complex applications composed of multiple interconnected containers.
    -   `Orchestration`: Orchestration refers to the management and coordination of multiple containers within a distributed application or infrastructure. Docker Swarm and Kubernetes are popular container orchestration platforms that automate container deployment, scaling, load balancing, service discovery, and fault tolerance.
    -   `Service`: In Docker Swarm or Kubernetes, a service is a logical abstraction that represents a running instance of an application or microservice. It encapsulates a group of containers and provides a consistent endpoint for accessing the application, load balancing traffic, and enabling scalability.
    -   `Volume`: A volume is a persistent storage mechanism in Docker that allows data to be shared and preserved between containers and the host machine. Volumes provide a way to manage and persist application data separately from the container's lifecycle, ensuring data integrity and persistence even if the container is stopped or removed.

        ```yml
        version: "3"

        services:
        webapp:
            image: nginx
            volumes:
                - ./host-data:/usr/share/nginx/html # Volume Mounts
                - /path/on/host:/path/in/container # Volume Mounts
                - named-volume:/container/mount/point

        volumes:
            named-volume:
        ```

        -   `Named Volumes`:

            -   Named volumes are a type of Docker volume that is created and managed by Docker itself.
            -   They provide a way to persist data independently of the host machine's file system.
            -   Named volumes are identified by a user-defined name and can be shared and accessed by multiple containers.
            -   Docker manages the lifecycle of named volumes, ensuring data integrity and allowing for easy backup, restoration, and migration.
            -   Named volumes are typically defined in the `docker-compose` file or with the `docker volume create` command and then mounted into containers using the `--mount` or `-v` flag.

        -   `Anonymous Volumes`: are created automatically when a container is created with the `--mount` or `-v` flag, without specifying a named volume. Anonymous volumes are not managed by Docker and their contents are lost when the container is deleted. Anonymous volumes are useful for testing and debugging, but not recommended for production use.

        -   `Volumes Mounts`:

            -   Volume mounts, also known as bind mounts, involve mounting a specific directory or file from the host machine directly into the container.
            -   With volume mounts, the data is stored on the host machine's file system and is shared with the container.
            -   Any changes made to the mounted directory or file in the container are immediately reflected on the host machine and vice versa.
            -   Volume mounts are typically specified in the `docker run` command or in the `docker-compose` file using the `<absolut_host_path>:<container_path>` syntax.

            -   `Bind Mounts`: allows you to mount a host file or directory into a container. The host file or directory is mounted directly into the container's file system and changes made to the mounted file or directory are reflected in both the host and container file systems.

                -   Bind mounts are a specific type of volume mount that map a host file or directory to a container.
                -   Bind mounts are specified in the `docker run` command or in the `docker-compose` file using the `<host_path>:<container_path>:<options>` syntax, where `<options>` can include `read-only` mode, consistency settings, or other mount options.


    -   `Networking`: Docker provides networking capabilities to enable communication between containers and other services. Docker creates a default bridge network for containers to communicate with each other. Additionally, Docker supports custom networks to isolate containers, attach containers to specific networks, and define network-level policies. Docker provides a flexible networking model that allows you to connect containers in various ways. Here are key concepts related to Docker networks:

        -   **Default Bridge Network**:

            -   When Docker is installed, it creates a default bridge network named bridge.
            -   Containers connected to the bridge network can communicate with each other, but by default, they are isolated from the host and other networks.

        -   **User-Defined Bridge Networks**:

            -   Docker allows you to create user-defined bridge networks.
            -   Containers connected to the same user-defined bridge network can communicate with each other, and they can also communicate with containers on the default bridge network.
            -   User-defined bridge networks provide better isolation and can be customized for specific applications.
            -   `$ docker network create mynetwork`

        -   **Host Network**:

            -   Containers can be connected to the host network, bypassing the network isolation provided by Docker.
            -   Containers on the host network share the network namespace with the host machine and can access services running on the host directly.
            -   `$ docker run --network host myimage`

        -   **Overlay Network**:

            -   Docker supports overlay networks for connecting containers across multiple Docker hosts.
            -   This is particularly useful in a swarm mode where you have multiple Docker hosts in a cluster.
            -   Overlay networks use the VXLAN protocol for communication between nodes.
            -   `$ docker network create --driver overlay myoverlay`

        -   **Macvlan Network**:

            -   Macvlan allows containers to have their own MAC address and appear as physical devices on the network.
            -   This can be useful when you want containers to be directly reachable on the network.
            -   `$ docker network create --driver macvlan --subnet=192.168.1.0/24 --gateway=192.168.1.1 -o parent=eth0 mymacvlan`

        -   **Network Inspection and Troubleshooting**:

            -   You can inspect a network to view its details, including connected containers.
            -   `$ docker network inspect mynetwork`
            -   Troubleshooting network issues can involve checking container IP addresses, DNS configuration, and ensuring proper connectivity between containers.

    -   `Attach Mode`: In the attached mode, Docker can start the process in the container and attach the console to the process’s standard input, standard output, and standard error.When you run a `docker run` command, it runs in the foreground or in an attached mode, meaning you will be attached to the console or the standard out of the Docker container. And you will see the output of the web service on your screen. You won't be able to do anything else on this console other than view the output until this Docker container stops. It won't respond to your inputs. press the `ctrl+c` combination to stop the container and the application hosted on the container exits and you get back to your prompt.
    -   `Detach Mode`: Detach mode started by the option `--detach` or `–d` flag in `docker run` command, means that a Docker container runs in the background of your terminal. It does not receive input or display output. Using detached mode also allows you to close the opened terminal session without stopping the container. The container will continue to run in the backend, run the `docker ps` command to view the running container. Now if you would like to attach back to the running container later, run the `docker attach con_id/con_name` command and specify the name or ID of the Docker container.
    -   `Context`: Context refers to the set of files and directories that are used as the basis for building Docker images or running Docker containers. When you build a Docker image, the build context is specified as an argument to the `docker build` command and is typically a directory on the local machine. When you run a Docker container, the context is specified as an argument to the `docker run` command and can be a Docker image, a directory on the local machine, or a remote location.
    -   `Build Stage`:
    -   `Layer`: A layer is modification to the image, represented by an instruction in the Dockerfile. Layers are applied in sequence to the base image to create the final image. When an image is updated or rebuilt, only layers that change need to be updated, and unchanged layers are cached locally. This is part of why Docker images are so fast and lightweight. The sizes of each layer add up to equal the size of the final image.

    -   `Exposing`/`Publishing` Port:

        -   Exposing a port in Docker means that the port is made available for use within the Docker network, but it is not accessible from outside the network or from the host machine. This is done using the `EXPOSE` instruction in a `Dockerfile` or the `--expose` flag when running a container.
            -   Example: `EXPOSE 8080` would make port 8080 available within the Docker network.
        -   Publishing a port in Docker means that the port is made accessible from outside the Docker network, allowing traffic to flow between the container and the host machine or other external networks. This is done using the `--publish` or `-p` flag when running a container.
            -   Example: `docker run -p 8080:80` would publish/map port 8080 on the host machine to the port 80 on the container, allowing traffic to be routed to the container from the host machine.
        -   `Note`: Exposing a port does not automatically publish it, and publishing a port does not require it to be exposed. Exposing a port is simply a way of documenting which ports a container is using and making them available for use within the Docker network. Publishing a port is necessary if you want to access the container from outside the Docker network or the host machine.

    -   `Storage Drivers`: Docker storage drivers are responsible for managing the storage backend of Docker containers. They define how the filesystem data for containers is stored and managed. Different storage drivers have different characteristics, performance profiles, and support for various features. Here are some commonly used Docker storage drivers:

        -   **aufs (Advanced Multi-Layered Unification File System)**:

            -   aufs was one of the earliest storage drivers and allowed for efficient layering of images.
            -   It supported copy-on-write, enabling the sharing of common layers among multiple containers.
            -   However, aufs is no longer the default driver, and its usage has diminished in favor of other drivers.

        -   **overlay and overlay2**:

            -   overlay and overlay2 are modern and widely used storage drivers.
            -   They provide better performance and support more features compared to aufs.
            -   Both drivers allow for layering images, copy-on-write, and efficient use of storage space.
            -   overlay2 is the recommended driver for most Linux distributions.

        -   **btrfs (B-tree File System)**:

            -   btrfs is a copy-on-write filesystem with features like snapshotting and subvolumes.
            -   While it supports Docker, its adoption has been limited due to certain stability concerns and dependencies.

        -   **devicemapper**:

            -   devicemapper uses the device mapper thin provisioning framework in the Linux kernel.
            -   It supports features like snapshots and thin provisioning.
            -   It can be used with loopback devices or directly with block devices.
            -   devicemapper requires careful configuration and management to avoid potential performance and storage space issues.

        -   **vfs (Virtual File System)**:

            -   vfs is the most basic storage driver and is used for testing and development.
            -   It doesn't provide the same level of performance and efficiency as other drivers.
            -   It does not support features like layering or copy-on-write.

        -   To specify a storage driver for Docker, you can use the --storage-driver option when starting the Docker daemon or set it in the Docker daemon configuration file. For example:

            -   `$ dockerd --storage-driver overlay2`

            Or in the Docker daemon configuration file (e.g., /etc/docker/daemon.json):

            ```json
            {
                "storage-driver": "overlay2"
            }
            ```

        -   The choice of a storage driver can depend on factors such as performance requirements, filesystem support, and the specific features needed for your use case. It's essential to be aware of the characteristics and limitations of each storage driver when selecting the most suitable one for your Docker environment.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">docker</summary>

    -   [docker](https://docs.docker.com/engine/reference/commandline/docker/) | [Use the Docker command line](https://docs.docker.com/engine/reference/commandline/cli/)

    -   [$ docker build](https://docs.docker.com/engine/reference/commandline/build/): `docker build [OPTIONS] PATH | URL | -`

        -   The docker build command is used to build a Docker image from a Dockerfile. It automates the process of creating a customized and reproducible image that encapsulates an application or service. Here's a detailed explanation of the docker build command and its various aspects:
        -   `docker build [OPTIONS] PATH | URL | -`

            -   `OPTIONS`: Specifies additional build options to customize the image creation process.
            -   `PATH` | `URL` | `-`: Specifies the path to the build context, which includes the Dockerfile and any files referenced by it. It can be a local directory path, a URL to a Git repository, or `-` to use the standard input.
            -   Commonly used options with the docker build command:
                -   `-t` or `--tag`: Assigns a name and optional tag to the built image in the format <name>:<tag>.
                -   `-f` or `--file`: Specifies the path to the Dockerfile if it is not named Dockerfile or is located in a different directory.
                -   `--build-arg`: Defines build-time variables that can be accessed within the Dockerfile.
                -   `--no-cache`: Forces Docker to build the image from scratch, ignoring any cached layers.
                -   `--pull`: Forces Docker to always attempt to pull the latest version of the base image.

        -   `$ docker build -t image_name .`
            -   The `-t` flag is used to tag the new built image by the image-name of "image_name". The `.` is used to indicate that the Dockerfile is in the current directory (`.`), along with so-called “context” — that is, the rest of the files that may be in that location

        -   `$ docker run -dit --rm -v $GD/gd/Software_Development/notes_hub/dotfiles/Linux:/root --name=rhel8 roboxes/rhel8 sleep 9000`

    -   [`docker run` (Actually an Alias for `docker container run`)](https://docs.docker.com/engine/reference/commandline/run/): `docker run [OPTIONS] IMAGE [COMMAND] [ARG...]`

        -   The docker run command is used to launch and run a Docker container based on a pre-built specific Docker image. It is one of the fundamental commands in Docker and allows you to instantiate and start a container from an image. Here's a detailed explanation of the docker run command and its various options:

            -   `docker run [OPTIONS] IMAGE [COMMAND] [ARG...]`

                -   `OPTIONS`: Specifies additional options to customize the behavior of the container.
                -   `IMAGE`: Specifies the Docker image to use for creating the container.
                -   `COMMAND` (optional): Overrides the default command specified in the Docker image.
                -   `ARG...` (optional): Arguments passed to the command in the container.

            -   Commonly used options with the `docker run` command:

                -   `-d` or `--detach` (Detatched Mode): It tells Docker to run the container in the background. If you omit this, your terminal will be **locked** to the container's output.
                -   `-i` or `--interactive` (Interactive Mode): Keeps STDIN open even if not attached.
                -   `-t` (TTY): Allocates a pseudo-TTY (a virtual terminal).
                -   `-v` or `--volume`: Mounts a host directory or volume into the container in the format `<host-path>:<container-path>`.
                -   `-p` or `--publish`: Maps container ports to host ports in the format `<host-port>:<container-port>`.
                -   `-expose`: Expose a port or a range of ports.
                -   `--name`: Assigns a custom name to the container.
                -   `--env` or `-e`: Sets environment variables in the container.
                -   `--restart`: Specifies container restart policy (e.g., always, unless-stopped, on-failure).
                -   `--network`: Connects the container to a specific Docker network.
                -   `--rm`: Specifies to automatically remove the container once it exits.
                -   **Note**: Combining `-it` is what allows you to eventually **enter** the container later using docker exec to run bash commands.

            ```bash
            docker run \
                -dit \                                  # Run in detached (`-d`) and interactive (`-i`) mode with terminal (`-t`) attached to it.
                --rm \                                  # Tells Docker to automatically remove the container once it exits.
                -e WORKING_DIR=/User/a.momin/Data \     # Set environment variables
                -w /code \                              # Working directory inside the container
                -p 8010:8012 \                          # Publish a container's port(s) to the host
                --expose 80 \                           # Expose a port or a range of ports
                --read-only -v /icanwrite \             # Mount the container's root filesystem as read only
                -v `pwd`:`pwd` \                        # This option mounts the current working directory of the host system into the same path inside the container. The backtick syntax pwd`` executes the pwd command to dynamically get the current working directory.
                -v /doesnt/exist:/foo \                 # Docker will automatically create this directory on the host if a bind-mounted volume doesn’t exist.
                --read-only --mount type=volume,target=/icanwritetoo \  # This option creates a volume named /icanwritetoo and mounts it inside the container.
                --mount type=bind,src=/data,dst=/data \     # This option mounts the directory /data from the host system into the same path inside the container.
                -w `pwd` \
                --network=network_name \
                --name=container_name \
                --entrypoint sleep \                     # This option overrides the default entrypoint of the image with the `sleep` command.
                image_name:latest param1                # Append parameter `param1` to entrypoint bash command (`sleep param1`)
            ```

    -   `$ docker run -d --name=name_your_container <image_name>`

        -   Pull image_name down if it's not available in docker-host (Local Machine) and instantiate and run an image_name_container from image_name image.
        -   Run in _Attach Mode_. Add `-d` option to run in _Detach Mode_
        -   `--name=name_your_container` is used to give the container a name to refer it later
        -   EX: `$ docker run nginx`.

    -   **Runing Special UBUNTU Image**:

        -   When you run the Docker run Ubuntu command it runs an instance of Ubuntu image and exits immediately.
        -   Now why is that? Unlike virtual machine containers are not meant to host an operating system. Containers are meant to run a specific task or process such as to host an instance of a web server or application server or a database, or simply to carry some kind of computation or analysis task. Once the task is complete, the container exits. A container only lives as long as the process inside it is alive. If the web service inside the container is stopped, or crash, then the container exits.

        -   `$ docker run ubuntu` → Runs an Ubuntu image and it exites immediately.
        -   `$ docker run ubuntu sleep 60` → Runs an Ubuntu image with sleep command of 60 minutes


    -   `$ docker pull <image_name>` → Just pull down the image into the docker-host (Local machine) form docker registry (Docker Hub)

    -   `Run - STDIN`:

        -   `$ docker run -it <image_name>` → Run in interactive (`i`) mode with terminal (`t`) attached to it.
        -   `$ docker run python:3.7`

    -   `Run - PORT Mapping`:
        -   `$ docker run -it 80:5000 dockerized_flask_app/app`

    ![docker_port_mapping](../assets/docker_port_mapping.png)

    -   Run - VOLUME Mapping:

        -   `$ docker run -v /dir_out_container:/dir_in_container mysql`

    -   Inspect a Container:

        -   `$ docker inspect <container_name | container_id>` → Return details of a container in json format.

    -   **Container Logs**:

        -   `$ docker logs <container_name | container_id>` → Show the logs of a container ran in backgroun (detach mode).
        -   `$ docker logs -f <container_name | container_id>` → Show the logs of a container ran in backgroun (detach mode) with `-f` (--follow) following log output.
        -   `$ docker attach <container_id>` → Run (without `-d` option) in _Attach Mode_ back.

    -   [$ docker ps](https://docs.docker.com/engine/reference/commandline/ps/): `docker ps [OPTIONS]`

        -   `$ docker ps` → list out only the running containers
        -   `$ docker ps -a` → list out all (running/stopped) containers
        -   `$ docker ps --format "table {{.Names}}:\t{{.Ports}}\t{{.Status}}"` → Print the result of `docker pa` in the given format.

    -   [$ docker stop](https://docs.docker.com/engine/reference/commandline/stop/): `docker stop [OPTIONS] CONTAINER [CONTAINER...]`

        -   `$ docker stop <container_id | container_name>` → Stop the given running container keeping the instance of the container for later use.

    -   [$ docker kill](https://docs.docker.com/engine/reference/commandline/kill/): `docker kill [OPTIONS] CONTAINER [CONTAINER...]`

        -   The docker kill subcommand kills one or more containers. The main process inside the container is sent SIGKILL signal (default), or the signal that is specified with the --signal option. You can reference a container by its ID, ID-prefix, or name. While the default (SIGKILL) signal will terminate the container, the signal set through --signal may be non-terminal, depending on the container’s main process. For example, the SIGHUP signal in most cases will be non-terminal, and the container will continue running after receiving the signal.

    -   [$ `docker rm` (Alias of `docker container remove`)](https://docs.docker.com/reference/cli/docker/container/rm/):

        -   `$ docker rm <container_id | container_name>` → Remove the instance of container previously created.
        -   `$ docker images` → List out images available in docker host (local machine or remote server)

        -   `$ docker rmi <image_name>`
            -   Remove the image_name previously build or pulled down from docker registry.
            -   EX: `$ docker rmi nginx`.
            -   Must not running any container of that image.

    -   [$ docker exec](https://docs.docker.com/engine/reference/commandline/exec/): `docker exec [OPTIONS] CONTAINER COMMAND [ARG...]`

        -   `$ docker exec -it <container_id | container_name> bash` → This command is used to access the running container
        -   `$ docker exec -it -u 0 <container_id | container_name> bash` → This command is used to access the running container as a root user.

    -   [$ docker image](): ``

        -   `docker images` → List our images
        -   `$ docker image tag image_name new_image_name` → Take the backup of image_name by new name `new_image_name`
        -   `$ docker rmi <image_name_or_id>` → Remove the docker image.
        -   `$ docker history <image_name_or_id>` → View the hierarchy of the Docker image

    -   `$ docker pull image_name` - Just pull the image from docker registry but don't run it.

    -   `$ docker push`:

        -   `$ docker tag <ImageID> <DockerHubUsername>/<ImageName>:<VersionTag>`
        -   `$ docker tag 596cc7b7fa46 bbcredcap3/django-bookstore:v1`
        -   `$ docker login`
        -   `$ docker push <DockerHubUsername>/<ImageName>:<VersionTag>`
        -   `$ docker push bbcredcap3/django-bookstore:v1`

    -   [$ docker cp](): The `docker cp` command allows you to copy files or directories between your host machine and a running container.
        -   `$ docker cp <source_path> <container_name>:<destination_path>` → Copy my_new_dag.py from CWD to allocated dag volume in the docker container.
        -   `$ docker cp ./my_new_dag.py dagvaol_host:/dags` → Copy my_new_dag.py from CWD to allocated dag volume in the docker container.
            -   Copy content of current directory in the `folder_name` of `volume_name`.
        -   `$ docker cp source <container_name | container_id>:folder_path`

    ##### [docker image]()

    -   `$ docker image ls` (or `ls -a`) → **List** all top-level images currently stored on your local machine.
    -   `$ docker image pull name:tag` → **Download** an image from a registry (like Docker Hub) to your local machine.
    -   `$ docker image push name:tag` → **Upload** a local image to a remote registry.
    -   `$ docker image build -t name .` → **Create** a new image from a `Dockerfile` located in the current directory.
    -   `$ docker image tag image_name new_name` → **Create a shortcut** (alias) that refers to `image_name` by a new name.
    -   `$ docker image inspect image_name` → **Display detailed information** (JSON format) about an image, including layers, OS, and environment variables.
    -   `$ docker image history image_name` → **Show the history** of an image, listing every layer and command used to build it.
    -   `$ docker image save -o file.tar image_name` → **Export** an image to a tarball archive (useful for moving images without a registry).
    -   `$ docker image load -i file.tar` → **Import** an image from a tarball archive back into Docker.
    -   `$ docker image rm image_name` → **Remove** one or more specific images from local storage.
    -   `$ docker image prune` → **Remove all dangling images** (images that are not tagged and not used by any container).
    -   `$ docker image prune -a` → **Remove all unused images**, not just the dangling ones (be careful with this one!).

    ##### Docker Container

    -   `$ docker container --help`
    -   `$ docker container <COMMAND> --help`
    -   `$ docker container attach` → Attach local standard input, output, and error streams to a running container
    -   `$ docker container commit` → Create a new image from a container's changes
    -   `$ docker container cp` → Copy files/folders between a container and the local filesystem
    -   `$ docker container create` → Create a new container
    -   `$ docker container diff` → Inspect changes to files or directories on a container's filesystem
    -   `$ docker container exec` → Run a command in a running container
    -   `$ docker container export` → Export a container's filesystem as a tar archive
    -   `$ docker container inspect` → Display detailed information on one or more containers
    -   `$ docker container kill` → Kill one or more running containers
    -   `$ docker container logs` → Fetch the logs of a container
    -   `$ docker container ls` → List containers
    -   `$ docker container pause` → Pause all processes within one or more containers
    -   `$ docker container port` → List port mappings or a specific mapping for the container
    -   `$ docker container prune` → Remove all stopped containers
    -   `$ docker container rename` → Rename a container
    -   `$ docker container restart` → Restart one or more containers
    -   `$ docker container rm` → Remove one or more containers
    -   `$ docker container run` → Run a command in a new container
    -   `$ docker container start` → Start one or more stopped containers
    -   `$ docker container stats` → Display a live stream of container(s) resource usage statistics
    -   `$ docker container stop` → Stop one or more running containers
    -   `$ docker container top` → Display the running processes of a container
    -   `$ docker container unpause` → Unpause all processes within one or more containers
    -   `$ docker container update` → Update configuration of one or more containers
    -   `$ docker container wait` → Block until one or more containers stop, then print their exit codes


    ##### [docker network](https://docs.docker.com/engine/reference/commandline/network/)

    -   `$ docker network --help`
    -   `$ docker network <COMMAND> --help`
    -   `$ docker network create [OPTIONS] NETWORK`
    -   `$ docker network ls [OPTIONS]`
    -   `$ docker network inspect [OPTIONS] NETWORK [NETWORK...]`
    -   `$ docker network rm NETWORK [NETWORK...]`
    -   `$ docker network prune [OPTIONS]` → Remove all unused networks. Unused networks are those which are not referenced by any containers.
    -   `$ `


    ##### docker volume

    -   [Add bind mounts, volumes or memory filesystems](https://docs.docker.com/engine/reference/commandline/service_create/#add-bind-mounts-volumes-or-memory-filesystems)

    -   `$ docker volume --help`
    -   `$ docker volume ls --help`
    -   `$ docker volume create [OPTIONS] [VOLUME]`
    -   `$ docker volume ls [OPTIONS]`
    -   `$ docker volume inspect [OPTIONS] VOLUME [VOLUME...]`
    -   `$ docker volume rm [OPTIONS] VOLUME [VOLUME...]`
    -   `$ docker volume prune [OPTIONS]` → Remove all unused local volumes. Unused local volumes are those which are not referenced by any containers.
    -   `$ `

    </details>


---

-   <details><summary style="font-size:25px;color:Orange">docker-compose</summary>

    -   [Using Volume in Docker Compose](https://devopsheaven.com/docker/docker-compose/volumes/2018/01/16/volumes-in-docker-compose.html)
    -   [docker-compose](https://docs.docker.com/compose/reference/):
    -   [Compose CLI environment variables](https://docs.docker.com/compose/reference/envvars/)

    Docker Compose is a tool that allows you to define and manage multi-container Docker applications. It simplifies the process of running and orchestrating multiple containers as a single application. Docker Compose uses a YAML file to define the services, networks, and volumes required for the application, making it easy to configure and deploy complex setups. Here's a detailed explanation of Docker Compose and its key components:

    -   **Docker Compose File**:

        -   The core of Docker Compose is the Compose file (docker-compose.yml). It is a YAML-formatted configuration file that defines the services, networks, and volumes for your application.
        -   The Compose file specifies the Docker images to use for each service, the environment variables, container dependencies, network connections, and other configuration options.
        -   It allows you to define multiple services that can interact with each other, creating a cohesive application stack.

    -   **Services**:

        -   A service is a containerized application or component defined in the Compose file. Each service runs as a separate container with its own configuration and properties.
        -   Services can be built from a Dockerfile or use pre-built images from Docker Hub or other repositories.
        -   Services can define ports to expose, volumes to mount, environment variables, dependencies on other services, and other container-specific settings.

    -   **Networks**:

        -   Docker Compose creates a default network for the application, allowing services to communicate with each other using service names as hostnames.
        -   You can define custom networks in the Compose file to isolate and control the communication between services. Custom networks can be used to create separate environments or apply specific network policies.

    -   **Volumes**:

        -   Docker Compose allows you to define volumes to persist data and share it between containers or with the host machine.
        -   Volumes can be used to store databases, log files, or any other data required by the application.
        -   By defining volumes in the Compose file, you ensure that the data persists even if the containers are recreated or restarted.

    -   **Commands**:

        -   Docker Compose provides several commands to manage the application defined in the Compose file, such as up, down, start, stop, build, logs, and more.
        -   For example, docker-compose up starts the application and creates the necessary containers, networks, and volumes as defined in the Compose file.
        -   docker-compose down stops and removes the containers, networks, and volumes associated with the application.

    -   **Benefits**:

        -   Docker Compose simplifies the process of managing multi-container applications, making it easier to define, deploy, and scale complex setups.
        -   It promotes the use of a declarative and version-controlled approach to managing application infrastructure.
        -   With Docker Compose, you can define the entire application stack in a single file, making it easier to share and collaborate on application configurations.

    Docker Compose is a powerful tool for managing containerized applications, allowing you to define and run multi-container environments with ease. It provides a concise and portable way to describe application stacks and simplifies the process of setting up and orchestrating complex Docker-based applications.

    -   `$ docker-compose down` →
    -   `$ docker-compose up --build` → It builds the image before getting up.
    -   `$ docker-compose up -d` → It just spin up the container assuming the image is built already.
    -   `$ docker-compose build` → It just build the image.
    -   `$ docker-compose ` →

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Miscellaneous</summary>

    ### Rough:

    -   `$ docker commit`

        -   docker commit <conatainer_id> <username/imagename>
        -   This command creates a new image of an edited container on the local system

    ### Run Container:

    -   `$ docker run <image name>`

        -   `$ docker run hello-world`

    -   Although this is a perfectly valid command, there is a better way of dispatching commands to the docker daemon.
    -   Prior to version 1.13, Docker had only the previously mentioned command syntax. Later on, the command-line was restructured to have the following syntax:

    -   `$ docker <object> <command> [options] [...]`

        -   `object` indicates the type of Docker object you'll be manipulating. This can be a `container`, `image`, `network` or `volume` object.
        -   `command` indicates the task to be carried out by the daemon, for instance, the `run` command.
        -   `options` can be any valid parameter that can override the default behavior of the command, like the `--publish` option for port mapping.

        -   `$ docker container run -d <image_name>`
        -   `$ docker container run --detach --publish 8080:80 fhsinchy/hello-dock`
        -   `$ docker volume create volume_my_data`
        -   `$ docker network create --drive bridge --subnet 128.18.0.0/16 custom_isolated_network`

        -   `--publish (-p) 8080:80` indicates that any request sent to port 8080 of your host system will be forwarded to port 80 inside the container‌.
        -   `--detach (-d)` option is provided to keep container running without terminal to keep running .
        -   One thing that you have to keep in mind in case of the run command is that the image name must come last. If you put anything after the image name then that'll be passed as an argument to the container entry-point (explained in the [Executing Commands Inside a Container]() sub-section) and may result in unexpected situations.

    -   `$ ctrl + c`

    ### Stop/kill Container:

    -   `$ docker container stop <container_identifier>`
    -   `$ docker container kill <container_identifier>`

        -   If you use the name as identifier, you'll get the name thrown back to you as output. The stop command shuts down a container gracefully by sending a SIGTERM signal. If the container doesn't stop within a certain period, a SIGKILL signal is sent which shuts down the container immediately.
        -   In cases where you want to send a SIGKILL signal instead of a SIGTERM signal, you may use the container kill command instead. The container kill command follows the same syntax as the stop command.


    ### Restart/Reboot Container:

    -   Restart: The container which were previously stoped or killed
    -   Reboot: The container which are currently running.

    -   `$ docker container start <container_identifier`

        -   The container start command can be used to start any stopped or killed container.
        -   The container start command starts any container in detached mode by default and retains any port configurations made previously.

    -   `$ docker container restart <container_identifier`

    -   The main difference between the two commands is that the container restart command attempts to stop the target container and then starts it back up again, whereas the start command just starts an already stopped container.
    -   In case of a stopped container, both commands are exactly the same. But in case of a running container, you must use the container restart command.

    ### Docker Volume:

    -   `Anonymous`: Randomly created and maintained by Docker.
    -   `Host`: Mount a local directory or file on the container
    -   `Named`: Created with a name and maintaied by Docker

    ### Usefull Commands in case of non-responsive Dockers in RHEL

    -   ps -auxwww | head -n1
    -   cat sos_commands/process/ps_auxwww | awk '$8 ~ /D/'
    -   echo 1 > /proc/sys/kernel/sysrq
    -   echo w > /proc/sysrq-trigger

    </details>

---

-   <details><summary style="font-size:25px;color:Orange"> Dockerfile </summary>

    -   [Dockerfile sample for Jupyter notebook images](https://www.ibm.com/docs/en/cloud-paks/cp-data/4.5.x?topic=image-dockerfile-sample-jupyter-notebook-images)
    -   [Dockerfile Components](https://github.com/wsargent/docker-cheat-sheet#dockerfile)

    ### Important Dockerfile Directives

    -   `FROM`: sets the base image for the build process
    -   `LABEL`: adds metadata to the image in the form of key-value pairs
    -   `ENV`: sets an environment variable. ENV - sets an environment variable that will persist in the final image. The value of an ENV variable can be referenced in the Dockerfile using $VAR_NAME syntax and can be used to configure the behavior of applications or scripts running in the container. The value of an ENV variable can also be overridden at runtime using the -e flag when running the container.
        -   `ENV PYTHONUNBUFFERED 1`
            -   In Python, when running scripts or applications, the standard output and standard error streams are usually buffered, which means the output is not immediately displayed in the console. This buffering can cause delays in printing log messages or displaying program output. Setting `PYTHONUNBUFFERED` to a non-zero value, such as 1, disables the buffering of the standard output and standard error streams.
        -   `ENV PATH="/scripts:/py/bin:$PATH"`
    -   `ARG`: sets a build-time argument with a default value. ARG - is used to define a variable that can be passed at build-time using the --build-arg flag. The value of an ARG variable can be changed for each build, and the variable is not persisted in the final image. ARG variables are often used to specify image configuration parameters that can be adjusted without changing the Dockerfile.
    -   `COPY <src> <dest>`: It is a simple instruction that only supports copying files or directories from the host file system into the image. The COPY instruction is faster than ADD, as it does not perform any additional functionality like URL extraction or decompression.
        -   `COPY . .`
    -   `ADD <src> <dest>`: .It is a more versatile instruction that supports copying files or directories from the host file system into the image, as well as extracting tar archives and decompressing gzip files.
    -   `EXPOSE`: exposes one or more ports for external access. The purpose of the EXPOSE instruction in a Dockerfile is to inform the user and other containers about the network ports that the container listens on. When you specify the EXPOSE instruction in your Dockerfile, you are declaring the ports that the container will use for communication. The EXPOSE instruction does not actually publish the ports, it simply provides information about the ports to the user and other containers. To make the exposed ports accessible from the network, you need to use the -p or --publish flag when running the container, which maps the container's exposed ports to ports on the host machine.
    -   `HEALTHCHECK`: specifies how to check the health of the container
    -   `ONBUILD`: triggers a command when the image is used as the base for another build
    -   `RUN`: runs a command in a new layer on top of the current image
    -   `SHELL`: sets the default shell to use for commands specified in RUN, CMD, and ENTRYPOINT
    -   `STOPSIGNAL`: sets the system call signal that will be sent to the container to exit
    -   `VOLUME`: creates a mount point for data volumes in the container
    -   `USER`: sets the UID (user ID) or username that will run the command specified in CMD, ENTRYPOINT, and RUN
    -   `WORKDIR`: sets the working directory for subsequent instructions
    -   `ENTRYPOINT`: specifies the command to run when the container starts and cannot be overridden from the command line
    -   `CMD`: specifies the command to run when the container starts

    </details>
