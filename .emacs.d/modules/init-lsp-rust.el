(require 'use-package)

(require 'init-lsp)
(require 'init-rust)

(use-package lsp-rust
  :ensure t
  :hook
  (rust-mode . lsp-rust-enable)
  (rust-mode . flycheck-mode))

(provide 'init-lsp-rust)
