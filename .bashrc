parse_git_branch () {
  git branch --show-current 2>/dev/null
}

write_git_branch_colorized () {
  branch=$(parse_git_branch)
  if [[ -z $branch ]]; then
    return
  fi;

  if [[ $(git status -s 2> /dev/null) ]]; then
    echo -e " \033[0;33m[$branch]*"
  else
    echo -e " \033[0;33m[$branch]"
  fi
}

export EDITOR=vim
export PS1="\033[0;96m\$(date "+%H:%M") \033[0;94m\w\$(write_git_branch_colorized) \033[0m\n "

export FZF_DEFAULT_CMD="fd"
export FZF_DEFAULT_OPTS="--preview='fzf-preview {}'"
# [ -f ~/.fzf.bash ] && source ~/.fzf.bash

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH="$HOME/.cargo/bin:~/.local/bin:$PATH"
export JOURNAL_DATA_FILE=~/.local/.journal

alias ls="ls --color"
alias bat="bat --theme=TwoDark --style=plain --pager=less"

alias dmk="pwd >> ~/.local/.dmks"
alias cdmk="cd \$(cat ~/.local/.dmks | fzf)"

alias vpn-connect="systemctl start openvpn-client@o4s.service"
alias vpn-disconnect="systemctl stop openvpn-client@o4s.service"
alias vpn-status="systemctl status openvpn-client@o4s.service"

alias bt-connect="bluetoothctl connect \$(bluetoothctl devices | fzf | awk '{print \$2}')"

alias grep="grep --exclude-dir dist --exclude-dir node_modules --exclude tags --color=always"

alias shutup="sudo modprobe -r xhci_pci && systemctl poweroff"

# Git aliases
alias gsc="git log --oneline | fzf | awk '{print \$1}'"
alias gsb="git branch -l | fzf | awk '{print \$1}'"
alias gc="git checkout \$(gsb)"

export PAGER_VIM="vim -c 'silent write! /tmp/last_paged_content | terminal cat /tmp/last_paged_content' -c 'only' -"
