# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
	source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

# ============================================================================
# ============================================================================

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
	export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
else # macOS `ls`
	colorflag="-G"
	export LSCOLORS='BxBxhxDxfxhxhxhxhxcxcx'
fi


# List all files colorized in long format
alias l="ls -lF ${colorflag}"

# List all files colorized in long format, including dot files
alias la="ls -larF ${colorflag}"

# List only directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"

# Always use color output for `ls`
alias ls="command ls -1 ${colorflag}"

# Always enable colored `grep` output
# Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Get week number
alias week='date +%V'

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# Get macOS Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update; sudo gem cleanup'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# Flush Directory Service cache
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

# Clean up LaunchServices to remove duplicates in the “Open With” menu
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Canonical hex dump; some systems have this symlinked
command -v hd > /dev/null || alias hd="hexdump -C"

# macOS has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# macOS has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# JavaScriptCore REPL
jscbin="/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc";
[ -e "${jscbin}" ] && alias jsc="${jscbin}";
unset jscbin;

# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"


# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple’s System Logs to improve shell startup speed.
# Finally, clear download history from quarantine. https://mths.be/bum
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# Merge PDF files
# Usage: `mergepdf -o output.pdf input{1,2,3}.pdf`
alias mergepdf='/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'

# Disable Spotlight
alias spotoff="sudo mdutil -a -i off"
# Enable Spotlight
alias spoton="sudo mdutil -a -i on"

# PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
alias plistbuddy="/usr/libexec/PlistBuddy"

# Airport CLI alias
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'

# Ring the terminal bell, and put a badge on Terminal.app’s Dock icon
# (useful when executing time-consuming commands)
alias badge="tput bel"

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
	alias "$method"="lwp-request -m '$method'"
done

# Make Grunt print stack traces by default
command -v grunt > /dev/null && alias grunt="grunt --stack"

# Stuff I never really use but cannot delete either because of http://xkcd.com/530/
alias stfu="osascript -e 'set volume output muted true'"
alias pumpitup="osascript -e 'set volume output volume 100'"

# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

# Lock the screen (when going AFK)
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'
# ============================================================================

beautify_prompt(){
    # colors:
    green="\[\033[0;32m\]"
    blue="\[\033[0;34m\]"
    purple="\[\033[0;35m\]"
    reset="\[\033[0m\]"
    BRed='\033[1;31m'       # Bold Red
    Yellow='\033[0;33m'     # Yellow
    Orange='\033[38;5;214m'
    BOrange='\e[1;33m'


    host=$(whoami)
    # host=
    if [ $host = "am" ]; then
        host_color=$BRed
    elif [ $host = "aminulmomin" ]; then
        host_color=$BRed
    elif [ $host = "a.momin" ]; then
        host_color=$Orange
    else
        host_color=$BOrange
    fi
    arrow_color=$purple

    # # Prompt String
    # export PS1="$host_color${host}-$arrow_color =>|$green\$(__git_ps1)$blue\W$arrow_color|\n$ $reset"

    export PS1="${host_color}${host}-${arrow_color} =>|${green}\$(__git_ps1)${blue}\W${arrow_color}|${reset}\n$ "

    # Meaning of
        #	\h     ->> the host name
        #	\n     ->> the new line
        #	\s     ->> the name of the shell
        #	\t     ->> the current time in 24-hour format
        #	\u     ->> the user name of current user
        #	\w     ->> the current working directory
        #	\W     ->> the basename of the current working directory
}

base_dotfile_symlinks(){
    ln -sf $NTBS/dotfiles/macos/bash_profile_mos01 $HOME/.bash_profile
    ln -sf $NTBS/dotfiles/macos/git-aliases.bash $HOME/.git-aliases.bash
    ln -sf $NTBS/dotfiles/macos/git-completion.bash $HOME/.git-completion.bash
    ln -sf $NTBS/dotfiles/macos/git-prompt.sh $HOME/.git-prompt.sh
    ln -sf $NTBS/dotfiles/macos/aliases $HOME/.aliases
    ln -sf $NTBS/dotfiles/macos/bash_utils.bash $HOME/.bash_utils.bash
}

