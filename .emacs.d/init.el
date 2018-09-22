;; functions to reload and edit the init file

(defun init/edit-init ()
  "Open the init file for editing and making changes"
  (interactive)
  (find-file (concat user-emacs-directory "init.el")))

(defun init/load-init ()
  "Load the init file to make changes apply"
  (interactive)
  (load-file (concat user-emacs-directory "init.el")))

;; config for package

(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

;; make sure we have =use-package= installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; =use-package= is used for installing packages
(require 'use-package)
(setq use-package-always-ensure t) ; always make sure packages are installed

(add-to-list 'load-path (concat user-emacs-directory "modules"))
(add-to-list 'load-path "/usr/share/emacs/site-lisp")

;; personal information

(setq user-full-name "Frederik Engels"
      user-mail-address "frederik.engels24@gmail.com")

;; change backups to use a better folder

(setq
 backup-by-copying t
 backup-directory-alist '(("." . "~/.emacs.d/backups"))
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)

;; window configuration disable all unneeded bars etc

(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;; use fira mono 11 as our default font
;; change to fira code when emacs supports ligatures

(set-frame-font "Fira Mono 11")

;; use the spacemacs theme because it's pretty

(use-package spacemacs-theme
  :defer t
  :init
  (load-theme 'spacemacs-dark t))

;; use y or n instead of yes or no

(fset 'yes-or-no-p 'y-or-n-p)

;; use UTF8 by default

(set-language-environment "UTF-8")


(require 'init-evil)
(require 'init-evil-keybinds)
(require 'init-projectile)
(require 'init-counsel-projectile)
(require 'init-company)
;(require 'init-eglot)
(require 'init-company-lsp)
(require 'init-lsp-ui)
;;(require 'init-ccls)
(require 'init-cquery)
(require 'init-lsp-rust)
(require 'init-buffer-move)
(require 'init-yasnippet)
(require 'init-which-key)
(require 'init-evil-collection)
(require 'init-modern-font-lock)

(require 'init-clang-format)

(require 'init-meson-mode)

;; org capture settings

(setq org-agenda-files (list "~/org/organizer.org"))
(setq org-default-notes-file "~/org/organizer.org")
(init/space-definer
  :states 'motion
  :keymaps 'override

  "o" '(:ignore t :wk "org")
  "oo" '((lambda() (interactive) (find-file "~/org/organizer.org")) :wk "org/organizer")
  "oc" 'org-capture)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (modern-cpp-font-lock evil-collection ccls clang-format meson-mode cargo lsp-rust rust-mode yasnippet-snippets lsp-ui eglot cquery company-lsp lsp-mode counsel-projectile yasnippet projectile buffer-move which-key counsel general evil-surround evil-org evil-magit evil-escape evil company spacemacs-theme use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
