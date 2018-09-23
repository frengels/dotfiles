(require 'init-general)

(init/space-definer
  :definer 'minor-mode
  :states 'motion
  :keymaps 'lsp-mode

  "l" '(:ignore t :wk "lsp")
  "lr" 'lsp-rename
  "lR" 'lsp-restart-workspace
  "lg" '(:ignore t :wk "goto")
  "lgt" 'lsp-goto-type-definition
  "lgi" 'lsp-goto-implementation)
  

(provide 'init-lsp-evil)
