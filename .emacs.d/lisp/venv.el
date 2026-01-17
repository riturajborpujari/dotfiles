(defun venv-setup ()
  (when-let* ((current-path (getenv "PATH"))
              (venv-bin (expand-file-name "venv/bin" (file-name-directory (buffer-file-name)))))
    (when (file-directory-p venv-bin)
      (unless (string-match-p (regexp-quote venv-bin) current-path)
        (setenv "PATH" (concat venv-bin ":" current-path))
        (setq exec-path (cons venv-bin exec-path))))))

(provide 'venv)
