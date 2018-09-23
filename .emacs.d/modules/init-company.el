(require 'use-package)

(use-package company
  :ensure t
  :hook
  (after-init . global-company-mode)
  :config
  (setq company-idle-delay .1)
  (setq company-minimum-prefix-length 1)
  (setq company-show-numbers 0)
  (setq company-tooltip-align-annotations t))

 (provide 'init-company)
