(require 'use-package)

(use-package which-key
  :ensure t
  :config
  (which-key-mode t)
  (which-key-setup-side-window-bottom))

(provide 'init-which-key)
