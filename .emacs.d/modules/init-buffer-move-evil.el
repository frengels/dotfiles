(require 'init-evil)
(require 'init-general)

(init/space-definer
  :states 'motion
  :keymaps 'override

  "bH" '(buf-move-left :wk "move-left")
  "bL" '(buf-move-right :wk "move-right")
  "bJ" '(buf-move-down :wk "move-down")
  "bK" '(buf-move-up :wk "move-up"))


(provide 'init-buffer-move-evil)
