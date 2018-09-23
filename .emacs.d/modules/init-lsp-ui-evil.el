(require 'init-general)
(require 'init-evil)

(init/space-definer
  :states 'motion
  :keymaps 'lsp-ui-mode-map

  "lu" '(:ignore t :wk "lsp-ui")
  "luf" 'lsp-ui-flycheck-list
  "lui" 'lsp-ui-imenu

  "lur" 'lsp-ui-peek-find-references
  "lud" 'lsp-ui-peek-find-definitions
  "lui" 'lsp-ui-peek-find-implementation)

(general-define-key
  :keymaps 'lsp-ui-peek-mode-map

  "q" 'lsp-ui-peek--abort

  "j" 'lsp-ui-peek--select-next
  "k" 'lsp-ui-peek--select-prev)

  

(provide 'init-lsp-ui-evil)
