*   Explain _.exe, _.cmd, _.bat, _.ps1 files in great details
*   how to customize Windows CMD prompt
*   [Configure keyboard shortcut](https://www.youtube.com/watch?v=vEQe_Mt0BTM)

*   <details><summary style="font-size:25px; color: Orange">Windows Shortcuts</summary>

    1.  **The "Life Savers" (Essential Utility)**: These are the shortcuts everyone should know to navigate the OS quickly.
        - **`Win + V`**: **Clipboard History**. Instead of only pasting the _last_ thing you copied, this shows a list of everything you've copied recently. (You may need to click "Turn on" the first time).
        - **`Win + Shift + S`**: **Snipping Tool**. The fastest way to take a partial screenshot and draw on it or save it.
        - **`Ctrl + Shift + Esc`**: **Task Manager**. Opens it directly without needing to go through the `Ctrl + Alt + Del` screen.
        - **`Win + .` (Period)**: **Emoji & Symbol Picker**. Quickly insert emojis, GIFs, or mathematical symbols into any text field.
        - **`Win + L`**: **Lock PC**. Instantly locks your computer—essential for office or public settings.
    2.  **Window & Desktop Management**: Control your screen clutter like a pro.
        - **`Win + D`**: **Show/Hide Desktop**. Minimizes everything instantly. Press again to bring them all back.
        - **`Alt + Tab`**: **Switch Apps**. Hold `Alt` and tap `Tab` to cycle through open windows.
        - **`Win + Arrow Keys`**: **Snap Windows**. Snap the current window to the left, right, or corners to multi-task perfectly.
        - **`Win + Tab`**: **Task View**. Shows all open windows and allows you to create **Virtual Desktops** (great for separating "Work" from "Gaming").
        - **`Win + Ctrl + D`**: Create a new Virtual Desktop.
        - **`Win + Ctrl + Left / Right Arrow`**: Switch between your Virtual Desktops.
    3.  **File Explorer Shortcuts**: Stop hunting through folders with your mouse.
        - **`Win + E`**: **Open File Explorer**.
        - **`F2`**: **Rename**. Select a file and hit F2 to change the name instantly.
        - **`Alt + Up Arrow`**: Go "up" one folder level.
        - **`Alt + D`**: Jump to the **Address Bar** so you can type a path or search.
        - **`Ctrl + Shift + N`**: Create a new folder.

    4.  **Hidden "Power" Menus**:
        - **`Win + X`**: **Power User Menu**. Opens a secret menu above the Start button with quick links to Device Manager, Terminal (Admin), and System settings.
        - **`Win + I`**: **Settings**. Opens the main Windows Settings app.
        - **`Win + R`**: **Run Dialog**. Type `cmd` , `notepad` , or `calc` to launch apps instantly.
        - **`Win + [Number 1-9]`**: Opens the app pinned to your taskbar in that position (e.g., `Win + 1` opens the first app on the left).

    5.  **Quick Browser / Navigation Tips**: These work in almost any browser (Edge, Chrome, etc.) and many Windows apps. - **`Ctrl + T`**: Open new tab. - **`Ctrl + Shift + T`**: **Undo Close Tab**. Reopens the last tab you accidentally closed (a true life-saver). - **`Ctrl + L`**: Highlight the URL/Search bar. - **`Ctrl + Backspace`**: Delete a whole word at a time (much faster than character-by-character).
        > **Pro Tip:** If your graphics/screen ever freezes or acts "glitchy," try **`Win + Ctrl + Shift + B`**. This restarts your graphics driver without closing your apps.

    </details>

---

Customizing the Command Prompt (CMD) can turn a drab, black-and-white box into a productive environment that feels like a modern developer tool.


1. **Functional Setup (Environment Variables)**: If you want to run programs like `python`, `git`, or `node` from anywhere, you must configure your **PATH**.

    1. Press `Win + S` and search for **"Edit the system environment variables"**.
    2. Click **Environment Variables** at the bottom.
    3. Under **User variables**, find **Path** and click **Edit**.
    4. Add the folder paths where your `.exe` files live.


1. **Persistent Aliases (The "Linux Style")**: CMD doesn't support the `alias` command natively like Linux, but you can use `doskey`. However, `doskey` resets every time you close the window unless you use a **Startup Script**.

    - **Step A**: Create a macro file

        Create a file named `macros.doskey` in a safe folder (e.g., `C:\Scripts\`) and add your favorite shortcuts:

        ```batch
        ls=dir /b
        ll=dir /a
        gs=git status
        ga=git add .
        gc=git commit -m $*
        clear=cls

        ```

    - **Step B**: Automate it via the Registry

        To make CMD load these every time it starts, you need to tell the registry where your "AutoRun" script is.

        1. Press `Win + R`, type `regedit`, and hit Enter.
        2. Navigate to: `HKEY_CURRENT_USER\Software\Microsoft\Command Processor`
        3. Right-click in the right pane -> **New** -> **String Value**.
        4. Name it `AutoRun`.
        5. Double-click it and set the value to: `doskey /macrofile="C:\Scripts\macros.doskey"`

---

#### What's Alt+Fn shortcuts in context of Windows?

In the context of Windows, **Alt + Fn** isn't a single "standard" shortcut like `Alt + Tab`. Instead, its behavior is determined by how your specific laptop or keyboard handles the **Function (Fn) key lock**.

To understand this, you have to look at how the **Fn** key acts as a "modifier" for the top row of your keyboard ( through ).


1. **The "Function Lock" Toggle**:

    On most modern laptops (Dell, HP, Lenovo), the  keys have two roles: **Media/System actions** (brightness, volume) and **Legacy F-actions** (standard Windows functions).

    * **If Fn-Lock is ON:** Pressing the top row acts as –.
    * **If Fn-Lock is OFF:** Pressing the top row adjusts volume/brightness. You must hold **Fn** to access the – functions.

    Therefore, `Alt + Fn + F4` is often required on laptops to perform the standard "Close Window" command if your Function keys are set to "Media Mode" by default.


1. **Common "Alt + Fn + [Key]" Combinations**:

    Depending on your hardware manufacturer, the combination of **Alt** and **Fn** usually unlocks these hidden hardware features:

    | Combination          | Typical Action                                                                                                   |
    | -------------------- | ---------------------------------------------------------------------------------------------------------------- |
    | **Alt + Fn + F4**    | **Force Close:** The laptop version of `Alt + F4`.                                                               |
    | **Alt + Fn + PrtSc** | **Partial Screenshot:** Captures only the active window (standard Windows behavior) while using the Fn modifier. |
    | **Alt + Fn + Space** | **Keyboard Backlight:** On many gaming laptops, this cycles through RGB or brightness levels.                    |
    | **Alt + Fn + Tab**   | **Screen Toggle:** On some older setups, this switches between external displays.                                |


3. **The "Legacy" Purpose: The Alt-Code Numpad**:

    On older laptops that do not have a dedicated Number Pad, the **Fn** key was used to turn the right side of the letter keys (7, 8, 9, U, I, O, etc.) into a virtual Numpad.

    * **The Trick:** Holding **Alt + Fn** allowed users to type **Alt Codes** (special symbols like ™ or ©) by using the blue-labeled numbers on the letter keys.
    * *Example:* Holding `Alt + Fn` and typing `J-K-L` (which mapped to `1-2-3`) would input an ASCII character.


4. **How to change this behavior**:

    If you find it annoying to hold the **Fn** key every time you want to use a shortcut, you can usually swap the behavior:

    1. **Fn + Esc:** On many keyboards, this toggles "Fn Lock" globally.
    2. **BIOS Settings:** You can switch "Function Key Mode" to "Legacy" or "Multimedia" in the BIOS/UEFI.
    3. **Windows Mobility Center:** Press `Win + X` > `Mobility Center` to toggle the Function Key row on some brands.

Summary: **The "Peer" Take**:

    Basically, `Alt + Fn` isn't a secret Windows feature—it's a **hardware necessity**. If your laptop defaults to "Mute" when you press , then `Alt + Fn + F4` becomes your new best friend for closing frozen apps.

---

#### What's Ctrl+Shift+letter shortcuts in context of Windows?

In Windows, the **Ctrl + Shift + [Letter]** combination is typically reserved for "High-Level" or "Power User" actions. While standard `Ctrl + [Letter]` shortcuts perform basic tasks (like Copy or Paste), adding the **Shift** key usually signifies an **inverse action**, a **secondary version** of the command, or a **system-level** tool.

1. **The "Big Three" Productivity Shortcuts**:These are the most universal shortcuts across Windows and most web browsers (Chrome, Edge).

    * **Ctrl + Shift + T (Reopen Closed Tab):** The "Life Saver." In any browser, this opens the last tab you accidentally closed. Pressing it multiple times keeps bringing back older tabs.
    * **Ctrl + Shift + N (New Incognito/Private Window):** Opens a new browsing session that doesn't save history or cookies.
    * *Desktop alternative:* On the Windows Desktop, this creates a **New Folder** instantly.


    * **Ctrl + Shift + Esc (Task Manager):** The direct route. Unlike `Ctrl + Alt + Del` (which brings up a full-screen menu), this launches the Task Manager immediately onto your current screen.

2. **Text Editing & Formatting**:If you are working in Word, Outlook, or a code editor, these shortcuts provide advanced control over text.

    | Shortcut                 | Action                                                                                       |
    | ------------------------ | -------------------------------------------------------------------------------------------- |
    | **Ctrl + Shift + V**     | **Paste as Plain Text:** Pastes content without any original formatting (bold, links, etc.). |
    | **Ctrl + Shift + > / <** | **Increase/Decrease Font Size:** Rapidly scales text up or down in most editors.             |
    | **Ctrl + Shift + L**     | **Bulleted List:** Instantly starts a bulleted list in many Microsoft apps.                  |
    | **Ctrl + Shift + Z**     | **Redo:** The opposite of Undo (`Ctrl + Z`).                                                 |

3. **Screen & Navigation Shortcuts**:These shortcuts help manage your display and how you interact with the OS.

    * **Ctrl + Shift + Win + B:** **Reset Graphics Driver.** If your screen freezes or goes black, this "wakes up" the video driver. You will hear a beep, and the screen will flicker.
    * **Ctrl + Shift + S (OneNote/Snipping Tool):** Depending on your version, this can trigger a partial screen snip (though `Win + Shift + S` is now the standard).

4. **Developer & Browser Tools**:For web developers or those troubleshooting sites, these are essential:

    * **Ctrl + Shift + I (Inspect):** Opens the Developer Tools (Elements, Console, Network) in browsers.
    * **Ctrl + Shift + R (Hard Refresh):** Reloads the current page and **clears the cache** for that specific site. Use this if a website looks "broken" after an update.
    * **Ctrl + Shift + Del (Clear Browsing Data):** A shortcut to the menu for deleting history, cookies, and cache.

-   **Summary Checklist**:

    | If you want to...       | Use this...               |
    | ----------------------- | ------------------------- |
    | **Fix a mistake**       | `Ctrl + Shift + Z` (Redo) |
    | **Fix a frozen screen** | `Ctrl + Shift + Win + B`  |
    | **Fix a closed tab**    | `Ctrl + Shift + T`        |
    | **Fix a slow PC**       | `Ctrl + Shift + Esc`      |

> **Peer Tip:** If you ever find your keyboard typing weird symbols (like `@` becoming `"`), you likely hit **Ctrl + Shift** by accident—this is the default shortcut to **switch keyboard languages/layouts**. Pressing it again usually fixes it!
