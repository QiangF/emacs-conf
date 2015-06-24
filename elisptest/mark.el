
;; test几个mark相关的函数
(defun test () (interactive) (message "if use region?:%s" (use-region-p)) (message " region beginning %d" (region-beginning))
  (message " region end %d" (region-end))
)
