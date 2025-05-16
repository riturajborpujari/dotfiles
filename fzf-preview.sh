if [[ -d $1 ]]; then
  echo "\033[7;33mDirectory: $1\033[0m\n";
  ls --color=always $1;
elif [[ -f $1 ]]; then
  echo "\033[7;33mFile: $1\033[0m\n";
  bat --color=always --style=numbers --theme=zenburn $1;
fi
