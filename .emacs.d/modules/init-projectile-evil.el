(require 'init-evil)
(require 'init-general)

(init/space-definer
  :states 'motion
  :keymaps 'override

  "p" '(:ignore t :wk "project")
  "pf" '(projectile-find-file :wk "find-file")
  "pa" '(projectile-find-other-file :wk "find-other-file")
  "pp" '(projectile-switch-project :wk "switch-project")
  "pq" '(projectile-switch-open-project :wk "switch-open-project")
  "pi" '(projectile-invalidate-cache :wk "invalidate-cache")

  "ps" '(:ignore t :wk "search")
  "psa" '(projectile-ag :wk "agrep")
  "psr" '(projectile-ripgrep :wk "ripgrep")
  "psg" '(projectile-grep :wk "grep"))

(provide 'init-projectile-evil)
