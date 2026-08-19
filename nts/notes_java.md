-   **JDK (Java Development Kit)**:
    -   `Purpose`: The JDK is a complete software development kit used to develop Java applications.
    -   `Components`: It includes the JRE (Java Runtime Environment), a compiler (javac), debuggers, and various tools necessary for Java development.
    -   `Usage`: Developers use the JDK to write, compile, and debug Java programs.
-   **JRE (Java Runtime Environment)**:
    -   `Purpose`: The JRE provides the environment necessary to run Java applications.
    -   `Components`: It includes the JVM (Java Virtual Machine) and the core libraries and other components to execute Java applications.
    -   `Usage`: End-users need the JRE to run Java applications on their devices.
-   **JVM (Java Virtual Machine)**:
    -   `Purpose`: The JVM is an abstract machine that enables Java programs to be executed on any device or operating system.
    -   `Components`: It interprets the compiled Java bytecode and translates it into machine code for the host system.
    -   `Usage`: The JVM allows Java applications to be platform-independent, running the same compiled code on different operating systems.
-   **Summary of Differences**:
    -   `JDK`: For developing Java applications. Includes JRE + development tools.
    -   `JRE`: For running Java applications. Includes JVM + core libraries.
    -   `JVM`: The engine that runs Java bytecode on any device/platform. Part of JRE.

These components work together to enable Java's "write once, run anywhere" capability.

<details><summary style="font-size:18px;color:#C71585">What is a jar file in Java?</summary>

A 'JAR' file in Java stands for Java ARchive. It is a package file format used to aggregate many Java class files, metadata, and resources (like text, images, etc.) into one file for distribution.

**Key Features of JAR Files**:

-   `Packaging`:

    -   JAR files bundle multiple files into a single archive file, typically using the ZIP file format.
    -   This makes it easier to distribute and deploy Java applications, applets, and libraries.

-   `Executable`:

    -   JAR files can be made executable by specifying the entry point (the main class with the main method) in the MANIFEST.MF file.
    -   Example command to create an executable JAR: `jar cfe MyApp.jar com.example.Main -C classes .`
    -   Where `com.example.Main` is the fully qualified name of the main class.

-   `Compression`: JAR files use ZIP compression, which reduces the size of the files, making them easier to distribute and faster to download.

-   `Classpath`:

    -   JAR files can be added to the classpath, which is a parameter in the Java Virtual Machine or the Java compiler that specifies the location of user-defined classes and packages.
    -   Example command to run a Java application with a JAR file in the classpath: `java -cp MyApp.jar com.example.Main`

-   `Metadata`:

    -   JAR files include a META-INF directory, which contains metadata about the JAR, including the MANIFEST.MF file.
    -   The `MANIFEST.MF` file can specify configuration information, including the main class and package sealing information.

**Creating a JAR File**: Here’s a simple example of how to create a JAR file:

-   Compile Java Classes: `javac -d classes src/com/example/*.java`
-   Create JAR File: `jar cvf MyApp.jar -C classes .`

    -   `c` creates a new archive.
    -   `v` generates verbose output.
    -   `f` specifies the archive file name.
    -   Specify the Main Class (Optional for Executable JARs):

-   Create a manifest file (e.g., manifest.txt) with the following content: `Main-Class: com.example.Main`
-   Create the JAR file with the manifest: `jar cmf manifest.txt MyApp.jar -C classes .`
-   Running a JAR File
    -   If the JAR file is executable (contains the main class in the manifest): `java -jar MyApp.jar`
    -   If the JAR file is not executable, include it in the classpath: `java -cp MyApp.jar com.example.Main`

A JAR file is a convenient way to package Java classes and associated resources into a single file, facilitating distribution, deployment, and execution of Java applications and libraries.

</details>