pvt_symbolic_links(){
    # Source: $NTBS
    ln -sf $NTBS/dotfiles/macos/aws_config.ini \
        $HOME/.aws/config
    ln -sf $NTBS/dotfiles/macos/aws_credentials.ini \
        $HOME/.aws/credentials
    ln -sf $NTBS/nts/notes_cicd.md \
        $SD/Web_Development/cicd/notes_cicd.md
    ln -sf $NTBS/iqs/query_questions_answers.sql \
        $SD/Databases/RDBMS/sql/query_questions_answers.sql
        
    ln -sf $NTBS/nts/notes_django.md \
        $HOME/mydocs/Software_Development/Web_Development/django-courses/notes_django.md
    ln -sf $NTBS/nts/notes_docker.md \
        $HOME/mydocs/Software_Development/Web_Development/cicd/dockers/notes_docker.md
    ln -sf $NTBS/nts/notes_fastapi.md \
        $HOME/mydocs/Software_Development/Web_Development/fast_API/notes_fastapi.md
    ln -sf $NTBS/nts/notes_flask.md \
        $HOME/mydocs/Software_Development/Web_Development/flask-course/notes_flask.md
    ln -sf $NTBS/nts/notes_terraform.md \
        $HOME/mydocs/Software_Development/DEDS/terraform_aws/notes_terraform.md
    ln -sf $NTBS/nts/notes_ansible.md \
        $HOME/mydocs/Software_Development/Web_Development/cicd/ansible/notes_ansible.md
    ln -sf $NTBS/nts/notes_networking.md \
        $HOME/mydocs/Software_Development/networking/notes_networking.md

    ln -sf $NTBS/nts/notes_db.md \
        $HOME/mydocs/Software_Development/Databases/RDBMS/sql/notes_db.md
        
    ln -sf $NTBS/nts/query_questions_answers.md \
        $HOME/mydocs/Software_Development/Databases/RDBMS/sql/query_questions_answers.md

    ############ VSCode User Settings.json ############################
    ln -sf $NTBS/dotfiles/vscode/settings.json \
        ~/Library/Application\ Support/Code/User/settings.json
    ln -sf $NTBS/dotfiles/vscode/custom_keybindings.json \
        $HOME/Library/Application\ Support/Code/User/keybindings.json
    ln -sf $NTBS/dotfiles/vscode/markdown_code_snippets \
        $HOME/Library/Application\ Support/Code/User/snippets/markdown_snippets.code-snippets
    ln -sf $NTBS/dotfiles/vscode/style.less \
        $HOME/.local/state/crossnote/style.less
    ###################################################################
    
    ln -sf $NTBS/dotfiles/macos/config \
        $HOME/.ssh/config

    if [ ! -f $HOME/notes_rough.md ]; then
        touch $HOME/notes_rough.md;
    fi

}

c1_symbolic_links(){
    ############ VSCode User Settings.json ############################
    ln -sf $NTBS/dotfiles/vscode/settings.json \
        ~/Library/Application\ Support/Code/User/settings.json
    ln -sf $NTBS/dotfiles/vscode/custom_keybindings.json \
        $HOME/Library/Application\ Support/Code/User/keybindings.json
    ln -sf $NTBS/dotfiles/vscode/style.less \
        $HOME/.local/state/crossnote/style.less
    ###################################################################
    
    ln -sf $NTBS/dotfiles/macos/config \
        $HOME/.ssh/config

    if [ ! -f $HOME/notes_rough.md ]; then
        touch $HOME/notes_rough.md;
    fi
}

tmxnew(){
    if [[ -n $1 ]]; then tmux new -s $1 
    else tmux new -s main
    fi
}

