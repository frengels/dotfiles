(require 'use-package)

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration nil)
  :config
  (evil-mode t))

(use-package evil-escape
  :ensure t
  :after (evil)
  :config
  (evil-escape-mode t)
  (setq-default evil-escape-key-sequence "fd")
  (setq-default evil-escape-delay 0.15))

(use-package evil-magit
  :ensure t
  :after (evil))

(use-package evil-org
  :ensure t
  :after (evil)
  :hook
  (org-mode . evil-org-mode)
  :config
  (evil-org-set-key-theme '(textobjects insert navigation additional shift todo heading)))

(use-package evil-surround
  :ensure t
  :after (evil)
  :config
  (global-evil-surround-mode t))
  
(provide 'init-evil)
