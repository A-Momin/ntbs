-   𝑳𝒊𝒔𝒕 𝒐𝒇 𝐔𝐬𝐞𝐟𝐮𝐥𝐥 𝑺𝒚𝒎𝒃𝒐𝒍𝒔: ⮐ ⎇ ⬆︎ ⌘ ⌥ + ⌃ + ⤶ ⇧  ⤶ ⬋ ↩︎ ↲ ↵ ↫ ⭿ ♥ ★ 🎾 & 🔥

---

<details><summary style="font-size:25px;color:Orange;text-align:left">Terms and Concepts</summary>

-   **Buffer**: A buffer is the in-memory representation of a file being edited. Multiple buffers can exist simultaneously, and you can switch between them.
-   **Window**: A window is a viewport onto a buffer. Neovim can split the editing area into multiple windows, allowing you to view and edit different parts of the same or different buffers.
-   **Registers**: Registers are storage spaces that hold text. They can be used to yank (copy) and put (paste) text.
-   **Tab Page**: A tab page is a collection of windows. You can have multiple tab pages, and each tab page can contain a different arrangement of windows.
-   **Mode**: Neovim has different modes, including **Normal Mode** (for navigating and manipulating text), **Insert Mode** (for inserting and editing text), **Visual Mode** (for selecting text), and more.
-   **Command-line mode**: Neovim has a command-line mode where you can execute various commands, such as saving files, searching, and running external commands.
-   **Operator-Pending mode**: This mode follows an operator command and awaits a motion or text object to operate on. For example, d (delete) in Normal mode followed by w (word) operates on a word.
-   **Mappings**: Mappings allow you to define custom keybindings for various actions. They are defined in the configuration file (usually init.vim or init.lua).
-   **Plugins**: Neovim supports plugins to extend its functionality. Plugins can be managed using package managers like vim-plug or dein.vim.
-   **Configuration file**: Neovim's configuration is typically stored in a file named init.vim for Vimscript or init.lua for Lua. This file contains settings, mappings, and plugin configurations.
-   **Autocommands**: Autocommands are events triggered automatically by Neovim. You can attach commands or scripts to these events, such as running commands on file read or write.
-   **Syntax highlighting**: Neovim provides syntax highlighting for various file types. Syntax files define how different elements of the code are highlighted.
-   **LSP (Language Server Protocol)**: Neovim supports the LSP for enhanced language-aware features such as autocompletion, linting, and code navigation.
-   **Terminals**: Neovim has built-in terminal emulation, allowing you to run a terminal inside a Neovim window.
-   **Folds**: Folding allows you to collapse or hide sections of code for a clearer view. You can fold and unfold sections based on various criteria.
-   **Remote plugins**: Neovim supports remote plugins, which enables running plugins as separate processes to enhance stability and performance.
</details>

---

<details open><summary style="font-size:25px;color:Orange;text-align:left">Vim Shortcutes</summary>

-   `<Space> n` → Toggle folder/file explorer
-   `<Space> t` → Toggle Tagbar
-   `<Space> m` → Toggle mouse ON/OFF
-   `⌃ + w` + `→/←/↑/⬇️` → Shift focus across vim pane.
-   How to comment out multiple lines?
    -   mark lines needed to be commented
    -   `:/s/^/#` → substitute starting of marked lines by `#`

### MUST-KNOW:

-   `:q! or ZQ` → Quit and throw away unsaved changes
-   `:q` → Quit (fails if there are unsaved changes)
-   `:w` → Write (save) the file, but don’t exit
-   `:w !sudo tee %` → Write out the current file using sudo
-   `:wq` / `:x` / `ZZ` → Write (save) and quit
-   `:source %` → source (`run`) the current file (lua files) you are working on.
-   `i + gt` (i in [1-9]) → Focus i-th buffer (Vim Tab)
-   `<SPACE>` + `[` / `]` → Changes the focus across the Buffer (Vim Tab)
-   Usage of: `f,t,w,b,%,h,j,k,l`
-   `v` → to select range of text
    -   After selecting the text, try d to delete, or y to copy, or :s/match/replace/, or :center, or !sort, or...
