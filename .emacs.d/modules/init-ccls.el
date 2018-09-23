(require 'use-package)
(require 'init-lsp)

(use-package ccls
  :commands lsp-ccls-enable
  :config
  (setq ccls-executable "/usr/bin/ccls")
  :hook
  (c-mode-common . lsp-ccls-enable))

(provide 'init-ccls)
