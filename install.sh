PWD=$(pwd)

echo "Setting up '${HOME}/.local' directories"
mkdir -p ~/.local/{bin,lib,share,shate,var}
mkdir -p ~/.local/var/vim/{better-sessions,undo}
mkdir -p ~/.local/var/dmk

echo "Setting up Bash"
ln -sf "${PWD}/.bashrc" ~/.bashrc

echo "Setting up Fzf-Preview"
install "${PWD}/fzf-preview" ~/.local/bin/

echo "Setting up XDG Directories"
ln -sf "${PWD}/.config/user-dirs.dirs" ~/.config/user-dirs.dirs

echo "Setting up Hyprland, EWW, Quickshell, Tofi, Kitty, Vim, Zathura"
ln -sf \
	"${PWD}/.config/hypr" \
	"${PWD}/.config/eww" \
	"${PWD}/.config/quickshell" \
	"${PWD}/.config/tofi" \
	"${PWD}/.config/kitty" \
	"${PWD}/.config/vim" \
	"${PWD}/.config/zathura" \
	~/.config/

echo "Setting up Emacs"
mkdir -p ~/.emacs.d
ln -sf "${PWD}/.emacs.d/init.el" ~/.emacs.d/init.el
ln -sf "${PWD}/.emacs.d/early-init.el" ~/.emacs.d/early-init.el
ln -sf "${PWD}/.emacs.d/lisp" ~/.emacs.d/

echo "Setting up Newsboat"
mkdir -p ~/.newsboat
ln -sf "${PWD}/.newsboat/urls" ~/.newsboat/urls
