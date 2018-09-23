(require 'use-package)
(require 'init-swiper)

(use-package counsel
  :ensure t
  :config
  (counsel-mode))

(require 'init-counsel-evil)

(provide 'init-counsel)
