(require 'use-package)

(use-package eglot
  :ensure t
  :hook
  (c-mode-common . eglot-ensure)
  (rust-mode . eglot-ensure))

(provide 'init-eglot)
