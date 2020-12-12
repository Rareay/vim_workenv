
;; verilog-mode setting; verilog-mode must be turned on
(setq verilog-indent-level             2
	  verilog-indent-level-module      2
	  verilog-indent-level-declaration 2
  	  verilog-indent-level-behavioral  2
	  verilog-indent-level-directive   2
	  verilog-case-indent              2
	  verilog-cexp-indent              2
	  verilog-auto-newline             nil
	  verilog-auto-indent-on-newline   t
	  verilog-tab-always-indent        nil
	  verilog-auto-endcomments         t
	  verilog-auto-reset-widths        t
	  verilog-assignment-delay         "#1 "
	  verilog-minimum-comment-distance 72
	  verilog-indent-begin-after-if    t
      verilog-auto-lineup              'declarations
;;	  verilog-auto-lineup              '(all)
	  )

(defun insert-comment-block ()
  (interactive)
  (let ((des-block (read-from-minibuffer "Enter comment description:")))
    (insert (format "\n\/\/-----------------------------------------------------------------------------\n"))
    (insert (format   "\/\/ %s\n" des-block))
    (insert (format   "\/\/-----------------------------------------------------------------------------\n"))
    )
)

(defun comment-current-line()
  (interactive)
  (re-search-backward "^" nil t)
       (replace-match "//")
 )

(defun uncomment-current-line()
  (interactive)
  (beginning-of-line)
  (re-search-forward "/+" nil t)
       (replace-match "")
 )

(global-set-key (kbd "<f2> i") 'insert-comment-block)
(global-set-key (kbd "<f2> c") 'comment-current-line)
(global-set-key (kbd "<f2> u") 'uncomment-current-line)
