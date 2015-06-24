
(defun my-select-current-line ()
  (interactive "^")
  (move-end-of-line nil)
  ;(move-beginning-of-line nil)
  ;(set-mark-command nil)
  ;(move-end-of-line nil)
  ;(setq deactivate-mark nil)
)

(defun my-select-to-end ()
  (interactive )
  ;(message " is it worked ? ")
  ;; 系统仍然认为没有激活shift
  (setq this-command-keys-shift-translated t)
  (handle-shift-selection)
  ;(set-mark-command nil)
  (move-end-of-line nil)
)

(defun select-to-backward-word ()
  (interactive)
  (setq this-command-keys-shift-translated t)
  (handle-shift-selection)
  (backward-word)
)

(defun move-screen-up ()
  (interactive)
  (scroll-up 1)
)

(defun move-screen-down ()
  (interactive)
  (scroll-down 1)
)

; c -e , when no shift, start of next word
; when shift, select to end of next word
(defun start-next-word ()
  (interactive "^")
  ;(setq this-command-keys-shift-translated t)
  ;(handle-shift-selection)
  (cond 
    ((eq t this-command-keys-shift-translated) 
      (right-word)
    )
    ((not this-command-keys-shift-translated) 
      (forward-word)
      (forward-char)
    )
  )

)


(defun start-next-word-shift ()
  (interactive)
  (setq this-command-keys-shift-translated t)
  (handle-shift-selection)
  (forward-word)
  (forward-char)
)

;; 这个支持s expression. [] {}不不支持. 
;; 这个函数好像只认识(). 其他不认识. 
;; 41 ')'
;; 125 '}'
;; 123 '{'
;; 10 line feed
(defun px-match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert <key>."
  (interactive "^p")
  (cond
   ((char-equal 41 (char-before)) (backward-list 1))
   ((char-equal 125 (char-before)) (backward-list 1))
   ((char-equal 93 (char-before)) (backward-list 1))
   ((and
     (char-equal 123 (char-before))
     (char-equal 10 (char-after)))
       (backward-char 1) (forward-list 1))
   ((looking-at "\\s\(") (forward-list 1))
   ((looking-at "\\s\)") (backward-list 1))
   (t (self-insert-command (or arg 1)))))
   


