

###############################################################################
###########################  MAC CONFIGURATION ############################

personalize_mac(){
    # Enable Darkmode
    osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'
    # # Disable Darkmode
    # osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to false'

    # set the Dock to the right side of the screen
    defaults write com.apple.dock orientation -string "right" && killall Dock

    # Enable automatically hide the Dock
    defaults write com.apple.dock autohide -bool true && killall Dock

    # # Disable automatically hide the Dock
    # defaults write com.apple.dock autohide -bool false && killall Dock

    # set the Dock size (e.g., 36 pixels)
    
    # Show hidden files in Finder
    defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder
    
    # # Hide hidden files in Finder
    # defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder

    # Show path bar in Finder
    defaults write com.apple.finder ShowPathbar -bool true && killall Finder

    # Hide path bar in Finder
    defaults write com.apple.finder ShowPathbar -bool false && killall Finder
}

enable_tap_to_click(){
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
    defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

}

disnable_tap_to_click(){
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool false
    defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 0
    defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 0

}

configure_hot_corner(){
    # Bottom-right corner to show the desktop
    defaults write com.apple.dock wvous-br-corner -int 4
    defaults write com.apple.dock wvous-br-modifier -int 0
    killall Dock
    
    ## xy represents the corner (tl for top-left, tr for top-right, bl for bottom-left, br for bottom-right).
    ## The -int value represents the action. For example, 4 is for showing the desktop, 2 for Mission Control, 3 for application windows, and so on.
}

#!/bin/bash

# Function to add an app to the Dock
# NOT WORKING
add_app_to_dock() {
    app_path=$1
    defaults write com.apple.dock persistent-apps -array-add "{\"tile-data\":{\"file-data\":{\"_CFURLString\":\"file://${app_path}\",\"_CFURLStringType\":15}}}"
}

# # Clear all current Dock items
# defaults write com.apple.dock persistent-apps -array

# # Add specified apps back to the Dock
# add_app_to_dock "/Applications/Safari.app/"
# add_app_to_dock "/Applications/Utilities/Terminal.app/"
# add_app_to_dock "/System/Library/CoreServices/Finder.app/"

# # Restart the Dock to apply changes
# killall Dock


###############################################################################
###########################  DOTFILE CONFIGURATION ############################

mac_download_dotfiles(){
    : "
    NOTES: Download secrets.bash file manually since it's not in Github.
    "

    dot_files="https://raw.githubusercontent.com/A-Momin/noteshub/main/dotfiles/macos"

    host=$(hostname)
    touch $HOME/.bash_profile
    # host=
    if [ $host = "MOS01" ]; then
        $dot_files/bash_profile_mos01 > $HOME/.bash_profile
    elif [ $host = "MOS02" ]; then
        $dot_files/bash_profile_mos02 > $HOME/.bash_profile
    else
        $dot_files/bash_profile >> $HOME/.bash_profile
    fi

    # 
    touch $HOME/init.vim
    curl $dot_files/init.vim >> $HOME/init.vim

    for file in {bash_utils.bash,tmux.conf,aliases,bashrc,git-completion.bash,git-prompt.sh,git-aliases.bash}; do
        if [ ! -f $HOME/.$file ]; then
            touch $HOME/.$file
        fi
        curl $dot_files/$file > $HOME/.$file

    done
}

establish_dotfiles_symlink(){
    host_name=$(hostname)

    local mos01=(bash_utils.bash tmux.conf aliases)

    if [ $host_name = "MOS01" ]; then
        ln -sf $NTBS/dotfiles/macos/bash_profile_mos01 $HOME/.bash_profile
        ln -sf $NTBS/dotfiles/macos/config $HOME/.ssh/config

        for element in "${mos01[@]}"; do
            echo Linking "$element" ...
            ln -sf $NTBS/dotfiles/macos/config $HOME/.$element
        done
    else
        ln -sf $NTBS/dotfiles/macos/bash_profile_mos02 $HOME/.bash_profile
    fi

    ln -sf $NTBS/dotfiles/macos/bashrc $HOME/.bashrc
    ln -sf $NTBS/dotfiles/macos/git-aliases.bash $HOME/.git-aliases.bash
    ln -sf $NTBS/dotfiles/macos/git-completion.bash $HOME/.git-completion.bash
    ln -sf $NTBS/dotfiles/macos/git-prompt.sh $HOME/.git-prompt.sh
}


###############################################################################
###########################   VISUAL STUDIO CODE ##############################

mac_install_vscode(){
    brew install --cask visual-studio-code
}

