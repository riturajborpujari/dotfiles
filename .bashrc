parseGitBranch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/'
}

export PS1="\t \033[0;34m\w \e[38;05;204m\$(parseGitBranch)>\033[0m "

export FZF_DEFAULT_CMD="fd"
export FZF_DEFAULT_OPTS="--preview='cat {}'"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
alias ls="ls --color"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
EDITOR=vim

# Journal file
export JOURNAL_DATA_FILE=/var/journal/journal.log

#Screenshot dir
export HYPRSHOT_DIR=~/screenshots

# Directory marking
alias dmk="pwd >> ~/.dmks"
alias cdmk="cd \$(cat ~/.dmks | fzf)"

. "$HOME/.cargo/env"
