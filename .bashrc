parse_git_branch () {
  git branch --show-current 2>/dev/null
}

write_git_branch_colorized () {
  branch=$(parse_git_branch)
  if [[ -z $branch ]]; then
    return
  fi;

  if [[ $(git status -s 2> /dev/null) ]]; then
    echo -e " \e[91m[$branch]*"
  else
    echo -e " \e[36m[$branch]"
  fi
}

export PS1="[\u@\h] \e[97m\w\$(write_git_branch_colorized)\e[0m\n$ "

alias top="top -u \${USER} -em"
alias ls="ls -lh --color"
alias dmk="pwd >> ~/.local/var/dmk/marks.dmk"
alias cdmk="cd \$(cat ~/.local/var/dmk/marks.dmk | fzf)"
alias bt-connect="bluetoothctl connect \$(bluetoothctl devices | fzf | awk '{print \$2}')"
alias grep="grep --exclude-dir dist --exclude-dir node_modules --exclude tags --color=always"
alias wlls="sudo iwctl station wlan0 get-networks"
alias wlscan="sudo iwctl station wlan0 scan"
alias wlconn="sudo iwctl station wlan0 connect \$1"
alias tm="tmux new-session -A -s probe"
alias title="printf \"\e]0;%s\a\" \$1"
