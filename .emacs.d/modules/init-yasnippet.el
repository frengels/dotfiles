(require 'use-package)

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode)
  (yas-reload-all))

(use-package yasnippet-snippets
  :ensure t)

(provide 'init-yasnippet)
