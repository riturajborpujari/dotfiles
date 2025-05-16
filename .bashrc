parse_git_branch () {
  git branch --show-current 2>/dev/null
}

write_git_branch_colorized () {
  branch=$(parse_git_branch)
  if [[ -z $branch ]]; then
    return
  fi;

  if [[ $(git status -s 2> /dev/null) ]]; then
    echo -e " \033[1m[$branch]*"
  else
    echo -e " \033[1m[$branch]"
  fi
}

export EDITOR=vim
export PROMPT_DIRTRIM=1
export PS1="\033[0m\$(date "+%H:%M") \033[0;37m\w\$(write_git_branch_colorized) \033[0m\n "

export FZF_DEFAULT_CMD="fd"
export FZF_DEFAULT_OPTS="--preview='fzf-preview {}'"

export GOPATH="$HOME/.go"
export PATH="$PATH:$HOME/.cargo/bin:$GOPATH/bin:$HOME/.local/bin"
export JOURNAL_DATA_FILE=~/.local/state/journal/data.journal

alias bat="bat --theme=TwoDark --style=plain --pager=less"
alias ls="ls -1p"

alias dmk="pwd >> ~/.local/state/dmk/marks.dmk"
alias cdmk="cd \$(cat ~/.local/state/dmk/marks.dmk | fzf)"

alias vpn-connect="systemctl start openvpn-client@o4s.service"
alias vpn-disconnect="systemctl stop openvpn-client@o4s.service"
alias vpn-status="systemctl status openvpn-client@o4s.service"

alias bt-connect="bluetoothctl connect \$(bluetoothctl devices | fzf | awk '{print \$2}')"

alias grep="grep --exclude-dir dist --exclude-dir node_modules --exclude tags --color=always"

# Git aliases
alias gsc="git log --oneline | fzf | awk '{print \$1}'"
alias gsb="git branch -l | fzf | awk '{print \$1}'"
alias gc="git checkout \$(gsb)"

# Wlan commands
alias wlls="sudo iwctl station wlan0 get-networks"
alias wlscan="sudo iwctl station wlan0 scan"
alias wlconn="sudo iwctl station wlan0 connect \$1"

# export PAGER_VIM="vim -c 'silent write! /tmp/last_paged_content | terminal cat /tmp/last_paged_content' -c 'only' -"
