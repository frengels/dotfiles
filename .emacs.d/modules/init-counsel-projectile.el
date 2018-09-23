(require 'use-package)

(require 'init-counsel)
(require 'init-projectile)

(use-package counsel-projectile
  :ensure t
  :config
  (counsel-projectile-mode t))

(provide 'init-counsel-projectile)
