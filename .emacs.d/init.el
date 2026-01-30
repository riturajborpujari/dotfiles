(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(dolist (pkg '(multiple-cursors go-mode magit))
  (unless (package-installed-p pkg)
    (package-refresh-contents)
    (package-install pkg)))

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-M-h") 'backward-kill-word)
(global-set-key (kbd "M-m") #'compile)
(global-set-key (kbd "M-n") #'recompile)

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(setq display-line-numbers-type 't)
(global-display-line-numbers-mode t)

(set-face-attribute 'default nil
                    :family "NotoSansM Nerd Font Mono"
                    :height 250
                    :weight 'light
                    :width 'extra-condensed)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq c-basic-offset 4)

(setq whitespace-style '(face tabs tab-mark))
(global-whitespace-mode 1)
(setq-default auto-save-mode nil)
(setq grep-command "grep -rn ")

(setq scroll-step 1)
(setq scroll-margin 0)
(setq doc-view-continuous 1)

(defun open-in-zathura ()
  (interactive)
  (start-process "zathura" nil "zathura" (buffer-file-name)))
(add-to-list 'auto-mode-alist '("\\.pdf\\'" . (lambda ()
                                                (open-in-zathura)
                                                (kill-buffer))))

(let ((backup-dir (expand-file-name "backups/" user-emacs-directory))
      (auto-dir   (expand-file-name "auto-save/" user-emacs-directory)))
  (make-directory backup-dir t)
  (make-directory auto-dir t)
  (setq backup-directory-alist `(("." . ,backup-dir))
        auto-save-file-name-transforms `((".*" ,auto-dir t))
        auto-save-list-file-prefix (concat auto-dir ".saves-")
        create-lockfiles nil))

(require 'eglot)
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'colorscheme)
(require 'lsp)
(add-hook 'python-mode-hook (lambda ()
                              (require 'venv)
                              (auto-revert-mode 0)
                              (eldoc-mode 0)))
(add-hook 'go-mode-hook (lambda ()
                          (setenv "GOPATH"
                                  (concat
                                   (getenv "HOME")
                                   "/.local/lib/go"))))
