(require 'use-package)

(use-package clang-format
  :ensure t
  :bind
  (:map c-mode-map
	("C-c C-f" . clang-format-buffer)
	:map c++-mode-map
	("C-c C-f" . clang-format-buffer)
	:map objc-mode-map
	("C-c C-f" . clang-format-buffer)))

(provide 'init-clang-format)
