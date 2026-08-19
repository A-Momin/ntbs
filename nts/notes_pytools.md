-   **𝑺𝒚𝒎𝒃𝒐𝒍𝒔**: ⌘ ⌥ + ⌃ + ⤶ ⇧  ⤶ ⬋ ↩︎ ↲ ↵ ↫ ⭿ ♥ ★ 🎾 & 🔹

-   <details><summary style="font-size:25px;color:Orange">Termilology</summary>

    -   **PYTHONPATH**:

        -   `PYTHONPATH` is an environment variable in Python that tells the interpreter where to locate the module files imported into a program. It is a colon-separated list of directories that the Python interpreter searches for modules when executing your code.
        -   When you try to import a module, Python looks for the module in the directories listed in sys.path. The `PYTHONPATH` environment variable allows you to customize this search path.

    -   **sys.path**: In your Python script, you can modify the sys.path list to include the directories containing your Python modules.

        ```python
        import sys
        sys.path.append('/path/to/your/module')
        # Now you can import your module
        import your_module
        ```

        ```python
        >>> import sys
        >>> sys.argv
        >>> sys.executable
            '/Library/Frameworks/Python.framework/Versions/3.7/bin/python3'
        ```

    -   **sit-modules**: The Python site module is part of the Python standard library and is used to configure the Python environment on startup. It plays a crucial role in setting up the Python environment, including configuring the module search path and handling user-specific site-packages directories.

    -   **python3 -m site**: It is used to display information about the site module in Python, which includes paths to various site-packages directories and other configuration details about the Python environment

        ```ini
        sys.path = [
            '/home/user',
            '/usr/local/lib/python39.zip',
            '/usr/local/lib/python3.9',
            '/usr/local/lib/python3.9/lib-dynload',
            '/usr/local/lib/python3.9/site-packages',
        ]
        USER_BASE: '/home/user/.local' (exists)
        USER_SITE: '/home/user/.local/lib/python3.9/site-packages' (exists)
        ENABLE_USER_SITE: True
        ```

    -   **PyPI**: It is stand for **Python Package Index** - the main public repository/catalog of Python packages that tools like **pip** install from.

    -   **`.whl`** File: A `.whl` file (Wheel file) is a binary distribution format for Python packages. It is a **pre-built**, compressed package that allows for faster installation compared to building from source.

        -   `Pre-compiled`: Unlike `setup.py`, which requires building, a `.whl` file contains a pre-compiled package, making installation (`pip install package.whl`) faster.
        -   `Faster Installation`: Since it avoids compilation, installing a wheel file with pip is significantly faster.
        -   `Standard Format`: `.whl` follows the PEP 427 (Wheel Standard), making it the preferred way to distribute Python packages.

    -   **wheel**/**source** distribution: In the Python ecosystem, when you want to share your code or install a package via `pip`, you generally deal with two types of distribution formats: **Source Distributions (sdist)** and **Wheels (bdist_wheel)**. Think of it like getting a meal: a **Source Distribution** is the recipe and raw ingredients, while a **Wheel** is the pre-cooked, ready-to-eat meal.

        1. **Source Distribution (sdist)**: A **Source Distribution** is an archive (usually a `.tar.gz` file) that contains the actual source code and any necessary metadata.

            -   **What’s inside:** The raw `.py` files, READMEs, and a `pyproject.toml` or `setup.py` file.
            -   **The Installation Process:** When you run `pip install` on an sdist, your computer has to do the heavy lifting. If the package contains C or C++ extensions (like NumPy), your system must have the correct compilers and libraries installed to build it from scratch.
            -   **Pros:** Highly portable across different operating systems because the code isn't "built" yet.
            -   **Cons:** Installation is much slower and can fail if your environment is missing the required build tools.

        2. **Built Distribution: The Wheel (.whl)**: A **Wheel** is a "Built Distribution." It is a ZIP-format archive that is already compiled and ready to be moved directly into your site-packages folder.

            -   **What’s inside:** Usually compiled bytecode (`.pyc` files) and, for packages with C extensions, pre-compiled binary files.
            -   **The Installation Process:** Pip simply unzips the file and moves it to the right place. There is no "building" phase.
            -   **Pros:** * **Speed:** Blazing fast installation.
                -   **Consistency:** You don't need a compiler on the machine where you are installing the package.
            -   **Cons:** Wheels are often platform-specific. A wheel built for **Windows 64-bit** will not work on **macOS** or **Linux**.

        3. **Why does this matter to you?**: When you run `pip install some-package`, Pip looks for a **Wheel** that matches your specific operating system and Python version first. If it finds one, it downloads it and you're done in seconds. 

            -   If no compatible Wheel exists (perhaps you are using a very new version of Python or an obscure Linux distro), Pip falls back to the **Source Distribution**, tries to compile it on the fly, and—if you don't have the right tools installed—this is usually when you see those long, scary red error messages in your terminal.

    -   **Wheel Compatibility Tag**: A Wheel Compatibility Tag is a string embedded in the wheel filename that specifies which Python implementations, versions, and platforms the wheel is compatible with. It determines whether a wheel can be installed on a particular Python environment.

        -   **Format**: Wheel filenames follow the pattern: `{distribution}-{version}(-{build tag})?-{python}-{abi}-{platform}.whl`
            - Example: 
                -   `numpy-1.21.0-cp39-cp39-win_amd64.whl` (Compatibility Tag: `cp39-cp39-win_amd64`)
                -   `psycopg2-2.9.9-cp311-cp311-manylinux_2_28_x86_64.whl` (Compatibility Tag: `cp311-cp311-manylinux_2_28_x86_64`)

        -   **Components of Compatibility Tag**:
            - `{python}`: Python implementation and version (e.g., `py3`, `cp39`, `pp37`):
                - `py2`, `py3`: Generic Python versions (no implementation-specific features)
                - `cp37`, `cp38`, `cp39`: CPython 3.7, 3.8, 3.9
                - `pp37`: PyPy 3.7
                - `ip27`: IronPython 2.7
                - `jy27`: Jython 2.7
            - `{abi}`: Application Binary Interface tag (e.g., `cp39`, `abi3`, `none`):
                - `cp39`: CPython 3.9's C API
                - `abi3`: Stable ABI (compatible across multiple Python versions)
                - `none`: Pure Python (no compiled extensions)
            - `{platform}`: Operating system and architecture (e.g., `win_amd64`, `macosx_10_15_x86_64`, `linux_x86_64`):
                - `manylinux_2_28_x86_64` → Linux (portable across distros)
                - `linux_x86_64`: Linux with x86_64 architecture
                - `macosx_10_15_x86_64`: macOS 10.15 with x86_64 architecture
                - `win32`, `win_amd64`: Windows 32-bit, 64-bit
                - `any`: Platform-independent (pure Python)

        -   **Examples**:
            - `requests-2.28.0-py3-none-any.whl`: Pure Python package compatible with any Python 3 version on any platform
            - `numpy-1.23.0-cp39-cp39-win_amd64.whl`: Compiled extension built for CPython 3.9 on Windows 64-bit
            - `cryptography-37.0.2-cp37-abi3-macosx_10_10_x86_64.whl`: Uses stable ABI, works on CPython 3.7+ on macOS

        -   **How pip Uses Compatibility Tags**: When installing a package, `pip` compares the wheel's compatibility tag against the current Python environment's:
            - Python implementation (CPython, PyPy, etc.)
            - Python version (3.8, 3.9, 3.10, etc.)
            - Operating system (Windows, macOS, Linux)
            - Architecture (x86_64, ARM, etc.)
            - If tags match, the wheel is compatible and can be installed; otherwise, pip skips it

        -   **Common Tag Patterns**:
            - `py3-none-any`: Universal pure Python package for Python 3
            - `py2.py3-none-any`: Pure Python compatible with both Python 2 and 3
            - `cp{version}-cp{version}-{platform}`: Compiled extension for specific CPython version
            - `cp{version}-abi3-{platform}`: Uses stable ABI (works across multiple Python versions)

        -   **Checking Wheel Compatibility**: You can check which wheels are compatible with your environment:
            ```bash
            python -c "from wheel.vendored.packaging import tags; print(list(tags.sys_tags()))"
            # Or use pip debug
            pip debug --verbose
            ```

    -   **setup.cfg:**:`setup.cfg` is a configuration file used to specify various options and metadata for a Python package. It is typically used in conjunction with the `setup.py` file or as an alternative to it. Some common settings that can be specified in `setup.cfg` include package metadata (name, version, author, etc.), dependencies, entry points, testing configurations, and more. It follows the INI file format with sections and key-value pairs.

        -   Using `setup.cfg` can help keep the `setup.py` file clean and focused on the essential setup logic, while the configuration details are stored in a separate file. To use `setup.cfg`, you typically run python `setup.py` commands that automatically read the configuration from `setup.cfg`.

    -   **setup.py:**:`setup.py` is a Python script that contains the setup logic for a Python package. It is commonly used to define the package structure, dependencies, installation instructions, and other details required for packaging and distribution. The `setup.py` file typically imports the setuptools or distutils module to define the package and its associated metadata.

        -   Running commands like python `setup.py` install or python `setup.py` sdist executes the setup script to perform actions such as package installation, building source distributions, running tests, and more.
        -   While `setup.cfg` is focused on configuration settings, `setup.py` contains the executable logic for package setup. It is usually more customizable and can handle complex scenarios, such as dynamic generation of code or custom setup steps.

    -   **pyproject.toml**:`pyproject.toml` is a configuration file used in Python projects that adhere to the PEP 517 and PEP 518 standards. It is primarily used for specifying build and distribution tooling configurations, such as build system dependencies, build tool configuration, and project metadata. The file is written in the TOML (Tom's Obvious, Minimal Language) format.

        -   `Build System Configuration`: pyproject.toml allows you to specify the build system requirements and configuration for your project. This includes the build backend to be used (e.g., setuptools, flit, poetry), as well as any required build tools, such as compilers or transpilers.
        -   `Dependency Declarations`: You can declare the dependencies required for building and testing your project. This includes both runtime dependencies (specified in install_requires) and build/test dependencies (specified in build-system.requires or build-system.build-backend.requires). These dependencies are typically resolved and managed by the build tool.
        -   `Project Metadata`: pyproject.toml allows you to specify project metadata, such as the package name, version, author, license, and other relevant information. This metadata is used during packaging and distribution processes.
        -   `Tool Configuration`: The file provides a place to configure specific build tools or plugins used in your project. For example, you can configure code linters, code formatters, testing frameworks, or other development tools specific to your project.
        -   `Standardized Project Structure`: By using pyproject.toml, you adhere to the PEP 517 and PEP 518 standards, which define a standardized approach to Python project build and distribution. This helps ensure compatibility and consistency across different build tools and environments.
        -   It's important to note that pyproject.toml alone does not perform any build or distribution actions. Instead, it provides the necessary configuration for build tools (specified in build-system.build-backend) to execute the build and distribution processes.
        -   Popular build tools that utilize pyproject.toml include `setuptools`, `flit`, and `poetry`. These tools interpret the configuration in pyproject.toml and perform actions such as building source distributions (sdist), building binary distributions (bdist), installing the package (install), running tests (test), and more.
        -   Overall, pyproject.toml serves as a central configuration file for build and distribution tooling in Python projects, enabling standardized build processes and providing a consistent way to specify project metadata and dependencies.

    -   **MANIFEST.in**:The `MANIFEST.in` file is used in Python projects to specify additional files that should be included when creating source distributions or packaging the project. It is commonly used in conjunction with the "`setup.py`" script and build tools like "setuptools" to define the contents of the distribution package.
        -   The purpose of the "MANIFEST.in" file is to provide explicit instructions on what files and directories should be included in the distribution, beyond the default inclusion rules specified by the build tool. By default, build tools like "setuptools" include only the necessary files based on the Python package's structure and metadata specified in "`setup.py`". However, there might be additional files or directories that are required for the package to function correctly or need to be distributed with the package.
        -   Here are some common use cases and directives that can be specified in the "MANIFEST.in" file:

    -   **pytest.ini**:The `pytest.ini` file is a configuration file used by the pytest testing framework. It allows you to customize the behavior and settings of pytest for your project. When pytest runs, it looks for a `pytest.ini` file in the current directory or any of its parent directories. The `pytest.ini` file is written in the INI file format and typically includes various sections and options that define how pytest should discover and execute tests, specify test paths, configure plugins, and more. Some commonly used options in `pytest.ini` include:

        -   `[pytest] section`: This section is used to configure general pytest options, such as the test discovery behavior, test naming conventions, test markers, and output settings.
        -   `[testpaths] section`: This section allows you to specify the directories or paths where pytest should search for tests. You can define multiple test paths separated by line breaks.
        -   `[pytest-watch] section`: If you have the pytest-watch plugin installed, you can use this section to configure its behavior, such as the files to watch for changes and the commands to run when changes occur.
        -   `Other sections and options`: Depending on your project's needs and installed plugins, you may have additional sections and options in your `pytest.ini` file. For example, if you use plugins like `pytest-cov` for code coverage or `pytest-html` for HTML test reports, you may have sections to configure those plugins.
        -   By configuring options in the `pytest.ini` file, you can set project-specific defaults and avoid passing command-line options to pytest every time you run tests. It helps in maintaining consistent test configurations across different environments and makes it easier to share your project with other developers.
        -   Note that the `pytest.ini` file is optional, and if it's not present, pytest will use its default settings.

   </details>

---

-   <details><summary style="font-size:25px;color:Orange">PYTHON3</summary>

    -   [Corey: How to Set the Path and Switch Between Different Versions/Executables (Mac & Linux)](https://www.youtube.com/watch?v=PUIE7CPANfo&list=PL-osiE80TeTskrapNbzXhwoFUiLCjGgY7&index=14&t=1218s)

    -   **TROUBLESHOOTING ON PYTHON EXECUTABLES**:

        -   `$ which -a python3` → locate all (`-a`) python3 file in the user's path
        -   `$ which python3.11`
        -   `$ whereis python3` → /usr/bin/python3
        -   `$ ls -al /opt/homebrew/bin | grep python`
        -   `$ ls -al /opt/bin/python3`
        -   `$ ls -al /opt/bin/python3 | grep python`

        -   **Some Common paths of Python binaries**:

            -   `/usr/local/Cellar/python3/3.7.3/bin`
            -   `/Library/Frameworks/Python.framework/Versions`
            -   `/usr/local/Cellar` → paths of various python versions.
            -   `/usr/local/opt/` → These python executables are actually symlinks of python in `/usr/local/Cellar`
            -   `/usr/local/opt/python@3.9/bin/python3.9` → PATH of python3.9:

    -   `$ type python`
    -   `$ python3 -V` → Version of the current executalbe python3.
    -   `$ echo $PATH` → show the path variable of my machine.
    -   `$ type python3` → python3 is hashed (/usr/local/bin/python3)
    -   `$ man python3`
    -   `$ python3 module_name.py [arg1, ..., argn]` → Run python file from command line
    -   🔥 `$ python3 -m pydoc <package_name>` → print out the documents of the given package.
    -   🔥 `$ python3 -m site` → print the path of python3's site-packages
    -   `$ python3 -m site --user-base`
    -   `$ python3 setup.py install --prefix=~`
        -   'cd' into the module directory that contains `setup.py` and run the install command above.
        -   Instalation of dependencies through the `setup.py` file of the given project
    -   `$ python3 setup.py -q deps` → show available dependency groups
    -   `$ python3 setup.py -q deps --dep-groups=core,vision` → print dependency list for specified groups
    -   `$ python3 setup.py -q deps --help` → see all options
    -   `$ python3 setup.py sdist bdist_wheel`
    -   🔥 `$ pip3 install -e .` → Install a custom package in editable mode.

    -   Installing a Bash Kernel:

        -   `$ python -m venv .venv`
        -   `$ source .venv/bin/activate`
        -   `$ pip install bash_kernel`
        -   `$ pip install ipykernel`
        -   `$ python -m bash_kernel.install`
        -   `$ rm -fr bash_kernel`

    -   Installing a MySQL Kernel:

        -   `$ pip install mysql_kernel`
        -   `$ python -m mysql_kernel.install`

    -   Run Jupyter from Virtual Environment:

        -   `$ python -m venv .venv`
        -   `$ source .venv/bin/activate`
        -   `$ pip install ipykernel`
        -   `$ ipython kernel install --user --name=jnb_flaskapp_env`
        -   `$ jupyter notebook`
            -   select `jnb_flaskapp_env` from select manu of jupyter karnel.
        -   Installed kernelspec jnb_flaskapp_env in $HOME/Library/Jupyter/kernels/jnb_flaskapp_env

    -   `$ jupyter kernelspec list`
    -   `$ jupyter kernelspec remove kernel_name`

    #### python3 Virtual Environment: (python version ≥ 3.3)

    -   [How to Use Virtual Environments with the Built-In venv Module](https://www.youtube.com/watch?v=Kg1Yvry_Ydk&list=PL-osiE80TeTskrapNbzXhwoFUiLCjGgY7&index=25&t=0s)

    -   `$ python3 -m venv -h` →
    -   `$ python3 -m venv project_env ` → Create an python3 virtual environment by the name `project_env` in current directory
    -   `$ python3 -m venv .venv` → Create an python3 virtual environment by the name `.venv` in current directory
    -   `$ source project_env/bin/activate ` → activate the environment
    -   `$ source .venv/bin/activate ` → activate the virtual environment (`.venv`) defined in your current directory
    -   `$ deactivate ` → deactivate the active environment
    -   `$ python3 -m venv project_env/venv ` → to keep the environment seperate from the project itself.
    -   `$ source project_env/venv/bin/activate`
    -   `$ which python`
    -   `$ pip3 freeze ` → to displey the list of dependencies that you'd used in a requirement.txt file
    -   `$ pip3 freeze > requirement.txt ` → create the requirement.txt file with the list of dependencies recorded in the current env.
    -   `$ rm -rf project_env ` → to delete the environment, project_env
    -   `$ pip3 install -r requirement.txt ` → install the dependencies recorded in requirement.txt into the environment
    -   `$ python3 -m venv project_name_env --system-site-packages` → Make global site packages available into to your virtual environment
    -   `$ pip3 list --local`

    -   How to create python environment from requirment.txt (Python >= 3.6.x):
        -   `cd my_project`
        -   `sudo pip install virtualenv` → This may already be installed
        -   `virtualenv .env` → Create a virtual environment
        -   `source .env/bin/activate` → Activate the virtual environment
        -   `pip install -r requirements.txt` → Install dependencies
        -   `deactivate` → Exit the virtual environment

   </details>

---

-   <details><summary style="font-size:25px;color:Orange">pip3</summary>

    -   `$ which pip` → run the command from the newly created env
    -   `$ pip3 -V` → Version of the pip3
    -   `$ type pip3` → pip3 is `/usr/local/bin/pip3`
    -   `$ pip3 <command> [options]`
    -   `$ sudo -H pip3 install --upgrade pip3`
    -   `$ python3 -m pip install --upgrade pip`
    -   `$ python3 -m pip uninstall pip`

    -   **HELP**:
        -   `$ pip3 -h`
        -   `$ pip3 <command> -h` → EX: `$ pip3 install -h`
    -   `$ pip3 help` → Prints out all the availabel commands can be used in conjunction with pip3.
    -   `$ pip3 <comand_name> help | -h` → Apply help command to the specified pip command. Ex. pip3 install -h. NOTE: The vertical var, '|', indicate 'OR'
    -   `$ pip3 help install` → Provide help with pip3 'install' command.

    -   `$ pip3 show <package_name>`
    -   `$ pip3 show numpy`
    -   `$ pip3 search <package_name>` → Ex. pip3 search numpy
    -   `$ pip3 list`
    -   `$ pip3 list [--outdated | -o]`
    -   `$ pip3 list --local`
    -   `$ pip3 install selenium -U` NOTE: `-U` → Update
    -   `$ pip3 install -r requirements.txt` → Install all the packages mentioned in the 'requirment.txt' file.
    -   `$ pip install Django==3.1.4 -t django_libraries` → Install Django in the given targated directory.
    -   🔥 `$ pip3 uninstall -r requirements.txt` → Uninstall all the packages listed in the given requirements file
    -   `$ pip3 install numpy`
    -   `$ pip3 show numpy`
    -   `$ pip3 uninstall --user selenium`
    -   `$ pip3 uninstall [options] <package> ...`
    -   `$ pip3 uninstall [options] -r <requirements file> ...`
    -   `$ pip3 freeze | xargs pip uninstall -y`
    -   `$ pip3 freeze` → to displey the list of dependencies that you'd used in a requirements.txt file
    -   `$ pip3 freeze > requirements.txt` → create the requirements.txt file with the list of dependencies recorded in the current env.
    -   `$ pip3 install -r requirements.txt -y` → install the dependencies recorded in requirement.txt into the environment
    -   🔥 `$ pip3 install -e .` → Install a custom package in editable mode.

    -   `$ pip install somepackage.whl` → Install from a Local `.whl` File
    -   `$ pip install numpy --index-url https://pypi.org/simple` → Use a Specific Index (Alternative PyPI)

    -   `$ pip config list` → 
    -   `$ pip debug --verbose` → 
    -   `$ pip index versions psycopg` → queries Python Package Index and lists all available versions of a package.
    -   `$ pip show psycopg` → 
    -   `$ pip install -vvv --dry-run psycopg` → 
    -   `$ pip install --only-binary=:all: --dry-run psycopg` → `--only-binary=:all:` tells pip to install only prebuilt wheels (`.whl`), never build from source.
    -   `$ ` → 

    -   **Install the Packages from GitHub Using `pip`**:

        -   `$ pip install git+https://github.com/yourusername/your-repo.git` → Install from a Public Repository
        -   `$ pip install git+https://github.com/yourusername/your-repo.git@branch-name` → Install from a Specific Branch
        -   `$ pip install git+https://github.com/yourusername/your-repo.git@v0.1.0` → Install from a Specific Tag (Versioned Release)
        -   `$ pip install git+https://github.com/yourusername/your-repo.git@commit-hash` → Install from a Specific Commit
        -   `$ pip install git+ssh://git@github.com/yourusername/your-repo.git` → Install from a Private Repository (Using SSH)

    -   **pipx**: `pipx` is a tool for installing and running Python applications in isolated environments. It allows you to install CLI-based Python tools globally while keeping them separate from your system's Python environment.

        -   Use `pipx` for standalone CLI applications (e.g., `black`, `poetry`, `httpie`).
        -   Use `pip` for library dependencies inside a virtual environment (e.g., `pip install requests`).

        -   `$ python3 -m pip install --user pipx`
        -   `$ python3 -m pipx ensurepath`
        -   `$ pipx install poetry` → Install a CLI Tool Using `pipx`. This installs `poetry` in an isolated virtual environment and makes it globally accessible.
        -   `$ pipx run cowsay "Hello, World!"` → Run a CLI Tool Without Installing. This runs `cowsay` without permanently installing it.
        -   `$ pipx list` → List Installed Applications
        -   `$ pipx uninstall poetry` → Uninstall a Tool

    -   **How `pipx` Differs from `pip`**

        | Feature                          | `pipx`                                                                     | `pip`                                                                      |
        | -------------------------------- | -------------------------------------------------------------------------- | -------------------------------------------------------------------------- |
        | **Primary Use**                  | Installs and runs Python applications in **isolated virtual environments** | Installs Python packages into the **current environment**                  |
        | **Scope**                        | Designed for **CLI tools** (executables)                                   | Used for installing **libraries, frameworks, and dependencies**            |
        | **Isolation**                    | Each installed package gets its **own virtual environment**                | Installs packages into a **shared environment** (global or virtualenv)     |
        | **Risk of Dependency Conflicts** | Low (isolated environments prevent conflicts)                              | Higher (dependencies may conflict in the same environment)                 |
        | **Global Installation**          | Safe for installing global CLI tools                                       | Not recommended for global installation (can lead to dependency conflicts) |
        | **Uninstallation**               | Clean and removes all traces of a package                                  | May leave behind dependencies that are no longer needed                    |



   </details>

---

-   <details><summary style="font-size:25px;color:Orange">poetry</summary>

    -   **Poetry** is a **dependency management** and **packaging tool** for Python that simplifies the process of managing dependencies, packaging projects, and publishing to PyPI. It provides an easy way to create, build, and distribute Python packages while handling virtual environments automatically.

    -   `$ poetry new my_project` → Create a new Python project with a standard structure
    -   `$ source <(poetry env activate)` → Create virtual environment

    -   `$ poetry init` → Initialize a Poetry project interactively in the current directory
    -   `$ poetry add requests` → Add a package (e.g., requests) to the project dependencies
    -   `$ poetry add numpy@latest` → Add the latest version of numpy
    -   `$ poetry add flask --dev` → Add a package to the development dependencies
    -   `$ poetry install` → Install all dependencies from `pyproject.toml`
    -   `$ poetry update` → Update all dependencies to the latest allowed versions
    -   `$ poetry lock` → Generate a new `poetry.lock` file based on `pyproject.toml`
    -   `$ poetry show` → Show installed dependencies and their versions
    -   `$ poetry show --tree` → Display dependencies in a tree format
    -   `$ poetry remove pandas` → Remove a package from dependencies
    -   `$ poetry build` → Build the project as a package
    -   `$ poetry publish` → Publish the package to PyPI
    -   `$ poetry publish --dry-run` → Simulate publishing without actually uploading
    -   `$ poetry run python script.py` → Run a script inside the Poetry environment
    -   `$ poetry shell` → Spawn a new shell within the virtual environment
    -   `$ poetry self update` → Update Poetry to the latest version
    -   `$ poetry cache clear --all` → Clear all cached dependencies
    -   `$ poetry config --list` → Show current Poetry configuration
    -   `$ poetry export -f requirements.txt > requirements.txt` → Export dependencies to a `requirements.txt` file

    -   `$ poetry env` → 
    -   `$ poetry env info` → 
    -   `$ poetry env list` → List out the env
    -   `$ poetry env use pythonX.Y` → 
    -   `$ poetry env remove python3.11` → Remove the specific environment
    -   `$ poetry config virtualenvs.in-project true` → 
    -   `$ poetry self add poetry-plugin-shell` → 

   -   <details><summary style="font-size:25px;color:#C71585">Configure and Publish Python package using Poetry</summary>

        > This guide demonstrates how to create, configure, and publish a Python package using Poetry from start to finish.

        ### Step 1: Install Poetry

        First, install Poetry if you haven't already:

        ```bash
        # Using pipx (recommended)
        pipx install poetry

        # Or using pip
        pip install poetry

        # Verify installation
        poetry --version
        ```

        ### Step 2: Create a New Poetry Project

        Create a new Python project with Poetry:

        ```bash
        # Create a new project
        poetry new my-awesome-package

        # Navigate to the project directory
        cd my-awesome-package
        ```

        This creates a project structure like:
        ```
        my-awesome-package/
        ├── pyproject.toml          # Project configuration
        ├── README.md               # Project description
        ├── my_awesome_package/     # Package directory
        │   └── __init__.py
        └── tests/                  # Test directory
            ├── __init__.py
            └── test_my_awesome_package.py
        ```

        ### Step 3: Configure pyproject.toml

        The `pyproject.toml` file is automatically created. Let's examine and modify it:

        ```toml
        [tool.poetry]
        name = "my-awesome-package"
        version = "0.1.0"
        description = "A brief description of your package"
        authors = ["Your Name <your.email@example.com>"]
        readme = "README.md"
        packages = [{include = "my_awesome_package"}]

        [tool.poetry.dependencies]
        python = "^3.8"
        requests = "^2.25.1"  # Add runtime dependencies

        [tool.poetry.group.dev.dependencies]
        pytest = "^6.2.4"
        black = "^21.12b0"
        flake8 = "^4.0.1"

        [build-system]
        requires = ["poetry-core"]
        build-backend = "poetry.core.masonry.api"
        ```

        **Key configuration options:**

        - `name`: Package name (must be unique on PyPI)
        - `version`: Semantic version (follows SemVer)
        - `description`: Short description
        - `authors`: List of authors with email
        - `packages`: List of packages to include
        - `dependencies`: Runtime dependencies
        - `dev-dependencies`: Development-only dependencies

        ### Step 4: Add Dependencies

        Add dependencies to your project:

        ```bash
        # Add runtime dependencies
        poetry add requests numpy

        # Add development dependencies
        poetry add --group dev pytest black flake8 mypy

        # Add specific version
        poetry add "pandas>=1.3.0,<2.0.0"

        # View current dependencies
        poetry show
        ```

        ### Step 7: Configure Additional Settings

        Update `pyproject.toml` with more configuration:

        ```toml
        [tool.poetry]
        name = "my-awesome-package"
        version = "0.1.0"
        description = "A demonstration Python package using Poetry"
        authors = ["Your Name <your.email@example.com>"]
        license = "MIT"
        readme = "README.md"
        homepage = "https://github.com/yourusername/my-awesome-package"
        repository = "https://github.com/yourusername/my-awesome-package"
        documentation = "https://my-awesome-package.readthedocs.io/"
        keywords = ["demo", "poetry", "python"]
        classifiers = [
            "Development Status :: 3 - Alpha",
            "Intended Audience :: Developers",
            "License :: OSI Approved :: MIT License",
            "Programming Language :: Python :: 3",
            "Programming Language :: Python :: 3.8",
            "Programming Language :: Python :: 3.9",
            "Programming Language :: Python :: 3.10",
            "Programming Language :: Python :: 3.11",
        ]
        packages = [{include = "my_awesome_package"}]

        [tool.poetry.urls]
        "Bug Reports" = "https://github.com/yourusername/my-awesome-package/issues"
        "Source" = "https://github.com/yourusername/my-awesome-package"

        [tool.poetry.dependencies]
        python = "^3.8"
        requests = "^2.25.1"

        [tool.poetry.group.dev.dependencies]
        pytest = "^6.2.4"
        pytest-cov = "^3.0.0"
        black = "^21.12b0"
        flake8 = "^4.0.1"
        mypy = "^0.931"
        isort = "^5.10.1"

        [build-system]
        requires = ["poetry-core"]
        build-backend = "poetry.core.masonry.api"

        # Tool configurations
        [tool.black]
        line-length = 88
        target-version = ['py38']

        [tool.isort]
        profile = "black"

        [tool.mypy]
        python_version = "3.8"
        warn_return_any = true
        warn_unused_configs = true
        disallow_untyped_defs = true
        disallow_incomplete_defs = true
        ```

        ### Step 8: Set Up Development Environment

        Install dependencies and set up the development environment:

        ```bash
        # Install all dependencies
        poetry install

        # Activate the virtual environment
        poetry shell

        # Or run commands in the environment without activating
        poetry run python --version
        ```

        ### Step 9: Run Tests and Quality Checks

        Run your tests and code quality tools:

        ```bash
        # Run tests
        poetry run pytest

        # Run tests with coverage
        poetry run pytest --cov=my_awesome_package

        # Format code
        poetry run black my_awesome_package tests
        poetry run isort my_awesome_package tests

        # Lint code
        poetry run flake8 my_awesome_package tests

        # Type check
        poetry run mypy my_awesome_package
        ```

        ### Step 10: Build the Package

        Build your package for distribution:

        ```bash
        # Build both wheel and source distribution
        poetry build

        # Check the built files
        ls dist/
        ```

        This creates:
        - `dist/my-awesome-package-0.1.0.tar.gz` (source distribution)
        - `dist/my-awesome-package-0.1.0-py3-none-any.whl` (wheel)

        ### Step 11: Prepare for Publishing

        Before publishing, ensure you have:

        1. **PyPI Account**: Create an account at https://pypi.org/

        2. **API Token**: Generate an API token from your PyPI account settings

        3. **Configure Poetry**:
        ```bash
        # Configure PyPI credentials
        poetry config pypi-token.pypi your-api-token-here

        # Or for Test PyPI first
        poetry config pypi-token.testpypi your-testpypi-token-here
        ```

        ### Step 12: Publish to PyPI

        Publish your package:

        ```bash
        # First, publish to Test PyPI for testing
        poetry publish --build -r testpypi

        # Check if it uploaded correctly
        # Visit: https://test.pypi.org/project/my-awesome-package/

        # If everything looks good, publish to real PyPI
        poetry publish --build
        ```

        ### Step 13: Verify Installation

        Test that your package can be installed:

        ```bash
        # Create a new virtual environment
        python -m venv test_env
        source test_env/bin/activate

        # Install from PyPI
        pip install my-awesome-package

        # Test the package
        python -c "from my_awesome_package import hello_world; print(hello_world('PyPI'))"
        ```

        ### Step 14: Version Management

        Update version and publish new releases:

        ```bash
        # Update version
        poetry version patch  # 0.1.0 -> 0.1.1
        poetry version minor  # 0.1.1 -> 0.2.0
        poetry version major  # 0.2.0 -> 1.0.0

        # Or set specific version
        poetry version 1.0.0

        # Build and publish
        poetry build
        poetry publish
        ```

        ### Step 15: Maintenance

        Keep your package updated:

        ```bash
        # Update dependencies
        poetry update

        # Update Poetry itself
        poetry self update

        # Clear cache if needed
        poetry cache clear --all pypi
        ```

        ### Complete Workflow Script

        Here's a complete script you can use as a reference:

        ```bash
        #!/bin/bash

        # Create new project
        poetry new my-package
        cd my-package

        # Add dependencies
        poetry add requests click
        poetry add --group dev pytest black

        # Write some code
        cat > my_package/main.py << 'EOF'
        import requests
        import click

        @click.command()
        @click.argument('url')
        def fetch_url(url):
            """Fetch and display the content of a URL."""
            response = requests.get(url)
            click.echo(response.text)

        if __name__ == '__main__':
            fetch_url()
        EOF

        # Update pyproject.toml with entry points
        cat >> pyproject.toml << 'EOF'

        [tool.poetry.scripts]
        fetch-url = "my_package.main:main"
        EOF

        # Install and test
        poetry install
        poetry run pytest

        # Build and publish (after setting up PyPI token)
        poetry build
        poetry publish --dry-run  # Test run first
        # poetry publish  # Real publish
        ```

        ### Common Issues and Solutions

        4. **"Package name already exists on PyPI"**
        - Choose a unique name or use a namespace (e.g., `yourname-mypackage`)

        5. **"Version already exists"**
        - Update version with `poetry version patch/minor/major`

        6. **"Build failed"**
        - Check that all files are included in `packages` in `pyproject.toml`
        - Ensure `__init__.py` exists in package directories

        7. **"Import errors after installation"**
        - Verify package structure matches `pyproject.toml`
        - Check for missing dependencies

        8. **"Permission denied"**
        - Ensure you have the correct PyPI API token
        - Check token scope (pypi vs. testpypi)

        ### Best Practices

        - Use semantic versioning
        - Keep `README.md` updated with installation and usage instructions
        - Include a `LICENSE` file
        - Write comprehensive tests
        - Use type hints for better code quality
        - Keep dependencies minimal
        - Test on multiple Python versions
        - Use Test PyPI for testing before real PyPI


        </details>

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">uv</summary>

    -   [UV](https://docs.astral.sh/uv/)
    -   [commands](https://docs.astral.sh/uv/reference/cli/#uv)
    -   [uv for EVERYTHING: How to use uv for Python, venv, and project management](https://www.youtube.com/watch?v=zgSQr0d5EVg)
    -   [UV for Python… (Almost) All Batteries Included](https://www.youtube.com/watch?v=qh98qOND6MI)

    -   `$ brew install uv` → Installs the [`uv`](https://github.com/astral-sh/uv) package manager via Homebrew on macOS. `uv` is a fast Python package manager built in Rust by Astral.
    -   `$ uv python install 3.11.11` → Downloads and installs **Python 3.11.11** via `uv`’s environment manager.
    -   `$ uv python list --only-installed` → Lists all installed Python versions managed by `uv`.
    -   `$ uv python pin` →
    -   `$ uv python pin -h` →
    -   `$ uv python dir` →
    -   `$ uv python find` →
    -   `$ uv python uninstall` →

    -   `$ uv init --no-workspace` → Initializes a new Python project **without a workspace layout**, creating basic project files like `pyproject.toml`.
    -   `$ uv tool dir` → Prints the directory path where `uv` stores tool environments (e.g., virtual environments or tool-specific envs).
    -   `$ uv clean cache` → Clears the `uv` cache (packages, indices, etc.) to free up disk space or fix caching issues.
    -   `$ uv add --dev black` → Installs the black code formatter as a development dependency.
    -   `$ uv add -r requirements.txt` → Adds dependencies listed in `requirements.txt` to your project’s `pyproject.toml` and installs them.
    -   `$ uv run main.py` → Runs `main.py` inside the project's managed Python environment (like `poetry run` or `pipenv run`).
    -   `$ uv run --activate main.py` -> `--activae` prefer the active virtual environment over the project’s virtual environment. No active virtual environment, it has no eefect.
    -   `$ uv sync` → Synchronizes your environment with your `pyproject.toml` and `uv.lock` — installs all declared dependencies.
    -   `$ uv sync --upgrade` → upgrade and sync environmnet with any changes.
    -   `$ uv add --dev ipykernel` → Adds `ipykernel` as a **development dependency**, useful for running Jupyter notebooks or using IPython.

    -   `$ uv `
    -   `$ uv `

    #### Project Initialization

    -   `$ uv init`
    -   `$ uv add -h`
    -   `$ uv add --active requests` -> install the requests library into activated environment instead of current projects environment with updating the `pyproject.toml` or `uv.lock` file.
    -   `$ uv add PyYaml`
    -   `$ uv pip freeze > requirements.txt` -> create `requirements.txt` file from an activated `uv` environment.(How to integrate packages of a existing `uv` environment)
    -   `$ uv add -r requirements.txt` -> Integrate packages from an `requirements.txt` file into current project.
    -   `$ uv export --format requirements.txt --no-hashes --no-emit-project -o requirements.txt`
    -   `$ uv export --format requirements-txt --no-hashes --no-emit-project -o requirements.txt`
    -   `$ uv `

    #### Creating & Using a virtual environment

    -   [uv Docs on virtual environment](https://docs.astral.sh/uv/pip/environments/#creating-a-virtual-environment)
    -   `$ uv venv --help`
    -   `$ uv venv [OPTIONS] [PATH]`
    -   `$ uv venv [venv_name]`
    -   `$ uv venv ~/.uv/uvenv1 --python 3.11` -> Create a Virtualenv in `~/.uv/` by the name `uvenv1`
    -   `$ source ~/.uv/uvenv1/bin/activate` -> Activate `~/.uv/uvenv1` environment.
    -   `$ uv run --activate main.py` -> `--activae` prefer the active virtual environment over the project’s virtual environment. No active virtual environment, it has no eefect.
    -   `$ uv pip --help`
    -   `$ uv pip install requests` → Installs the `requests` library into the current `uv` virtual environment.
    -   `$ uv pip list` → Lists all packages currently installed in the `uv` virtual environment along with their versions.
    -   `$ uv pip uninstall pandas` → Uninstalls the `pandas` package from the `uv` virtual environment.
    -   `$ uv pip freeze > requirements.txt` → Outputs all currently installed packages (with exact versions) in `requirements.txt` format and writes them to a `requirements.txt` file.
    -   `$ uv sync --dev`
    -   `$ uv sync --strict`
    -   `$ rm -fr $UV/myvenv` -> Remove `myvenv` virtual environment.
    -   `$ `

    -   **how to create uv project and venv from? `requirements_dev.txt`**

        -   `$ uv init --no-workspace`
        -   `$ uv add --dev -r requirements_dev.txt`

    -   **How create a empty venv and add packages using `uv`**

        -   `$ uv venv`
        -   `$ source .venv/bin/activate`
        -   `$ uv pip install requests`
        -   `$ uv sync`
        -   `$ uv add --dev pytest`
        -   `$ `
        -   `$ uv pip freeze | xargs uv pip uninstall`

    -   **how to create `uv` venv from `uv.lock` or `pyproject.toml` file?**

        -   **Option 1:**
            -   `$ uv venv` -> Create virtual environments in `.venv`
            -   `$ source .venv/bin/activate` -> Activate the virtual environments - `.venv`
            -   `$ uv sync` -> This command reads the `uv.lock` file and installs the exact packages and versions specified within it.
        -   **Option 2**: Create named uv virtual env.
            -   `$ uv venv $UV/named_venv --python 3.11` -> Create virtual environments in `$UV` by the name of `named_venv`
            -   `$ source $UV/named_venv/bin/activate` -> Activate the virtual environments - `named_venv`
            -   **Option 1**:
                -   `$ uv sync --active` -> This command reads the `uv.lock` file and installs the exact packages and versions specified within active environment.
            -   **Option 2**:
                -   `$ uv pip install -r pyproject.toml` -> This command reads the `pyproject.toml` file, resolves dependencies, and installs them into the active virtual environment. If a `uv.lock` file exists, it will be updated

    -   **How create `uv` virtual environment in a central location?**
        -   `$ uv venv $UV/my_uv_env`
        -   `$ uv venv $UV/my_uv_env --python=python3.11`
        -   `$ uv venv $UV/my_uv_env -python 3.11`
        -   `$ uae` -> Activate `uv` environment using aliases - `uae`
        -   `$ ude` -> Deactivate `uv` environment using aliases - `ude`

    #### Tool Environments

    **Tool Environments** refer to **dedicated, isolated virtual environments automatically managed by `uv`** to install and run project-specific developer tools — such as linters (`black`), test runners (`pytest`), formatters (`ruff`, `isort`), or other CLI tools — **separately from your main application dependencies**.

    -   **Why tool environments exist**: Tool environments help with:

        -   ✅ **Separation of concerns**: Keep your runtime dependencies (`requests`, `numpy`, etc.) separate from dev tools.
        -   ✅ **Reproducibility**: Tools get installed exactly as defined in `uv.lock`, isolated from system or user Python.
        -   ✅ **Speed**: `uv` can reuse cached tool environments across multiple projects.
        -   ✅ **Clean development**: Prevents cluttering your main environment with dev-only packages.

    -   **Where they live**: Tool environments are typically stored in a central location, like `~/.cache/uv/tools/`

    -   **Example**

        If your `pyproject.toml` includes:

        ```toml
        [tool.uv.dependencies]
        requests = "^2.32"

        [tool.uv.dev-dependencies]
        black = "^24.0"
        pytest = "^8.0"
        ```

        -   `$ uv run black .`
            -   Automatically install and cache `black` into a **tool environment**.
            -   Not affect your main application virtual environment.

    -   **Tool Envs vs Main venv**

        | Aspect               | Main `venv`                   | Tool Environment                     |
        | -------------------- | ----------------------------- | ------------------------------------ |
        | Purpose              | Run the actual Python app     | Run dev tools like `black`, `pytest` |
        | Created by           | `uv venv`, `uv sync`          | Auto-created by `uv`                 |
        | Location             | Project folder or manual path | `~/.cache/uv/tools/`                 |
        | Shared between repos | ❌ (project-specific)          | ✅ (cached and reused)                |

   </details>

---

-   <details><summary style="font-size:25px;color:Orange">pipx</summary>

    -   Use `pipx` to keep your Python CLI tools isolated and avoid dependency conflicts!
    -   Installing CLI Applications

        -   `pipx` ensures Python-based command-line tools are **installed globally** but **run in isolated virtual environments**, avoiding dependency conflicts.
        -   Example CLI tools best installed with `pipx`:

            -   `black` (code formatter)
            -   `httpie` (HTTP client)
            -   `awscli` (AWS command-line tool)
            -   `poetry` (Python packaging tool)
            -   `ansible` (IT automation)

            **Example:**

            -   `$ pipx install black` → Install black package
            -   `$ black --version  # Works globally without interfering with other projects`

    -   Preventing Dependency Conflicts
        -   Since `pipx` creates **isolated virtual environments** for each application, it prevents global package conflicts.
        -   If you install a CLI tool using `pip`, it could interfere with existing dependencies.

    #### Commands

    ##### **🔹 Installation & Uninstallation**

    ```bash
    $ pipx install <package-name>
    ```

    -   Install a CLI tool globally in an isolated environment.
    -   **Example:**

        ```bash
        $ pipx install black  # Install Black (Python formatter)
        ```

        ```bash
        $ pipx uninstall <package-name>
        ```

        -   Uninstall a previously installed CLI tool.

    -   **Example:**

        ```bash
        $ pipx uninstall black  # Remove Black
        ```

        ```bash
        $ pipx reinstall <package-name>
        ```

        -   Reinstall a package in a fresh environment.

    -   **Example:**

        ```bash
        $ pipx reinstall black  # Reinstall Black
        ```

        ```bash
        $ pipx reinstall-all
        ```

        -   Reinstall all installed packages. Useful after upgrading Python.

        ```bash
        $ pipx uninstall-all
        ```

        -   Uninstall all installed tools.

    ##### **🔹 Running Python Apps Without Installing**

    ```bash
    $ pipx run <package-name> [args]
    ```

    -   Run a tool **without installing it permanently**.
    -   **Example:**

        ```bash
        $ pipx run cowsay "Hello, pipx!"  # Run cowsay once without installing
        ```

        ```bash
        $ pipx runpip <package-name> <pip-command>
        ```

        -   Run `pip` inside an isolated environment.

    -   **Example:**

        ```bash
        $ pipx runpip black install requests  # Install requests inside Black's environment
        ```

    ##### **🔹 Listing & Managing Installed Packages**

    ```bash
    $ pipx list
    ```

    -   Show all installed CLI tools and their virtual environments.

    ```bash
    $ pipx ensurepath
    ```

    -   Ensure `pipx`'s installation path is in your system's `PATH` variable (needed after installing `pipx`).

    ```bash
    $ pipx upgrade <package-name>
    ```

    -   Upgrade a specific package.
    -   **Example:**

        ```bash
        $ pipx upgrade black  # Upgrade Black
        ```

        ```bash
        $ pipx upgrade-all
        ```

        -   Upgrade all installed packages.

    ##### **🔹 Managing Virtual Environments**

    ```bash
    $ pipx inject <package-name> <dependency>
    ```

    -   Inject additional dependencies into an installed package's environment.
    -   **Example:**

        ```bash
        $ pipx inject black mypy  # Install `mypy` inside Black's environment
        ```

        ```bash
        $ pipx reinstall-all --python <python-version>
        ```

        -   Reinstall all packages using a specific Python version.

    -   **Example:**

        ```bash
        $ pipx reinstall-all --python python3.10  # Reinstall using Python 3.10
        ```

    ##### Summary Table

    | Command                                | Description                                 |
    | -------------------------------------- | ------------------------------------------- |
    | `$ pipx install <package>`             | Install a package globally in isolation     |
    | `$ pipx uninstall <package>`           | Uninstall a package                         |
    | `$ pipx list`                          | List installed packages                     |
    | `$ pipx run <package>`                 | Run a package without installing            |
    | `$ pipx upgrade <package>`             | Upgrade a package                           |
    | `$ pipx upgrade-all`                   | Upgrade all packages                        |
    | `$ pipx reinstall <package>`           | Reinstall a package                         |
    | `$ pipx reinstall-all`                 | Reinstall all packages                      |
    | `$ pipx inject <package> <dependency>` | Add a dependency to a package's environment |

   </details>

---

-   <details><summary style="font-size:25px;color:Orange">pyenv</summary>

    -   [pyenv doc](https://github.com/pyenv/pyenv-installer)
    -   [How to Install and Run Multiple Python Versions on macOS](https://www.youtube.com/watch?v=31WU0Dhw4sk)

    -   **pyenv** is a popular tool for managing multiple versions of Python on a single system. It simplifies the process of switching between different Python versions and managing project-specific Python environments. Here are the key features and uses of pyenv in the context of Python programming:
    -   **pyenv-virtualenv** is a plugin for `pyenv` that facilitates the creation and management of Python virtual environments. This integration allows you to create virtual environments that are associated with specific Python versions managed by `pyenv`

    -   **Multiple Python Versions**: pyenv allows you to install and use multiple versions of Python simultaneously. This is particularly useful for testing your code against different Python versions or using different versions for different projects.
    -   **Version Switching**: You can easily switch between different Python versions using simple commands. This helps in maintaining compatibility with various projects that might require different Python versions.
    -   **Local and Global Versions**: pyenv enables setting a global Python version that is used system-wide. Additionally, you can set local Python versions for specific projects, ensuring that each project uses the correct version of Python without interfering with others.
    -   **Plugin Support**: pyenv can be extended with plugins, such as pyenv-virtualenv, which integrates virtual environment management. This further enhances its capabilities by allowing the creation and management of isolated Python environments for different projects.
    -   **Configuration**:

        -   `$ brew install pyenv`
        -   `$ brew install pyenv-virtualenv` → [Install pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv)

            ```sh
            # Add pyenv to PATH
            export PATH="$HOME/.pyenv/bin:$PATH"
            # Initialize pyenv
            eval "$(pyenv init --path)"
            eval "$(pyenv init -)"
            ##  pyenv-virtualenv is a plugin for pyenv that facilitates the creation and management of Python virtual environments.
            eval "$(pyenv virtualenv-init -)"
            ```

        -   `$ pyenv virtualenvs`
        -   `$ pyenv activate <virtualenv_name>`
        -   `$ pyenv deactivate`
        -   `$ pyenv virtualenv-delete virtualenv_name`

    -   `$ pyenv` → list out all _pyenv_ commands.
    -   `$ pyenv help <command>` → Provide information on the specified command.
    -   `$ pyenv install -l` → List out all the python versions available to install.
    -   🚀`$ pyenv versions` → List out all the installed python versions in your machine.
    -   🚀`$ pyenv global 3.9.7` → Set the given python version as your global python.
    -   🚀`$ pyenv local myenv` → set a virtual environment to be used automatically in a specific project directory by creating a `.python-version` file in that directory.

    -   `$ pyenv install 3.9.7` → Install python3.9.7 through pyenv.
    -   `$ pyenv install 3.10.0rc2` → Install latest release candidate (rc) of your current python version.
    -   `$ pyenv local 3.10.0rc2` → Install latest release candidate as dot python version for this project.
    -   `$ python -m venv .venv` → Create python environment from the `..python` version.
    -   `$ pyenv `

    -   Some useful pyenv commands are:
        -   `$ pyenv --version` → Display the version of pyenv
        -   `$ pyenv commands` → List all available pyenv commands
        -   `$ pyenv exec` → Run an executable with the selected Python version
        -   `$ pyenv global` → Set or show the global Python version(s)
        -   `$ pyenv help` → Display help for a command
        -   `$ pyenv hooks` → List hook scripts for a given pyenv command
        -   `$ pyenv init` → Configure the shell environment for pyenv
        -   `$ pyenv install` → Install a Python version using python-build
        -   `$ pyenv latest` → Print the latest installed or known version with the given prefix
        -   `$ pyenv local` → Set or show the local application-specific Python version(s)
        -   `$ pyenv prefix` → Display prefixes for Python versions
        -   `$ pyenv rehash` → Rehash pyenv shims (run this after installing executables)
        -   `$ pyenv root` → Display the root directory where versions and shims are kept
        -   `$ pyenv shell` → Set or show the shell-specific Python version
        -   `$ pyenv shims` → List existing pyenv shims
        -   `$ pyenv uninstall` → Uninstall Python versions
        -   `$ pyenv version` → Show the current Python version(s) and its origin
        -   `$ pyenv version-file` → Detect the file that sets the current pyenv version
        -   `$ pyenv version-name` → Show the current Python version
        -   `$ pyenv version-origin` → Explain how the current Python version is set
        -   `$ pyenv versions` → List all Python versions available to pyenv
        -   `$ pyenv whence` → List all Python versions that contain the given executable
        -   `$ pyenv which` → Display the full path to an executable

    #### Create and Mange Virtural Environment using 'pyenv'

    -   `$ pyenv install 3.9.5 ` → Ensure Python 3.9.5 is installed
    -   🚀`$ pyenv versions` → List out all the installed python versions in your machine.
    -   🚀`$ pyenv virtualenv 3.9.5 myenv` → create a virtual environment with a specific version of Python using the pyenv virtualenv command.
    -   🚀`$ pyenv virtualenvs ` → To list all virtual environments managed by `pyenv-virtualenv`
    -   `$ pyenv activate myenv ` → To activate a virtual environment
    -   `$ pyenv deactivate` → To deactivate the currently active virtual environment
    -   `$ pyenv uninstall myenv` → To remove an existing virtual environment
    -   `$ pyenv ` →
    -   `$ pyenv ` →
    -   `$ pyenv ` →

   </details>

---

-   <details><summary style="font-size:25px;color:Orange">pipenv</summary>

    -   [Corey: Easily Manage Packages and Virtual Environments](https://www.youtube.com/watch?v=zDYL22QNiWk&list=PL-osiE80TeTskrapNbzXhwoFUiLCjGgY7&index=23&t=672s)
    -   [Pipenv & Virtual Environments](https://pipenv-fork.readthedocs.io/en/latest/install.html#installing-pipenv)
    -   `$ NOTE: pipenv should be added to the PATH in order to pipenv be recognized by Terminal.`

    **pipenv** is a dependency management tool for Python that aims to combine the functionalities of pip (Python's package installer) and virtualenv (a tool to create isolated Python environments). It provides a unified approach to managing project dependencies, ensuring that your project's environment is isolated and all dependencies are properly managed.

    -   **Virtual Environment Management**: pipenv automatically creates and manages a virtual environment for your project, eliminating the need to manually create virtual environments with virtualenv or pyenv-virtualenv.
    -   **Dependency Management**: pipenv uses a Pipfile to specify project dependencies, replacing the traditional requirements.txt file. This Pipfile allows for more flexibility and readability.
    -   **Lockfile for Reproducible Builds**: pipenv generates a Pipfile.lock, which locks the exact versions of dependencies, ensuring that your project builds are reproducible and consistent across different environments.
    -   **Integration with pip**: pipenv leverages pip for package installation, ensuring compatibility with the broader Python ecosystem.
    -   **Unified Workflow**: pipenv provides a single command-line interface for managing both virtual environments and dependencies, streamlining the workflow.
    -   **Security**: pipenv can check for known security vulnerabilities in your dependencies using the pipenv check command, which is powered by the Python Packaging Authority's safety database.

    -   **Notes**:

        -   You cannot directly install a specific Python version using `pipenv`.
            -   You can use `pyenv` to install specific Python version.
                -   `pipenv --python 3.*.*` can find the given python version if it's install through `pyenv`.
        -   You have to be in the environment to activate it.
        -   You can run a script that in a perticular environment without activating it (`pipenv run python script.py`).
        -   A random python script cannot be run in a perticular pipenv environment without moving it into that environment.
        -   pipenv does not directly support creating a virtual environment with a custom name. It automatically creates a virtual environment in a default location (`~/.local/share/virtualenvs/`) based on the project's directory.
            -   **Workaround**: Create venv using `pyenv` or `python -m venv` with custom name and activate it. Now `pipenv` consumes it instead of creating a new venv.

    -   **Configuration**:

        -   `$ pip3 install pipenv`

        -   Important Pipenv related paths:

            -   `/Users/a.momin/.local/share/virtualenvs`

    -   🚀`$ pipenv --python 3.7` → Create a new project using Python 3.7, specifically

        -   `$ pipenv --python /usr/local/Cellar/python@3.9/3.9.13_1/Frameworks/Python.framework/Versions/3.9/bin/python3.9`
        -   `$ pipenv --python /usr/local/Cellar/python@3.10/3.10.4/bin/python3.10`

    -   `$ pipenv --help | -h`
    -   `$ pipenv --py` →
    -   `$ pipenv install` → create pip env and install packages from pipfile.lock
    -   `$ pipenv install requests`
    -   `$ pipenv uninstall requests`
    -   `$ exit` → deactivate environment
    -   🚀`$ pipenv shell` → Activate the virtualenv
    -   `$ pipenv run` → Alternative to <pipenv shell>, run a command inside the virtualenv
    -   `$ pipenv run python` →
    -   🚀`$ pipenv run python script.py` → run `script.py` in context of env without activating it. assumed `script.py` is in the venv
    -   `$ pipenv install -r ../requirment.txt` → install several packages from existing project using requirment.txt (a text file containing list of dependencies a project needs) file
    -   `$ pipenv lock -r` →
    -   `$ pipenv install pytest --dev` → way to keep dev packages seperate from build packages
    -   `$ pipenv --python 3.6` → change the python version to 3.6 in the env from existing version. Before running the command mannual change is need inside the pipfile: existing version to 3.6
    -   `$ pipenv --rm` → remove the the environment. Note: the Pipfile is not removed.
    -   🚀`$ pipenv --venv` → Returns the path of activated environment (pipenv)
    -   🚀`$ ls ~/.local/share/virtualenvs/` → to List All Pipenv Virtual Environments.
    -
    -   `$ pipenv check` →
    -   `$ pipenv install` → install from the `Pipfile`
    -   `$ pipenv graph` → Show a graph of your installed dependencies
    -   `$ pipenv lock` →
    -   `$ pipenv install --ignore-Pipfile`

    -   <details><summary style="font-size:15px;color:Maroon">How can I share a pipenv virtual environment with multiple projects?</summary>

        #### Method 1: Use a Common Virtual Environment Path (`PIPENV_VENV_IN_PROJECT`)

        By default, Pipenv stores virtual environments in `~/.local/share/virtualenvs/` (Linux/macOS) or `%USERPROFILE%\.virtualenvs\` (Windows). To share an environment between multiple projects, you can:

        1. **Create the Virtual Environment in a Common Location**

        ```bash
        pipenv --python 3.x  # Create a virtual environment (choose your Python version)
        ```

        2. **Find the Virtual Environment Path**

        ```bash
        pipenv --venv
        ```

        Example output:

        ```
        /Users/your_user/.local/share/virtualenvs/myenv-abc123
        ```

        3. **Set the `PIPENV_VENV_IN_PROJECT` or Manually Link the Virtual Environment**
           To force Pipenv to use this environment in another project, use:

        ```bash
        export PIPENV_VENV_IN_PROJECT=1  # Keeps the env in the project directory
        ```

        Alternatively, create a `.venv` symlink in another project:

        ```bash
        ln -s /Users/your_user/.local/share/virtualenvs/myenv-abc123 /path/to/another_project/.venv
        ```

        #### Method 2: Use a Global Virtual Environment

        Instead of creating project-specific environments, use a system-wide virtual environment and instruct Pipenv to use it:

        4. **Create a Global Virtual Environment**

        ```bash
        python3 -m venv ~/shared_env
        ```

        5. **Activate It in Each Project**: For macOS/Linux:

        ```bash
        source ~/shared_env/bin/activate
        ```

        6. **Use `pipenv --python` to Link It**: In each project, tell Pipenv to use this Python environment:

        ```bash
        pipenv --python ~/shared_env/bin/python
        ```

        #### Method 3: Use a Custom Environment Variable (`PIPENV_IGNORE_VIRTUALENVS`)

        If you manually activate the virtual environment before using `pipenv`, set:

        ```bash
        export PIPENV_IGNORE_VIRTUALENVS=1
        ```

        This prevents Pipenv from creating a new virtual environment and forces it to use the currently activated one.

       </details>

       </details>

---

-   <details><summary style="font-size:25px;color:Orange">conda</summary>

    -   [ANACONDA Documentations](https://conda.io/projects/conda/en/latest/user-guide/index.html)
    -   [Corey Schafer: How to manage multiple version and environments of python](https://www.youtube.com/watch?v=cY2NXB_Tqq0)
    -   path = `/Users/a.momin/opt/anaconda3` → Installed here so that only installing user can use the Conda distribution.
    -   path = `/opt/anaconda3` → Installed here so that all user of the machine can use Anaconda.
    -   `$ conda install bash_kernel -c conda-forge`

    -   `$ conda init <SHELL_NAME>` → To initialize your shell for the first time.
    -   `$ conda init bash` → Appends lines of codes to `.bash_profile` file
    -   `$ conda clean --all` → Conda maintains a package cache that can grow large over time. Clearing the cache can free up significant space.

    -   #### conda help:

        -   `$ conda -h`
        -   `$ conda <command> -h` → EX. conda remove -h
        -   `$ conda create -H`
        -   `$ conda env -h`
        -   `$ conda env remove -h`
        -   `$ conda config remove -h`

    -   #### conda config:

        -   `$ conda config --describe [DESCRIBE [DESCRIBE ...]]` → Describe given configuration parameters. If no arguments given, show information for all configuration parameters.
        -   `$ conda config --set auto_activate_base false` → To prevent Conda from activating the base environment by default?
        -   `$ conda config --add channels conda-forge` → Add the conda-forge channel:
        -   `$ conda config --show channels` -

    -   FastAI:

        -   git clone https://github.com/fastai/fastai.git
        -   cd fastai

    -   `$ conda activate fastai-cpu`
    -   `$ 🔥 conda info`
    -   `$ 🔥 conda info --envs` → To see a list of all of your environments

    -   #### conda env:

        -   `$ 🔥 conda env list` → To see a list of all of your environments
        -   `$ 🔥 conda env export > environent.yml` → export virtual environent into environent file.
        -   `$ 🔥 conda env create -f environment-cpu.yml` → Create a new python project environment using conda package manager
        -   `$ 🔥 conda env create -f bio-env.txt -n env_name` → Create a new project environment using text file.
        -   `$ 🔥 conda env remove --name environent_name` → Remove/Delete the environment by the name `environent_name`

    -   #### conda create/remove:

        -   `$ conda create -n env_name -y` → Create a environment with the given name, env_name
        -   `$ conda create --name conda_env_name <first_pkg second_pkg ...>`
        -   `$ conda create --name bio-env biopython` → Stack commands: create a new environment, name it bio-env and install the biopython package
        -   `$ conda create --name conda_env_name27 python=2.7 <a_pythone_package>` → Create a new python 2.7 project environment using conda package manager
        -   `$ 🔥 conda env create -f environment-cpu.yml` → Create a new python project environment using conda package manager
        -   `$ 🔥 conda env create -f requirements.txt -n  env_name` → Create a new project environment using text file.
        -   `$ conda remove --name conda_env_name --all` → Remove the specified environment
        -   `$ conda remove --name conda_env_name <package_name>` → Remove the specified package_name from specified environment.
        -   `$ 🔥 conda env remove --name environent_name` → Remove/Delete the environment by the name `environent_name`

    -   🔥 `$ conda list` → list out the packages in the current environments
    -   `$ conda list --explicit > pkgs.txt` → Export an environment with exact package versions for one OS
    -   🔥 `$ conda list --export > requirements.txt`
    -   `$ conda update -n base -c defaults conda`
    -   `$ conda activate conda_env_name` → To activate this environment. Ex. conda activate fastai-cpu
    -   `$ source activate conda_env_name` → To activate the environent
    -   `$ conda deactivate` → To deactivate an active environment
    -   `$ source deactivate` → To deactivate an active environment
    -   `$ conda install -c pytorch pytorch`

    ##### [How to Manage Multiple Projects, Virtual Environments, and Environment Variables](https://www.youtube.com/watch?v=cY2NXB_Tqq0&list=PL-osiE80TeTt2d9bfVyTiXJA-UTHn6WwU&index=16)

    -   Create a bash file in corresponding conda environment.
        -   mkdir -p $HOME/opt/anaconda3/envs/fastai/etc/conda/activate.d
        -   mkdir -p $HOME/opt/anaconda3/envs/fastai/etc/conda/deactivate.d
        -   touch $HOME/opt/anaconda3/envs/fastai/etc/conda/activate.d/env_vars.sh
            -   #!/bin/sh
            -   export SECRET_KEY='SDFLKJ;LASKJF;LAKSD;L'
            -   export DATABASE_URI="postgresql://user:pass@bd_server:5432/test_db"
        -   touch $HOME/opt/anaconda3/envs/fastai/etc/conda/deactivate.d/env_vars.sh
            -   #!/bin/sh
            -   unset SECRET_KEY
            -   unset DATABASE_URI

   </details>

---

-   <details><summary style="font-size:25px;color:Orange">Linter: Pylint</summary>

    -   A linter is a static code analysis tool used in programming to automatically check your code for errors, bugs, style issues, and potential problems—before you run it. Examples of Linters in Different Languages:

        | Language   | Linter Tools                                    |
        | ---------- | ----------------------------------------------- |
        | Python     | `pylint`, `flake8`, `mypy`, `black` (formatter) |
        | JavaScript | `eslint`, `jshint`                              |
        | Go         | `golint`, `go vet`                              |
        | Java       | `Checkstyle`, `PMD`, `SpotBugs`                 |
        | C/C++      | `cppcheck`, `clang-tidy`                        |

    ##### Pylint

    -   **Pylint** is a **static code analysis tool** for Python that checks for:

        -   Syntax errors
        -   Code quality issues
        -   Coding standard violations (e.g., PEP8)
        -   Refactoring suggestions
        -   Unused variables or imports

    -   It scores your code and gives you actionable feedback to improve readability, maintainability, and correctness.
    -   `$ pip install pylint`

    ##### ✅ Step 3: Configure Pylint as the Linter

    1. Open **Command Palette** (`Ctrl+Shift+P`)
    2. Search: `Python: Select Linter`
    3. Choose: `pylint`

    This tells VS Code to use `pylint` as the default linter.

    ##### ✅ Step 4: (Optional) Customize `pylint` Settings

    You can create a custom configuration file:

    -   `$ pylint --generate-rcfile > .pylintrc`

    -   Then modify the `.pylintrc` file to:

        -   Ignore specific rules or directories
        -   Customize naming conventions
        -   Set max line length, etc.

        ```ini
        [MESSAGES CONTROL]
        disable=C0114, C0115, C0116, W0611

            # C0114: Missing module docstring
            # C0115: Missing class docstring
            # C0116: Missing function or method docstring
            # W0611: Unused import
        [MASTER]
        ignore=tests,migrations
        ignore-patterns=.*_test\.py
        [FORMAT]
        max-line-length=100
        [BASIC]
        variable-rgx=[a-z_][a-z0-9_]{2,30}$
        function-rgx=[a-z_][a-z0-9_]{2,30}$
        class-rgx=[A-Z_][a-zA-Z0-9]+$
        const-rgx=(([A-Z_][A-Z0-9_]*)|(__.*__))$
        [TYPECHECK]
        ignored-modules=numpy,torch

        [REPORTS]
        output-format=colorized
        ```

    -   Or configure through `settings.json` in VS Code:

        ```json
        "python.linting.pylintEnabled": true,
        "python.linting.enabled": true,
        "python.linting.pylintArgs": [
            "--disable=C0114,C0115,C0116",  // Example: disable docstring warnings
        ]
        ```

   </details>

---

-   <details><summary style="font-size:25px;color:Orange">Formatter: Black</summary>

    A **formatter** is a tool that automatically adjusts your code to follow a consistent **style guide**. It fixes indentation, spacing, line lengths, quotation marks, etc., without changing what the code _does_.

    ##### Black

    **Black** is an **opinionated code formatter** for Python.
    It reformats your entire code base to follow a standard style (PEP 8 + Black's rules), making your code look **clean and uniform**.

    > "Black makes code formatting a non-issue. By using it, you no longer need to argue over style."

    -   `$ pip install black`
    -   `$ pip install -U black --user`

    -   Make sure the official **Python extension** from Microsoft is installed in your VS Code.

    -   **Configure VS Code to Use Black**

        1. Open `settings.json` (use `Ctrl+Shift+P` → "Preferences: Open Settings (JSON)")
        2. Add or update these settings:

        ```json
        {
            "python.formatting.provider": "black",
            "editor.formatOnSave": true,
            "[python]": {
                "editor.defaultFormatter": "ms-python.python"
            }
        }
        ```

        > You can also disable formatting on save or only run Black manually if you prefer.

    -   **Optional**: Create a `pyproject.toml` to Customize Black to formate your project

        ```toml
        [tool.black]
        line-length = 100
        skip-string-normalization = true
        target-version = ['py39']
        ```

        > Place this in your project root to customize Black’s behavior (e.g., line length, skipping double quotes, etc.)

    -   **Benefits of Using Black**

        -   Enforces **uniform code style**
        -   Saves **review time** and avoids style arguments
        -   Works well with linters (like Pylint or Flake8)
        -   Easy integration with **CI/CD** and **pre-commit hooks**

   </details>

---

-   <details><summary style="font-size:25px;color:Orange">isort</summary>

   </details>

---

-   <details><summary style="font-size:25px;color:Orange">Sphinx (Document Generator)</summary>

    -   **Sphinx** is a **documentation generator** written in Python. It's widely used to build **HTML, PDF, LaTeX**, and other formats from **reStructuredText (reST)** source files.

        -   Converts `.rst` or `.md` and docstrings into beautiful documentation
        -   Highly customizable via themes, extensions, and plugins
        -   Supports API docs via `autodoc` (introspects your Python code)
        -   Officially used by Python documentation (e.g., `docs.python.org`)

        -   You install and enable Napoleon like this:

            -   `pip install sphinx`

        -   In `conf.py` (Sphinx config):

            ```python
            extensions = ['sphinx.ext.autodoc', 'sphinx.ext.napoleon']
            ```

    -   **Napoleon** is a **Sphinx extension** that allows Sphinx to **understand and parse**:

        1. **Google-style** docstrings
        2. **NumPy-style** docstrings
        3. Without Napoleon, Sphinx **only understands reST-style docstrings**, which are more verbose and harder to write manually.

    -   **Sphinx vs Napoleon: Comparison Table**

        | Feature                        | **Sphinx (Core)**              | **Napoleon (Extension)**                          |
        | ------------------------------ | ------------------------------ | ------------------------------------------------- |
        | Parses reStructuredText        | ✅ Yes                          | 🚫 No                                              |
        | Parses Google-style docstrings | ❌ No (native)                  | ✅ Yes                                             |
        | Parses NumPy-style docstrings  | ❌ No (native)                  | ✅ Yes                                             |
        | HTML/LaTeX/PDF output          | ✅ Yes                          | ➖ Not its role (relies on Sphinx)                 |
        | Auto-generates API docs        | ✅ (via `autodoc`)              | ✅ (works with `autodoc`)                          |
        | Setup complexity               | Medium                         | Low (just add to `extensions` list)               |
        | Best use case                  | Full control, official formats | Modern, readable docstring formats (Google/NumPy) |

    -   **When to Use What?**

        | Scenario                                           | Use                              |
        | -------------------------------------------------- | -------------------------------- |
        | You prefer `reStructuredText` everywhere           | Just Sphinx (no Napoleon)        |
        | You use **Google-style or NumPy-style** docstrings | Sphinx + Napoleon                |
        | You are documenting a data science or ML library   | Sphinx + Napoleon (NumPy-style)  |
        | You want clean, readable inline docstrings         | Sphinx + Napoleon (Google-style) |

    </details>

---

-   <details><summary style="font-size:25px;color:Tomato"> Publish a Python package into PyPI Repository</summary>

    #### Experimental Python package:

    -   **Inspired by**: [Arjan Code](https://youtu.be/5KEObONUkik.)
    -   **Created `pyenv` Environment**: `pypkgpublish`
    -   **Project Location**: `/Users/am/mydocs/Software_Development/Python_Program/Python3/2023-package`

   </details>
