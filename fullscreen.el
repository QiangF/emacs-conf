;; this just maximize
(make-variable-frame-local 'my-frame-state)


(defun my-frame-maximize ()
  "Maximize Emacs window in win32"
  (interactive)

  (modify-frame-parameters nil '((my-frame-state . t)))
  (w32-send-sys-command ?\xf030))

(defun my-frame-restore ()
  "Restore Emacs window in win32"
  (interactive)

  (modify-frame-parameters nil '((my-frame-state . nil)))
  (w32-send-sys-command ?\xF120))

(defun my-frame-toggle ()
  "Maximize/Restore Emacs frame based on `my-frame-state'"
  (interactive)
  (if my-frame-state
    (my-frame-restore)
    (my-frame-maximize)))
;(my-frame-toggle)
(my-frame-maximize)
