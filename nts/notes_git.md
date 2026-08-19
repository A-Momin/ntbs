-   `$ brew install git-lfs`

-   **GIT TUTORIALS**:
    -   [Git MERGE vs REBASE: Everything You Need to Know](https://www.youtube.com/watch?v=0chZFIZLR_0)
    -   [Learn Git with Bitbucket Cloud](https://www.atlassian.com/git/tutorials/learn-git-with-bitbucket-cloud)
    -   [Udacity: How to Use Git and GitHub](https://www.youtube.com/playlist?list=PLAwxTw4SYaPk8_-6IGxJtD3i2QAu5_s_p)
    -   https://git-scm.com/docs


-   <details><summary style="font-size:25px;color:Orange;text-align:left">Git Terminology</summary>

    -   ![Git Push/Pull Cycle](/assets/git/git_cycle.png)
    -   ![Git Workflow](/assets/git/git_workflow.gif)

    #### KEY WORDS:

    -   **Working Directory**:

        -   The working directory is the directory on your local machine where you edit, create, delete, and organize files.
        -   It contains the current state of your project.

    -   **Staging Area (Index)**:

        -   The staging area, also known as the index or cache, is an intermediate area where you prepare changes for the next commit.
        -   Files are added to the staging area using the git add command before they are committed to the repository.

    -   **HEAD**:

        -   `HEAD`: Git’s way of referring to the current snapshot. Internally, the ‘git checkout’ command simply updates the HEAD to point to either the specified branch or commit. When it points to a branch, Git doesn’t complain, but when you check out a commit, it switches into a “detached HEAD” state.
        -   Head Pointer always points to the Active Branch. When it points to a branch, Git doesn’t complain, but when you check out a commit, it switches into a “detached HEAD” state.
        -   Detached Head

    -   **Remote**:

        -   In Git, a `remote` typically refers to a repository that is hosted on a separate server or location from your local repository. `Remote`s allow you to connect and interact with repositories that may be located on the internet or on another machine.
        -   `Remote`s can be repositories you contribute to, collaborate with, or simply synchronize your local repository with to stay up-to-date. Examples of popular `remote` hosting services include GitHub, GitLab, and Bitbucket.
        -   When you add a `remote` repository to your local Git configuration, you give it a name. Common names include "origin," "upstream," "fork," or any other descriptive name you choose.

    -   **`origin` vs `upstream`**

        -   **origin** is the **default name** for the remote repository that you cloned from. It’s where you typically **push your changes** and **pull updates** from.
        -   **upstream** is A **second remote** name typically used to point to the **original repository** when you’ve forked one. It’s where you **pull the latest changes from the main project** so your fork stays updated.

    -   **Master**: The default branch name in Git is master. For both `remote` and local repository.
    -   **Tag**: A **Tag** is a permanent "bookmark" pointing to a specific point in your repository's history. While branches move every time you add a new commit, a tag **stays put**. It is typically used to mark specific release points (like **v1.0** or **v2.1**).

        1. **When to use a Tag**: Think of tags as **milestones**. You shouldn't tag every commit, but you should tag significant moments:

            * **Software Releases:** Marking a version that is being deployed to production.
            * **Version History:** Keeping a record of what code was included in "v1.0.2" versus "v1.1.0."
            * **Major Milestones:** Marking the completion of a major project phase or a "Golden Master" build.

        2. **Creating a Tag**: There are two main types of tags: **Lightweight** (just a pointer) and **Annotated** (stored as full objects with a message, date, and creator). Annotated tags are recommended for public releases.

            * **Annotated Tag (Best Practice)**: `$ git tag -a v1.0 -m "Initial public release"`
            * **Lightweight Tag**: `$ git tag v1.0-lw`

        3. **Pushing Tags to a Server**: By default, `git push` does **not** send tags to remote servers like GitHub. You have to push them explicitly:

            -   `$ git push origin v1.0` -> Push a specific tag
            -   `$ git push origin --tags` -> Push all local tags

        4. **Listing and Deleting Tags**: 

            -   `$ git tag` -> List all tags
            -   `$ git tag -d v1.0` -> Delete a local tag

        5. **Tags vs. Branches**

            | Feature       | Git Tag                                   | Git Branch                                  |
            | ------------- | ----------------------------------------- | ------------------------------------------- |
            | **Movement**  | **Fixed.** It never changes once created. | **Active.** Moves forward with new commits. |
            | **Purpose**   | To mark a **version** or milestone.       | To develop **features** or fixes.           |
            | **Lifecycle** | Usually exists forever as a record.       | Usually deleted after merging.              |



    #### KEY Terminology

    -   **HEAD** Pointer: To understand Git, you can think of your project's history as a timeline of commits (snapshots of your code), and the **HEAD** pointer as a **"You Are Here"** marker on a map.

        > It is a reference that tells Git which commit, and which branch, you are currently working on in your local workspace.

        -   **How HEAD Works Locally**: In almost all cases, HEAD points directly to a **branch name** (like `main` or `feature-login`), and that branch name points to the **latest commit** on that branch.

            ```
            [Commit A] ───> [Commit B] ───> [Commit C]
                                            ▲
                                            │
                                        [  main  ]  <─── [ HEAD ]

            ```

            -   When you perform common Git actions, HEAD moves automatically:

                * **Making a new commit:** When you run `git commit`, Git records a new snapshot. Your active branch moves forward to this new commit, and **HEAD moves right along with it**.
                * **Switching branches:** When you run `git checkout feature-abc` or `git switch feature-abc`, HEAD detaches from your old branch and hooks onto the new one. Git immediately updates the files in your editor to match what that branch looks like.

        -   **What is a "Detached HEAD"?**: Sometimes you want to look at an old version of your code, so you checkout a specific commit hash instead of a branch name (e.g., `git checkout a1b2c3d`).

            > When you do this, Git will give you a warning that you are in a **"detached HEAD" state**. This simply means:

            * HEAD is now pointing **directly to a specific commit** instead of pointing to a branch name.
            * **The Risk:** You can look around and even make experimental changes here. However, if you make new commits while in a detached HEAD state, those commits aren't saved to any branch. If you switch back to `main`, those experimental commits will become "orphaned" and very difficult to find again.
            * *How to fix it:* If you made changes in a detached HEAD state that you want to keep, just run `git switch -c my-new-experimental-branch` to create a brand new branch right where HEAD is sitting.

        -   **The GitHub Context: Local vs. Remote HEAD**: Because Git is entirely decentralized, your **local HEAD** and GitHub’s **remote HEAD** operate independently until you sync them.

            * **Diverged HEADs:** You might be working on your laptop and make two new commits on your local `main` branch. Your local HEAD has moved forward. Meanwhile, on GitHub, the `main` branch is still sitting on the older commit.
            * **Syncing with Push/Pull:** When you run `git push`, you send your new commits to GitHub and tell the remote repository to advance its branch pointer to match your local HEAD.
            * **The Default Branch:** When you visit a repository on GitHub's website, the files you see on the main screen are determined by GitHub's `HEAD` definition for the default branch (usually `main` or `master`).

    -   **Tracking** and **Upstream**: In Git, "tracking" and "upstream" are the glue that connects your local environment to a remote server like GitHub. Without them, Git wouldn't know which branch on your computer belongs to which branch on the internet.

        1. **What is an "Upstream" Branch?**: An **upstream branch** is the authoritative version of a branch hosted on a remote repository (usually named `origin`). 

            -   When you clone a repository from GitHub, Git automatically sets up a relationship between your local `main` branch and the remote `origin/main` branch. In this relationship:
                -   **The Remote** `origin/main` is the **Upstream**.
                -   **The Local** `main` is the **Tracking Branch**.
            _   Think of the upstream as the "source of truth." When you run `git pull`, Git looks at the upstream to see what work you’re missing.

        2. **What is "Tracking"?**: **Tracking** is the active link between your local branch and its upstream counterpart. When a branch is "tracking" another, Git can provide helpful status updates, such as:
            -   *"Your branch is ahead of 'origin/main' by 2 commits."*
            -   *"Your branch is behind 'origin/main' by 5 commits."*
            -   Why does tracking matter?
                -   If your branch is tracking an upstream, you don't have to type out the full names every time. Instead of typing `git push origin feature-branch`, you can just type **`git push`**. Git already knows where it's supposed to go.

        3. **How to Set Upstream/Tracking**: Sometimes you create a branch locally that doesn't exist on GitHub yet. You have to tell Git to create the link manually.

            -   **The First Push**: When you push a new branch for the first time, use the `-u` (or `--set-upstream`) flag: `git push -u origin feature-name`
                -   *This creates the branch on GitHub AND links your local branch to it permanently.*

            -   **Checking Relationships**: To see which local branches are tracking which remotes, use: `git branch -vv`

        -   **Summary Table**

            | Term         | Definition                                           | Context                                                 |
            | :----------- | :--------------------------------------------------- | :------------------------------------------------------ |
            | **Upstream** | The "parent" branch on the remote server (GitHub).   | "I need to fetch the latest changes from **upstream**." |
            | **Tracking** | The ongoing connection between local and remote.     | "My local branch is **tracking** origin/main."          |
            | **Origin**   | The default nickname for your GitHub repository URL. | "Push my code to **origin**."                           |

    -   **Soft**/**Hard Reset**: A `reset` is a powerful tool used to undo changes by moving your current branch head to a specific commit.

        > To understand the difference between a **Soft** and a **Hard** reset, you first need to understand the three distinct trees or areas that Git manages on your local machine:

        1. **The Commit History (HEAD):** The timeline of recorded snapshots.
        2. **The Staging Area (Index):** The launchpad where files are prepared before a commit.
        3. **The Working Directory:** The actual files you are editing on your computer.

        -   **1. Git Reset --soft (Keep Your Work)**: A **Soft Reset** moves the `HEAD` pointer back to a previous commit, but it **does not touch your files**.

            * **What it does:** It undoes the *commit* action itself, but keeps all the changes you made staged and ready to go.
            * **The Result:** Your Working Directory and Staging Area remain exactly as they were. If you run `git status` right after, you will see your changes sitting in green, ready to be recommitted.
            * **Best Used For:** Squashing recent commits or fixing a typo in your last commit message. For example, if you made three messy commits and want to combine them into one clean commit:
            ```bash
            git reset --soft HEAD~3
            git commit -m "One clean commit message"

            ```

        -   **2. Git Reset --hard (Destroy Your Work)**: A **Hard Reset** is the nuclear option. It moves the `HEAD` pointer back to a previous commit and **completely overwrites everything else**.

            * **What it does:** It rolls back the Commit History, wipes out the Staging Area, and overwrites your Working Directory to match that exact past commit perfectly.
            * **The Result:** Any uncommitted changes, staged files, or commits made after that target commit are completely erased from your workspace.
            * **Best Used For:** Throwing away bad ideas and starting over. If you started hacking on a feature, completely broke the code, and just want to reset your local environment back to exactly how it looked at the last successful commit:
            ```bash
            git reset --hard HEAD

            ```

        -   **The GitHub Context: When to Reset (and When Not To)**: Because Git is local and GitHub is remote, using `git reset` introduces a golden rule regarding collaboration:

            > ⚠️ **Never perform a hard reset on a commit that has already been pushed to a shared GitHub repository.**

            * **The Local Problem:** If you do a hard reset locally and try to run a standard `git push`, GitHub will reject it. This happens because your local history is now *behind* the remote history.
            * **The Nuclear Push:** To force GitHub to accept your reset, you would have to use `git push --force`.
            * **The Team Consequence:** If your teammates have already pulled down those commits, forcing a rewrite of the GitHub history will break *their* local repositories, causing massive merge conflicts and headaches for the team.

            **The Alternative:** If you need to undo a commit that is already public on GitHub, use **`git revert <commit-id>`** instead. Revert doesn't rewrite history; it creates a brand new commit that does the exact opposite of the bad commit, making it safe for collaboration.

    -   **Fast-forward merge**: Fast-forward merge is the simplest and cleanest way to combine two branches. It occurs when the base branch (like main) hasn't had any new commits since you created your feature branch. Instead of creating a new "merge commit," Git simply moves the pointer of your current branch forward to the latest commit of the feature branch.

        -   **How it Works Visually**: Imagine your project is a book. You are on Page 10 (main) and you write Pages 11 and 12 on a separate notepad (feature). If nobody else wrote anything in the book while you were gone, you can just glue your new pages directly to the end of Page 10.

    -   **Divergent Branch**: A **divergent branch** situation arises when both your local branch and its corresponding remote branch have progressed independently since their last common commit. This means that new commits have been added to both branches, leading to separate lines of development. Here are the Causes of Divergence:

        -   `Local Commits`: You've made commits on your local branch that haven't been pushed to the remote repository.

        -   `Remote Commits`: Other collaborators have pushed commits to the remote branch that you haven't yet incorporated into your local branch.

        -   When you attempt to synchronize these branches using commands like `git pull` or `git push`, Git detects the divergence and requires guidance on how to reconcile the differences.

        -   **Resolving Divergent Branches**: To address this situation, you can choose from several strategies:

            1. `Merge (Default Strategy)`: Combines the remote changes with your local commits, creating a new merge commit.

                - `$ git pull --no-rebase`
                - `$ git config pull.rebase false` → Set Merge as Default

            2. `Rebase`: Reapplies your local commits on top of the remote branch, resulting in a linear commit history.

                - `$ git pull --rebase`
                - `$ git pull --rebase origin cpecs-12147`
                - `$ git config pull.rebase true` → Set Rebase as Default

            3. `Fast-Forward Only`: Updates your branch only if it can be fast-forwarded; otherwise, it aborts to prevent unintended merges.

    -   **Three-way merge**: A Three-way merge is how Git combines two branches that have diverged. Unlike a Fast-Forward merge (where one branch is just ahead of the other), a three-way merge occurs when both branches have new, unique commits since they last shared a common ancestor. It is called "three-way" because Git uses three specific snapshots to create the final result:

        -   **The Common Ancestor**: The last point where both branches were identical.
        -   **Branch A Tip**: The latest work on your current branch (e.g., main).
        -   **Branch B Tip**: The latest work on the branch you are pulling in (e.g., feature).

    -   **Merge Commit**: A Merge Commit is a special type of commit that combines the histories of two diverging branches. Unlike a standard commit, which has only one "parent," a merge commit has two or more parent commits. It acts as a symbolic knot that ties together independent lines of development, marking exactly when and how a feature was integrated back into a main branch.

        -   **When a Merge Commit happen**: A merge commit is created automatically during a Three-way Merge. This occurs when the branch you are merging into (e.g., main) has moved forward with new commits since you first branched off to start your work. Since Git can't just "fast-forward" the pointer in a straight line, it creates a new commit to reconcile the differences between:

            -   The tip of Branch A (main).
            -   The tip of Branch B (feature).
            -   The Common Ancestor where they first split.

    -   **Rebase**: **rebase** is an alternative to merging. While a merge joins two branches together with a "merge commit," a rebase rewrites your project history by moving your entire branch so that it begins at the tip of another branch.

        -   **When to use rebase**: Rebasing is most commonly used to keep a **clean, linear project history**. You should use it when:

            1. **Updating your local branch**: If you've been working on a feature for a few days and `main` has moved forward, you rebase your feature branch onto `main` to pull in the latest changes without an ugly "merge commit."
            2. **Cleaning up commits**: Before pushing your work for a Pull Request, you can use **Interactive Rebase** to combine (**squash**) small "fixed typo" commits into one clean, professional commit.
            3. **Maintaining a "No-Merge" policy**: Many professional teams prefer a linear history where every commit follows the previous one in a straight line.

        -   **The Standard Rebase**: If you are on your `feature` branch and want to pull in the latest from `main`:

            -   `$ git checkout feature & git rebase main` → This sequence of commands is a common workflow used to keep a feature branch up to date with the main branch. Instead of "merging" (which creates a new commit joining the two branches), rebasing literally "rewrites" your branch history by moving your unique work to sit on top of the latest changes from main.
            -   Git will "lift" your feature commits, move the starting point to the end of `main`, and then "replay" your commits one by one on top.

        -   **The Interactive Rebase (The "Cleanup" Tool)**: This is the most powerful version of the command. It lets you edit your history before others see it.

            -   `$ git rebase -i HEAD~3` → This opens an editor showing your last 3 commits. You can change the word `pick` to `squash` to combine them or `reword` to fix a typo in a commit message.

        -   **The Golden Rule of Rebasing**: Never rebase commits that you have already pushed to a public/shared server. Because rebasing **rewrites history** (it actually creates brand new commits with new IDs), if you rebase something that others are already working on, you will break their version of the repository. Only rebase work that is still local to your machine.

        -   **Rebase with Merge Conflict**

            -   `git pull --rebase origin develop` → fetch remote changes and replay your local commits on top.
            -   If a conflict occurs, Git pauses the rebase and shows the conflicted files.
            -   Use `git status` to see which files need attention and which commit is being applied.
            -   Open each conflicted file, resolve the `<<<<<<<`, `=======`, and `>>>>>>>` sections, then save the file.
            -   Stage the resolved files with `git add <file>`.
            -   Continue the rebase with `git rebase --continue`.
            -   If a conflict is too difficult or you want to abandon the rebase, use `git rebase --abort` to restore the branch to its original state.
            -   If you want to skip the current patch entirely, use `git rebase --skip`.
            -   `git rebase --edit-todo` lets you adjust the remaining rebase plan before continuing.
            -   Use `git diff` or `git diff --cached` to inspect unresolved changes during the rebase.
            -   For a cleaner workflow with local uncommitted changes, use `git pull --rebase --autostash` so Git temporarily stashes your work, rebases, then reapplies it.

    -   **Squashing**: In Git, **squashing** is the process of taking multiple commits and condensing them into a single, clean commit. Think of it as "editing" your history to remove the messy trail of small, intermediate changes before sharing your work with the rest of the team.

        1. **Why Squash?**

            -   During development, your commit history often looks like this:
                1. `Added initial login logic`
                2. `Fixed typo`
                3. `Forgot to add validation`
                4. `Actually fixed typo this time`
                5. `Finalized login feature`

            -   To a teammate reviewing your code, the "typo" commits are noise. Squashing allows you to combine all five into one professional commit: **"Implemented User Login with validation."**

        2. **Common Ways to Squash**

            -   **Method A: Interactive Rebase (The Manual Way)**: This is the most powerful method because it allows you to choose exactly which commits to merge.

                1. Run `git rebase -i HEAD~N` (where **N** is the number of commits you want to look back at).
                2. An editor opens. You'll see a list of commits starting with the word `pick`.
                3. Change `pick` to `squash` (or just `s`) for the commits you want to fold into the one above them.
                4. Save and close. Git will then ask you to write a new, combined commit message.

            -   **Method B: Merge with Squash (The "GitHub/GitLab" Way)**: When you are ready to merge a feature branch into `main`, you can squash everything at the point of the merge.

                ```bash
                git checkout main
                git merge --squash feature-branch
                git commit -m "Summarized feature description"
                ```

            -   **Result:** All changes from the feature branch are added to `main` as one single commit. The original history on the feature branch remains untouched.

        3. **Squash vs. Standard Merge**

            | Feature          | Standard Merge                                   | Squash Merge                                           |
            | ---------------- | ------------------------------------------------ | ------------------------------------------------------ |
            | **History**      | Preserves every single tiny commit.              | Creates one clean, summary commit.                     |
            | **Traceability** | Easy to see exactly *when* a bug was introduced. | Harder to see granular changes; cleaner "big picture." |
            | **Reverting**    | Can be complex to undo multiple commits.         | Very easy to undo (it's just one commit).              |
            | **Best For...**  | Long-running shared branches.                    | Feature branches and Pull Requests.                    |

        4. **Important Rules & Risks**

            * **Don't Squash Shared History:** Never squash commits that have already been pushed to a shared public branch (like `main`) that others are working on. This rewrites history and will cause "Git nightmares" for your teammates.
            * **The "Base" Commit:** When squashing via rebase, you always keep at least one `pick` at the top. You cannot squash the very first commit in the list into nothingness; it needs a "parent" to merge into.

    -   **Merge Conflict**: In Git, a **Merge Conflict** is an event that occurs when Git is unable to automatically reconcile differences between two commits. While Git is usually smart enough to combine changes from different branches, it stops and asks for help when it sees "competing" edits.

        1. **Why do Merge Conflicts happen?**: A conflict typically occurs in two scenarios:

           -    **Competing Content:** Two or more people change the same line(s) in the same file differently.
           -    **Structural Changes:** One person deletes a file while another person is busy editing it.

        2. **How to Identify a Conflict**: When you run `git merge <branch>`, Git will notify you:

            > `CONFLICT (content): Merge conflict in file_name.py`
            > `Automatic merge failed; fix conflicts and then commit the result.`

            If you open the conflicted file, you will see **Conflict Markers**:

            ```text
            <<<<<<< HEAD (Current change)
            print("Hello from the Main branch")
            =======
            print("Hello from the Feature branch")
            >>>>>>> feature-branch (Incoming change)
            ```

            * **`<<<<<<< HEAD`**: Start of the changes on your current branch.
            * **`=======`**: The divider between the two versions.
            * **`>>>>>>> branch-name`**: End of the changes from the branch you are trying to merge.

        -   **Step-by-Step Resolution**: 

            -   **Step 1: Locate the files**: Run `git status` to see a list of "Unmerged paths." These are your broken files.

            -   **Step 2: Decide which code to keep**: Open the file in a text editor (like VS Code). You have four choices:

                1. Keep **Current** (yours).
                2. Keep **Incoming** (theirs).
                3. Keep **Both** (by combining the lines).
                4. Write something entirely new.

                -   **Crucial:** You must delete the `<<<<<<<`, `=======`, and `>>>>>>>` lines manually.

            -   **Step 3: Stage the fix**: Tell Git you've resolved the issue by staging the file:

                -   `$ git add file_name.py`


            -   **Step 4: Complete the merge**: Finalize the process with a commit:

                -   `$ git commit -m "Resolved merge conflict in file_name.py"`

            -   **Pro Tools for Resolution**: : If manually editing text files feels "primitive," you can use a **Merge Tool** which provides a side-by-side 3-pane view (Local, Remote, and Result).

                * **VS Code:** Has a built-in "Merge Editor" with easy-to-click buttons.
                * **GitKraken:** A visual GUI that makes dragging and dropping changes very intuitive.
                * **`git mergetool`:** A command that launches external software like Meld, KDiff3, or P4Merge.

    -   **ISO (International Organization for Standardization)**:

        -   It's an independent, non-governmental international organization that develops and publishes standards to ensure quality, safety, efficiency, and interoperability.
        -   These standards are developed by experts from industry, government, and academia.

        -   **ISO Standards for Software Projects**: Some GitHub repositories, especially those focused on **security, compliance, or enterprise software**, might claim or work toward compliance with certain ISO standards.

            | ISO Standard      | Purpose                         | Relevance                                                    |
            | ----------------- | ------------------------------- | ------------------------------------------------------------ |
            | **ISO/IEC 27001** | Information Security Management | Used for security-focused projects or companies.             |
            | **ISO/IEC 9001**  | Quality Management              | Related to software QA and consistent delivery.              |
            | **ISO/IEC 25010** | Software Quality Model          | Defines characteristics like maintainability, security, etc. |
            | **ISO/IEC 12207** | Software Lifecycle Processes    | Describes software development processes.                    |

            These are typically mentioned in **README files**, **project documentation**, or **compliance badges**.

    -   **SHA**: SHA stands for Secure Hash Algorithm, usually referring to the SHA-1 hash Git uses to identify each object uniquely.

        -   Git stores everything (commits, trees, blobs, tags) as content-addressed objects.
        -   Each object is identified by a 40-character SHA-1 hash (e.g., 6a1c7ed6e0b8f64b32681d264c37df3e57b8d2fc).
        -   The commit SHA is used to refer to this specific commit uniquely.
        -   This hash is referred to as the commit SHA when talking about commits.

    -   **ref**: ref in Git is a human-readable pointer to a Git object, typically a commit. Refs include:

        -   Branches (e.g., refs/heads/main)
        -   Tags (e.g., refs/tags/v1.0)
        -   Remote branches (e.g., refs/remotes/origin/main)
        -   Special refs like `HEAD`
        -   These refs point to commit SHAs behind the scenes.
        -   When you run `git checkout main`, Git uses `refs/heads/main` to locate the corresponding SHA and check out the commit.
        -   On GitHub API:

            -   GitHub API endpoints often return or require ref and sha:

                ```json
                {
                    "ref": "refs/heads/main",
                    "node_id": "MDM6UmVmMTIzNDU6bWFzdGVy",
                    "url": "https://api.github.com/repos/user/repo/git/refs/heads/main",
                    "object": {
                        "sha": "6a1c7ed6e0b8f64b32681d264c37df3e57b8d2fc",
                        "type": "commit",
                        "url": "https://api.github.com/repos/user/repo/git/commits/6a1c7ed..."
                    }
                }
                ```

        </details>

---

-   <details><summary style="font-size:25px;color:Orange;text-align:left">Git Commands</summary>

    -   🔥**NOTES**:

        -   There generally are at least three copies of a project on your workstation:

            -   One copy is your own repository with your own commit history (the already saved one, so to say).
            -   The second copy is your working copy where you are editing and building (not committed yet to your repo).
            -   The third copy is your local “cached” copy of a `remote` repository (probably the original from where you cloned yours).

        -   You cannot delete the branch you are on.
        -   If you checkout a branch and then commits, the branch’s label autometically updates to the new commits.

    -   🔥**HELP**:

        -   `$ git --help`
        -   `$ git help -a`
        -   `$ git help -g`
        -   `$ git help <command>` -->> Ex: `git help add`, `git help reset`, `git help rm`
        -   `$ git help <concept>`
        -   `$ git help git`
        -   `$ git [options] commands [<args>]`

    ## Initialize/Clone Git Repository

    -   There are two methods to start a git projects:

        1. Cloning an Existing Repository from `www.github.com` using git command, (`$ git clone`)
        2. Initializing a Git Repository skeleton in the local machin using git command, (`$ git init`) then push it into a remote location such as `www.github.com` after establishing a link to the remote repository ,

    -   `$ git clone -b feature/development-2.0 https://github.com/user/my-repo.git` → To clone a repository named `my-repo` and immediately check out the branch named `feature/development-2.0`.
    -   `$ git clone https://github.com/repoName` → It creates a repository named `repoName`, initializes a `.git` directory inside it, pulls down all the data from that `main`/`master` branch of repository, and checks out a working copy of the latest version.
    -   `$ git clone --branch <branch_name> --single-branch <repository_url>` →

    -   `$ git init` → It creates a new subdirectory named .git that contains all of your necessary repository files – a Git repository skeleton.
    -   `$ git init <folder_name>` → It creates a new directory named folder_name in current directory and initialize a git repository – a Git Repository Skeleton - in it.
    -   `$ git remote add origin <URL>` → Add the repository, named ‘origin’, from the remote (GitHub) to the local machin through given ‘url’. Conventionaly the word ‘origin’ is used as the name of remote repository, but the link between the locally initialized git repository and the remote(GitHub) get established through the provided URL, not through the name of remote repository, ‘origin’
        `$ git remote add origin git@github.com:Aminul-Momin/TestingProj.git`
    -   `$ 🔥 git remote set-url origin git@github.com:Aminul-Momin/<repository_name>.git` → Updates the URL of the existing origin remote to a new repository address.
    -   `$ git remote set-url origin git@gh2:Aminul-Momin/project_name.git`
    -   `$ git remote set-url origin git@github.com:Aminul-Momin/Algorithms_and_Data_Structures.git` → to set remote origin url
    -   `$ git remote show origin` → Displays detailed information about the remote named `origin`, including its fetch and push URLs, tracking branches, and status.
    -   `$ git remote add upstream <URL>` → Adds a new remote named `upstream` pointing to the given `<URL>`, typically used to track the original repository if you’ve forked it.

    -   `$ git config --global --edit`
    -   `$ git config --global user.name 'Aminul Momin'`
    -   `$ git config --global user.email A.Momin.NYC@gmail.com`
    -   `$ git config --global init.defaultBranch <master_branch>` → setup the initial branch name to create in all new repositories.
    -   `$ git remote` → List out all the remote this git repo has been added to
    -   `$ git remote -v` → Listout all the remote’s URL this git repo has been added to

    -   `$ git branch --set-upstream-to=origin/develop NETSEC-11111` → a feature branch (like one named after a ticket number) tracks its corresponding branch on the remote (e.g., origin/NETSEC-11111). By setting the upstream to origin/develop, your future `git pull` and `git push` commands (without arguments) will interact directly with the develop branch.


    ## CONFIGURATIONS

    -   `$ git config edit --global` → Print the full path to the git command
    -   `$ Which git` → Print the full path to the git command
    -   `.git/config` → Git's local configuration file.
    -   `/usr/local/git/etc/gitconfig` → Git's Default configuration
    -   `~/.gitconfig` → Git's user configuration file
    -   `$ git config --local| --global --list` → List out the local or global configuration
    -   `$ git config --local| --global| --system --edit` → Edit local or global or system config file
    -   🔥 <bold style="color:orange">NOTES</bold>: When reading, the values are read from the system, global and repository local configuration files by default, and options `--system`, `--global`, `--local`, `--worktree` and `--file <filename>` can be used to tell the command to read from only that location (see FILES).
    -   `$ git config --get user.name` → Returns name of the current git user.
    -   `$ git config --get user.email` → Returns the email address of current git user.
    -   `$ git config --global core.editor code –wait [“subl –n -w”, emacs, “atom-wait”]` → Set globaly VisualStudioCode (`code`) as your code editor.
    -   `$ git config --global color.ui auto`
    -   `$ git config --local user.name 'Aminul Momin'` → Set localy user name configuration parameter. (`--local` can only be used inside a git repository)
    -   `$ git config --local user.email "bbcredcap3@gmail.com"`
    -   [Git and Vimdiff](https://medium.com/usevim/git-and-vimdiff-a762d72ced86)
    -   `$ git config --global diff.tool vimdiff` → Sets **`vimdiff`** as the **default tool for viewing diffs** globally (across all repositories). When you run `git difftool`, it will use `vimdiff` to show file differences.
    -   `$ git config --global merge.tool vimdiff` → Sets **`vimdiff`** as the **default tool for resolving merge conflicts** globally. When you run `git mergetool`, it will launch `vimdiff` for conflict resolution.
    -   `$ git config --local [user.email | author.name | author.email | committer.name | committer.email]`
    -   `$ git config user.name [author.name | author.email | committer.name | committer.email]` → Returns a specific key’s value ( here, key = user.name).

    -   <details open><summary style="font-size:20px;color:red;text-align:left">Troubleshoot Github Authenticatios</summary>

        -   `$ eval $(ssh-agent)` → Make sure 'ssh-agent' is running
        -   `$ 🔥 alias runsshagent='eval $(ssh-agent)'` → Make sure 'ssh-agent' is running
        -   `$ code .git/config` → Git Repo's local configuration file.

        -   `$ ssh-add -l` → list out all the keys added to the ssh agent.
        -   `$ ssh-add -d ~/.ssh/github_bbcredcap3` → Delete a key from SSH Agent
        -   `$ ssh-add ~/.ssh/github_bbcredcap3` → Add a key to SSH Agent

        -   `$ ssh -T git@github.com` → Test your Authentication/Connection into remote.
        -   `$ ssh -T git@gh1` → Test your Authentication/Connection into remote.
        -   `$ ssh -T git@gh2` → Test your Authentication/Connection into remote.
        -   `$ git remote show origin` → get the remote origin URL
        -   `$ git config --get remote.origin.url` → get the remote origin URL
        -   `$ git clone git@gh1:A-Momin/project_name.git` → Clone from perticular github account
        -   `$ git remote add origin git@gh1:A-Momin/drf.git`
        -   `$ git remote set-url origin git@gh1:A-Momin/drf.git`
        -   `$ git remote set-url origin git@gh2:Aminul-Momin/noteshub.git`
        -   `$ git remote set-url origin git@github.com:Aminul-Momin/noteshub.git`

        </details>

    ## RECORD & EXAMIN CHANGES

    -   `$ git diff develop --name-status` → shows the files that differ between your current working state and the develop branch, along with their change status.
    -   `$ git diff` → Difference between Working Directory and Staging Area
    -   `$ git diff --cached` → Show the difference between the index and the last commit.
    -   `$ git diff another_branch` → Show a diff between the current working directory and the named branch.
    -   `$ git diff --staged` → Difference between Staging Area and Repository.
    -   `$ git diff --stat` → Shows an overview of changes.
    -   `$ git diff other-branch path/to/this_file` → Shows diff of this_file between this and it's other branch.
    -   `$ git diff <commit_id1 commit_id2>` → Difference between two commits.
    -   `$ git show <commit_id>` → Show the changes in commits compared to it’s parrents
    -   `$ git log <command>`
    -   `$ git log --pretty=format:"[%h] %ae, %ar: %s" --stat` → Shows commit history with the files that were changed.
    -   `$ git log --help`
    -   `$ git log --statq`
    -   `$ git log --oneline`
    -   `$ git log --oneline --decorate`
    -   `$ git log --graph --oneline --decorate --all`
    -   `$ git add .` → Add changes of all files in the current & subdirectory to the Staging Area.
    -   `$ git commit` → Commit into the Repository.
    -   `$ git commit -m “Commit_Message”` → Commint into the Repository with Commit Message.

    -   `git diff`: It is the primary tool for viewing changes between different "states" of your project—such as your working directory, your staging area, or different branches.Here is how to use it in common scenarios:

        1. **View Unstaged Changes**: This is the most common use case. It shows you the changes you have made in your files that **have not yet been added** to the staging area (`git add`).
            -   `$ git diff`
            -   **Red text:** Lines that were removed.
            -   **Green text:** Lines that were added.

        2. **View Staged Changes**: If you have already run `git add`, a normal `git diff` will show nothing. To see what is sitting in the "waiting room" (staging area) ready to be committed, use:
            -   `$ git diff --staged`
            -   `$ gt diff --cached`

        3. **Compare Two Branches**: This is useful for seeing exactly what is different between your current feature and the main project.
            -   `$ git diff main..feature_branch`
            -   `$ git diff main..feature_branch path/to/file.txt` -> You can also compare a specific file across branches:

        4. **Compare Two Commits**: If you want to see what changed between two specific points in your project's history, use their commit hashes (shas).
            -   `$ git diff [commit_hash_1] [commit_hash_2]`

        5. **Summary and Formatting Options**: Sometimes the full output is too much. You can modify the view to be more concise:
            | Command                      | Result                                                                      |
            | ---------------------------- | --------------------------------------------------------------------------- |
            | **`git diff --stat`**        | Shows a summary of which files changed and how many lines.                  |
            | **`git diff --name-only`**   | Only lists the names of the files that have changed.                        |
            | **`git diff --color-words`** | Shows changes word-by-word instead of line-by-line (much cleaner for text). |

        -   **Pro-Tip: The "Three-Dot" Diff**: When you run `git diff main..feature`, you see all differences. If you run `git diff main...feature` (three dots), it shows the changes on the feature branch **since it diverged** from main. This is often what you actually want to see during a code review!


    ##### [git stash](https://www.youtube.com/watch?v=fXGug4itlTk)

    -   `git stash` temporarily shelves (or stashes) changes you've made to your working copy so you can work on something else, and then come back and re-apply them later on. Stashing is handy if you need to quickly switch context and work on something else, but you're mid-way through a code change and aren't quite ready to commit.
    -   You cannot directly apply a stash by its name — Git identifies stashes by their index (like `stash@{0}`), even if you gave them a custom message.

    -   `$ git stash show` → show the content of your most recent stash.
    -   `$ git stash show stash@{n}` → show the content of specified stash. (`n` is a integer and specefying stash-index)
    -   `$ git stash list` → List out all your repository's stashes.
    -   `$ git stash` → stash uncommited local changes
    -   `$ git stash push -m stash_name` → name and retrieve a Git stash by the name?
    -   `$ git stash apply stash@{n}` → To apply (bring back) specified stash. You cannot directly apply a stash by its name.
    -   `$ git stash pop stash@{n}` → pop (bring back and drop) specified stash - see `git stash list` 
    -   `$ git stash pop` → Popping your stash removes the changes from your stash and reapplies them to your working copy.
    -   `$ git stash drop stash@{n}` → drop specific stash.
    -

    ##### [Resetting, Reverting, and Checking Out](https://www.atlassian.com/git/tutorials/resetting-checking-out-and-reverting)

    -   [Undoing Commits & Changes](https://www.atlassian.com/git/tutorials/undoing-changes)
    -   🔥 [git checkout]()

        -   `$ git checkout <commit_id>`
        -   `$ git checkout master`
        -   `$ git checkout <file_name>` → Discard the specified file from Working Area.
        -   `$ git checkout .` → Discard all the changes to the Working Area.
        -   `$ git checkout -- <file_name>` → just want to discard your recent edits to return to the last committed state

    -   🔥 [git reset]()

        -   <font color="orange">How do I unstage changes?</font>

            -   `$ git checkout .` → discards all local changes in the working directory and resets the files to the latest committed state (HEAD); this does not affect untracked files.
            -   `$ git restore .` → restores all files in the current directory and subdirectories to their last committed state, effectively discarding all local changes; this is the modern replacement for `git checkout .`.
        -   `$ git restore <path/to/filefile_name>` → Discard all the changes of the file.
        -   `$ git restore --source=HEAD~1 -- <path/to/filefile_name>` → Restore a file to exactly how it was in the previous commit (i,e HEAD~1)
        -   `$ git restore --source <COMMIT_ID> <file_name>` → Revert the file to how it is in the specified commit.
        -   `$ git restore --staged <path/to/filefile_name>` → Reset the file in the staging area (Index) back to what's in HEAD (your last commit)
        -   `$ git clean -df` → Remove untracked directories/files from the working tree.
        -   `$ git rm --cached <file_name>` → Unstage the specified file (`file_name`) from Staging Area.
        -   `$ git rm --cached *_initial.py` → Unstage all the files name ended with `_initial.py` from Staging Area.
        -   `$ git rm -r --cached */migrations/` → Unstage all (`migrations/*`) files recursively from Staging Area. (`--cached` refere to 'Staging Area')

        -   <span style="color:orange">How to discard committed files? Extra care should be given using the reset command?</span>
            -   `$ git reset` → Removes all files from the staging area, but keeps the changes in your working directory. It effectively "unstages" all changes.
            -   `$ git reset HEAD <file_name>` → Unstage the specified file from Staging Area.
            -   `$ git reset HEAD */.` → Unstage all the file from Staging Area
            -   `$ git reset HEAD~3` → Discard the LAST THREE commit from Local Repository (Committing Area). Discarted file kept in Working Area
            -   `$ git reset --soft HEAD~3` → Discard the first three commit from Local Repository (Committing Area). Discarted file kept in Staging Area
            -   **$ git reset --hard** → It is used to reset the current commit or branch and the staging area to it's initial state or to a given commit. It moves the HEAD and the current branch pointer to the specified commit if given any.
            -   `$ git reset --hard HEAD~2`
            -   `$ git revert` → it's better to use `git revert` to create a new commit that undoes the changes made in the previous commit.
            -   <span style="color:orange">How to remove a commit from remote repository:</span>
                1. git reset <commit_id>
                2. git push origin master -f

    ## GIT BRANCHING & MEARGING FILES

    -   🔥 [git branch](https://www.atlassian.com/git/tutorials/using-branches)

        -   `$ git branch -h`
        -   `$ git branch -vv`
        -   `$ git checkout -h`
        -   `$ git branch –a` → Show all the name of branches that has been created so far.
        -   `$ git checkout -b <new_branch_name>` → Create & checkout the specified new_branch_name.
        -   `$ git branch <new_branch_name>` → Creates a brnch with the specified branch_name.
        -   `$ git branch –d <branch_name>` → Deleting a branch won’t delete the commits. It only deletes the label.
        -   `$ git branch –D <branch_name>` → Delete a branch.
        -   `$ git branch <branch_name> <commit_id>`
        -   `$ git checkout <branch_name>` → Checkout the specified branch_name.
        -   `$ git log –graph –onetime <branch_name1 branch_name2 … >` → Visulize the branches Structure
        -   `$ git branch --set-upstream-to=origin/develop NETSEC-11111` → a feature branch (like one named after a ticket number) **tracks** its corresponding branch on the remote (e.g., origin/NETSEC-11111). By setting the upstream to origin/develop, your future `git pull` and `git push` commands (without arguments) will interact directly with the develop branch.

    -   🔥 TAG:

        -   `$ git tag` → List out all tags created fo far.
        -   `$ git tag BASELINE` → Create the 'BASELINE' tag.
        -   `$ git tag -a <lebel_of_tag>` → Creates a Annoted Tag, extra informations.
        -   `$ git tag -d <name_of_tag_to_be_deleted>` → Deletes the specified tag.
        -   `$ git tag -a <lebel_of_tag> <commit_id>` → Tags a older commit.
        -   `$ git tag < -l | --list >` → List all tags created so far.
        -   `$ git push --tags` → Push all the tags into remote (github.com)

    - **FETCH**:
        -   `$ git fetch origin <branch-name>` -> To fetch a specific branch from your remote (usually named `origin`)
        -   `$ git fetch` → retrieves the latest commits, branches, and tags from the remote repository **without merging** them into your current branch; updates your local view of the remote.

    -   🔥 [MERGING](https://www.atlassian.com/git/tutorials/using-branches/git-merge):

        -   `$ git merge <origin_branch_name> < local_branch_name>` → Merge a local branch into a origin branch.
        -   `$ git merge <local_branch_name1> < local_branch_name2>` → Merges two branches in local repository.
        -   `$ git merge —abort` → Abort merge if it is not possible to merge for any reason.

    -   **Rebase** & **Squash**:

        -   **NOTE**: Never rebase a branch that has been already pushed into remote.
        -   [Git Rebase in 6 minutes](https://www.youtube.com/watch?v=f1wnYdLEpgI)
        -   [git interactive rebase - Undo, Edit & Squash git commits with a single command](https://www.youtube.com/watch?v=42392W7SgnE)

        -   `$ git checkout feature & git rebase main` → This sequence of commands is a common workflow used to keep a feature branch up to date with the main branch. Instead of "merging" (which creates a new commit joining the two branches), rebasing literally "rewrites" your branch history by moving your unique work to sit on top of the latest changes from main.

        -   **How to edit previous commit on the local feature branch that has not been pushed yet**:
            -   `$ git rebase -i HEAD~3` → This opens an editor in interactive mode (`-i`) showing your last 3 commits. You can change the word `pick` to `squash` to combine them or `reword` to fix a typo in a commit message.
                -   overwrite **PICK** with **EDIT** on the opened editor and close it.
                -   `$ git add file_name_you_edited` ->
                -   `$ git rebase --continue`

        -   **How to split a previous commit into two on the local feature branch that has not been pushed yet**:
            -   `$ git rebase -i HEAD~3` → This opens an editor in interactive mode (`-i`) showing your last 3 commits. You can change the word `pick` to `squash` to combine them or `reword` to fix a typo in a commit message.
                -   overwrite **PICK** with **EDIT** on the opened editor and close it.
                -   `$ git reset HEAD~1` -> Remove the commit completely
                -   `$ git status` -> 
                -   `$ git add README.md` ->
                -   `$ git commit -m "Add readme file"` ->
                -   `$ git add index.js` ->
                -   `$ git commit -m "Add login feature"` ->
                -   `$ git rebase --continue`

        -   **How to squash previous commits on the local feature branch that has not been pushed yet**:
            -   `$ git rebase -i HEAD~4` → This opens an editor in interactive mode (`-i`) showing your last 3 commits. You can change the word `pick` to `squash` to combine them or `reword` to fix a typo in a commit message.
                -   overwrite **PICK** with **SQUASH** on the opened editor and close it.
                -   `$ git add file_name_you_edited` ->
                -   `$ git rebase --continue`

        -   `$ git rebase -i commit_hash` → 
        -   `$ git rebase`

        -   ```bash
            git checkout main
            git merge --squash feature-branch
            git commit -m "Summarized feature description"
            ```

    -   🔥 **FETCH**/**PULL**/**PUSH**:

        -   **git pull --rebase**: This is the "clean history" approach. It is designed for when you have already committed your work locally.
                -   **How it works**: It takes your local commits, "lifts" them up, pulls the new commits from the server, and then tries to stick your commits back on top of the new ones.
                -   **Best for**: Keeping a linear project history without "Merge branch 'main' of..." commits clogging up the log.
                -   **The Catch**: If your changes are uncommitted, `git pull --rebase` will often fail and tell you to "commit or stash" your changes anyway.
                -   `git pull origin develop --rebase --autostash` -> you can configure Git to automatically stash your uncommitted changes, perform a rebase, and then pop the stash for you in one command
                -   `git pull --rebase origin develop`

        -   `$ git pull --rebase origin cpecs-12147` → fetches the latest changes from `origin/cpecs-12147` and rebases your local branch on top of it (instead of merging).
        -   `$ git pull` → does everything `git fetch` does, **plus it merges** the fetched changes from the remote branch into your current branch (equivalent to `git fetch` followed by `git merge`).
        -   `$ git pull origin master` → fetches the latest changes from the `master` branch on the remote named `origin` and **merges** them into your current local branch.
        -   `$ git pull upstream Master` → fetches and merges the `Master` branch from the `upstream` remote into your current local branch.

        -   `$ git push origin master` → Pushes the master branch of local repository to master branch of remote repository.
        -   `$ git push -u origin master` → Push the commits from my local master branch to the master branch on the remote repository named origin, and set up tracking information for the master branch on the remote repository.
        -   `$ git push origin cpecs-12147 --force` → force-pushes the local `cpecs-12147` branch to the `origin` remote, overwriting any conflicts on the remote branch.
        -   `$ git push origin` → push all the branches to origin

    </details>

---

-   <details><summary style="font-size:25px;color:Orange;text-align:left">Github CLI Commands</summary>

    [DOC](https://cli.github.com/manual/gh_api)

    ### Authentication and Configuration

    -   `$ gh auth status`
    -   `$ gh config get --list`
    -   `$ gh auth login`
    -   `$ gh ssh-key list`
    -   `$ gh ssh-key add ~/.ssh/id_rsa.pub --title "Your SSH Key Title"`
    -   `$ `

    ### Repository Management

    -   `$ gh repo -h`
    -   `$ gh repo list`
    -   `$ gh repo clone owner/repo`
    -   `$ gh repo create [repo_name]`
    -   `$ gh repo view [owner/repo]`
    -   `$ gh repo list --fork`
    -   `$ gh repo list --source`

    ### Issue Management

    -   `$ gh issue create`
    -   `$ gh issue view [number]`
    -   `$ gh issue list`
    -   `$ gh issue list --state closed`
    -   `$ gh issue list --assignee [username]`

    ### Pull Request Management

    -   `$ gh pr create`
    -   `$ gh pr view [number]`
    -   `$ gh pr list`
    -   `$ gh pr list --state closed`
    -   `$ gh pr list --assignee [username]`

    ### Workflow and Actions

    -   `$ gh workflow view`
    -   `$ gh workflow run [workflow_name]`
    -   `$ gh run view [run_number]`

    ### Collaborator and Team Management

    -   `$ gh repo collaborator add [username]`
    -   `$ gh repo collaborator remove [username]`
    -   `$ gh team list`
    -   `$ gh team list-members [team_slug]`

    ### Git Operations

    -   `$ gh repo create branch-name`
    -   `$ gh repo view --json default_branch`
    -   `$ gh pr create --draft`
    -   `$ gh pr view --draft`

    ### MISC

    -   `$ gh repo delete <repository>`
    -   `$ `
    -   `$ `

    ### Usefull Bash function on 'gh'

    ```sh

    git_info(){
        echo "List of remote URLs:"
        git remote -v
        git config --get user.name
        git config --get user.email
        git log --graph --oneline --decorate --all
        echo "List of branches created so far:"
        git branch --list
    }


    add_github_secrets(){
        : ' Adds secrets to the Github
        '
        gh secret set DOCKERHUB_USERNAME --body ${DOCKERHUB_USERNAME}
        gh secret set DOCKERHUB_PASSWORD --body ${DOCKERHUB_PASSWORD}
        gh secret set DOCKER_REGISTRY --body ${DOCKER_REGISTRY}
        gh secret set DOCKER_REPOSITORY --body ${DOCKER_REPOSITORY}
        gh secret set STRIPE_SECRET_KEY --body ${STRIPE_SECRET_KEY}
        gh secret set STRIPE_PUBLISHABLE_KEY --body ${STRIPE_PUBLISHABLE_KEY}
    }

    remove_github_secrets(){
        : ' Removes secrets to the Github
        '
        gh secret remove DOCKERHUB_USERNAME
        gh secret remove DOCKERHUB_PASSWORD
        gh secret remove DOCKER_REGISTRY
        gh secret remove DOCKER_REPOSITORY
        gh secret remove STRIPE_SECRET_KEY
        gh secret remove STRIPE_PUBLISHABLE_KEY
    }
    ```

    -   `$ gh extension install cli/gh-webhook`

    -   How to set up a webhook on GitHub using the 'gh' CLI tool?

        -   `$ gh repo create repo-name --webhook-url=https://your-webhook-url`
            -   `repo-name` with the name of your repository.
            -   `https://your-webhook-url` with the actual `payload URL` of your webhook.
            -   This command will create a new GitHub repository and set up a webhook with the specified payload URL. Make sure that you have the necessary permissions to create webhooks in the repository.

    -   How to update a webhook on GitHub using the 'gh' CLI tool?
        -   `$ gh repo view -w owner/repo-name --json webhook.url | gh api -X PATCH repos/owner/repo-name/hooks/12345 --input - -F config.url=https://your-new-webhook-url`
            -   `owner` with the GitHub username or organization.
            -   `repo-name` with the name of your repository.
            -   `12345` with the actual webhook ID (you can obtain it from the output of the gh repo view command).
            -   `https://your-new-webhook-url` with the updated payload URL.
        -   This command retrieves the existing webhook information, and then uses the `gh` api command to update the webhook configuration with the new payload URL.

    ```sh

    add_gh_wh(){
        # Replace the following placeholders with your values
        OWNER=A-Momin
        REPO=bookstore
        # SECRET=your_webhook_secret
        URL=https://54.210.9.192/github-webhook/

        # Use gh api to create a webhook
        # gh api repos/$OWNER/$REPO/hooks -w -X POST -F name=web -F active=true -F events=push -F config.url=$URL
        # gh api repos/A-Momin/bookstore/hooks -X POST -F name=web -F active=true -F events=push -F config.url=https://54.210.9.192/github-webhook/
        # gh api https://github.com/A-Momin/bookstore/settings/hooks/new -W -X POST -F config.url=https://54.210.9.192/github-webhook/
        gh webhook forward --repo=/A-Momin/bookstore --events=push --url=https://54.210.9.192/webhooks/
    }
    ```

    -   <details><summary style="font-size:18px;color:#C71585">How to create Github Token for personal Use</summary>

        -   --> `https://github.com/A-Momin/bookstore` --> `Root Level Settings` --> `Developer Settings` --> `Personnel Access Token` --> `Token (classic)`

        </details>

    -   <details><summary style="font-size:18px;color:#C71585">How to configure the GitHub CLI (gh) tool with multiple GitHub accounts</summary>

        -   `NOT TESTED`

        To configure the GitHub CLI (`gh`) tool with multiple GitHub accounts, you can set up different authentication contexts for each account. Here's how to achieve this:

        ##### Log in to Each GitHub Account

        You need to authenticate each account with `gh` and create separate profiles.

        1. **Switch to Account 1 (Personal):**

            - `$ gh auth login`

            - Choose GitHub.com.
            - Select your preferred authentication method (browser or token).
            - Authenticate with your **personal** account.

        2. **Create a Profile for Account 1:**

            - `$ gh config set -h github.com profile personal` - After logging in, name the profile (e.g., `personal`)

        3. **Switch to Account 2 (Work):**

            - `$ gh auth login`
            - Repeat the authentication steps for your **work** account.

        4. **Create a Profile for Account 2:**

            - `$ gh config set -h github.com profile work` -> Name the profile (e.g., `work`)

        ##### Switch Between Profiles

        -   Use the **personal account**:

            -   `gh auth status --profile personal`

        -   Use the **work account**:

            -   `$ gh auth status --profile work`

        ##### Use Profiles with Commands

        When using `gh`, specify the profile explicitly if needed:

        ```bash
        gh repo clone username/repo-name --profile personal
        gh issue create --repo username/repo-name --profile work
        ```

        ##### Set Environment Variables for Automation

        To avoid specifying profiles manually, you can automate this by using environment variables for scripts or specific directories.

        In `.bashrc` or `.zshrc`:

        ```bash
        alias gh-personal='gh --profile personal'
        alias gh-work='gh --profile work'
        ```

        Use these aliases when working with `gh`.

        </details>

    -   <details><summary style="font-size:18px;color:#C71585">Github Webhook</summary>

        A **GitHub webhook** is a mechanism that allows external services to be notified of events happening in a GitHub repository. When a specific event occurs in a repository (e.g., a push, pull request, or issue creation), GitHub sends an HTTP POST request to a pre-configured URL (the webhook URL) with details about the event.

        Webhooks enable automation by triggering actions in external systems whenever changes occur in a repository.

        -   **Key Components of a GitHub Webhook**

            1. **Webhook URL**:

            -   The endpoint where GitHub will send the event payload.
            -   Typically, this is an API endpoint or a server that processes the webhook.

            1. **Events**:

            -   You can specify which events will trigger the webhook. Examples include:
                -   `push`: Triggered when commits are pushed to the repository.
                -   `pull_request`: Triggered when a pull request is opened, updated, or merged.
                -   `issues`: Triggered when an issue is created or updated.

            1. **Payload**:

            -   GitHub sends a JSON payload containing details about the event.
            -   For example, a `push` event payload includes commit details, branch information, and the repository URL.

            1. **Secret** (Optional but Recommended):

            -   A secret key that GitHub includes in the payload as a header (e.g., `X-Hub-Signature-256`).
            -   Helps validate that the request is genuinely from GitHub.

        -   **How Webhooks Work**

        1. **Configure a Webhook**:

            - Add a webhook to a repository via the GitHub UI or API.
            - Specify the webhook URL, secret, and event types.

        2. **Trigger an Event**:

            - Perform an action in the repository, like pushing a commit.

        3. **GitHub Sends a POST Request**:

            - GitHub sends a payload to the configured webhook URL.

        4. **Process the Payload**:
            - Your server receives the payload and processes the data, performing any necessary actions (e.g., updating a CI/CD pipeline, notifying a Slack channel).

        -   **Use Cases for GitHub Webhooks**

            1. **Continuous Integration/Continuous Deployment (CI/CD)**:

            -   Trigger build pipelines when code is pushed to specific branches.

            1. **Notification Systems**:

            -   Send notifications to Slack, Microsoft Teams, or other platforms when issues or pull requests are created.

            1. **Automated Testing**:

            -   Run tests automatically after a pull request is opened or updated.

            1. **Custom Workflows**:

            -   Automate tasks like syncing repositories, updating databases, or triggering serverless functions.

        -   **How to Set Up a Webhook**

            -   Using the GitHub UI:

            1. Navigate to the repository’s **Settings** > **Webhooks**.
            2. Click **Add webhook**.
            3. Fill in:
                - **Payload URL**: Your server's URL.
                - **Content type**: Choose `application/json` (recommended).
                - **Secret**: A string for validating requests.
                - **Events**: Select specific events or "Let me select individual events."
            4. Save the webhook.

        -   **Validating Webhook Payloads**

            1. GitHub sends the `X-Hub-Signature-256` header with a hashed signature of the payload.
            2. Use the secret to verify the request:

            -   Compare the hash in the header with one you compute using HMAC SHA-256.

            Example (Python):

            ```python
            import hmac
            import hashlib

            def verify_signature(payload, secret, signature):
                computed_hash = hmac.new(secret.encode(), payload, hashlib.sha256).hexdigest()
                return hmac.compare_digest(f"sha256={computed_hash}", signature)
            ```

        </details>

    -   <details><summary style="font-size:18px;color:#C71585">how to generate a github.com token with 'gh' cli tool?</summary>

        </details>

    -   <details><summary style="font-size:18px;color:#C71585">How to create Web Hook on a Github repository using `gh` cli</summary>

        You can create a webhook on a GitHub repository using the `gh` CLI tool by using the `gh api` command to interact with the GitHub REST API. Here’s a step-by-step guide:

        1. **Understand the API Endpoint for Webhooks**

            - The GitHub REST API for creating a webhook is:

                ```
                POST /repos/{owner}/{repo}/hooks
                ```

            - The request requires a JSON payload with the webhook configuration.

        2. **Prepare the Webhook Data**

            - Before running the `gh api` command, decide on:
            - The webhook's **URL** (e.g., your server URL).
            - The type of events the webhook should listen to (e.g., `push`, `pull_request`).
            - Any additional configuration, such as a secret for security.

            - Example JSON payload:
                ```json
                {
                    "name": "web",
                    "active": true,
                    "events": ["push", "pull_request"],
                    "config": {
                        "url": "https://example.com/webhook",
                        "content_type": "json",
                        "insecure_ssl": "0",
                        "secret": "your-secret-key"
                    }
                }
                ```

        3. **Use the `gh` CLI to Create the Webhook**

            - Run the following command, replacing placeholders with your repository details:

            ```bash
            gh api --method POST \
            -H "Accept: application/vnd.github+json" \
            /repos/{owner}/{repo}/hooks \
            -f name="web" \
            -F active=true \
            -F events='["push", "pull_request"]' \
            -F config='{"url":"https://example.com/webhook","content_type":"json","insecure_ssl":"0","secret":"your-secret-key"}'
            ```

            - Replace:
                - `{owner}`: Your GitHub username or organization name.
                - `{repo}`: The name of the repository.
                - `https://example.com/webhook`: The actual URL of your webhook.
                - `your-secret-key`: A secret string for securing the webhook.

        -   4. **Verify the Webhook**
            -   After creating the webhook, list all webhooks for the repository to verify it:
            -   `$ gh api /repos/{owner}/{repo}/hooks`
            -   Look for your webhook in the output and confirm the configuration.

        1. **Example Walkthrough**

            - Assume you have a repository called `my-repo` owned by `my-user`, and your webhook URL is `https://my-webhook-url.com`. Use the following commands:

            - Create the Webhook:

                ```bash
                gh api --method POST \
                -H "Accept: application/vnd.github+json" \
                /repos/my-user/my-repo/hooks \
                -f name="web" \
                -F active=true \
                -F events='["push"]' \
                -F config='{"url":"https://my-webhook-url.com","content_type":"json","insecure_ssl":"0","secret":"super-secret"}'
                ```

            - List and Verify Webhooks:

                ```bash
                gh api /repos/my-user/my-repo/hooks
                ```

            - This will successfully create and verify a webhook on your GitHub repository. Let me know if you encounter any issues!

        </details>

    </details>

---
