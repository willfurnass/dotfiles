;; Ensure use-package package loader is installed and available
(require 'package)
;  Enable the MELPA package repository
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;  Activate all the packages (in particular autoloads)
(package-initialize)
;  Fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))
;  Install the missing packages
(setq package-list '(use-package))
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))
;  (require 'use-package) - REDUNDANT?
;  The following is only needed once
(eval-when-compile
  (require 'use-package))

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

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

;; Org mode config
;  (from https://orgmode.org/worg/org-tutorials/orgtutorial_dto.html)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
;(setq org-log-done t)
(setq org-agenda-files (list "~/Dropbox/org/"))
; Save the clock history across Emacs sessions:
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)

; NB can use 'orgzly' app on Android to interact with org-mode files shared via Dropbox

;; Enable evil mode
(evil-mode 1)
