(require 'package)

; list the packages you want
;(setq package-list '(evil org-evil))
(setq package-list '(evil))

; list the repositories containing them
;(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
;                         ("gnu" . "http://elpa.gnu.org/packages/")
;                         ("marmalade" . "http://marmalade-repo.org/packages/")))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)
