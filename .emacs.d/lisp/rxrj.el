(require 'ox-publish)
(add-to-list 'load-path "~/.emacs.d/lisp/org-publish-rss/")
(require 'org-publish-rss)

(defun rxrj-publish ()
  (interactive)
  (rxrj-generate-subdir-index "~/docs/rxrj" "~/docs/rxrj/devlog" "^\\* Devlog\n")
  (org-publish "rxrj" t))

(defun rxrj-html-preamble (info)
  (let ((filename (plist-get info :input-file)))
    (if (string-match-p "/index\\.org$" filename)
        ""
        "<div class=\"site-nav\"><a href=\"/\">Home</a></div>")))

(defun rxrj-generate-subdir-index (project-dir subdir index-section-identifier)
  (interactive)
  (let* ((entry-links
		  (rxrj-format-org-entries-as-links
		   (rxrj-get-org-entries project-dir subdir)))
		 (index-file (expand-file-name "index.org" project-dir)))
    (with-temp-buffer
	  (org-mode)
      (insert-file-contents index-file)
      (goto-char (point-min))
      (re-search-forward index-section-identifier)
      (let ((beg (point))
			(end (save-excursion (org-end-of-subtree t t) (point))))
		(delete-region beg end))
      (insert (mapconcat #'identity entry-links "\n"))
      (write-file index-file))))

(defun rxrj-get-org-entries (org-project-dir org-file-dir)
  (interactive)
  (let* ((files (directory-files org-file-dir t "\\.org$"))
	   (entries '()))
	(dolist (file files)
	  (with-temp-buffer
		(insert-file-contents file)
		(org-mode)
		(let
			((title (cadr (assoc "TITLE" (org-collect-keywords '("TITLE")))))
			 (date (cadr (assoc "DATE" (org-collect-keywords '("DATE"))))))
		  (push
		   (list :date date :title title :path (file-relative-name file org-project-dir))
		   entries))))
	(sort entries
		  (lambda (a b)
			(string>
			 (plist-get a :date)
			 (plist-get b :date))))))

(defun rxrj-format-org-entries-as-links (entries)
  (mapcar
   (lambda (entry)
	 (format "- %s [[file:%s][%s]]"
			 (plist-get entry :date)
			 (plist-get entry :path)
			 (plist-get entry :title)))
   entries))

(defun rxrj-format-org-entries-as-paths (entries)
  (mapcar
   (lambda (entry)
	 (format "%s"
			 (plist-get entry :path)))
   entries))

(setq org-publish-project-alist
  	  '(
        ("rxrj-devlog"
         :base-directory "~/docs/rxrj/devlog"
         :base-extension "org"
         :publishing-directory "~/docs/rxrj/public/devlog"
         :recursive t
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

		("rxrj-index"
		 :base-directory "~/docs/rxrj"
		 :base-extension "org"
		 :publishing-directory "~/docs/rxrj/public"
		 :include ("index.org")

		 :html-head "<link rel=\"stylesheet\" href=\"/static/style.css\" />"
         :html-preamble nil
         :html-postamble nil

		 :publishing-function org-html-publish-to-html)
		
        ("rxrj-static"
         :base-directory "~/docs/rxrj/static"
         :base-extension "css\\|\\|png\\|jpg\\|jpeg\\|gif"
         :publishing-directory "~/docs/rxrj/public/static"
         :recursive t
         :publishing-function org-publish-attachment)

		("rxrj-rss"
         :base-directory "~/docs/rxrj/devlog"
		 :base-extension "xml"
         :publishing-directory "~/docs/rxrj/public"
         :include ("rss.xml")
         :publishing-function org-publish-attachment)
		
        ("rxrj-cname"
         :base-directory "~/docs/rxrj"
         :publishing-directory "~/docs/rxrj/public"
		 :exclude ".*"
         :include ("CNAME")
         :publishing-function org-publish-attachment)
				
        ("rxrj"
         :components ("rxrj-devlog" "rxrj-index" "rxrj-static" "rxrj-rss" "rxrj-cname"))))

(provide 'rxrj)