tmxkill(){
    if [[ -n $1 ]]; then tmux kill-ses -t $1 
    else tmux kill-ses -t main
    fi
}

# # Function to rsync the document folder to a flash drive based on the target value
sync_to_volume() {
    : '
    Args:
        $1 (mendatory): the name of the volume attached to the mac.
    
    Example:
        `$ sync_to_volume mypassport`
    '

    # local target="$1"
    rsync -avz \
        --delete \
        --exclude '.venv' \
        --exclude 'venv*' \
        --exclude 'node_modules' \
        --exclude '.ipynb_checkpoints' \
        --exclude '.egg-info' \
        --exclude '*.egg-info' \
        --exclude '*.pyc' \
        --exclude '*.class' \
        --exclude '*.terraform' \
        --exclude '*.git' \
        --exclude '.tmp.drivedownload' \
        --exclude '.tmp.driveupload' \
        --exclude '*.DS_Store' \
        --exclude '.pytest_cache' \
        --exclude '__pycache__' \
        $HOME/mydocs/ /Volumes/$1/MYDOCS_BACKUP/

    # case "$target" in
    #     "mypassport")
    #         echo "Syncing $HOME/mydocs/ to /Volumes/mypassport/MYDOCS_BACKUP/"
    #         rsync -avz --exclude '.venv' --exclude 'venv*' --exclude 'node_modules' --exclude '.ipynb_checkpoints' --exclude '.egg-info' --exclude '*.egg-info' --exclude '*.class' --exclude '*.DS_Store' --exclude '.pytest_cache' --exclude '__pycache__' $HOME/mydocs/ /Volumes/mypassport/MYDOCS_BACKUP/
    #         ;;
    #     "FD01")
    #         echo "Syncing $HOME/mydocs/ to /Volumes/Momin-MC01/MYDOCS_BACKUP/"
    #         rsync -avz --exclude '.venv' --exclude 'venv*' --exclude 'node_modules' --exclude '.ipynb_checkpoints' --exclude '.egg-info' --exclude '*.egg-info' --exclude '*.class' --exclude '*.DS_Store' --exclude '.pytest_cache' --exclude '__pycache__' $HOME/mydocs/ /Volumes/Momin-MC01/MYDOCS_BACKUP/
    #         ;;
    #     *)
    #         echo "Invalid target. Please choose one of: mypassport, mc01, target3."
    #         ;;
    # esac
}

sync_to_c1() {
    : '
    Args:
        $1 (mendatory): the name of the volume attached to the mac.
    
    Example:
        `$ sync_to_c1 mypassport`
    '

    # local target="$1"
    rsync -avz \
        --delete \
        --exclude '*secrets.bash' \
        --exclude '*interviewprep' \
        --exclude '.git' \
        --exclude '.gitignore' \
        --exclude '.venv' \
        --exclude 'venv*' \
        --exclude 'node_modules' \
        --exclude '.teraform' \
        --exclude '.ipynb_checkpoints' \
        --exclude '.egg-info' \
        --exclude '*.egg-info' \
        --exclude '*.pyc' \
        --exclude '*.class' \
        --exclude '.tmp.drivedownload' \
        --exclude '.tmp.driveupload' \
        --exclude '*.DS_Store' \
        --exclude '.pytest_cache' \
        --exclude '__pycache__' \
        /Volumes/$1/MYDOCS_BACKUP/Software_Development/noteshub $HOME/
}

sync_aws_to_c1(){
    : '
    Args:
        $1 (mendatory): the name of the volume attached to the mac.
    
    Example:
        `$ sync_aws_to_c1 mypassport`
    '

    # local target="$1"
    rsync -avz \
        --delete \
        --exclude '.git' \
        --exclude '.venv' \
        --exclude 'venv*' \
        --exclude '.teraform' \
        --exclude 'node_modules' \
        --exclude '.ipynb_checkpoints' \
        --exclude '.egg-info' \
        --exclude '*.egg-info' \
        --exclude '*.pyc' \
        --exclude '*.class' \
        --exclude '.tmp.drivedownload' \
        --exclude '.tmp.driveupload' \
        --exclude '*.DS_Store' \
        --exclude '.pytest_cache' \
        --exclude '__pycache__' \
        /Volumes/$1/MYDOCS_BACKUP/Software_Development/Web_Development/aws $CODEBASE/
}

