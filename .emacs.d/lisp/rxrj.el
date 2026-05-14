(require 'ox-publish)
(add-to-list 'load-path "~/.emacs.d/lisp/org-publish-rss/")
(require 'org-publish-rss)

(defun rxrj-publish ()
  (interactive)
  (rxrj-generate-devlog-index)
  (org-publish "rxrj" t))

(defun rxrj-html-preamble (info)
  (let ((filename (plist-get info :input-file)))
    (if (string-match-p "/index\\.org$" filename)
        ""
      "<div class=\"site-nav\">
         <a href=\"/\">Home</a>
       </div>")))

(defun rxrj-generate-devlog-index ()
  (interactive)
  (let* ((notes-dir "~/docs/rxrj/devlog/")
         (files (directory-files notes-dir t "\\.org$"))
         (entries '()))
    (dolist (file files)
      (with-temp-buffer
        (insert-file-contents file)
        (let ((title (cadr (assoc "TITLE" (org-collect-keywords '("TITLE")))))
              (date  (cadr (assoc "DATE"  (org-collect-keywords '("DATE"))))))
          (push
           (format "- [%s] [[file:%s][%s]]"
                   date
                   (file-relative-name file "~/docs/rxrj/")
                   title)
           entries))))
    (setq entries (sort entries #'string>))
    (with-temp-buffer
      (insert-file-contents "~/docs/rxrj/index.org")
      (goto-char (point-min))
      (re-search-forward "^\\* Devlog\n")
      (delete-region (point) (point-max))
      (insert (mapconcat #'identity entries "\n"))
      (write-file "~/docs/rxrj/index.org"))))


(setq org-publish-project-alist
  	  '(
        ("rxrj-notes"
         :base-directory "~/docs/rxrj"
         :base-extension "org"
         :publishing-directory "~/docs/rxrj/public"
         :recursive t
         :exclude "meta/"
         :publishing-function org-html-publish-to-html
         :headline-levels 4
         :auto-preamble f
		 
         :html-head "<link rel=\"stylesheet\" href=\"/static/style.css\" />"
         :html-preamble rxrj-html-preamble
         :html-postamble nil

		 :html-link-home ""
		 :html-link-up ""

         :auto-rss t
         :rss-title "rxrj"
		 :rss-link "https://riturajb.dev"
         :rss-description "Devlog of Rituraj Borpujari"
         :rss-with-content all
		 :completion-function org-publish-rss)
		
        ("rxrj-static"
         :base-directory "~/docs/rxrj/static"
         :base-extension "css\\|\\|png\\|jpg\\|jpeg\\|gif"
         :publishing-directory "~/docs/rxrj/public/static"
         :recursive t
         :publishing-function org-publish-attachment)
		
        ("rxrj-rss"
         :base-directory "~/docs/rxrj"
         :base-extension "xml"
         :publishing-directory "~/docs/rxrj/public"
         :include ("rss.xml")
         :publishing-function org-publish-attachment)
		
        ("rxrj"
         :components ("rxrj-notes" "rxrj-static" "rxrj-rss"))))

(provide 'rxrj)
