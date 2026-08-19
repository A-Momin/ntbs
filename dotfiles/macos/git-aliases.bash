#!/usr/bin/env bash
# alias "gtl"="git log --oneline"
# alias gl='git log --graph --oneline --decorate --all'
alias gs='git status'
alias gl="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gb='git branch'
alias gco="git checkout"
alias gc="git commit -m"

alias gca="git commit -a -m"
alias gp="git push origin $1"
alias gpu="git pull origin"
alias gst="git status"
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'
alias gcoall='git checkout -- .'
alias gr='git remote'
alias gre='git reset'