remove_pattern(){
    find $1 -type d -name "__pycache__*" -exec rm -rf {} \;
    find $1 -type f -name "*.class" -delete
}

launch_ec2(){
    : '
    USAGES: 
        $ launch_ec2 ami-0c7217cdde317cfec t2.micro
    '
    # AMI_ID=$1
    AMI_ID="ami-0c7217cdde317cfec"
    # INSTANCE_TYPE=$2
    INSTANCE_TYPE="t2.micro"
    REGION="${AWS_DEFAULT_REGION}"
    KEY_PAIR_NAME="${AWS_DEFAULT_KEY_PAIR_NAME}"
    SECURITY_GROUP_ID="${AWS_DEFAULT_SG_ID}"
    SUBNET_ID="${AWS_DEFAULT_SUBNET_ID}"

    # Launch the EC2 instance
    INSTANCE_ID=$(aws ec2 run-instances \
        --region "$REGION" \
        --image-id "$AMI_ID" \
        --instance-type "$INSTANCE_TYPE" \
        --key-name "$KEY_PAIR_NAME" \
        --security-group-ids "$SECURITY_GROUP_ID" \
        --subnet-id "$SUBNET_ID" \
        --query 'Instances[0].InstanceId' \
        --output text)

    sleep 20
    # Check if the instance was launched successfully
    if [ -n "$INSTANCE_ID" ]; then
        echo "EC2 instance with ID $INSTANCE_ID is now launching."
    else
        echo "Failed to launch the EC2 instance."
    fi
}


## NOT TESTED YET !!
create_ami(){
    aws ec2 create-image --instance-id $1 --name "Your-AMI-Name" --description "Your-AMI-Description" --no-reboot
}

instance_id_from_nickname(){
    local INSTANCE_NICK_NAME=$1  # Assign the value of the first argument to INSTANCE_NICK_NAME

    # Transform INSTANCE_NICK_NAME to uppercase using 'tr' command
    local INSTANCE_NAME=$(echo "$INSTANCE_NICK_NAME" | tr '[:lower:]' '[:upper:]')

    local INSTANCE=AWS_INSTANCE_ID_$INSTANCE_NAME
    
    local INSTANCE_ID=$(eval "echo \$$INSTANCE")

    echo $INSTANCE_ID
}

up_ec2(){
    : ' Given the AWS EC2 inastance Name, it will launch the instance. Its assumed that the given instance is already created.
    Args:
        ($1): AWS EC2 inastance Name (Host) in your `~/.ssh/config` file.
    Usage:
        $ launch_ec2 ubun
    '

    local INSTANCE_NICK_NAME=$1  # Assign the value of the first argument to INSTANCE_NICK_NAME

    # Transform INSTANCE_NICK_NAME to uppercase using 'tr' command
    local INSTANCE_NAME=$(echo "$INSTANCE_NICK_NAME" | tr '[:lower:]' '[:upper:]')

    local INSTANCE=AWS_INSTANCE_ID_$INSTANCE_NAME
    
    local INSTANCE_ID=$(eval "echo \$$INSTANCE")

    echo "Starting instance with ID: $INSTANCE_ID"
    # Start the EC2 instance
    aws ec2 start-instances --instance-ids "$INSTANCE_ID"
    sleep 30

    local matching="Host $INSTANCE_NICK_NAME"
    local public_ip=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[].Instances[].PublicIpAddress' --output text)
    local replacement="HostName $public_ip"


    if [ $public_ip ]; then
        echo "Your $INSTANCE_NICK_NAME is Started (public IP address: $public_ip)"
        echo "Your Jenkins server is running at: $public_ip:8080/"

        if [ ! -d "$HOME/tmp" ]; then
            mkdir $HOME/tmp
            # echo "A temporary folder has been created in $HOME directory by the name 'tmp'"
        fi

        # Backing up your current `~/.ssh/config` file into a '$HOME/tmp' folder.
        cp ~/.ssh/config $HOME/tmp/config.bak
        
        # This will find the line containing $matching, skip to the next line using n, and then delete that line using d.
        sed "/$matching/{n; d;}" ~/.ssh/config > $HOME/tmp/config
        # sed -i .bak "/Host ubuntu_server/a $replacement" ~/.ssh/config # On Linux
        sed -e "/$matching/a\\"$'\n'"$replacement" $HOME/tmp/config > ~/.ssh/config # on mac Only
        
        mv $HOME/tmp/config.bak ~/.ssh/
        rm -fr $HOME/tmp
    fi
}

