(require 'use-package)

(require 'init-company)
(require 'init-lsp)

(use-package company-lsp
  :ensure t
  :config
  (setq company-transformers nil
	company-lsp-async t
	company-lsp-cache-candidates nil)
  (add-to-list 'company-backends 'company-lsp))

(provide 'init-company-lsp)
