(let ((asymbol (intern "mysymbol"))) 
  (defvar mysymbol "hello") 
  (print  asymbol) ;; asymbol eval, mysymbol , pass to print,
  (print (eval asymbol)) 
  (print (type "sdsdd")) 
  (print  (type asymbol))  
  (print asymbol) 
  (defvar asymbol "hello") 
  (print asymbol)
  
)

(type (type "sdsdd"))
;; ??
(message (intern "sdsdsd"))
(print (intern "sdsdsd"))


(list
       (key-binding
        [down-mouse-1]))


(key-binding (kbd "<down-mouse-1>"))

(dolist (i '(1 2 3 )) (print i))

(defun foo ()
  (setq aaa "sdsd")
)
(foo)
aaa


(let (abc) (setq abc "sdsdsd") abc)

;; 从1开始的
(buffer-substring-no-properties 1 100)

;; add to list , side effect
(defvar foo '())
(add-to-list 'foo 3)
(add-to-list 'foo "sdsd")
(add-to-list 'foo 100)
