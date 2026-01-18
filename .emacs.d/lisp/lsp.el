(setq flymake-no-changes-timeout nil)
(setq flymake-start-on-flymake-mode t)
(setq flymake-start-on-save-buffer t)
(global-set-key (kbd "C-c d") 'flymake-start)

(setq eldoc-idle-delay 0)
(setq eldoc-echo-area-use-multiline-p nil)
(global-set-key (kbd "C-c h") 'eldoc-mode)
(global-set-key (kbd "C-c k") 'eldoc-print-current-symbol-info)

(add-hook 'eglot-managed-mode-hook
          (lambda ()
            (eldoc-mode 0)
            (flymake-mode 0)))

(provide 'lsp)
