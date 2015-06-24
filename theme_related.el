



(setq day-theme 'leuven)
(setq dark-theme 'wombat)

(defun synchronize-theme ()
    (setq hour 
        (string-to-number 
            (substring (current-time-string) 11 13))) 
    (if (member hour (number-sequence 6 16))
        (setq now day-theme)
        (setq now dark-theme)) 
    (load-theme now)
    
)

(defun font-set ()
  (set-default-font "Fixedsys Excelsior 3.01 12")
  (dolist 
    (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
      charset
      (font-spec :family "Microsoft Yahei" :size 16)))
)

(synchronize-theme)
;; (eval '(leuven))
;; (load-theme 'wombat)
(font-set)


(defun day ()
  (interactive)
  (load-theme 'leuven)
  (font-set)
)

(defun dark ()
  (interactive)
  (load-theme 'wombat)
  (font-set)
)