-   🔥`⬆︎ + v` → to select a line.
-   `⌃ + v` → to select columns of text
-   `yiw` → copy the word where the curson on
-   `:m 12` → move current line to after line 12
-   `:5,7m 21` → move lines 5, 6 and 7 to after line 21
-   `:/pattern + ⮐` → Highlight the pattern.
    -   `n` / `shift+n` → to hop over the highlighted patterns.
-   `shift + *`/`shift + #` → Search for the word currently cursor is in.Repeat to get the next/previous occurance
-   `x` → to cut character.
-   `g;` → to go through changes in backward
-   `g,` → to go through changes in forword
-   `~` → to switch cases
-   `:changes` → to see all the changes
-   `:jumps`

🔥 Tip: Prefix a cursor movement command with a number to repeat it. For example, `4j` moves down 4 lines.

### ENTERING INTO INSERT MODE:

-   `🔥 a` → Insert (append) `after the focused character`.
-   `🔥 A` → Insert (append) `at the end of the line`
-   `🔥 i` → Insert `before the focused character`.
-   `🔥 I` → Insert at the `beginning of the line`
-   `🔥 o` → Append (open) a new line `below the current line`.
-   `🔥 O` → Append (open) a new line `above the current line`.
-   `ea` → Insert (append) `at the end of the word`
-   `Esc` → Exit insert mode

### CUT AND PASTE IN NORMAL MODE:

-   `yy` → Yank (copy) a line
-   `2yy` → Yank (copy) 2 lines
-   `yw` → Yank (copy) the characters of the word from the cursor position to the start of the next word
-   `y$` → Yank (copy) to end of line
-   `:%y+` → Yank the whole file
-   `p` → Put (paste) the clipboard after focused character.
-   `P` → Put (paste) before focused character.
-   `dd` → Delete (cut) a line
-   `2dd` → Delete (cut) 2 lines
-   `dw` → Delete (cut) the characters of the word from the cursor position to the start of the next word
-   `D` → Delete (cut) to the end of the line
-   `d$` → Delete (cut) to the end of the line
-   `x` → Delete (cut) character

### EDITING IN NORMAL MODE:

-   `V` → Sellect the line of which the cursor is on
-   `🔥 J` → join line below to the current line
-   `🔥 u` → undo
-   `🔥 Ctrl + r` → redo
-   `🔥 .` → repeat last command
-   `r` → replace a single character
-   `cc` → change (replace) entire line
-   `cw` → change (replace) to the end of the word
-   `c$` → Change (replace) to the end of the line
-   `s` → Delete character and substitute text
-   `S` → Delete line and substitute text (same as cc)
-   `🔥 xp` → Transpose two letters (delete and paste)

### CURSOR MOVEMENTS:

-   `h`/`j`/`k`/`l` → Move cursor Left/Down/Up/Right
-   `H`/`M`/`L` → Move to Top/Middle/Bottom of screen
-   `🔥 w` → Jump forwards to the start of a word
-   `W` → Jump forwards to the start of a word (words can contain punctuation)
-   `🔥 e` → Jump forwards to the end of a word
-   `E` → Jump forwards to the end of a word (words can contain punctuation)
-   `b` → Jump backwards to the start of a word
-   `B` → Jump backwards to the start of a word (words can contain punctuation)
-   `0` → Jump to the start of the line
-   `🔥 ^` → Jump to the first non-blank character of the line
-   `🔥 $` → Jump to the end of the line
-   `🔥 g_` → Jump to the last non-blank character of the line
-   `🔥 gg` → Go to the first line of the document
-   `🔥 G` → Go to the last line of the document
-   `🔥 5G` → Go to line 5
-   `🔥 fx` → Jump to next occurrence of character x
-   `🔥 tx` → Jump to before next occurrence of character x
-   `}` → Jump to next paragraph (or function/block, when editing code)
-   `{` → Jump to previous paragraph (or function/block, when editing code)
-   `zz` → Center cursor on screen
-   `Ctrl + b` → Move back one full screen
-   `Ctrl + f` → Move forward one full screen
-   `🔥 Ctrl + d` → Move forward 1/2 a screen
-   `🔥 Ctrl + u` → Move back 1/2 a screen