show_ec2_ip(){
    local INSTANCE_NICK_NAME=$1  # Assign the value of the first argument to INSTANCE_NICK_NAME

    # Transform INSTANCE_NICK_NAME to uppercase using 'tr' command
    local INSTANCE_NAME=$(echo "$INSTANCE_NICK_NAME" | tr '[:lower:]' '[:upper:]')

    local INSTANCE=AWS_INSTANCE_ID_$INSTANCE_NAME
    
    local INSTANCE_ID=$(eval "echo \$$INSTANCE")

    local public_ip=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[].Instances[].PublicIpAddress' --output text)

    echo "PUBLIC IP ADDRESS: $public_ip"
    echo "Your Jenkins server is running at: http://$public_ip:8080/"
}

down_ec2(){
    : ' Given the AWS EC2 inastance Name, it will stop the running instance.
    Args:
        ($1): AWS EC2 inastance Name (Host) in your `~/.ssh/config` file
    '
    local INSTANCE_NICK_NAME=$1  # Assign the value of the first argument to INSTANCE_NICK_NAME

    # Transform INSTANCE_NICK_NAME to uppercase using 'tr' command
    local INSTANCE_NAME=$(echo "$INSTANCE_NICK_NAME" | tr '[:lower:]' '[:upper:]')

    local INSTANCE=AWS_INSTANCE_ID_$INSTANCE_NAME
    
    local INSTANCE_ID=$(eval "echo \$$INSTANCE")

    # Start the EC2 instance
    aws ec2 stop-instances --instance-ids "$INSTANCE_ID"
}

capturescreen() {
    # Get the current date and time
    current_datetime=$(date +'%m-%d-%Y:%I-%M-%S')
    
    # Specify the full path for screencapture
    # local screencapture_cmd="/usr/sbin/screencapture"
    
    # Set the target folder
    local folder_name="$HOME/mydocs/Software_Development/networking/NetworkingFundamentals/sshot"
    
    # Ensure the target folder exists
    mkdir -p "$folder_name"
    
    # Capture the screenshot
    # screencapture -R 100,100,300,200 -T 1 "$folder_name/screenshot-$current_datetime.png"
    screencapture -T 1 "$folder_name/screenshot-$current_datetime.png"
}

