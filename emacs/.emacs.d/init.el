;; init.el --- Emacs configuration

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ensure use-package package loader is installed and available
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
;; Enable the MELPA package repository
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;; Activate all the packages (in particular autoloads)
(package-initialize)
;; Fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))
;; Install the missing packages
(setq package-list '(use-package))
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))
;; (require 'use-package) - REDUNDANT?
;; The following is only needed once
(eval-when-compile
  (require 'use-package))

;;;;;;;;;;;;;;;
;; Basic config
;;;;;;;;;;;;;;;

(use-package better-defaults
  :ensure t)

;; Enable/disable line numbers globally
;(global-linum-mode t)

;; More attractive theme
(use-package material-theme
  :ensure t)
;; Load this theme
(load-theme 'material t)

;;;;;;;;;;;;;;
;; Git support
;;;;;;;;;;;;;;
(use-package evil-magit
  :ensure t)

;;;;;;;;;;;;;;;;;;;
;; Markdown support
;;;;;;;;;;;;;;;;;;;
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;;;;;;;;;;;;;;;;;
;; Python support
;;;;;;;;;;;;;;;;;
(use-package elpy
  :ensure t)
(elpy-enable)
(use-package py-autopep8
  :ensure t)
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;;;;;;;;;;;;;;;;;;
;; Haskell support
;;;;;;;;;;;;;;;;;;
(use-package haskell-mode
  :ensure t)

;;;;;;;;;;;;;;;;;;
;; Syntax checking
;;;;;;;;;;;;;;;;;;
(use-package flycheck
  :ensure t)
;; By default Emacs+elpy comes with a package called Flymake to
;; support syntax checking. However, another Emacs package, Flycheck,
;; is available and supports realtime syntax checking. Luckily
;; switching out for Flycheck is simple:
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-mode and evil-org-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Ensure that tab works in evil org mode
; (https://stackoverflow.com/a/22922161)
(setq evil-want-C-i-jump nil)

;; Install evil-org package
(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

;; From https://orgmode.org/worg/org-tutorials/orgtutorial_dto.html
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
;(setq org-log-done t)
(setq org-agenda-files (list "~/Dropbox/org/"))

; Save the clock history across Emacs sessions:
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)

; Hide DONE tasks in agenda view
(setq org-agenda-skip-scheduled-if-done t)
(org-clock-persistence-insinuate)
;  `with-eval-after-load' macro was introduced in Emacs 24.x
;  In older Emacsen, you can do the same thing with `eval-after-load'
;  and '(progn ..) form.
(with-eval-after-load 'org       
  ;(setq org-startup-indented t) ; Enable `org-indent-mode' by default
  (add-hook 'org-mode-hook #'visual-line-mode))
; NB can use 'orgzly' app on Android to interact with org-mode files shared via Dropbox

;; Enable evil mode
(evil-mode 1)

(defun org-feed-parse-RTM-entry (entry)
  "Parse the `:item-full-text' as a sexp and create new properties."
  (let ((xml (car (read-from-string (plist-get entry :item-full-text)))))
    ;; Get first <link href='foo'/>.
    (setq entry (plist-put entry :link
                           (xml-get-attribute
                            (car (xml-get-children xml 'link))
                            'href)))
    ;; Add <title/> as :title.
    (setq entry (plist-put entry :title
                           (xml-substitute-special
                            (car (xml-node-children
                                  (car (xml-get-children xml 'title)))))))
    ;; look for some other information that's in the content of the entry
    ;; the structure looks something like:
    ;; <content><div>   <div item> <span itemname></span><span itemvalue></span></div>...
    (let* ((content (car (xml-get-children xml 'content)))
           (main  (car (xml-get-children content 'div)))
           (items (xml-get-children main 'div)))
      (when items
        ; iterate over all items and check for certain classes
        (while items
          (setq item (car items))
          ; get the second span entry
          (setq valuesub (car (cdr (xml-node-children item))))
             (cond
              ((string= (xml-get-attribute item 'class) "rtm_due")
               (setq entry (plist-put entry :due (car (xml-node-children valuesub))))
               (setq mydate (car (xml-node-children valuesub)))
               ;; Any time will be stripped
               ;; Entries will be only schedued to a date
               (if (string= mydate "never")
                   nil
                   ;; entries could be scheduled to a date "Tue 4 Aug 15" 
                   ;; or to a date/time "Tue 4 Aug 15 at 10:00AM"
                   (if (string-match "^\\([a-zA-Z]*\\) \\([0-9]*\\) \\([a-zA-Z]*\\) \\([0-9]*\\) at \\([0-9:]*\\)" mydate)
                       (setq mydate (concat "20" (match-string 4 mydate) " " (match-string 3 mydate) " " (match-string 2 mydate) " " (match-string 5 mydate) ":01"))
                     (progn
                       (string-match "^\\([a-zA-Z]*\\) \\([0-9]*\\) \\([a-zA-Z]*\\) \\([0-9]*\\)$" mydate)
                       (setq mydate (concat "20" (match-string 4 mydate) " " (match-string 3 mydate) " " (match-string 2 mydate) " 00:00:01"))))
                 (progn
                  (setq mydate (parse-time-string mydate))
                  (setq mydate (apply #'encode-time mydate))
                  (setq mydate (format-time-string (car org-time-stamp-formats) mydate))
                  (setq entry (plist-put entry :dueorgformat mydate)))))
              ((string= (xml-get-attribute item 'class) "rtm_tags")
               (setq entry (plist-put entry :tags (car (xml-node-children valuesub)))))
              ((string= (xml-get-attribute item 'class) "rtm_time_estimate")
               (setq entry (plist-put entry :timeestimate (car (xml-node-children valuesub)))))
              ((string= (xml-get-attribute item 'class) "rtm_priority")
               (setq entry (plist-put entry :priority (car (xml-node-children valuesub)))))
              ((string= (xml-get-attribute item 'class) "rtm_location")
               (setq entry (plist-put entry :location (car (xml-node-children valuesub))))))
          (setq items (cdr items))
          )))
    entry))

(setq rtm-atom-feed-url "https://www.rememberthemilk.com/atom/willf_/?tok=eJwNzEEKAyEMBdATCYk-xrjsfu5QEo0w4K6FXr*zfzwF9RzTWtiYU2xFVkRXRRp3qxSBdDwGlITqGrFsCncGmXL53efsdzn351te11WYCFKxjI6o7eVrLJrxMAtjNdbdVlUf-A1EFJ3E")

(setq rtm-org-file-path "~/Dropbox/org/rtm.org")

(setq org-feed-alist
      '(("Remember The Milk"
         rtm-atom-feed-url
         rtm-org-file-path 
         "Remember The Milk"
         :parse-feed org-feed-parse-atom-feed
         :parse-entry org-feed-parse-RTM-entry
         :template "* TODO %title\n SCHEDULED:%dueorgformat\n Due: %due\n Location: %location\n Priority:%priority\n Tags:%tags\n %a\n "
         ;:filter org-feed-RTM-filter-non-scheduled
         )))

(defun myupdate-RTM ()
  "deletes old rtm.org and generates a new one"
  (save-current-buffer
    (if (not (eq nil (get-buffer "rtm.org")))
        (progn
         (kill-buffer (file-name-nondirectory rtm-org-file-path))
         (delete-file rtm-org-file-path)))
    (set-buffer (get-buffer-create (file-name-nondirectory rtm-org-file-path)))
    (write-file rtm-org-file-path)
    (org-feed-update-all)
    (save-buffer)))

;;* rtm feed timer
(run-at-time 60 60 'myupdate-RTM)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (haskell-mode material-theme elpy better-defaults use-package markdown-mode evil-org))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
