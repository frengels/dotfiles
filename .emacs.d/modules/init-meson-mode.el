(require 'use-package)
(require 'init-company)

(use-package meson-mode
  :ensure t
  :hook
  (meson-mode . company-mode))

(provide 'init-meson-mode)
