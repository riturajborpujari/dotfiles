(custom-theme-set-faces
 'user
 
 '(default ((t (:background "#161616" :foreground "#efefef"))))
 '(whitespace-tab ((t (:background "#181818" :foreground "#303030"))))
 '(font-lock-string-face ((t (:foreground "#30d020"))))
 '(font-lock-keyword-face ((t (:foreground "#efefef"))))
 '(font-lock-function-name-face ((t (:foreground "#fdc04b" :bold t))))
 '(font-lock-preprocessor-face ((t (:foreground "#efefef" :bold t))))
 '(font-lock-variable-name-face ((t (:foreground "#efefef"))))
 '(font-lock-type-face ((t (:foreground "#d0e0d0" :bold t))))
 '(font-lock-constant-face ((t (:foreground "#30d020"))))
 '(font-lock-builtin-face ((t (:foreground "#fdc04b"))))
 '(region ((t (:background "#444444"))))
 '(mode-line ((t (:background "#242424" :foreground "#efefef" :box nil))))
 '(mode-line-inactive ((t (:background "#1c1c1c" :foreground "#777777" :box nil))))
 '(line-number ((t (:foreground "#444444"))))
 '(line-number-current-line ((t (:foreground "#e5c07b"))))
 '(minibuffer-prompt ((t (:foreground "#fdc04b"))))
 '(link ((t (:foreground "#fdc04b" :underline t))))
 '(cursor ((t (:foreground "#ff0000" :background "#fdc04b"))))
 '(link-visited ((t (:foreground "#fdc04b" :underline t)))))

(defun minimal-c-function-call-font-lock ()
  (font-lock-add-keywords
   nil
   '(("\\_<\\([A-Za-z_][A-Za-z0-9_]*\\)\\s-*("
      1 font-lock-function-name-face))))

(add-hook 'c-mode-hook #'minimal-c-function-call-font-lock)

(provide 'colorscheme)
