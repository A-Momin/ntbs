lnx_load_dotfiles(){
    : ' Install short version 'notes_hub' into home directory
        NOTE:
    '
    mkdir -p $HOME/notes_hub/dotfiles/lnx
    export NTHUB="$HOME/notes_hub"
    dotfiles="https://raw.githubusercontent.com/Aminul-Momin/notes_hub/master/dotfiles/lnx"
    files=(bashrc bash_profile aliases git-completion.bash git-prompt.sh git-aliases.bash)
    for file in "${files[@]}"; do
        if [! -f $NTHUB/dotfiles/lnx/$file ]; then
            touch $NTHUB/dotfiles/lnx/$file
        fi
        curl $dotfiles/.$file > $NTHUB/dotfiles/lnx/$file
        # echo $file
    done
    # curl $nt_dotfiles/bash_profile > $NTHUB/dotfiles/lnx/bash_profile
    # curl $nt_dotfiles/aliases > $NTHUB/dotfiles/lnx/aliases
    # curl $nt_dotfiles/git-completion.bash > $NTHUB/dotfiles/lnx/git-completion.bash
    # curl $nt_dotfiles/git-prompt.sh > $NTHUB/dotfiles/lnx/git-prompt.sh
    # curl $nt_dotfiles/git-aliases.bash > $NTHUB/dotfiles/lnx/git-aliases.bash
}

lnx_vim_dotfiles(){
    # my_home=/home/$USER
    # vimrc_file="$my_home/.vimrc"
    # if [ -e $vimrc_file ]; then      # Check if file exists.
    #     mkdir $my_home/old_vimrc
    #     mv $vimrc_file $my_home/old_vimrc/
    # fi
    
    # for dir in $my_home/.{local/share/nvim config/nvim}; do
    #     if [ -d $dir ]; then
    #         if [! -d $my_home/old_nvim]; then
    #             mkdir $my_home/old_nvim
    #         fi

    #         if [! -f $my_home/old_nvim/README.md]; then
    #             touch $my_home/old_nvim/README.md
    #         fi

    #         cat $dir >> $my_home/old_nvim/README.md
    #         mv $dir $my_home/old_nvim/
    #     fi
    # done;

    src_vimrc="https://raw.githubusercontent.com/Aminul-Momin/notes_hub/master/dotfiles/Linux"
    
    # download my `.vimrc` from my github account.
    curl $src_vimrc/.vimrc > ~/.vimrc

    # Install `vim-plug` package manager to be used with vim (`.vimrc`). Check the documentation to use it with neovim (`init.vim`)
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    # inorder to install vim plugins:
        # `$ vim ~/.vimrc`
        # `:PlugInstall`
}

lnx_nvim_dotfiles(){
    # Install `vim-plug` package manager to be used with nvim (`init.vim`). Check the documentation to use it with vim (`.vimrc`)
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    
    ## Build COC as follows:
    # cd .local/share/nvim/pluged/coc.nvim
    # yarn install
    # yarn build

    ## configuration: ~/.config/nvim/
}


download_vim_config_files(){
    cd ~
    curl https://raw.githubusercontent.com/Aminul-Momin/notes_hub/master/vim_configs/vim01_python/.vimrc >> ~/.vimrc
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    # then Open `~/.vimrc` file with vim.
}


lnx_notes_cmds(){

    nt_cmds="https://raw.githubusercontent.com/Aminul-Momin/notes_hub/master/cmds"
    for file in notes_{airflow,docker,git,py,vim}.md; do
        if [! -d $HOME/NTS]; then
            mkdir $HOME/NTS
        fi
        curl $nt_cmds/$file >> $HOME/NTS/$file
    done
}


prepare_my_mac(){
    : ' Not done yet
        NOTE: rough !!
    '
    brew install mysql
    brew install tmux
    brew install postgresql
    brew install tmux

}