setscpath() {
    : '
    -------------------------------------------------------------------------------
    Function: setscpath
    Description:
      Sets the default save location and file name prefix for screenshots taken
      using the macOS built-in screenshot utility (CMD+Shift+3/4/5).
      It requires restarting the SystemUIServer to apply the changes immediately.
    
    Arguments:
      $1 (Optional): The full path to the desired save directory.
                     Defaults to '~/Desktop/ss' if not provided.
      $2 (Optional): The file name prefix (e.g., 'capture').
                     Defaults to 'screenshot' if not provided.
    
    Writes to:
      com.apple.screencapture 'location'
      com.apple.screencapture 'name'
      com.apple.screencapture 'include-date' (set to false)
    
    Requires:
      macOS (to use the 'defaults' and 'killall' commands).
    
    Invocation Syntax Examples:
    
      # Example 1: Set location to '~/Documents/Screens' and prefix to 'project_A'
      setscpath ~/Documents/Screens project_A
    
      # Example 2: Set location to '~/Desktop/Images' but keep the default prefix ('screenshot')
      setscpath ~/Desktop/Images
    
      # Example 3: Reset to default location ('~/Desktop/ss') and default prefix ('screenshot')
      setscpath
    -------------------------------------------------------------------------------
    '

    # 1. Set the screenshot location (defaulting to ~/Desktop/ss if $1 is empty)
    defaults write com.apple.screencapture location "${1:-~/Desktop/ss}"

    # 2. Set the screenshot name prefix (defaulting to "screenshot" if $2 is empty)
    # The name is used as the file prefix, e.g., "myprefix 2025-11-29 at 11.52.52.png"
    defaults write com.apple.screencapture name "${2:-screenshot}"
    
    # 3. Explicitly disable the date stamp as the original function attempted
    defaults write com.apple.screencapture include-date -bool false

    # 4. Apply changes immediately
    killall SystemUIServer

    # 5. Provide feedback to the user
    # Note: The command in the echo will read the actual system-resolved path.
    echo "Screenshots will now be saved in '$(defaults read com.apple.screencapture location)'"
    echo "Files will be named with the prefix: '$(defaults read com.apple.screencapture name)'"
}

showscpath(){
    echo "Screenshots will be saved in '$(defaults read com.apple.screencapture location)'"
}

create_old_jnb_pyenv(){
    pyenv virtualenv ${1:-oldjnb}
    pyenv activate ${1:-oldjnb}
    pip install -r $SD/requirements_jnb_ds_bash_mysql_2.txt
    pip uninstall jinja2 nbconvert -y
    pip install jinja2 nbconvert
}


