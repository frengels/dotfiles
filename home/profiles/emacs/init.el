;; -*- lexical-binding: t -*-

(require 'package)

(setq package-archives nil)

(require 'use-package)

(use-package avy
  :bind (("M-g g" . avy-goto-line))
  :config
  (setq avy-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l ?)) ; switch for colemak
  (setq avy-style 'at-full)
  (setq avy-all-windows t))
