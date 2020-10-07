;; -*- lexical-binding: t -*-

(setq ring-bell-function 'ignore)

(blink-cursor-mode -1)

(fset 'yes-or-no-p 'y-or-n-p)

(set-language-environment "UTF-8")

(when (display-graphic-p)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

(show-paren-mode 1)
(setq show-paren-style 'expression
      show-paren-delay 0)

(add-to-list 'default-frame-alist
             '(font . "Fira Mono 11"))

(require 'package)

(setq package-archives nil)

(require 'use-package)

(use-package avy
  :bind (("M-g g" . avy-goto-line))
  :config
  (setq avy-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)) ; switch for colemak
  (setq avy-style 'at-full)
  (setq avy-all-windows t))

(use-package which-key
  :init
  (setq which-key-idle-delay 0.4)
  (setq which-key-popup-type 'side-window)
  :config
  (which-key-mode))
  
(use-package counsel
  :demand t)

(use-package projectile
  :demand t
  :bind (:map projectile-mode-map
              ("C-c p" . projectile-command-map))
  :config
  (projectile-mode))

(use-package direnv
  :config
  (direnv-mode))

(use-package counsel-projectile
  :demand t
  :after (counsel projectile)
  :config
  (counsel-projectile-mode)
  (define-key projectile-mode-map
    [remap projectile-ag]
    #'counsel-projectile-rg))

(use-package ivy
  :demand t
  :init
  (ivy-mode 1)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-height 20)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-display-style 'fancy)
  (setq projectile-completion-system 'ivy))

(use-package magit)

(use-package smooth-scrolling
  :config
  (smooth-scrolling-mode 1))

(defvar evil-leader-map (make-sparse-keymap))

(use-package evil
  :functions (evil-global-set-key)
  :init
  (setq evil-want-integration t ; both settings required for evil-collection
	evil-want-keybinding nil)
  (evil-mode)
  :config
  (evil-global-set-key 'motion (kbd ";") #'evil-ex)
  (evil-global-set-key 'motion (kbd ":") #'evil-repeat-find-char))

(use-package evil-magit
  :after (evil magit))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package key-chord
  :init
  (setq key-chord-two-keys-delay 0.1)
  (setq key-chord-one-key-delay 0.2)
  :config
  (key-chord-mode 1)
  (key-chord-define evil-insert-state-map "fd" #'evil-normal-state))

(use-package company
  :defer 3
  :config
  (setq company-minimum-prefix-length 1)
  :hook
  (after-init . global-company-mode))

(use-package nix-mode
  :mode "\\.nix\\'")

(use-package cmake-mode
  :mode ("CMakeLists.txt" "\\.cmake\\'"))

(use-package gitignore-mode
  :mode "\.gitignore")

(use-package gitconfig-mode
  :mode "\.gitconfig")

(use-package treemacs)

(use-package treemacs-projectile
  :after (treemacs projectile))

(use-package treemacs-magit
  :after (treemacs magit))

;; load a selection of themes
(use-package moe-theme
  :defer t)
(use-package spacemacs-theme
  :defer t
  :init
  (load-theme 'spacemacs-dark t))
(use-package material-theme
  :defer t)

(use-package format-all)

(use-package hydra
  :config
  (defun fe/disable-all-themes ()
    (interactive)
    (mapc #'disable-theme custom-enabled-themes))
  (defhydra fe/themes-hydra (:hint nil :color pink)
    "
Themes

^Spacemacs^   ^Moe^       ^Material^
_s_: Dark     _m_: Dark   _a_: Dark    _DEL_: none
_S_: Light    _M_: Light  _A_: Light
"
    ("s" (load-theme 'spacemacs-dark t))
    ("S" (load-theme 'spacemacs-light t))
    ("m" (load-theme 'moe-dark t))
    ("M" (load-theme 'moe-light t))
    ("a" (load-theme 'material t))
    ("A" (load-theme 'material-light t))
    ("DEL" (fe/disable-all-themes))
    ("RET" nil "done" :color blue)))