# PASSED
run_python_func() {
    : '
    Runs a specified function from a given Python script with mandatory arguments.

    Usage:
        run_python_func </path/to/script.py> <function_name> <arg1> <arg2> <arg3> [...]

    Parameters:
        script_path   - The full or relative path to the Python script (with .py extension).
        function_name - The name of the function inside the Python script.
        args          - Optional arguments to pass to the function (at least 1 required).

    Example:
        run_python_func /Users/am/mydocs/Software_Development/noteshub/utils/misc.py rename_images /Users/am/Desktop/ss screenshot sshot
    '

    # Ensure at least three arguments (script, function, and one function argument)
    if [ $# -lt 3 ]; then
        echo "Usage: run_python_func </path/to/script.py> <function_name> <arg1> <arg2> <arg3> [...]"
        return 1
    fi

    local script_path=$1
    local function_name=$2
    shift 2  # Remove script path and function name, leaving only function arguments

    # Extract directory and script name
    local script_dir
    script_dir=$(dirname "$script_path")
    local script_name
    script_name=$(basename "$script_path" .py)

    # Convert remaining arguments to a Python function call format
    local args=""
    for arg in "$@"; do
        args+="\"$arg\", "
    done
    args=${args%, }  # Remove trailing comma and space

    # Change to the script directory and execute the function with arguments
    (cd "$script_dir" && python3 -c "from ${script_name} import ${function_name}; ${function_name}(${args})")
}

# NOT PASSED
rename_images() {
    # Check if the correct number of arguments is provided
    if [ $# -lt 1 ]; then
        echo "Usage: rename_images <directory> [old_prefix] [new_prefix]"
        return 1
    fi

    # Assign arguments to variables
    local directory=$1
    local old_prefix="${2:-screenshot }"  # Default to "screenshot " if not provided
    local new_prefix="${3:-screenshot }"  # Default to "screenshot " if not provided

    # Ensure the directory exists
    if [ ! -d "$directory" ]; then
        echo "Directory does not exist: $directory"
        return 1
    fi

    # Find all files matching the old prefix and with valid image extensions
    local files=($(find "$directory" -maxdepth 1 -type f -iname "${old_prefix}*.{jpg,jpeg,png,gif,bmp}" | sort))

    # Ensure there are files to rename
    if [ ${#files[@]} -eq 0 ]; then
        echo "No files with the prefix '$old_prefix' found in $directory."
        return 1
    fi

    # Rename files sequentially
    local index=0
    for file in "${files[@]}"; do
        # Extract the file extension
        local extension="${file##*.}"
        local new_filename="${new_prefix}${index}.${extension}"
        local new_path="$directory/$new_filename"

        # Rename the file
        mv "$file" "$new_path"
        echo "Renamed: $(basename "$file") → $new_filename"

        # Increment the index
        ((index++))
    done
}


function findsz() {
    : '
    Finds and displays the sizes of directories in a given path.

    Parameters:
      $1 (optional) - Directory path to search (default: current directory).
      $2 (optional) - Max depth level for search (default: 1).

    Example Usage:
      findsz /var/log 2
      # Lists directory sizes in /var/log up to depth 2, sorted by size.
    '

    find ${1:-.} -maxdepth ${2:-1} -type d -exec du -sh {} + | sort -h
}

function cleandir() {
    : '
    Deletes directories matching a given name pattern within the current directory.

    Parameters:
      $1 (optional) - Directory name pattern to match (default: "*.venv").

    Example Usage:
      1. `$ cleandir node_modules` -> Removes all directories named "node_modules" in the current directory.
      2. `$ cleandir` -> Removes all directories named "*.venv" in the current directory.
    '

    find . -type d -name "${1:-*.venv}" -exec rm -rf {} +
}

setup_noteshub_on_c1(){
    : '
    This function sets up the my noteshub environment on a macOS system of Capital One.
    '
    if [ -d "$HOME/noteshub" ]; then
        cp -fr $HOME/noteshub $HOME/noteshub.bak # Forcefully and recursively
    fi

    export NTBS="$HOME/noteshub"
    export DOTFILES="$NTBS/dotfiles/macos"
    ln -fs $DOTFILES/bash_profile_capone $HOME/.bash_profile
    source $HOME/.bash_profile

    echo "Previous 'noteshub' folder has been backed up to $HOME/noteshub.bak"
    echo "Remove the backup folder if you don't need it anymore by running the following command:"
    echo -e "\trm -rf $HOME/noteshub.bak" # -e flag enables interpretation of escape sequences like \t for a tab.
}

## NOT TESTED YET !!
install_vscode_extensions_from_file() {
    : '
    Installs Visual Studio Code extensions listed in a specified file.
    Args:
        $1 (mendatory): the path to the file containing the list of extensions.
    Example:
        $ install_vscode_extensions_from_file $NTBS/dotfiles/vscode/vscode_extension_list.txt
    '
    local file_path="$1"

    # Check if a file path was provided
    if [[ -z "$file_path" ]]; then
        echo "Usage: install_extensions_from_file <path_to_file>"
        return 1
    fi

    # Check if the file actually exists
    if [[ ! -f "$file_path" ]]; then
        echo "Error: File '$file_path' not found."
        return 1
    fi

    echo "Starting extension installation..."

    # Read the file line by line
    while IFS= read -r extension || [[ -n "$extension" ]]; do
        # 1. Strip carriage returns (for files created on Windows)
        # 2. Trim whitespace
        # 3. Skip empty lines or lines starting with '#'
        clean_ext=$(echo "$extension" | tr -d '\r' | xargs)
        
        if [[ -z "$clean_ext" || "$clean_ext" == \#* ]]; then
            continue
        fi

        echo "------------------------------------------"
        echo "Installing: $clean_ext"
        code --install-extension "$clean_ext"
    done < "$file_path"

    echo "------------------------------------------"
    echo "Process complete."
}

git_add_comit_push(){
    git add .
    git commit -m "${2:-regular update}"
    git push origin $1
}