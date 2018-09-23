(require 'use-package)

(use-package modern-cpp-font-lock
  :ensure t
  :hook
  (c++-mode . modern-c++-font-lock-mode))

(provide 'init-modern-font-lock)
