- 𝐔𝐬𝐞𝐟𝐮𝐥𝐥 𝑺𝒚𝒎𝒃𝒐𝒍𝒔: → ⌘ ⌥ + ⌃ + ⤶ ⇧ ⇪ ␣ ⌦ ⎋  ⮐ ⤶ ↩︎ ↲ ↵ ⬋ ↫ ♥ ★ → ↓ ↑ ➡️ ⬅️ ⬆︎ ⬇️
- [How to make your own VS Code theme!](https://www.youtube.com/watch?v=pGzssFNtWXw)
- [RemoteDev: Develop from anywhere with Visual Studio Code](https://www.youtube.com/watch?v=CYObXaSjj78)

- `^ + ⌘ + Spaces` → To get Emoji (🏠)
- `^ + Spaces` → To get markdown snippet autocomplete.
- `⌘ + ⇧ + O` → Open drop down to select Heading level to move to the selected heading.
- `⌥ + 8` → Shortcut to get dot symbol(•).
- `⌘ + ^ + ➡️/⬅️` → Split the window

---
---

-   <details><summary style="font-size:25px;color:Orange">Terms & Concepts</summary>

    > Visual Studio Code (VS Code) is more than just a text editor; it is a highly customizable **Integrated Development Environment (IDE)** built on the Electron framework. To master it, you need to understand its architectural components and the specific terminology Microsoft uses to describe its interface.

    1. **The Core Interface (The "Workbench")**: The "Workbench" refers to the entire UI window. It is divided into several distinct regions:
        - **Activity Bar:** The narrow vertical strip on the far left. It allows you to switch between Views (Explorer, Search, Source Control, etc.).
        - **Side Bar:** The expandable area next to the Activity Bar that contains the active View (e.g., your file tree).
        - **Editor Group:** The central area where you actually write code. You can split this into multiple groups (vertical or horizontal).
        - **Panel:** The bottom region housing the Integrated Terminal, Debug Console, Output, and Problems tabs.
        - **Status Bar:** The horizontal strip at the very bottom showing project info, Git branches, line/column numbers, and encoding.

    2. **Navigation & Command Tools**: These are the features that allow you to move through the editor at high speed.
        - **Command Palette:** The "heart" of VS Code. Accessed via `Ctrl+Shift+P`, it allows you to execute almost any command by typing its name.
        - **Quick Open:** Accessed via `Ctrl+P`, used for rapidly jumping to any file in your workspace.
        - **Breadcrumbs:** The navigation trail at the top of the editor showing your current file's location in the folder hierarchy and symbols (classes/methods) within that file.
        - **Mini-map:** A high-level graphical overview of your source code on the right side of the editor window, useful for "scrolling by shape."

    3. **IntelliSense & Editing Concepts**: VS Code’s "smart" features are collectively referred to as IntelliSense.
        - **IntelliSense:** A suite of features including code completion, parameter info, quick info, and member lists.
        - **LSP (Language Server Protocol):** The background technology that allows VS Code to support many languages. It separates the "smart" code analysis from the editor itself.
        - **Code Lens:** Actionable context-sensitive information displayed inline above your code (e.g., "3 references" or "Run Test").
        - **Snippets:** Reusable templates for common code patterns (e.g., typing `for` and hitting Tab to generate a full loop).
        - **Hover:** The informational tooltip that appears when you rest your mouse over a variable or function name.

    4. **Workspace & Configuration**: How VS Code manages your settings and files.

        > In Visual Studio Code, a **Workspace** is essentially the container for your project. While it may seem like just "the folder you have open," it is actually a sophisticated way for VS Code to track settings, configurations, and UI states specific to that particular body of work.

        > Think of it this way: **User Settings** are your global preferences (like your favorite font), while **Workspace Settings** are the rules for a specific job (like using 2 spaces for a Python project but 4 spaces for a C++ one).

        1. **The Three Types of Workspaces**: Depending on how you work, you will encounter three different "levels" of workspaces:

            * **Single-Folder Workspace:** The most common type. You simply open a folder (`File > Open Folder`). VS Code treats that folder as the "root" of your workspace.
            * **Multi-Root Workspace:** This allows you to have several entirely different folders open in one Side Bar. This is perfect for "Full Stack" development where you might have a `/frontend` folder and a `/backend` folder that aren't inside the same parent directory.
            * **Untitled Workspace:** If you add a second folder to a single-folder setup, VS Code creates a temporary, unsaved workspace until you save it as a `.code-workspace` file.

        2. **The `.vscode` Folder**: When you open a folder in VS Code, you might notice a hidden directory called `.vscode`. This is the "brain" of a local workspace. It typically contains:

            * **`settings.json`**: Customizes the editor just for this project (e.g., hiding certain files or changing the theme).
            * **`launch.json`**: Stores debugging configurations so you can just hit F5 to run your code.
            * **`tasks.json`**: Automates build scripts or compilers.
            * **`extensions.json`**: A list of "Recommended Extensions" that pops up for anyone else who opens your project.

        3. **The `.code-workspace` File**: For **Multi-Root Workspaces**, VS Code uses a special JSON file ending in `.code-workspace`. This file doesn't contain your code; it contains **metadata** about your project, such as:

            1. The paths to all the folders included.
            2. Global settings that apply to *all* those folders.
            3. Which folders should be excluded from search.

        4. **Why Use Workspaces? (Key Benefits)**

            | Feature         | How Workspace Handles It                                                                                                                        |
            | --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
            | **Search**      | `Ctrl + Shift + F` will search across all folders in your workspace simultaneously.                                                             |
            | **Security**    | VS Code uses "Workspace Trust" to prevent malicious scripts in a folder from running without your permission.                                   |
            | **Portability** | By committing the `.vscode` folder to Git, your whole team gets the same debugger and linter settings automatically.                            |
            | **Context**     | You can have one window open with a "Dark Mode" theme for your web project and another window with "Light Mode" for your documentation project. |

    1. **Extensions & Integration**
        - **Extension Marketplace:** The built-in store where you download themes, language support, and tools.
        - **VSIX:** The file format for VS Code extensions.
        - **Source Control (SCM):** The built-in interface for Git. It tracks changes, stages files, and handles commits.
        - **Integrated Terminal:** A full-functional shell (Bash, PowerShell, or Zsh) that runs inside the editor, so you don't have to switch windows.

    2. **Debugging Components**
        - **Debug Console:** Where you interact with the program's variables and state while it's paused.
        - **Breakpoints:** Markers you set on a line of code to tell the debugger to pause execution there.
        - **Launch Configurations:** A `launch.json` file that tells VS Code how to start your app (what arguments to use, which environment variables to set).
        - **Call Stack:** A view that shows the path the execution took to get to the current line during a debug session.

    - **Summary Table: Essential Shortcuts**

        | Term                | Shortcut (Win/Linux) | Shortcut (Mac)    |
        | ------------------- | -------------------- | ----------------- |
        | **Command Palette** | `Ctrl + Shift + P`   | `Cmd + Shift + P` |
        | **Quick Open File** | `Ctrl + P`           | `Cmd + P`         |
        | **Toggle Side Bar** | `Ctrl + B`           | `Cmd + B`         |
        | **Toggle Terminal** | `Ctrl + ` `          | `Ctrl + ` `       |
        | **Global Search**   | `Ctrl + Shift + F`   | `Cmd + Shift + F` |

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">USEFULL SHORTCUTS</summary>

    1. **Most Usaful Shortcuts**:

       - 🔥 `^ + k + f` → Format selected block of code snippets using default formatter.
       - 🔥 `^ + g` → Move cursore to the beginning of the given **LINE #**.
       - 🔥 `^ + ␣` → Search for custom **CODE SNIPPET** shortcuts for markdown.
       - 🔥 `^ + -` → **JUMP CURSOR BACKWORD** in the chain of it's previous position
       - 🔥 `^ + ⇧ + -` → **JUMP CURSOR FORWARD** in the chain of it's previous position
       - 🔥 `^ + ⇧ + ]/[` → **INCREASE OR DECREASE** the view size of current editor
       - 🔥 `⌘ + ⇧ + k` → **DELETE THE LINE** of code at the cursor.
       - 🔥 `⌘ + x` → **CUT THE LINE OF CODE** at the cursor to paste somewhere else.
       - 🔥 `⌘ + k + 0` → Fold code at the base indentation lavel
       - 🔥 `⌥ + z` → Toggle **WRAP/UNWRAP** words in integrated VSC terminal.
       - `⌥ + ⌘ + ]` → Fold code in the editor
       - `⌘ + k + j` → Unold all code blocks.
       - `⌘ + ⇧ + e` → Toggle between file explorer and editor.
       - `⌘ + ↓/↑` → Collapse/Expend the folder in the file explorer
       - `^ + Enter` → Open focused file from file explorer.
       - `fn + ^ + f5` → Run script
       - `⌘ + b` → Toggle side bar
       - `⌘ + ⇧ + e` → Jump between Editor and Explorer
       - `⌘ + j` → Togle between integrated terminal and Editor.
       - `⌘ + ⇧ + x` → Search for Extentions
       - `⌘ + k + m` → Options to choose among various keymaps.

       - `⌘ + ⇧ + f` → Search a patteren in multiple files.

    2. **Jupyter Notebook**:

       - `⬆︎ + ^ + -` → Split cell into two cells in Jupyter Notebook
       - `⬆︎ + m` → merges selected cells in Jupyter Notebook
       - `m` → Change selected cell to markdown cell in Jupyter Notebook
       - `y` → Change selected cell to code cell in Jupyter Notebook

    3. **Usefule Command Palette Search**:

        -   `⌘ + ⇧ + P` -> Open the Command Palette & Type in the Search Box:
            - `Preferences: Open User Settings` ↦ ⮐
            - `Preferences: Open Settings (UI)` ↦ ⮐
            - `Preferences: Open Profiles (UI)` ↦ ⮐
            - `Preferences: Open keyboard shortcuts` ↦ ⮐
            - `Profiles: Switch Profile` -> to Switch Between Profiles
            - `Notebook: Join Selected Cells` ↦ ⮐
            - `Notebook: Collapse all Cell Outputs` ↦ ⮐
            - `Notebook: Expand all Cell Inputs` ↦ ⮐
            - `filename` ↦ ⮐
            - `insert unicode` ↦ ⮐ -> To get Unicode Characters
            - `transform to UPPERCASE/lowercase/titlecase` ↦ ⮐
            - `indentationToSpaces` ↦ ⮐
            - `indentationToTabs` ↦ ⮐

    4. **Misc Shortcuts**:

       - <b style="color:magenta;text-align:left">How to search a kewword across multiple files?</b>
           1.  select the folder/files (by clicking it) you want to serch in.
           2.  `⌘+⬆︎+f`
           3.  put the kew word into the search box to search

       - <b style="color:magenta;text-align:left">How to find differences between two files?</b>
           1.  `RightClick` on one file and `select: Select for Compare`
           2.  `RightClick` on the second file and `select: Compare with Selected`


    5. **Configuration Shortcuts**:

        | MAC         | Action                                            | Windows     |
        | :---------- | :------------------------------------------------ | :---------- |
        | `⌘ + k + t` | Toggle between themes.                            | `^ + k + t` |
        | `⌘ + ,`     | Open the default `settings.json`-file for VSCode. | `^ + ,`     |
        | `⌘ + ⇧ + P` | type 'Default Keyboard Shortcuts (JSON)' ↦ ⮐      | `^ + ⇧ + P` |
        | `⌘ + k + r` | OPEN KEYBOARD SHORTCUTS Reference.                | `^ + k + r` |
        | `⌘ + k + s` | Open Keyboard Shortcuts.                          | `^ + k + s` |

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Settings & Configs</summary>

    > VSCode provides different types of settings that allow users to customize their development environment. These settings are categorized based on scope and application.

    1. **User Settings**: User settings apply globally to the entire VSCode application and are stored in a JSON file. They affect all projects and workspaces unless overridden by workspace settings.
        - **Location**:
            - Windows: `%APPDATA%\Code\User\settings.json`
            - macOS: `~/Library/Application Support/Code/User/settings.json`
            - Linux: `~/.config/Code/User/settings.json`

        - **Example Setting:**
            ```json
            {
                "editor.fontSize": 14,
                "editor.tabSize": 4,
                "editor.wordWrap": "on"
            }
            ```

    2. **Workspace Settings**: Workspace settings apply only to the specific project or workspace in which they are defined. These settings override user settings when a project is opened.
        - **Location**: Inside `.vscode/settings.json` in the root of the workspace

        - **Example Setting:**
            ```json
            {
                "editor.formatOnSave": true,
                "python.pythonPath": "/usr/bin/python3"
            }
            ```

    3. **Folder Settings**: Folder settings are similar to workspace settings but apply only to a specific folder within a multi-root workspace.
        - **Location**: Inside `.vscode/settings.json` within the respective folder

        - **Example Setting:**
            ```json
            {
                "files.exclude": {
                    "**/node_modules": true,
                    "**/.git": true
                }
            }
            ```

    4. **Language-Specific Settings**: These settings apply only when working with a particular programming language. They can be configured at the user, workspace, or folder level.
        - **Example Setting:**
            ```json
            {
                "[python]": {
                    "editor.insertSpaces": true,
                    "editor.tabSize": 4
                },
                "[javascript]": {
                    "editor.tabSize": 2
                }
            }
            ```

    5. **Remote Settings**: When using VSCode’s Remote Development features (like SSH, WSL, or Containers), settings specific to the remote environment can be defined.
        - **Location**: Inside `.vscode-remote/settings.json`

        - **Example Setting:**
            ```json
            {
                "remote.SSH.useLocalServer": false
            }
            ```

    6. **Default Settings**: These are built-in settings that come with VSCode. They cannot be directly modified but can be overridden using user or workspace settings.
        - **To view default settings:**
            - Open **Command Palette** (`Ctrl+Shift+P` or `Cmd+Shift+P` on macOS)
            - Search for **"Preferences: Open Default Settings (JSON)"**

    7. **Machine Settings**: Machine settings apply only to the local machine and cannot be synced across different devices. These are mainly used for security-sensitive configurations.
        - **Example Setting:**
            ```json
            {
                "security.workspace.trust.enabled": false
            }
            ```

    8. **How to Modify Settings?**: You can edit settings in multiple ways:
        1. **GUI Method**
            - Open VSCode
            - Go to **File > Preferences > Settings** (`Ctrl+,` or `Cmd+,` on macOS)
            - Search for the setting and modify it

        2. **JSON Method**
            - Click **Open Settings (JSON)** in the settings UI
            - Manually edit the `settings.json` file

    -   <details><summary style="font-size:20px;color:#C71585">Profile in Visual Studio Code?</summary>

        > A **profile** in **Visual Studio Code (VS Code)** is a feature that allows you to create and manage separate, customized configurations for your development environment. Profiles can include different settings, extensions, themes, keybindings, and UI layouts, making it easier to switch between different setups tailored for specific projects, workflows, or development needs.

        #### **Key Features of Profiles in VS Code**
        1. **Custom Settings**: Each profile can have its own unique configuration settings (e.g., font size, editor behavior, etc.).
        2. **Extensions**: Profiles can have different sets of installed extensions, enabling you to install only what you need for a particular project or workflow.
        3. **Keybindings**: Profiles allow customized keybinding configurations for different tasks or workflows.
        4. **UI Customization**: You can adjust themes, icons, and layouts for each profile.
        5. **Workspace-Specific Profiles**: Profiles can be linked to specific workspaces, making them automatically load when you open that workspace.

        #### **Why Use Profiles?**
        6. **Project-Specific Needs**: Different projects may require unique configurations or extensions (e.g., Python vs. JavaScript projects).
        7. **Role-Specific Workflows**: Developers who switch between roles (e.g., frontend development, backend development, or DevOps) can maintain separate setups for each.
        8. **Focus and Organization**: Minimize clutter by loading only the extensions and settings relevant to your current task or project.
        9. **Personal and Team Use**: Share profiles with team members to maintain a consistent development environment across a team.

        #### **How to Use Profiles in VS Code**
        10. **Access Profiles**:
            - Open the Command Palette (`Ctrl+Shift+P` or `Cmd+Shift+P` on macOS).
            - Search for **"Profiles: Create Profile"**, **"Profiles: Switch Profile"**, or **"Profiles: Manage Profiles"**.

        11. **Create a Profile**:
            - Choose "Create Profile" from the Command Palette.
            - Name your new profile and decide whether to start from scratch or use an existing configuration as a base.

        12. **Switch Profiles**:
            - Use the **"Profiles: Switch Profile"** command to toggle between profiles.
            - Profiles are instantly loaded, updating your settings, extensions, and layout.

        13. **Export/Import Profiles**:
            - You can export a profile to a JSON file and share it with others or import a shared profile into your own VS Code setup.

        #### **Example Use Cases**
        14. **Frontend Development Profile**:
            - Extensions: Prettier, ESLint, Tailwind CSS IntelliSense.
            - Settings: Auto-format on save, dark theme.
            - Keybindings: Shortcuts for web preview.

        15. **Backend Development Profile**:
            - Extensions: Python, PostgreSQL, Docker.
            - Settings: Enable linting and debugging configurations.

        16. **Writing or Documentation Profile**:
            - Extensions: Markdown Preview Enhanced, Spell Checker.
            - Settings: Increased font size for readability.

        </details>


    -   <details><summary style="font-size:20px;color:#C71585">MacOS</summary>

        -   **TWEAK SETTINGS**:

            - `~/Library/Application\ Support/Code/User/settings.json` → Path for VSC `settings.json` file

            - `⌘ + ⇧ + P`
                - 🔥search: `setting`; Select: `Open Workspace Setting (JSON)` → to create local workspace Settings? - `python.terminal.activateEnvironment": true`
                - search: `key mapping`; Select: `Inspect key mapping` → to inspect key-mapping file.
                - search: `keyboard shortcut`; Select: `Open Default keyboard shortcut (JSON)` → to inspect shortcut file.
                - search: `user snippet`; Select: `configure user snippet` → to configure user snippets.
                    - Project wise user's snippet are saved in `.vscode` folder

        -   **USEFULL PATH OF FILES AND FOLDERS on MACOS**:

            - ~/Library/Application\ Support/Code/User/settings.json
            - ~/Library/Application\ Support/Code/User/keybindings.json
            - ~/Library/Application\ Support/Code/User/snippets

        -   **MANAGE EXTENSIONS FROM COMMAND LINE**:

            - `$ code -help` → Print usage.
            - `$ code --install-extension <extension-id[@version] | path-to-vsix>` → Installs or updates an extension.
                - The argument is either an extension id or a path to a VSIX.
                - The identifier of an extension is '${publisher}.${name}'.
                - Use '--force' argument to update to latest version. To install a specific version provide '@${version}'. For example: 'vscode.csharp@1.2.3'.
            - `$ code --list-extensions > list_vsc_extension.txt` → List out all the vscode extensions in the file, list_vsc_extension
            - `$ code --uninstall-extension <extension-id>` → Uninstalls an extension.
            - `$ code --disable-extensions` → Disable all installed extensions.
            - `$ code --disable-extension <extension-id>` → Disable an extension.
            - `$ code --extensions-dir <dir>` → Set the root path for extensions.

        </details>

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">VS Code Agentic Development Shortcuts</summary>

    -   `/` -> Commands
    -   `#` -> Add Context
    -   `@` -> Extensions

    -   Participents
    -   Agent Session
    -   Tools

    | MacOS Commands | Achivements              | Windows Commands |
    | :------------- | :----------------------- | :--------------- |
    | ``             | Run propmt in new Window | `Win + ⌥ + /`    |
    | ``             | Generate prompt          | `⌥ + Win + /`    |
    | ``             |                          | ----             |
    | ----           | ----                     | ----             |


    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Windows OS</summary>
      
    - Keyboard Shortcut (`^ + k + s`):

        - Search: `View: Open Next/Previous Editor`; Set: `⌃ + ⎇ + ➡️` / `⌃ + ⎇ + ⬅️`.
        - This bindings is not possible through `keybindings.json` file.
        - Search: `cursorTop/cursorBottom`; Set: `⌃ + ⬆︎` / `⌃ + ⬇️`.
        - Search: `cursorTopSelect/cursorBottomSelect`; Set: `⌃ + ⇧ + ⬆︎` / `⌃ + ⇧ + ⬇️`.
        - Search: `cursorHomeSelect/cursorEndSelect`; Set: `⌃ + ⇧ + ⬅️` / `⌃ + ⇧ + ➡️`.
        - Search: `cursorWordEndLeftSelect/cursorWordEndRightSelect`; Set: `⇧ + ⌥ + ⬅️`/`⇧ + ⌥ + ➡️`.

    </details>
