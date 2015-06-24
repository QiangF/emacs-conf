
;; 放在末尾的话有副作用, 至少保证在keybinding之前. 
(require 'cl)
(setq basepath "c:/bin/config/emacs/")

(load (format "%s%s" basepath "custom_generated.el"))
(load (format "%s%s" basepath "theme_related.el"))
(load (format "%s%s" basepath "keybindings.el"))
(load (format "%s%s" basepath "fullscreen.el"))
(load (format "%s%s" basepath "others.el"))




