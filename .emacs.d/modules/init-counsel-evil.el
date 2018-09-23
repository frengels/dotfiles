(require 'init-evil)
(require 'init-general)

(init/space-definer
  :states 'motion
  :keymaps 'override

  "fo" '(counsel-locate-action-extern :wk "xdg-open")
  "bb" 'counsel-ibuffer)

(provide 'init-counsel-evil)
