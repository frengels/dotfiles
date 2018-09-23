(require 'use-package)

;(require 'init-eglot)
(require 'init-lsp)

(use-package cquery
  :ensure t
  :config
  (setq cquery-executable "/usr/bin/cquery")
  :hook
  (c-mode-common . lsp-cquery-enable))

(provide 'init-cquery)
