;;org mode 设置
(load "~/.emacs_lisp/emacs.clock.el")
(setq org-startup-with-inline-image t)
;;(setq org-export-with-sub-superscripts nil)
;;(setq org-export-with-footnotes nil)
;;(setq org-export-with-emphasize nil)
;;(setq org-use-speed-commands t)
;;(setq org-speed-commands-user (quote (("1" . delete-other-windows)
;;                                      ("2" . split-window-vertically)
;;                                      ("3" . split-window-horizontally)
;;                                      ("h" . hide-other)
;;                                      ("k" . org-kill-note-or-show-branches)
;;                                      ("r" . org-reveal)
;;                                      ("s" . org-save-all-org-buffers)
;;                                      ("z" . org-add-note)
;;                                      ("c" . self-insert-command)
;;                                      ("C" . self-insert-command)
;;                                      ("J" . org-clock-goto))))  


;;在中文中使用 *xxx*加粗时，前后不用加空格
 (custom-set-variables
 '(org-emphasis-regexp-components
   '(" \t('\"{[:multibyte:]" "- \t.,:!?;'\")}\\[:multibyte:]" " \t\r\n,\"'" "." 1)))
;;remember设置
(require 'remember)
;;(require 'org-remember)
;;  
(define-key global-map "\C-cc" 'org-capture)

;; ** 简介
;;- 开篇
;;- 提示
;;- 听课后复习的思考
;;- 图表
;;** 阅读的时间
;;- 
;;** 阅读的目的
;;- [ ] 专业知识阅读
;;- [ ] 专业扩展阅读
;;- [ ] 主题兴趣阅读
;;** 主要内容
;;- 记录讲义的内容
;;- 记录学习的内容
;;- 简洁的文字阐述
;;- 听课是填写和记录
;;** 结论或者总结
;;- 记录最重要的几点
;;- 写成可以快速检索形式
;;- 课后复习总结
;; Capture templates for: TODO tasks, Notes, appointments, phone calls, and org-protocol
(setq org-capture-templates (quote (
      ("t" "todo" entry (file+datetree "~/.emacs_home/everyday/org/plans/index.org") "* TODO %? %^g\n")
      ("T" "time" entry (file+datetree "~/.emacs_home/everyday/org/plans/time.org") "* %? %^g\n")
      ("n" "note" entry (file "~/.emacs_home/everyday/org/others/index_note.org") "* %?\n")
      ("r" "research" entry (file "~/.emacs_home/everyday/org/research/index.org") "* %?\n")
      ("m" "matlab" entry (file "~/.emacs_home/everyday/org/research/matlab.org") "* %?\n")
      ;;("f" "FT1500_note" entry (file "~/.emacs_home/everyday/org/project/ftlog.org") "* %?   %U\n")
      ("p" "project_log" entry (file+datetree "~/.emacs_home/everyday/org/project/project_log.org") "*  %U\n%?")
      ("d" "diary" entry (file+datetree "~/.emacs_home/everyday/org/diary/index.org") "* %U\n%?" )
      ("R" "Reading" entry (file "~/.emacs_home/everyday/org/reading/index.org") "* 书名：%?
** 简介

** 阅读的时间
- 
** 主要内容

** 结论或者总结
      " )
      ("M" "Meetings" entry (file+datetree "~/.emacs_home/everyday/org/meetings/index.org") "* %U 
- 会议概要
  - 会议时间：
  - 会议地点：
  - 会议类型：
  - 主持人：
  - 与会者：
  - 会议议题：
- (演说者):(议题）：
  - 讨论
  - 结论
  - 拟办事项
    1) 负责人：
    2) 负责人：
- (演说者):(议题）：
  - 讨论
  - 结论
  - 拟办事项
    1) 负责人：
    2) 负责人：
- (演说者):(议题）：
  - 讨论
  - 结论
  - 拟办事项
    1) 负责人：
    2) 负责人：
      " )
      ("v" "review" entry (file+datetree "~/.emacs_home/everyday/org/plans/review.org") "* %U 
- 给今天各项表现打个分数，如不及格请说明原因：
  - 精神状态：
  - 工作效率：
  - 知识补充：
  - 环境融洽：
- 请检查今天是否已经完成以下事项：
  - [ ] project log
  - [ ] diary log
  - [ ] 检查今天的TODO items
  - [ ] 专业知识补充
- 今天对自己哪方面不满意，请简述理由及改进方法。
  - 
" ))))


;;org事件的归档设置
(require 'org-archive)
;;(setq org-archive-mark-done t);;实验没啥反应
(setq org-archive-location "%s_done.org::")

(require 'org-install)
(require 'ox-publish)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock)
(add-hook 'org-mode-hook 
	  (lambda () (setq truncate-lines nil)))
 
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(defun bsave-then-publish ()
  (interactive)
  (save-buffer)
  (org-save-all-org-buffers)
  (org-publish-current-file))

;;(global-set-key (kbd "<f8> p") 'bsave-then-publish)

(global-set-key (kbd "<f8>") 'bsave-then-publish)

;;mathjax设置，只能用相对路径了，windows下不认识绝对路径
(setq org-export-with-LaTeX-fragments t)
(setq org-export-html-mathjax-options
   ;;'((path  "~/.emacs_home/everyday/public_html/mathjax/MathJax.js")
   '((path  "../mathjax/MathJax.js")
    (scale "133")
    (align "left")
    (indent "2em")
    (mathml t)))

(setq       org-export-html-postamble-format
      '(("en"
"<hr>
<table width='100%' border='0' summary='Footer navigation'>
<tr>
  <td align='center'> <a href=../home/index.html> Home </a> / <a href=../tools/index.html> Tools </a> </td>
</table>
<hr>
<p class='author'> Author: %a <%e></p>
<p class='date'> Date: %d</p>
<p class='creator'> Creator: %c</p>
"
)))
(setq note-root-dir "~/.emacs_home/everyday/org")
(setq note-publish-dir "~/.emacs_home/everyday/public_html")

;;(setq org-agenda-files (quote ("~/.emacs_home/everyday/org"
;; 			       "~/.emacs_home/everyday/org/home"
;; 			       "~/.emacs_home/everyday/org/tools"
;; 			       "~/.emacs_home/everyday/org/reading"
;; 			       "~/.emacs_home/everyday/org/others"
;; 			       "~/.emacs_home/everyday/org/plans"
;; 			       "~/.emacs_home/everyday/org/project"
;; 			       "~/.emacs_home/everyday/org/research")))
(setq org-agenda-files (quote ("~/.emacs_home/everyday/org/plans")))

(setq org-publish-project-alist
      `(("note-org"
         :base-directory ,note-root-dir
         :publishing-directory ,note-publish-dir
         :base-extension "org"
         :recursive t
         :publishing-function org-html-publish-to-html
         :auto-index nil
         :index-filename "index.org"
         :index-title "index"
	 :sub-superscript nil
	 :footnotes nil
	 :headline-levels 4
         :link-home "http://202.197.52.124"
	 :link-up "http://202.197.52.124"
	 :author "隋兵才"
	 :email "bingcaisui@mail.cpu.cn"
         :style "<link rel=\"stylesheet\" href=\"../css/default.css\" type=\"text/css\"/>")
        ("note-static"
         :base-directory ,note-root-dir
         :publishing-directory ,note-publish-dir
         :recursive t
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|swf\\|zip\\|gz\\|txt\\|el"
         :publishing-function org-publish-attachment)
        ("note" :components ("note-org" "note-static"))))
;; 支持 example, src 等 literal block 的快捷方式，也可以使用 org-mode 内置的
;; easy-template 机制，但是会跟 auto-complete 在快捷键的使用上冲突，还是使用这种
;; ad-hoc 的方式吧！
(add-hook 'org-mode-hook
          (lambda ()
            (require 'skeleton)
            (require 'abbrev)

            (abbrev-mode)
	    (auto-fill-mode)
	    (flyspell-mode 1)
            (define-skeleton abbrev-org-exam
              "Input #+BEGIN_EXAMPLE #+END_EXAMPLE in org-mode"
              ""
              "#+BEGIN_EXAMPLE\n"
              _ "\n"
              "#+END_EXAMPLE"
              )

            (define-abbrev org-mode-abbrev-table "iexam" "" 'abbrev-org-exam)

            (define-skeleton abbrev-org-src
              "Input #+begin_src #+end_src in org-mode"
              ""
              "#+BEGIN_SRC\n"
              _ "\n"
              "#+END_SRC"
              )

            (define-abbrev org-mode-abbrev-table "isrc" "" 'abbrev-org-src)

            (define-skeleton abbrev-org-prop
              "Input :PROPERTIES: :END: in org-mode"
              ""
              >":PROPERTIES:\n"
              > _ "\n"
              >":END:"
              )

            (define-abbrev org-mode-abbrev-table "iprop" "" 'abbrev-org-prop)

            ;; enclose existing text
            (defun iexam (St Ed)
              "Enclose example for org-mode"
              (interactive "r")
              (let ((beg St) (end Ed))
                (message "%s %s" beg end)
                (i-babel-quote beg end "#+BEGIN_EXAMPLE" "#+END_EXAMPLE")))

            (defun isrc (St Ed)
              "Enclose code for org-mode"
              (interactive "r")
              (let ((beg St) (end Ed))
                (message "%s %s" beg end)
                (i-babel-quote beg end "#+BEGIN_SRC" "#+END_SRC")))

            (defun i-babel-quote (beg end str1 str2)
              (goto-char end)
              (end-of-line)
              (newline)
              (insert str2)
              (goto-char beg)
              (beginning-of-line)
              (newline)
              (forward-line -1)
              (insert str1)
              )
            ))


;; 如果有下级的条目处于未完成状态，那么它的上级条目也不能被标记为 DONE
(setq org-enforce-todo-dependencies t)
(setq org-enforce-todo-checkbox-dependencies t)

;; 所有 children 都 DONE 之后，自动设置 parent 为 DONE
;;(defun org-summary-todo (n-done n-not-done)
;;  "Switch entry to DONE when all subentries are done, to TODO otherwise."
;;  (let (org-log-done org-log-states)   ; turn off logging
;;    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
;;(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

;; 记录 TODO 条目的状态转换时间
(setq org-log-done 'time)
;; TODO 条目转换状态的时候添加一个注释
(setq org-log-done 'note)

;; 也可以在一个 buffer 中同时使用多个不同的 TODO Sequence，具体方法见文档
;; 顺序型的工作流
;;(setq org-todo-keywords '((sequence "TODO" "HALF" "ALMOST" "|" "DONE" "CANCELLED")))
;; 非顺序的工作类型
;;(setq org-todo-keywords '((type "Fred" "Sara" "Lucy" "|" "DONE")))

(setq org-todo-keywords (quote ((sequence "TODO(t!)" "NEXT(n@/!)" "HALF" "ALMOST" "|" "DONE(d@/!)")
                                (sequence "WAITING(w@/!)" "DELAYED(D@/!)" "|" "CANCELLED(c@/!)" )
                                (sequence "OPEN(O!)" "|" "CLOSED(C!)"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "green" :weight bold)
              ("HALF" :foreground "orange" :weight bold)
              ("ALMOST" :foreground "magenta" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("DELAY" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold)
              ("OPEN" :foreground "green" :weight bold)
              ("CLOSED" :foreground "forest green" :weight bold)
              ("PHONE" :foreground "forest green" :weight bold))))

;;Moving a task to CANCELLED adds a CANCELLED tag 
;;Moving a task to WAITING adds a WAITING tag 
;;Moving a task to DELAYED adds a DELAYED tag 
;;Moving a task to a done state removes a WAITING/DELAYED tag 
;;Moving a task to TODO removes WAITING and CANCELLED and DELAYED tags 
;;Moving a task to NEXT removes a WAITING/DELAYED tag 
;;Moving a task to DONE removes WAITING and CANCELLED and DELAYED tags 
(setq org-todo-state-tags-triggers
      (quote (("CANCELLED"
               ("CANCELLED" . t))
              ("WAITING"
               ("WAITING" . t))
              ("DELAYED"
               ("DELAYED" . t))
              (done
               ("WAITING")("DELAYED"))
              ("TODO"
               ("WAITING")("DELAYED")
               ("CANCELLED"))
              ("NEXT"
               ("WAITING")("DELAYED"))
              ("DONE"
               ("WAITING")("DELAYED")
               ("CANCELLED")))))


; Tags with fast selection keys
(setq org-tag-alist (quote (;;(:startgroup)
                            ;;("@errand" . ?e)
                            ;;("@office" . ?o)
                            ;;("@home" . ?h)
                            ;;("@farm" . ?f)
                            ;;(:endgroup)
			    ("中国人史纲" . ?z)
			    ("工作" . ?w)
                            ("生活" . ?l)
                            ("学习" . ?s)
                            ("娱乐" . ?p)
                            ("其他" . ?o))))
;;                            
; Allow setting single tags without the menu
(setq org-fast-tag-selection-single-key (quote expert))
  
; For tag searches ignore tasks with scheduled and deadline dates
(setq org-agenda-tags-todo-honor-ignore-options t)

; freemind export
(require 'ox-freemind)

 (setq org-ditaa-jar-path "~/.emacs_lisp/org-9.1.1/contrib/scripts/ditaa.jar")
 (setq org-babel-execute "~/.emacs_lisp/org-9.1.1/contrib/scripts/ditaa.jar")

;; (add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
;; (add-hook 'org-babel-execute 'org-display-inline-images)
 (setq org-babel-load-languages (quote ((emacs-lisp . t)
    (dot . t)
    (ditaa . t)
    (R . t)
    (python . t)
    (ruby . t)
    (gnuplot . t)
    (clojure . t)
    (sh . t)
    (ledger . t)
    (org . t)
    (plantuml . t)
    (latex . t))))
; Do not prompt to confirm evaluation
; ; This may be dangerous - make sure you understand the consequences
; ; of setting this -- see the docstring for details
 (setq org-confirm-babel-evaluate nil)