mac_setup_vscode(){

    : '
    Downloads VSCode extensions into the directory, `~/.vscode/extensions`.
    Args:
        file_name: The file name containg vscode extention-ids seperated by new line.
    '

    dot_files="https://raw.githubusercontent.com/Aminul-Momin/notes_hub/master/dotfiles"
    
    if [! -f $HOME/Library/Application\ Support/Code/User/settings.json]; then
        echo "'~/Library/Application Support/Code/User/settings.json' is not found"
    else
        if [! -d $HOME/tmp]; then
            echo "Creating '$HOME/tmp' Directory"
            mkdir $HOME/tmp
        fi
        
        curl $dot_files/vscode/settings.json > $HOME/tmp
        curl $dot_files/vscode/vscode_extension_list.txt > $HOME/tmp
        ln -sf $HOME/tmp/settings.json ~/Library/Application\ Support/Code/User/settings.json

    fi

    while read line; do
        echo "Installing $line . . . . . "
        code --install-extension $line
        # printf "%$(tput cols)s\n"|tr " " "="
    done < $HOME/tmp/vscode_extension_list.txt

    if [! -f $HOME/.local/state/crossnote/style.less]; then
        echo "'$HOME/.local/state/crossnote/style.less' file is not fount"
    else
        curl $dot_files/vscode/style.less > $HOME/tmp
        ln -sf $HOME/tmp/style.less $HOME/.local/state/crossnote/style.less
    fi
}


# To uninstall VSCode extentions
uninstall_vscode_extensions(){
    : ' Uninstall VSCode extensions.
    Args:
        file_name: The file name containg vscode extention-ids seperated by new line.
    '

    while read line; do
        echo "Uninstalling $line . . . . . "
        code --uninstall-extension $line
        printf "%$(tput cols)s\n"|tr " " "="
    done < $1
}

###############################################################################
###########################    VIM CONFIGURATIONS   ###########################



mac_nvim_tmux_config_depricated(){
    : ' Configure nvim for your local MAC OS.
        NOTE: It removes 'vim' (.vimrc) configuration if there is any.
    '

    if [ -h ~/.vimrc] || [ -d ~/.vim]; then # (`-h` indicates ` ~/.vimrc` exist and it's symbolic link)
        rm -fr ~/.vimrc ~/.vim ~/.viminfo
    fi

    # Install `vim-plug` package manager to be used with nvim (`init.vim`). Check the documentation to use it with vim (`.vimrc`)
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    if [ ! -d ~/.config/nvim ]; then
        mkdir -p ~/.config/nvim
    fi
    
    ln -fs $NTBS/dotfiles/macos/init.vim ~/.config/nvim/init.vim
    
    # Install all plugins mentioned on `~/.config/nvim/init.vim` file
    nvim +PlugInstall +qall

    # Build COC (Conquer of Completion) as follows:
    cd .local/share/nvim/pluged/coc.nvim && yarn install && yarn build

    ## Symlink to the tmux configuration file
    ln -fs $NTBS/dotfiles/macos/tmux.conf ~/.tmux.conf
}

config_nvchad(){
    # Install NVChad (https://nvchad.com/docs/quickstart/install)
    echo "Hellooooo"
}

mac_vim_tmux_config(){
    : ' Configure nvim for your mac.
        NOTE: It removes 'vim' (.vimrc) configuration if there is any.
    '

    # (`-h` indicates `~/.config/nvim/init.vim` exist and it's symbolic link)
    if [ -h ~/.config/nvim/init.vim] || [ -d ~/.local/share/nvim]; then
        rm -fr ~/.config/nvim .local/share/nvim ~/.viminfo
    fi

    ln -fs $NTBS/dotfiles/macos/vimrc ~/.vimrc

    # Install `vim-plug` package manager to be used with vim (`.vimrc`). Check the documentation to use it with neovim (`init.vim`)
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   
    # Install all plugins mentioned on `~/.vimrc` file
    vim +PlugInstall +qall

    ## Symlink to the tmux configuration file
    ln -fs $NTBS/dotfiles/macos/tmux.conf ~/.tmux.conf
}


###############################################################################
#################################    MYSQL   ##################################

mac_install_mysql(){
    :'Installation of mysql'
    brew install mysql
}

mac_install_mysql(){
    :'Installation of sqlite'
    brew install sqlite
}

