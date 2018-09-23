(require 'use-package)

(require 'init-flycheck)
(require 'init-lsp)

(use-package lsp-ui
  :ensure t
  :hook
  (lsp-mode . lsp-ui-mode))

(require 'init-lsp-ui-evil)

(provide 'init-lsp-ui)
