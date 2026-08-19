<h1 style="color:red" align="center" >Red Hat Package Management (rpm) Tools:</h1>

---

### Usefull Tutorials:

-   [Introduction to Linux – Full Course for Beginners](https://www.youtube.com/watch?v=sWbUDq4S6Y8&t=17914s)
-   [Linux Server Course - System Configuration and Operation](https://www.youtube.com/watch?v=WMy3OzvBWc0&t=17425s)
-   [Linux File System Explained!](https://www.youtube.com/watch?v=bbmWOjuFmgA)
-   [Learn CentOS](https://www.youtube.com/playlist?list=PLT98CRl2KxKHjHLIHrmmi5FmBGIZ8cNJE)
-   [Learn CentOS Part 12 - Software Repositories & Adding EPEL](https://www.youtube.com/watch?v=L9ky88zTca8)
-   [Linux System Administration Full Course](https://www.youtube.com/watch?v=UCr04qIB7uc&t=39s)

---

<details open><summary style="font-size:25px;color:Orange;text-align:left">Glossary</summary>

-   Ubuntu-Based Distributions:

    -   `Ubuntu`: One of the most popular Linux distributions, known for its user-friendly interface and frequent updates.
    -   `Linux Mint`: Based on Ubuntu and designed to provide a more traditional desktop experience.
    -   `Elementary OS`: Focused on simplicity and a macOS-like user interface.

-   Debian-Based Distributions:

    -   `Debian`: Known for its stability and as the base for many other Linux distributions.
    -   `Kali Linux`: Geared towards penetration testing and cybersecurity.
    -   `Raspbian`: Optimized for the Raspberry Pi single-board computers.

-   Red Hat-Based Distributions:

    -   `CentOS`: A community-supported version of Red Hat Enterprise Linux (RHEL).
    -   `Fedora`: A community-driven distribution sponsored by Red Hat and known for its cutting-edge features.

-   Enterprise Linux Distributions:

    -   `Red Hat Enterprise Linux (RHEL)`: Designed for enterprise-level use with long-term support.
    -   `SUSE Linux Enterprise Server (SLES)`: Developed for business-critical workloads.

-   Arch Linux-Based Distributions:

    -   `Arch Linux`: Known for its simplicity, customizability, and rolling release updates.
    -   `Manjaro`: A user-friendly version of Arch Linux with additional features.

-   Specialized Distributions:

    -   `Alpine Linux`: Lightweight and security-focused, often used in containers and embedded systems.
    -   `Tails`: Privacy-focused distribution designed to be used as a live operating system.

-   **rpm**: RedHat Package Manager
    -   RPM is the package manager used by Red Hat Linux, Fedora, CentOS, and other related distributions. RPM stands for Red Hat Package Manager, and it uses a binary package format as well. However, RPM is more complex than Pacman, and it is designed for use in enterprise environments where package management is a critical function. RPM has features such as dependency resolution, transaction support, and rollback capabilities.
-   **packman**: Package Manager
    -   Pacman is the package manager used by Arch Linux and its derivatives, such as Manjaro Linux. It is a simple and fast package manager that uses a binary package format, which means that packages are pre-compiled and ready to install. Pacman is designed to be easy to use and efficient, with features such as automatic dependency resolution and package signing.
-   **apt: (Advanced Package Tool)** - APT is the package manager used by Debian, Ubuntu, and other related distributions. It is a command-line tool that uses a binary package format. APT is designed to be user-friendly, with features such as automatic dependency resolution and package signing.

-   **rpm vs yum vs dnf:**

    -   `RPM`: Red Hat Package Manager is a low-level package manager that provides basic functionality for installing, removing, and managing packages in Red Hat-based Linux distributions. `RPM` is a command-line tool that uses binary package files.
    -   `yum`: Yellowdog Updater Modified was the default package manager for CentOS, Fedora, and RHEL versions up to RHEL 7. Yum is a high-level package management tool that uses RPM in the background.It provides an easy way to install, update, and remove packages along with handling package dependencies automatically. To install a package with Yum, you use the yum install command. For example: yum install package-name.
    -   `DNF`: Dandified Yum is a higher-level package manager that is used in Red Hat-based distributions since Fedora 22 and later, as well as in CentOS and RHEL 8. It is a fork of the older Yum package manager, but with added features and better performance. DNF uses a higher-level abstraction that provides better dependency resolution and transaction support, as well as more advanced features like modular packaging.
    -   One of the main differences between `RPM` and `DNF` is the level of abstraction. `RPM` is a lower-level tool that works directly with binary package files, while `DNF` provides a higher-level abstraction that simplifies package management tasks and adds more advanced features. `DNF` also has better performance compared to `Yum` and is designed to be more user-friendly.
    -   In general, RPM is used for basic package management tasks like installing, removing, and updating packages, while DNF is used for more advanced tasks like handling dependencies, managing modules, and providing transaction support. However, since DNF is a higher-level tool, it relies on RPM for its basic functionality, and RPM is still used for many tasks behind the scenes.
    -   Ultimately, the choice between RPM and DNF will depend on your specific needs. If you are using a newer version of Fedora, CentOS, or RHEL, it is recommended to use DNF as it provides more advanced features and better performance. If you are using an older version of Red Hat-based distribution or need to perform low-level package management tasks, RPM may be a better choice.

-   what is package index in linux?

</details>

<details open><summary style="font-size:25px;color:Orange;text-align:left">dnf / yum</summary>

-   [Linux Crash Course - The dnf Command](https://www.youtube.com/watch?v=mL1hMBYP1bQ)
-   **dnf**: DNF or Dandified YUM is the next-generation version of the Yellowdog Updater, Modified (**yum**), a package manager for .rpm-based Linux distributions.

-   `$ yum repolist`
-   `$ yum`
-   `$ yum`

</details>

<details open><summary style="font-size:25px;color:Orange;text-align:left">apt</summary>

-   **apt**: Advanced Package Tool (**APT**), is a free-software user interface that works with core libraries to handle the installation and removal of software on Debian, and Debian-based Linux distributions. APT is a collection of tools distributed in a package named **apt**. APT also includes command-line programs for dealing with packages, which use the library. Three such programs are **apt**, **apt-get** and **apt-cache**.

-   `$ apt-get`
-   `$ apt-cache`

</details>

<details open><summary style="font-size:25px;color:Orange;text-align:left">packman</summary>

</details>
