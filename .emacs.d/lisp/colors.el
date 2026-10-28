;;; -*- lexical-binding: t; -*-
(defun my/apply-color-theme (theme)
  "Apply THEME, which must be 'dark' or 'light'"
  (unless (memq theme '(dark light))
    (user-error "Theme must be dark or light"))
  (let* ((dark         (eq theme 'dark))
         (bg           (if dark "#181818" "#efefef"))
         (fg           (if dark "#efefef" "#181818"))
         (accent       (if dark "#fdc04b" "#af4000"))
         (string       (if dark "#30d020" "#108010"))
         (keyword      (if dark "#efefef" "#363636"))
         (function     (if dark "#fdc04b" "#114488"))
         (type         (if dark "#d0f0d0" "#363636"))
         (constant     (if dark "#30d020" "#d04010"))
         (region-bg    (if dark "#444444" "#d0e0f0"))
         (mode-bg      (if dark "#242424" "#d0d0d0"))
         (inactive-bg  (if dark "#1c1c1c" "#e5e5e5"))
         (inactive-fg  (if dark "#777777" "#888888"))
         (org-accent   (if dark "#f5c04b" accent))
		 
         (faces
          `((default :background ,bg :foreground ,fg)
            (whitespace-tab :background ,bg :foreground ,(if dark "#303030" "#181818"))
            (font-lock-string-face :foreground ,string)
            (font-lock-keyword-face :foreground ,keyword)
            (font-lock-function-name-face :foreground ,function)
            (font-lock-preprocessor-face :foreground ,keyword)
            (font-lock-variable-name-face :foreground ,keyword)
            (font-lock-type-face :foreground ,type)
            (font-lock-constant-face :foreground ,constant)
            (font-lock-builtin-face :foreground ,accent)
            (region :background ,region-bg)
            (mode-line :background ,mode-bg
                       :foreground ,(if dark fg "#242424")
                       :box nil)
            (mode-line-inactive :background ,inactive-bg
                                :foreground ,inactive-fg
                                :box nil)
            (line-number :inherit default :foreground "#444444")
            (line-number-current-line :inherit default
                                      :foreground ,(if dark "#e5c07b" "#114488"))
            (minibuffer-prompt :foreground ,accent)
            (org-verbatim :foreground ,org-accent)
            (org-code :foreground ,org-accent)
            (org-document-title :foreground ,org-accent :bold t)
            (org-document-info :foreground ,org-accent)
            (cursor :foreground ,bg :background ,fg)
            (link :foreground ,org-accent :underline t)
            (company-tooltip :background ,(if dark "#282828" "#ffffff"))
            (company-tooltip-common :foreground ,accent)
            (link-visited :foreground ,org-accent :underline t))))
    (dolist (spec faces)
      (apply #'set-face-attribute (car spec) nil (cdr spec)))
    (message "Set %s theme" theme)))

(defun my/set-theme (&optional theme)
  "Set THEME to `dark' or `light'; default to `dark'."
  (interactive
   (list (intern (completing-read "Theme (dark/light): "
                                  '("dark" "light")
                                  nil t nil nil "dark"))))
  (my/apply-color-theme (or theme 'dark)))

(defun my/toggle-theme ()
  "Toggle between dark and light themes."
  (interactive)
  (let ((current-bg (face-attribute 'default :background nil 'default)))
    (my/apply-color-theme
     (if (equal current-bg "#181818") 'light 'dark))))


(provide 'colors)
