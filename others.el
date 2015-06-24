(defun list-buffers-and-other-window ()
  (interactive "^")
  (list-buffers )
  (other-window 1)
)

;; disable Message buffer
(setq-default message-log-max nil)


(setq doc-view-ghostscript-program "gswin32c")

(setq indent-line-function 'indent-relative)

;; cider package problem
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)
(defalias 'go 'switch-to-buffer)
(defalias 'type 'type-of)
(defalias 'println 'print)
(defalias 'cls 'cider-repl-clear-buffer)
(defalias 'q 'save-buffers-kill-terminal)
(defalias 'gg 'beginning-of-buffer)
(defalias 'ge 'end-of-buffer)
(defalias 'lb 'list-buffers-and-other-window)



(require 'cider-client)
(require 'cider-interaction)
(autoload 'cider-connect "cider")



;; when i need a new repl don't ask me to confirm, just open it
(defun nrepl-check-for-repl-buffer (endpoint project-directory)
  "Check whether a matching connection buffer already exists.
Looks for buffers where `nrepl-endpoint' matches ENDPOINT,
or `nrepl-project-dir' matches PROJECT-DIRECTORY.
If so ask the user for confirmation."
  (if (cl-find-if
       (lambda (buffer)
         (let ((buffer (get-buffer buffer)))
           (or (and endpoint
                    (equal endpoint
                           (buffer-local-value 'nrepl-endpoint buffer)))
               (and project-directory
                    (equal project-directory
                           (buffer-local-value 'nrepl-project-dir buffer))))))
       (nrepl-connection-buffers))
      ;(y-or-n-p
       ;"An nREPL connection buffer already exists.  Do you really want to create a new one? ")
       t
    t))
    



(defun clj-connect ()
  "easy connect"
  (interactive "^")  
  (cider-connect "localhost"  7888)
)

(defalias 'clj 'clj-connect)

; auto revert buffer
(global-auto-revert-mode 1)


;; 这一句解决把utf读成gbk的情况. 
(prefer-coding-system 'utf-8-dos)
(setq default-buffer-file-coding-system 'utf-8-dos)
(setq buffer-file-coding-system 'utf-8-dos)
(set-default-coding-systems 'utf-8-dos)
(defun dos-file ()
      "Change the current buffer to Latin 1 with DOS line-ends."
      (interactive)
      (set-buffer-file-coding-system 'utf-8-dos t))

(defun unix-file ()
      "Change the current buffer to Latin 1 with Unix line-ends."
      (interactive)
      (set-buffer-file-coding-system 'utf-8-unix t))


(setq-default indent-tabs-mode nil)

; delete selection on insert
(delete-selection-mode +1)

;; only one instance
(server-start)


;; 不要备份文件. 
(setq make-backup-files nil) 


(show-paren-mode t)
(message "loading others after show paren mode")
;; elisp 居然不支持[] {}
(modify-syntax-entry ?[ "(]")
(modify-syntax-entry ?] ")[")
(modify-syntax-entry ?{ "(}")
(modify-syntax-entry ?} "){")
;;
;;(setq show-paren-style 'expression)

;; aspell
(add-to-list 'exec-path "C:/Program Files (x86)/Aspell/bin/")
(setq ispell-program-name "aspell")
(setq ispell-personal-dictionary "C:/Program Files (x86)/Aspell/dict")
(require 'ispell)


(setq flyspell-auto-correct-binding [(control ?\')])

(defun handle-shift-selection ()
  "Activate/deactivate mark depending on invocation thru shift translation.
This function is called by `call-interactively' when a command
with a `^' character in its `interactive' spec is invoked, before
running the command itself.

If `shift-select-mode' is enabled and the command was invoked
through shift translation, set the mark and activate the region
temporarily, unless it was already set in this way.  See
`this-command-keys-shift-translated' for the meaning of shift
translation.

Otherwise, if the region has been activated temporarily,
deactivate it, and restore the variable `transient-mark-mode' to
its earlier value."
  
  ;(message "handle-shift-selection is called")
  ;(message (format "%s%s" "shift-select-mode is " shift-select-mode))
  ;(message (format "%s%s" "this-command-keys-shift-translated is " this-command-keys-shift-translated))
  (cond ((and shift-select-mode this-command-keys-shift-translated)
         (unless (and mark-active
		      (eq (car-safe transient-mark-mode) 'only))
	   (setq transient-mark-mode
                 (cons 'only
                       (unless (eq transient-mark-mode 'lambda)
                         transient-mark-mode)))
           (push-mark nil nil t)))
        ((eq (car-safe transient-mark-mode) 'only)
         (setq transient-mark-mode (cdr transient-mark-mode))
         (deactivate-mark)))

)

(add-hook 'post-command-hook
  (lambda ()    
    (if (use-region-p)
      (progn
        ;(message (buffer-substring-no-properties (region-beginning) (region-end)))
        (msearch-cleanup)
        (msearch-set-word (buffer-substring-no-properties (region-beginning)  (region-end)))
      )
      (msearch-cleanup)
    )
  )
)



(defun indent-according-to-mode ()
  "Indent line in proper way for current major mode.
Normally, this is done by calling the function specified by the
variable `indent-line-function'.  However, if the value of that
variable is `indent-relative' or `indent-relative-maybe', handle
it specially (since those functions are used for tabbing); in
that case, indent by aligning to the previous non-blank line."
  (interactive)
  (syntax-propertize (line-end-position))
;  is always true, memq
  (if (and t (memq indent-line-function
	    '(indent-relative indent-relative-maybe)))
    (message "memq is true")
    (message "memq is false")
  )
  (if (memq indent-line-function
	    '(indent-relative indent-relative-maybe))
      ;; These functions are used for tabbing, but can't be used for
      ;; indenting.  Replace with something ad-hoc.
      (let ((column (save-excursion
		      (beginning-of-line)
		      (skip-chars-backward "\n \t")
		      (beginning-of-line)
		      (current-indentation))))
	(if (<= (current-column) (current-indentation))
	    (indent-line-to column)
	  (save-excursion (indent-line-to column))))
    ;; The normal case.
    (funcall indent-line-function)))


(add-hook 'emacs-lisp-mode-hook
          (function (lambda ()
                      (setq-local indent-line-function 'indent-relative)
          )
))

(add-hook 'haskell-mode-hook
          (function (lambda ()
                      (setq-local indent-line-function 'indent-relative)
          )
))

;; remove ^M
(defun remove-dos-eol ()                                                                 
 "Do not show ^M in files containing mixed UNIX and DOS line endings."                  
  (interactive)                                                                          
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M [])
)

(add-hook 'cider-repl-mode-hook 'remove-dos-eol) ;Remove ^M from clojure repl in windows 



;; 4:13 2015/1/10
;; 01/10/15 4:32 上午
;; "%D %-I:%M %p" - 01/10/15 4:32 上午
;; "%a %b %d %H:%M:%S %Z %Y" - 周六 1月 10 04:36:20 中国标准时间 2015
;; %-I:%M %Y-%m-%d %p - 4:42 2015-01-10 上午
(defun now ()
  "Insert string for the current time formatted like '2:34 PM'."                                                       
  (interactive) ; permit invocation in minibuffer                                                      
  (insert (format-time-string "%-I:%M %Y-%m-%d %p"))
)

(add-to-list 'load-path (format "%s" basepath))

(require 'msearch)
