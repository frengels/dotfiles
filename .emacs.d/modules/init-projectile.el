(require 'use-package)

(use-package projectile
  :ensure t
  :config
  (projectile-mode t)
  (setq projectile-enable-caching t)

  (add-to-list 'projectile-globally-ignored-directories "build")
  (add-to-list 'projectile-globally-ignored-directories ".cquery_cached_index")

  (add-to-list 'projectile-globally-ignored-file-suffixes ".o")
  (add-to-list 'projectile-globally-ignored-file-suffixes ".so"))

(require 'init-projectile-evil)

(provide 'init-projectile)
