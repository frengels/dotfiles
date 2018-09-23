(require 'use-package)
(require 'init-evil)

(use-package general
  :ensure t
  :config
  (general-evil-setup t))

(provide 'init-general)
