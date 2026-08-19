#!/bin/bash
export PATH="$HOME/bin:$PATH";
source $HOME/.bash_utils.sh
export UV="$HOME/.local/share/uv" # Where custom uv virtual environments are stored.

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{aliases,git-completion.bash,git-prompt.sh,git-aliases.bash,secrets.bash}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

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


# User specific aliases and functions
complete -cf sudo

# =============================================================================
export GIT_PS1_SHOWDIRTYSTATE=1


# Git global configuration
git config --global user.name "ubuntu"
git config --global user.email "myec2ubuntu.gmail.com"
# =============================================================================

beautify_prompt


if [ ! -f $HOME/rough.md ]; then
    touch $HOME/rough.md;
fi


# `pyenv` setup for Python version management
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)" # Load pyenv-virtualenv automatically


# `uv` complient variable for Rust
export PATH="$HOME/.local/bin:$PATH"
export TF_VAR_django_stripe_endpoint_secret=$DJANGO_STRIPE_ENDPOINT_SECRET