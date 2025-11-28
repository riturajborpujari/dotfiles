(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(dolist (pkg '(gruber-darker-theme multiple-cursors go-mode))
  (unless (package-installed-p pkg)
    (package-refresh-contents)
    (package-install pkg)))

(load-theme 'gruber-darker t)

(let ((backup-dir (expand-file-name "backups/" user-emacs-directory))
      (auto-dir   (expand-file-name "auto-save/" user-emacs-directory)))
  (make-directory backup-dir t)
  (make-directory auto-dir t)
  (setq backup-directory-alist `(("." . ,backup-dir))
        auto-save-file-name-transforms `((".*" ,auto-dir t))
        auto-save-list-file-prefix (concat auto-dir ".saves-")
        create-lockfiles nil))

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)
(set-face-attribute 'default nil :font "NotoSansM NFM ExtCondLight-21")
(setq-default tab-width 4)
(global-set-key (kbd "TAB") 'self-insert-command)
(global-set-key (kbd "M-m") #'compile)
(global-set-key (kbd "M-n") #'recompile)
(setq c-basic-offset 4)
(setq indent-tabs-mode nil)
(setq grep-command "grep -rn ")
(setq display-buffer-alist
      '(("\\*compilation\\*"
         (display-buffer-reuse-window display-buffer-at-bottom))))
(setq doc-view-continuous 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(empv go-mode gruber-darker-theme multiple-cursors)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
