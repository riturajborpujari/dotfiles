(setq flymake-no-changes-timeout nil)
(setq flymake-start-on-flymake-mode t)
(setq flymake-start-on-save-buffer t)

(setq eldoc-idle-delay 0)
(setq eldoc-echo-area-use-multiline-p nil)

(add-hook 'eglot-managed-mode-hook
          (lambda ()
            (eldoc-mode 0)
            (flymake-mode 0)))

(provide 'lsp)