;; ace jump 现在成为常用功能了.
(global-set-key "\C-t" 'ace-jump-mode)
;; 独占窗口, delete-other-windows, C-x 1, F2 1, now c + alt + Enter
(global-set-key (kbd "C-M-<return>") 'delete-other-windows)
;;这个容易误操作, unbound it
(global-unset-key (kbd "C-M-j"))


;; this work for .
(global-set-key (kbd "C-.") 'end-of-buffer)
;; both not work for , 这个没理由通不过
(global-set-key (kbd "C-,") 'beginning-of-buffer)
;;(global-set-key [?\C-,] 'beginning-of-buffer)
;; this is not even valid
;;(global-set-key [(control ,)] 'beginning-of-buffer) ;; reported work
;;(global-set-key [(control ?,)] 'beginning-of-buffer) ;; reported work
(global-set-key (kbd "C-'") 'end-of-buffer)
(global-set-key "\C-g" 'beginning-of-buffer)


(global-set-key "\C-b" 'px-match-paren)
; c -x 
(global-set-key (kbd "<f2>") ctl-x-map)
(global-set-key "\C-x" 'kill-region)
; c - c
(global-set-key (kbd "<f3>") mode-specific-map)
(global-set-key "\C-c" 'kill-ring-save)

(defun testfoo () 
  (message "hello")
)

; M return 代替F11
; 目前存在的问题 , 全屏之后不能覆盖任务栏
; 退出全屏之后窗口大小不对. 
(global-set-key (kbd "M-<return>") 'toggle-frame-fullscreen)

; c -u 
(global-set-key (kbd "<f4>") 'universal-argument)
(global-set-key "\C-u" 'scroll-down-command)
;; 复制 粘贴撤销
;; c - z 是最小化窗口的意思, 完全无用
;; 还是改成undo比较好
(global-set-key "\C-z" 'undo)
(global-set-key "\C-f" 'isearch-forward)
(global-set-key "\C-s" 'save-buffer)

(global-set-key "\M-i" 'move-screen-down)
(global-set-key "\M-k" 'move-screen-up)


(global-set-key "\C-e" 'start-next-word)
; how to bind c s e
;(global-set-key (kbd "C-<S-E>") 'start-next-word-shift)
(global-set-key [(control ?\/)] 'backward-word)
(global-set-key [(control ?\?)] 'select-to-backward-word)

(global-set-key "\C-w" 'kill-this-buffer)
;;(global-set-key "\C-o" 'previous-buffer)
;;(global-set-key "\C-p" 'next-buffer)

(setq pb-key "\M-j")
(setq nb-key "\M-l")
(global-set-key pb-key 'previous-buffer)
(global-set-key nb-key 'next-buffer)

; c-n other-window,  从来不习惯C-n下一行, 以后统一用C-k代替
(global-set-key "\C-n" 'other-window)

;; 忘记了C-i tab是捆绑的
(global-set-key (kbd "<tab>") 'self-insert-command)

; c - d 改为 scroll up, 其实是向下
(global-set-key "\C-d" 'scroll-up)
(global-set-key "\C-v" 'yank)
(global-set-key "\C-a" 'mark-whole-buffer)
(global-set-key "\C-i" 'previous-line)
(global-set-key "\C-k" 'next-line)
(global-set-key "\C-j" 'backward-char)
(global-set-key "\C-l" 'forward-char)
(global-set-key "\C-h" 'move-beginning-of-line)
(global-set-key [(control ?\;)] 'move-end-of-line)

(global-set-key [(control ?\:)] 'my-select-to-end)

(global-set-key (kbd "<return>") 'newline-and-indent)
(global-set-key (kbd "C-<return>") 'newline)
(global-set-key "\C-m" 'delete-backward-char)

; alt f4 exit
(global-set-key (kbd "M-<f4>") 'save-buffers-kill-terminal)

; http://ergoemacs.org/emacs/reclaim_keybindings.html
(define-key minibuffer-local-map (kbd "<return>") 'exit-minibuffer)
(define-key minibuffer-local-map (kbd "<tab>") 'minibuffer-complete) 


(eval-after-load 'help-mode
  '(define-key help-mode-map (kbd "<return>") 'help-follow-symbol)
  ;'(define-key help-mode-map [?\C-c ?$] 'testfoo)
)


(define-key button-map (kbd "<return>") 'push-button)
; 实验证明, 这样的确会改写 C-c为前缀命令
;(define-key button-map [?\C-c ?$] 'testfoo)


; (define-key ielm-map (kbd "<return>") 'ielm-return)
(add-hook 'ielm-mode-hook
  (lambda ()
     (define-key ielm-map (kbd "<return>") 'ielm-return)))


(add-hook 'flyspell-mode-hook
  (lambda ()
   ;(define-key flyspell-mode-map  "\C-h" 'testfoo)
   ; (global-set-key "\C-c" 'kill-ring-save)
   (define-key flyspell-mode-map  "\C-c" 'kill-ring-save)
   ;; c + ' 被占用了
   (define-key flyspell-mode-map  (kbd "C-'") 'end-of-buffer)
  )
)



;; java major mode key setting
(add-hook 'java-mode-hook
  (lambda ()
    (define-key java-mode-map "\C-c" 'kill-ring-save)
    (define-key java-mode-map "\C-d" 'scroll-up)
  )
)
	    
(add-hook 'Buffer-menu-mode-hook
  (lambda ()
    (define-key Buffer-menu-mode-map pb-key 'previous-buffer)
    ;; we don't need yank here
    (define-key Buffer-menu-mode-map "\C-y" 'Buffer-menu-switch-other-window)
    (define-key Buffer-menu-mode-map "\C-i" 'previous-line)
    (define-key Buffer-menu-mode-map "\C-k" 'next-line)
  )
)

;; dired mode C-o rebinding
;; dired-mode-map
(add-hook 'dired-mode-hook
  (lambda ()
    (define-key dired-mode-map pb-key 'previous-buffer)
    (define-key dired-mode-map "\C-y" 'dired-display-file)
  )
)

(add-hook 'cider-repl-mode-hook
  (lambda ()
    ;; let tab do what it suppose to do not C-i
    (define-key cider-repl-mode-map "\C-i" 'previous-line)
    (define-key cider-repl-mode-map "\C-m" 'delete-backward-char)
    ;; c + return 代替 C-m的工作, return 代替C-i的工作
    (define-key cider-repl-mode-map (kbd "C-<return>") 'cider-repl-newline-and-indent)
    (define-key cider-repl-mode-map (kbd "<return>") 'cider-repl-return)
    (define-key cider-repl-mode-map "\C-j" 'backward-char)
    (define-key cider-repl-mode-map "\C-c" 'kill-ring-save)
    (define-key cider-repl-mode-map [(control ?\:)] 'my-select-to-end)
    (define-key cider-repl-mode-map (kbd "C-<delete>") 'cls)
    
  )
)

(add-hook 'clojure-mode-hook
  (lambda ()

    (define-key clojure-mode-map "\C-c" 'kill-ring-save)
  )
)


(add-hook 'haskell-mode-hook
  (lambda ()
    (define-key haskell-mode-map "\C-c" 'kill-ring-save)
    (define-key haskell-mode-map "\C-x" 'kill-region)
  )
)

(add-hook 'shell-mode-hook
  (lambda ()
    (define-key shell-mode-map "\C-i" 'previous-line)
    (define-key shell-mode-map (kbd "<return>") 'comint-send-input)
    (define-key shell-mode-map "\C-c" 'kill-ring-save)
    (define-key shell-mode-map "\C-x" 'kill-region)
    (define-key shell-mode-map "\C-m" 'delete-backward-char)
  )
)