### VISUAL COMMANDS:

-   `>` → Shift text right
-   `<` → Shift text left
-   `y` → Yank (copy) marked text
-   `d` → Delete marked text
-   `🔥 ~` → Switch case

### SEARCH AND REPLACE:

-   `🔥 /pattern` → Search for pattern
-   `🔥 ?pattern` → Search backward for pattern
-   `\vpattern` → ‘Very magic’ pattern: non-alphanumeric characters are interpreted as special regex symbols (no escaping needed)
-   `n` → Repeat search in same direction
-   `N` → Repeat search in opposite direction
-   `:/pattern + ⮐` → Highlight the pattern.
    -   `n` / `shift+n` → to hop over the highlighted patterns.
-   `shift + *`/`shift + #` → Search for the word currently cursor is in.Repeat to get the next/previous occurance
-   `🔥 :%s/old/new/g` → Replace all old with new throughout file
-   `🔥 :%s/old/new/gc` → Replace all 'old' with 'new' throughout file with confirmations
-   `:noh` → Highlighting of search matches

### SEARCH IN MULTIPLE FILES:

-   `:vim[grep] /pattern/ {`{file}`}`
-   `:vimgrep /pattern/ {file}` → Search for pattern in multiple files (EX: `:vimgrep /foo/ **/*`)
-   `:cn` → Jump to the next match
-   `:cp` → Jump to the previous match
-   `:copen` → Open a window containing the list of matches

### WORKING WITH MULTIPLE FILES:

-   `:e file` → Edit a file in a new buffer
-   `:bnext or :bn` → Go to the next buffer
-   `:bprev or :bp` → Go to the previous buffer
-   `:bd` → Delete a buffer (close a file)
-   `:ls` → List all open buffers
-   `:sp file` → Open a file in a new buffer and split window
-   `:vsp file` → Open a file in a new buffer and vertically split window
-   `Ctrl + ws` → Split window
-   `Ctrl + ww` → Switch windows
-   `Ctrl + wq` → Quit a window
-   `Ctrl + wv` → Split window vertically
-   `Ctrl + wh` → Move cursor to the left window (vertical split)
-   `Ctrl + wl` → Move cursor to the right window (vertical split)
-   `Ctrl + wj` → Move cursor to the window below (horizontal split)
-   `Ctrl + wk` → Move cursor to the window above (horizontal split)

### TAB OPERATIONS:

-   `🔥 :tabnew or :tabnew file`
    -   open a file in a new tab
-   `Ctrl + wT`
    -   move the current split window into its own tab
-   `🔥 gt or :tabnext or :`tabn
    -   move to the next tab
-   `🔥 gT or :tabprev or :tabp`
    -   move to the previous tab
-   `🔥 #gt`
    -   move to tab number #
-   `:tabmove #`
    -   move current tab to the #th position (indexed from 0)
-   `🔥 :tabclose or :tabc`
    -   close the current tab and all its windows
-   `:tabonly or :tabo`
    -   close all tabs except for the current one
-   `:tabdo command`
    -   run the command on all tabs (e.g. :tabdo q
    -   closes all opened tabs)

### MARKING TEXT (VISUAL MODE):

-   `v` → Start visual mode, mark lines, then perform an operation (such as d-delete)
-   `V` → Start linewise visual mode
-   `Ctrl + v` → Start blockwise visual mode
-   `o` → Move to the other end of marked area
-   `O` → Move to other corner of block
-   `aw` → Mark a word
-   `ab` → A block with ()
-   `aB` → A block with {}
-   `ib` → Inner block with ()
-   `iB` → Inner block with {}
-   `Esc` → Exit visual mode

### GLOBAL:

-   `:help keyword` → Open help for keyword
-   `:o file` → Open file
-   `:saveas file` → Save file as
-   `:close` → Close current window

### REGISTERS:

-   `:reg` → Show registers content
-   `"xy` → Yank into register x
-   `"xp` → Paste contents of register x

-   Tip: Registers are being stored in ~/.viminfo, and will be loaded again on next restart of vim.
-   Tip: Register 0 contains always the value of the last yank command.

### MARKS:

-   `:marks` → List of marks
-   `ma` → Set current position for mark A
-   ``a` → Jump to position of mark A
-   `y`a` → Yank text to position of mark A

### MACROS:

-   `qa` → Record macro a
-   `q` → Stop recording macro
-   `@a` → Run macro a
-   `@@` → Rerun last run macro

</details>

<details>
<summary style="font-size:25px;color:Orange;text-align:left">Vim Configuration</summary>

### Refferences:

-   [[notes_vim2]]
-   ref: https://realpython.com/vim-and-python-a-match-made-in-heaven/
-   🔥 🔥 ref: https://stackoverflow.com/questions/5400806/what-are-the-most-used-vim-commands-keypresses/5400978#5400978
-   🔥 ref: https://www.radford.edu/~mhtay/CPSC120/VIM_Editor_Commands.htm

-   [10 Advanced Vim Features](https://www.youtube.com/watch?v=gccGjwTZA7k)
-   [My Favorite Vim Tricks](https://www.youtube.com/watch?v=B-EPvfxcgl0&t=290s)
-   [50+ Vim Tips and Tricks from Beginner to Expert](https://www.youtube.com/watch?v=ZEIpdC_klDI)

### Tutorials:

-   [NeuralNine/Awesome Neovim Setup From Scratch - Full Guide](https://www.youtube.com/watch?v=JWReY93Vl6g)
-   [Neovim from Scratch](https://www.youtube.com/playlist?list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ)
    -   [LunarVim/Neovim-from-scratch](https://github.com/LunarVim/Neovim-from-scratch)
-   [Neovim](https://www.youtube.com/playlist?list=PLhoH5vyxr6QqPtKMp03pcJd_Vg8FZ0rtg)
-   [Vimscript](https://www.youtube.com/watch?v=px74GhBAG9I)
-   [Learn Vimscript the Hard Way](https://learnvimscriptthehardway.stevelosh.com/)
-   [Vim Configurations](https://www.youtube.com/watch?v=n9k9scbTuvQ&list=PLm323Lc7iSW9kRCuzB3J_h7vPjIDedplM&index=4):
-   [NeoVim Configuration](https://www.youtube.com/watch?v=DogKdiRx7ls&t=516s):

-   [NeuralNine/Vim](https://www.youtube.com/playlist?list=PL7yh-TELLS1Eevqs4-XmlSfrFOKb5C97K)
    -   [GitHub/config](https://github.com/NeuralNine/config-files)

### Config Files

-   vim:
    -   `~/.vimrc` → Configuration file for `vim`.
    -   `vim +PlugInstall +qall` → Install vim/nvim plugins from terminal.
-   nvim:
    -   `~/.config/nvim/init.vim` → Configuration File for `Neovim`.
    -   `~/.config/nvim/plugged` → Plug-ins Folder for `Neovim`.
    -   `nvim +PlugInstall +qall` → Install vim/nvim plugins from terminal.
    -   `~/.local/share/nvim/site/autoload/plug.vim` → Autoload file for `Neovim`

**NOTES**

-   `:version` → Spits out which version of vim you are using.
-   `:options` → Seeking help on options
-   `:h tabstop` → Seeking help on 'tabstop' option.
-   `:echo has('python3')`
-   `:checkhealth`

-   How to use vim-plug:

    -   Download the vim plugins manager called **[vim-plug](https://github.com/junegunn/vim-plug)** from git hub. Then use following comands to manage your vim plugins.
    -   `~/.config/nvim/plugged` → Plug-ins Folder for `Neovim`.
    -   `:PlugInstall` → Install plugins
    -   `:PlugUpdate` → Update plugins：
    -   `:PlugClean` → Remove plugins： (Before run this command, comment the plugin install command in init.vim)
    -   `:PlugStatus` → Check the plugin status：
    -   `:PlugUpgrade` → Upgrade vim-plug itself：

-   How to use [COC (Conquer of Completion) commands]():

    -   `:CocConfig`
    -   `CocInstall coc-python`
    -   `CocCommand`

    -   `:! python file_name.py` → Run python file from vim.
    -   `: echo has('clipboard')`

    -   `:help popupmenu-completion`
    -   `:help popupmenu-keys`
    -   `$ brew install ctags`

### [Technical Problems](https://superuser.com/questions/1115159/how-do-i-install-vim-on-osx-with-python-3-support):

#### Python Integration of Vim:

-   [A setup for python](https://github.com/Optixal/neovim-init.vim)
-   [Setup Neovim for Python](https://yufanlu.net/2018/09/03/neovim-python/)
-   [Python in Vim](https://jdhao.github.io/2019/04/22/mix_python_and_vim_script/):
-   [Vim as an Python IDE](https://medium.com/nerd-for-tech/vim-as-an-ide-for-python-2021-f922da6d2cfe)

## </details>

---

<details><summary style="font-size:25px;color:Orange;text-align:left">Register in Vim</summary>

In **Vim**, a **register** is a location in memory where text can be temporarily stored for operations like copying, cutting, pasting, or executing commands. Registers act like named "containers" for storing text and commands. Understanding registers is crucial for efficient editing in Vim, especially for managing multiple pieces of text or macros.

#### Types of Registers in Vim

Vim provides several types of registers, each serving a specific purpose:

1. **Unnamed Register (`"`):**

    - The default register used for most operations.
    - Stores the last yanked (copied), deleted, or changed text.
    - You can paste from this register using the `p` or `P` commands.

2. **Named Registers (`a` to `z` and `A` to `Z`):**

    - Store specific pieces of text, accessible by name.
    - Lowercase (`a` to `z`): Overwrite content when used.
    - Uppercase (`A` to `Z`): Append to the existing content in the corresponding lowercase register.
    - Example:
        - Yank text to register `a`:
            ```vim
            "ay
            ```
        - Paste from register `a`:
            ```vim
            "ap
            ```

3. **Numbered Registers (`0` to `9`):**

    - **Register `0`**: Stores the most recently yanked text (not deleted).
    - **Registers `1` to `9`**: Store deleted or changed text in chronological order.
    - Example:
        - Paste from register `1`:
            ```vim
            "1p
            ```

4. **Read-Only Registers:**

    - **`%`**: Stores the current file name.
    - **`#`**: Stores the alternate file name.
    - **`:`**: Stores the last executed Ex command.
    - **`/`**: Stores the last search pattern.
    - Example:
        - Paste the current file name:
            ```vim
            :e <C-r>%
            ```

5. **Expression Register (`=`):**

    - Allows you to evaluate and paste the result of a Vim expression.
    - Example:
        - Paste the result of `3 + 5`:
            ```vim
            <C-r>=3+5<CR>
            ```

6. **Black Hole Register (`_`):**

    - Deletes text without saving it anywhere.
    - Example:
        - Delete a line without storing it in any register:
            ```vim
            "_dd
            ```

7. **System Clipboard Registers (`+` and `*`):**

    - **`+`**: Represents the system clipboard.
    - **`*`**: Represents the primary selection (on Linux, primarily).
    - Example:
        - Yank to the system clipboard:
            ```vim
            "+y
            ```

8. **Small Delete Register (`-`):**
    - Stores small deletes (fewer than one line).
    - Automatically used for commands like `x` or `dl`.

#### How to Use Registers

1. **Yanking into a Register:**
   Use `"[register]y` to copy text into a specific register.  
   Example:

    ```vim
    "ay
    ```

    Copies text into register `a`.

2. **Pasting from a Register:**
   Use `"[register]p` to paste text from a specific register.  
   Example:

    ```vim
    "ap
    ```

    Pastes text from register `a`.

3. **Deleting into a Register:**
   Use `"[register]d` to delete text into a specific register.  
   Example:

    ```vim
    "ad
    ```

    Deletes text into register `a`.

4. **Viewing All Registers:**
   To see the content of all registers, use the command:

    ```vim
    :registers
    ```

5. **Appending Text to a Register:**
   Use an uppercase register to append text to its lowercase counterpart.  
   Example:
    ```vim
    "Ay
    ```
    Appends yanked text to register `a`.

#### Why Registers Are Useful

-   **Multi-text Management**: Store and reuse multiple pieces of text simultaneously.
-   **Macro Execution**: Store and execute sequences of commands.
-   **Clipboard Integration**: Easily interact with the system clipboard.
-   **Non-destructive Deletions**: Avoid overwriting important text by specifying a register.

By mastering Vim registers, you can significantly improve your text editing efficiency and take full advantage of Vim's powerful features!

</details>

---

<details><summary style="font-size:25px;color:Orange;text-align:left">Macro in Vim</summary>

A **macro** in Vim is a recorded sequence of commands that can be played back to automate repetitive tasks. By recording a macro, you can save a series of keystrokes and then replay them as many times as needed, which is especially useful for repetitive text editing or formatting tasks.

### How Macros Work in Vim

1. **Recording**: The macro captures the sequence of commands you type.
2. **Storing**: The recorded macro is stored in a specific register.
3. **Replaying**: You can replay the macro on demand, either once or multiple times.

### How to Use Macros

#### 1. **Recording a Macro**

-   Use the `q` command to start recording:

    ```vim
    q<register>
    ```

    -   Replace `<register>` with a letter (e.g., `a`, `b`, etc.) to specify the register where the macro will be saved.
    -   While recording, all your keystrokes are stored in the specified register.

-   Example:
    ```vim
    qa
    ```
    -   Starts recording into register `a`.

#### 2. **Stop Recording**

-   Press `q` again to stop recording:
    ```vim
    q
    ```

#### 3. **Play Back a Macro**

-   Use the `@` command to play the macro:

    ```vim
    @<register>
    ```

    -   Replace `<register>` with the register where the macro was saved.

-   Example:
    ```vim
    @a
    ```
    -   Plays back the macro stored in register `a`.

#### 4. **Repeat the Last Macro**

-   Use `@@` to repeat the last played macro:
    ```vim
    @@
    ```

### Practical Example

#### Scenario:

You have the following text:

```
apple
banana
cherry
```

You want to add `-fruit` to the end of each line.

#### Steps:

1. **Start Recording**:

    - Move to the first line.
    - Press:
        ```vim
        qa
        ```
        (Starts recording into register `a`.)

2. **Perform the Actions**:

    - Move to the end of the line (`$`).
    - Insert `-fruit` (`A-fruit`).
    - Move to the next line (`j`).

3. **Stop Recording**:

    - Press:
        ```vim
        q
        ```

4. **Replay the Macro**:

    - Go to the next line and press:
        ```vim
        @a
        ```
        (Plays the macro on the second line.)

5. **Repeat the Macro**:
    - Use:
        ```vim
        @@
        ```
        (Repeats the macro on the third line.)

### Advanced Usage

1. **Execute Macro Multiple Times**:

    - Use a number before `@` to execute the macro multiple times:
        ```vim
        5@a
        ```
        (Executes the macro stored in `a` five times.)

2. **Edit or Modify a Macro**:

    - View the macro by checking the content of its register:
        ```vim
        :register a
        ```
    - Modify the content by overwriting or appending to the register.

3. **Nested Macros**:

    - A macro can call another macro using the `@` command inside it. Be careful to avoid infinite loops.

4. **Save Macros Across Sessions**:
    - Macros are temporary and stored in registers, so they are lost when Vim is closed. To save them:
        - Write the macro content to your `.vimrc` file or a script file.

### Best Practices

-   **Use Descriptive Registers**: Use meaningful register names (e.g., `qf` for a macro related to formatting).
-   **Plan Your Commands**: Before recording, think through the sequence of commands to avoid mistakes.
-   **Test on a Small Sample**: Test the macro on one line or a small section before applying it to the entire file.

### Benefits of Using Macros

-   **Save Time**: Automates repetitive tasks.
-   **Reduce Errors**: Ensures consistency in repetitive edits.
-   **Easy to Use**: No need to write a custom script; just record and replay.

Mastering macros in Vim can significantly enhance your productivity and efficiency, making repetitive tasks quick and painless! Let me know if you'd like examples of more complex macro use cases.

</details>

---

<details><summary style="font-size:25px;color:Orange;text-align:left">Tmux</summary>

<b style="font-size:25px;color:Red"> NOTE: Currently it's unknown how to copy text from tmux window</b>

-   `$ tmux -V`
-   `$ tmux source-file ~/.tmux.conf`

</details>
