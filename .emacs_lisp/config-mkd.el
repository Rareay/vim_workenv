
;; markdown setting
(autoload 'gfm-mode
  "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))

(setq markdown-css-paths
    '("/home/sbc/dms/ift/css/default_ztl.css"))

;;(setq markdown-command
;;    "/usr/bin/markdown")
(setq markdown-command
      "/home/sbc/markdown/peg-multimarkdown-3.7.1/multimarkdown")

;; (autoload 'gfm-mode
;;   "markdown-mode"
;;   "Major mode for editing GitHub Flavored Markdown files" t)
;; (add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))



(add-hook 'markdown-mode-hook
          (lambda ()
            (when buffer-file-name
              (add-hook 'after-save-hook
                        'check-parens
                        nil t))))


(require 'org-table)
(defun cleanup-org-tables ()
  (save-excursion
    (goto-char (point-min))
    (while (search-forward "-+-" nil t) (replace-match "-|-"))
    ))

(add-hook 'markdown-mode-hook 'orgtbl-mode)
(add-hook 'markdown-mode-hook
          (lambda()
            (add-hook 'after-save-hook 'cleanup-org-tables  nil 'make-it-local)))

;; Often Markdown gets added to a LaTeX project, too. So I eventually
;; need a LaTeX export.
(defun as/markdown-region-to-latex (start end)
  (interactive "r")
  (goto-char start)
  (save-restriction
    (let (in-list skip-to)
      (narrow-to-region start end)
      (while (re-search-forward "\\*\\|\n\\|\\`" nil t)
        (goto-char (match-beginning 0))
        (if (= (point) (match-end 0))
            (setq skip-to (1+ (point)))
          (setq skip-to (match-end 0)))
        (cond ((looking-at "\\*\\*\\b\\([^*]*?\\)\\b\\*\\*")
               (replace-match "\\\\textbf{\\1}"))
              ((looking-at "|\\(.*\\)|\\(.*\\)|\\(.*\\)|\\(.*\\)|")
               (replace-match "\\1\\2\\3;"))
              (t (goto-char skip-to)))))))

