PWD=$(pwd)

echo "Setting up '${HOME}/.local' directories"
mkdir -p ~/.local/{bin,lib,share,shate,var}
mkdir -p ~/.local/var/vim/{better-sessions,undo}
mkdir -p ~/.local/var/dmk

echo "Setting up Bash, Tmux"
ln -sf \
	"${PWD}/.bashrc" \
	"${PWD}/.tmux.conf" \
	~/

echo "Setting up Fzf-Preview"
install "${PWD}/fzf-preview" ~/.local/bin/

echo "Setting up Hyprland, EWW, Quickshell, Tofi, Kitty, Vim, Zathura, XDG Directories"
ln -sf \
	"${PWD}/.config/hypr" \
	"${PWD}/.config/eww" \
	"${PWD}/.config/quickshell" \
	"${PWD}/.config/tofi" \
	"${PWD}/.config/kitty" \
	"${PWD}/.config/vim" \
	"${PWD}/.config/zathura" \
	"${PWD}/.config/user-dirs.dirs" \
	~/.config/

echo "Setting up Emacs"
mkdir -p ~/.emacs.d
ln -sf \
	"${PWD}/.emacs.d/init.el" \
	"${PWD}/.emacs.d/early-init.el" \
	"${PWD}/.emacs.d/lisp" \
	~/.emacs.d/

echo "Setting up Newsboat"
mkdir -p ~/.newsboat
ln -sf "${PWD}/.newsboat/urls" ~/.newsboat/urls
