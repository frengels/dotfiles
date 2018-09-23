(require 'use-package)

(use-package ivy
  :ensure t
  :init
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (setq ivy-display-style 'fancy)
  :config
  (ivy-mode t)
  (setq projectile-completion-system 'ivy))

(provide 'init-ivy)
