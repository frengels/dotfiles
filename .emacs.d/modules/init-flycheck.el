(require 'use-package)
(require 'init-lsp)

(use-package flycheck
  :ensure t
  :hook
  (lsp-mode . flycheck-mode))

(provide 'init-flycheck)
