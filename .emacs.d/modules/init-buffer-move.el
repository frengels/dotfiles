(require 'use-package)

(use-package buffer-move
  :ensure t
  :commands
  (buf-move-left buf-move-right buf-move-up buf-move-down))

(require 'init-buffer-move-evil)

(provide 'init-buffer-move)