mac_uninstall_mysql(){
    :'Unistallation of mysql'

    ps -ax | grep mysql  # stop and kill any MySQL processes
    sudo rm /usr/local/mysql
    sudo rm -rf /usr/local/var/mysql
    sudo rm -rf /usr/local/mysql*
    sudo rm ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
    sudo rm -rf /Library/StartupItems/MySQLCOM
    sudo rm -rf /Library/PreferencePanes/My*
    launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
    # edit /etc/hostconfig and remove the line MYSQLCOM=-YES-
    rm -rf ~/Library/PreferencePanes/My*
    sudo rm -rf /Library/Receipts/mysql*
    sudo rm -rf /Library/Receipts/MySQL*
    sudo rm -rf /private/var/db/receipts/*mysql*
    sudo rm -rf /tmp/mysql*
    # # try to run mysql, it shouldn't work
}


###############################################################################
###############################     ANOCONDA    ###############################
mac_install_conda(){
    brew install --cask anaconda
    export PATH="/usr/local/anaconda3/bin:$PATH"
}

uninstall_anaconda(){
    rm -rf /opt/anaconda3

    # Remove Conda Environment Files
    rm -rf ~/.condarc ~/.conda ~/.continuum

    rm -rf ~/.jupyter

    # Remove Any Remaining Anaconda Files
    find ~ -name "*anaconda*" -exec rm -rf {} +
    find ~ -name "*conda*" -exec rm -rf {} +

    # REMOVE CONDA CONFIGURATION FROM SHELL SCRIPTS

    # Restart Your Shell
    source ~/.bash_profile
    source ~/.zshrc

    # # Verify Removal
    # conda --version
}

###############################################################################
#################################     JAVA    #################################
mac_install_java_brew(){
    :'Installation of java'
    brew install java
}

## ALTERNATIVE APPROCH: Need to open/have an Oracle account
mac_install_java(){
    sudo tar xvf /Users/am/Downloads/jdk-11.0.23_macos-x64_bin.tar.gz -C /usr/local ## → Untar `jdk-17_macos-aarch64_bin.tar.gz` and save it into `~/Download` directory.
    sudo rm -fr /Users/am/Downloads/jdk-11.0.23_macos-x64_bin.tar.gz
}

## ChatGPT: how to install and configure Jupyter Notebook in a remote AWS EC2 of Ubuntu Machine?
install_jupyter_notebook(){
    cd $SD/Big_Data/elements_of_spark
    python3 -m venv .venv
    source .venv/bin/activate
    pip3 install jupyterlab notebook numpy pandas matplotlib pip install scikit-learn pyspark

    # jupyter notebook --generate-config # Generate a Jupyter configuration file
    # jupyter notebook password # Set a password for Jupyter Notebook
    # jupyter-lab --ip 0.0.0.0 --no-browser --allow-root
    # vim ~/.jupyter/jupyter_notebook_config.py 
    # echo "c.NotebookApp.ip = '0.0.0.0'" >> ~/.jupyter/jupyter_notebook_config.py # Allow access from any IP address
    # echo "c.NotebookApp.port = 8888" >> ~/.jupyter/jupyter_notebook_config.py # Specify the port (default is 8888)
    # echo "c.NotebookApp.open_browser = False" >> ~/.jupyter/jupyter_notebook_config.py # Prevent Jupyter from opening a browser window by default
    # echo "c.NotebookApp.password = 'admin'" >> ~/.jupyter/jupyter_notebook_config.py # Prevent Jupyter from opening a browser window by default

    # jupyter notebook # Start Jupyter Notebook

    ## http://your-ec2-public-dns:8888 --> Access Jupyter Notebook
}

install_spark(){
    : ' 
    -   [Youtube](https://www.youtube.com/watch?v=ei_d4v9c2iA)
    STATUS: Developing ....

    1. Install Java.
    2. Download Spark
    3. Setting up environment variable
    4. Veryfy Spark Installation
    '

    sudo mkdir -p /usr/local
    sudo wget -P /usr/local/ https://dlcdn.apache.org/spark/spark-3.5.1/spark-3.5.1-bin-hadoop3.tgz
    sudo tar xvf /usr/local/spark-3.5.1-bin-hadoop3.tgz -C /usr/local ## → Untar `spark-3.5.1-bin-hadoop3.tgz` and save it into `~/Download` directory.
    sudo rm -fr /usr/local/spark-3.5.1-bin-hadoop3.tgz

    # Add required environment variable
    echo "export SPARK_HOME=\"/usr/local/spark-3.5.1-bin-hadoop3\"" >> ~/.bash_profile
    # Add Spark into your `PATH` variable
    echo "export PATH=\"\$SPARK_HOME/bin:\$PATH\"" >> ~/.bash_profile

    ## Open Interactive Spark Shell
    ## `$ spark-shell`

    install_jupyter_notebook

    source $SD/Big_Data/elements_of_spark/.venv/bin/activate
    pip install numpy pandas pyspark scikit-learn matplotlib
}

mac_remove_docker(){
    :'Remove Docker from your Mac'
    brew uninstall docker
    brew uninstall docker-compose
    brew uninstall docker-machine
    rm -rf ~/.docker
    rm -rf /Applications/Docker.app
    rm -rf /Applications/Docker
    rm -rf /usr/local/bin/docker
    rm -rf /usr/local/bin/docker-*
    rm -rf ~/.docker ~/Library/Containers/com.docker.docker
    rm -rf ~/Library/Application\ Support/Docker\ Desktop
    rm -rf ~/Library/Caches/com.docker.docker
    rm -rf ~/Library/Preferences/com.docker.docker.plist
    rm -rf ~/Library/Logs/Docker\ Desktop
    sudo rm -rf /var/run/docker.sock
    sudo rm -rf /usr/local/bin/com.docker.cli
    sudo rm -rf /Library/PrivilegedHelperTools/com.docker.vmnetd
    sudo rm -rf /Library/LaunchDaemons/com.docker.vmnetd.plist
    sudo rm -rf /Library/LaunchAgents/com.docker.helper

}

    