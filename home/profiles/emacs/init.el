;; -*- lexical-binding: t -*-

(when (display-graphic-p)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

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
  (setq ivy-display-style 'fancy))

(use-package magit)
