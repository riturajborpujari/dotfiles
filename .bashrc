parse_git_branch () {
  git branch --show-current 2>/dev/null
}

write_git_branch_colorized () {
  branch=$(parse_git_branch)
  if [[ -z $branch ]]; then
    return
  fi;

  if [[ $(git status -s 2> /dev/null) ]]; then
    echo -e " [$branch]*"
  else
    echo -e " [$branch]"
  fi
}

export EDITOR=vim
export PROMPT_DIRTRIM=0
export PS1="[\u@\h](\j) \w\$(write_git_branch_colorized)\n$ "

export FZF_DEFAULT_CMD="fd"
export FZF_DEFAULT_OPTS="--preview='fzf-preview {}'"

export GOPATH="$HOME/.local/lib/go"
export PATH="$PATH:$HOME/.local/bin:$GOPATH/bin"

alias ls="ls -1l --color"
alias dmk="pwd >> ~/.local/share/dmk/marks.dmk"
alias cdmk="cd \$(cat ~/.local/share/dmk/marks.dmk | fzf)"
alias bt-connect="bluetoothctl connect \$(bluetoothctl devices | fzf | awk '{print \$2}')"
alias grep="grep --exclude-dir dist --exclude-dir node_modules --exclude tags --color=always"
alias wlls="sudo iwctl station wlan0 get-networks"
alias wlscan="sudo iwctl station wlan0 scan"
alias wlconn="sudo iwctl station wlan0 connect \$1"
