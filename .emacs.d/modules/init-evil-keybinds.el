(require 'init-evil)
(require 'init-general)

(defun init/rename-file-and-buffer (new-name)
  "Rename the current buffer and file"
  (interactive "sNew name: ")
  (let ((name (buffer-name))
	(filename (buffer-file-name)))
    (if (not filename)
	(message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
	  (message "A buffer named '%s' already exists!" new-name)
	(progn
	  (rename-file filename new-name 1)
	  (rename-buffer new-name)
	  (set-visited-file-name new-name)
	  (set-buffer-modified-p nil))))))

(defun init/delete-file-and-buffer ()
  "Kill the current buffer and delete the visited file"
  (interactive)
  (let ((filename (buffer-file-name)))
    (if filename
	(if (yes-or-no-p (concat "Delete file '" filename "'?"))
	    (progn
	      (delete-file filename)
	      (message "Deleted file '%s'." filename)
	      (kill-buffer)))
      (message "Not a file visiting buffer!"))))

(general-create-definer init/space-definer
			:prefix "SPC")

;; swap ; and : functionality for evil
(general-mmap
 ";" 'evil-ex
 ":" 'evil-repeat-find-char)

(init/space-definer
  :states 'motion
  :keymaps 'override

  "SPC" '(execute-extended-command :wk "M-x")

  "f" '(:ignore t :wk "file")
  "ff" 'find-file
  "fs" 'save-buffer
  "fr" 'rename-file
  "fR" '(init/rename-file-and-buffer :wk "rename-file-and-buffer")
  "fd" 'delete-file
  "fD" '(init/delete-file-and-buffer :wk "delete-current-file")

  "fe" '(:ignore t :wk "emacs")
  "fel" 'load-file
  "feR" '(init/load-init :wk "load-init")
  "fec" '(init/edit-init :wk "edit-init")

  "w" '(:ignore t :wk "window")
  "wl" '(windmove-right :wk "move-right")
  "wh" '(windmove-left :wk "move-left")
  "wj" '(windmove-down :wk "move-down")
  "wk" '(windmove-up :wk "move-up")
  "wd" 'delete-window
  "wq" 'delete-window
  "wD" 'kill-buffer-and-window
  "w/" '(split-window-horizontally :wk "split-horizontally")
  "w-" '(split-window-vertically :wk "split-vertically")

  "b" '(:ignore t :wk "buffer")
  "bh" '(previous-buffer :wk "previous")
  "bl" '(next-buffer :wk "next")
  "bd" '(kill-buffer :wk "kill")
  "bq" '(kill-current-buffer :wk "kill-current")
  "bD" '(kill-current-buffer :wk "kill-current")
  "bE" 'eval-buffer

  "h" '(:ignore t :wk "help")
  "hc" 'describe-char
  "hm" 'describe-mode
  "hf" 'describe-function
  "hk" 'describe-key
  "hp" 'describe-package
  "ht" 'describe-theme
  "hv" 'describe-variable)


(provide 'init-evil-keybinds)
 
