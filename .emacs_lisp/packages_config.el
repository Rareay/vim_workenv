;; (require 'ibuffer)
;; (global-set-key (kbd "C-x C-b") 'ibuffer)
;; (require 'browse-kill-ring)
;; (global-set-key [(control c)(k)] 'browse-kill-ring)
;; (browse-kill-ring-default-keybindings)

(require 'tabbar)
(tabbar-mode)
(setq tabbar-cycle-scope 'tabs)   ; 在一个 group 之内的 tab 间切换，不切换 group
(setq tabbar-auto-scroll-flag nil) ; 不自动滚动，而是缩小 Tab Title 来适应窗口宽度

;; 将所有的 buffer 分为两个组，一个是用户打开的文件，另外一个是 emacs 自动创建的
(setq tabbar-buffer-groups-function
      (lambda ()
        (list
         (cond
          ((find (aref (buffer-name) 0) " *")
           "Emacs")
          (t
           "User")))))

;; ;; 在 label 的左右各加一个空格，直接修改 tabbar.el 来得更好
;; (defadvice tabbar-buffer-tab-label (after fixup_tab_label_space_and_flag activate)
;;   (setq ad-return-value
;;         (concat " " (concat ad-return-value " "))))

;; 如果 buffer 修改过的话，前面加上一个 '+'
;;              (if (and (buffer-modified-p (tabbar-tab-value tab))
;;                               (buffer-file-name (tabbar-tab-value tab)))
;;                      (concat " + " (concat ad-return-value " "))
;;                      (concat " " (concat ad-return-value " ")))))

;; ;; called each time the modification state of the buffer changed
;; (defun ztl-modification-state-change ()
;;   (tabbar-set-template tabbar-current-tabset nil)
;;   (tabbar-display-update))
;; ;; first-change-hook is called BEFORE the change is made
;; (defun ztl-on-buffer-modification ()
;;   (set-buffer-modified-p t)
;;   (ztl-modification-state-change))

;; ;; 修改标志总是很难得到实时的更新，并且似乎影响到了 emacs undo 时的 modeline 上的
;; ;; buffer 修改标记，还是去掉吧！
;; (add-hook 'after-save-hook 'ztl-modification-state-change)
;; ;; This doesn't work for revert-buffer, I don't know why.
;; ;;(add-hook 'after-revert-hook 'ztl-modification-state-change)
;; (add-hook 'first-change-hook 'ztl-on-buffer-modification)

;; ;; 在列表中删除那些由 emacs 自己打开的 buffer，只列出用户主动打开的 buffer。
;; ;; 这个没有什么用，只会让处于 Emacs 组时 header line 无显示。
;; (setq tabbar-buffer-list-function
;;       (lambda ()
;;         (remove-if
;;          (lambda(buffer)
;;            (find (aref (buffer-name buffer) 0) " *"))
;;          (buffer-list))))

;;(global-set-key (kbd "") 'tabbar-backward-group)
;;(global-set-key (kbd "") 'tabbar-forward-group)
(global-set-key (kbd "C-<prior>") 'tabbar-backward)
(global-set-key (kbd "C-<next>") 'tabbar-forward)



;; org-mode settings, \\' matches empty string at end, see ELISP Manual 34.3.1.3
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-to-list 'auto-mode-alist '("TODO\\'" . org-mode))

(setq org-directory "~/org/"            ; default directory for
                                        ; searching/visiting org files
      org-insert-mode-line-in-empty-file t
      org-agenda-files (list "~/org/")) ; directory for agenda org files

;; 也可以在一个 buffer 中同时使用多个不同的 TODO Sequence，具体方法见文档
;; 顺序型的工作流
(setq org-todo-keywords '((sequence "TODO" "HALF" "ALMOST" "|" "DONE" "CANCELLED")))
;; 非顺序的工作类型
;;(setq org-todo-keywords '((type "Fred" "Sara" "Lucy" "|" "DONE")))

;; 如果有下级的条目处于未完成状态，那么它的上级条目也不能被标记为 DONE
(setq org-enforce-todo-dependencies t)
(setq org-enforce-todo-checkbox-dependencies t)

;; 所有 children 都 DONE 之后，自动设置 parent 为 DONE
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

;; 记录 TODO 条目的状态转换时间
(setq org-log-done 'time)
;; TODO 条目转换状态的时候添加一个注释
;;(setq org-log-done 'note)

;; 设置 org-mode 的 contrib 模块
(setq org-ditaa-jar-path "/usr/bin/ditaa")
(require 'org-install)
(require 'ob-ditaa)

;;(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
;;(global-set-key "\C-cb" 'org-iswitchb)

;; remember for org-mode，使用 remember 这个记事工具方便的记录 TODO 项
;(org-remember-insinuate)
;(setq org-default-notes-file (concat org-directory "/gnu-linux.org"))
(define-key global-map "\C-cr" 'org-remember)

;; remember for org-mode
;(setq org-remember-templates
;      '(("Todo" ?t "* TODO %?\n  %i\n  %a" "~/org/subject.org" "Tasks")
;        ("Idea" ?i "* %?\n  %i\n  %a" "~/org/subject.org" "Ideas")))

;; 支持 example, src 等 literal block 的快捷方式，也可以使用 org-mode 内置的
;; easy-template 机制，但是会跟 auto-complete 在快捷键的使用上冲突，还是使用这种
;; ad-hoc 的方式吧！
(add-hook 'org-mode-hook
          (lambda ()
            (require 'skeleton)
            (require 'abbrev)

            (abbrev-mode)

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

;; Tab alone is enough for cycle, relase C-i for yasnippet completion
;;(define-key org-mode-map "\C-i" nil)


;;(setq gnus-inhibit-startup-message t) ;;去掉gnus启动时的引导界面


;; Viper/VimPulse 的设置
(setq viper-mode t)                              ; enable Viper at load time
(require 'viper)                                 ; load Viper
(setq viper-quoted-insert-key "")              ;
(setq viper-allow-multiline-replace-regions nil) ; f/t command don't cross lines

(load "viper-find-char")                ; support to find multi-byte chars

(setq vimpulse-want-quit-like-Vim nil
      vimpulse-experimental nil ; don't load bleeding edge code (see 6. installation instruction)
      vimpulse-enhanced-paren-matching nil
      vimpulse-want-C-u-like-Vim t
      vimpulse-want-vi-keys-in-Info nil
      vimpulse-want-vi-keys-in-help nil)

(require 'vimpulse)                     ; load Vimpulse

;; must after vimpulse loaded to use the `g' prefix key
(define-key viper-vi-basic-map "gt" 'tabbar-forward)
(define-key viper-vi-basic-map "gT" 'tabbar-backward)

;; must after vimpulse loaded to avoid being overriden
(define-key viper-insert-basic-map "\C-y" nil)
(define-key viper-insert-basic-map "\C-e" nil)
(define-key viper-insert-basic-map "\C-p" nil)
(define-key viper-insert-basic-map "\C-n" nil)
(define-key viper-insert-basic-map "\C-x\C-p" nil)
(define-key viper-insert-basic-map "\C-x\C-n" nil)
(define-key viper-insert-basic-map [delete] nil)
;(define-key viper-vi-basic-map "\C-v" nil)

(define-key vimpulse-window-map "+" 'enlarge-window)
(define-key vimpulse-window-map "-" 'shrink-window)
(define-key vimpulse-window-map ">" 'enlarge-window-horizontally)
(define-key vimpulse-window-map "<" 'shrink-window-horizontally)
(define-key viper-vi-basic-map "\C-r" 'undo)
(define-key viper-vi-basic-map "\C-]" 'cscope-find-global-definition-no-prompting)
(define-key viper-vi-basic-map "\C-t" 'cscope-pop-mark)

;; 使用 vimpulse 时，很多情况下希望将 Tab 与 C-i 区分，使 Tab 实现 indent 而 C-i
;; 实现 jump-forward。通过直接设置 global-map 的方法是不行的：有些情况下不想区分
;; Tab 和 C-i，因为很多 package 都假定这两个是相同的，设定绑定的时候都是只设置
;; C-i，比如 iswitchb 就是只绑定了 C-i；但是有些情况下希望这两者是不同的，比如在
;; 很多文本编辑模式下希望 Tab 是 indent 命令而 C-i 是 vimpulse-jump-forward 令令。
;; 因此较好的做法是全局绑定中两者相同，但是对于希望区分的模式下，通过 local-map
;; 将两者区分开来。

(defun differentiate-tab-and-c-i ()
  "Differentiate <tab> and C-i in current major mode."
  (interactive)
  (local-set-key [(tab)] 'indent-for-tab-command))

(add-hook 'emacs-lisp-mode-hook 'differentiate-tab-and-c-i)
(add-hook 'c-mode-common-hook 'differentiate-tab-and-c-i)
(add-hook 'LaTeX-mode-hook 'differentiate-tab-and-c-i)



(setq woman-use-own-frame nil       ; don't create new frame for manpages
      woman-use-topic-at-point t    ; don't prompt upon K key (manpage display)
      woman-fill-column 80          ; fill column for woman buffer
      )


;; ido mode 是一个用于 emacs minibuffer 补全的插件。但是我发现它显示太多东西了，
;; 并且不支持 emacs 中最好用的 .e.d/l/p 之类的首字母形式路径。iswitchb 和
;; ibuffer 是两个更好的替代品。
; (require 'ido) (ido-mode t)

;; window-number-mode 用于对 split window 方式下的多个 window 进行编号，可以方便
;; 的在多个 window 之间跳转。默认快捷键是 C-x C-j n，如果开启 Meta- 模式，可以用
;; M-n 跳转。
(require 'window-number)
(window-number-mode t)
(window-number-meta-mode t)             ; 使用 Meta- 前缀来跳转

(iswitchb-mode 1)                       ; 方便的切换 buffer


;; (require 'sr-speedbar)                  ; 将 speedbar 集成到 emacs frame 中

;; speedbar-frame-parameters 控制 speedbar frame 的参数，比如宽度、是否有
;; minibuffer、menubar、toobar 等，是一个 alist，类似于 frame-parameter。
;; speedbar-frame-plist 是一个关似的参数。

;; speedbar-tag-hierarchy-method 是一个 Hook List，用于生成 Speedbar 窗口中的层
;; 次结构

;; speedbar-tag-group-name-minimum-length

;; speedbar-tag-split-minimum-length 用于控制当 list 长度超出多少时才开始分组，
;; 所有的 tag-hierarchy 方法都应该尊重这个设定
(setq speedbar-tag-split-minimum-length 80)

;; speedbar-tag-regroup-maximum-length 当相临的 sub-group 中的项数少于此值时，就
;; 将其合并
(setq speedbar-tag-regroup-maximum-length 40)

;; speedbar-hide-button-brackets-flag 如果为真的话，隐藏 +/- 周围的方括号

;; speedbar-vc-do-check 检查文件是否处于版本控制下

;; auto-complete 是一个非常强悍的补全插件
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/lisp//ac-dict")
(ac-config-default)
(add-to-list 'ac-modes 'org-mode)       ; enable auto-complete-mode in org-mode

(setq
 ac-delay 0.05          ; delay between last command and completing
 ac-auto-show-menu t    ; Show completion menu immediately when complete
 ;;ac-ignore-case 'smart  ; smart case derivation
 ac-menu-height 10      ; completion menu height
 ac-use-menu-map t      ; use menu keymap, for C-n/C-p navigation
 ac-use-quick-help nil  ; disable autohelp tooltip
 )

(dolist (command '(backward-delete-char-untabify
                   delete-backward-char
                   viper-del-backward-char-in-insert
                   backward-kill-word))
  (add-to-list 'ac-trigger-commands command))

(define-key ac-completing-map (kbd "<tab>") 'ac-expand) ; as Tab is now different with C-i
(define-key ac-completing-map (kbd "\r") 'nil) ; preserve original behavior of Return
(define-key ac-completing-map (kbd "\e") 'ac-stop) ; use ESC to abort selection

;; 虽然使用 " " 提交选中的候选词与输入法非常相似，但是因为补全是自动弹出的，所以
;; 当需要输入空格本身时，会变成提交第一个候选词。除非不让补全菜单自动弹出，但这
;; 又会带来大量的补全触发操作。还是使用默认的 Tab 来提交补全好些。
;;(define-key ac-completing-map " " 'ac-complete)

;;(ac-set-trigger-key "M-/")


;; 默认的 Speedbar 内容，可选的值有 "files", "buffers", "quick buffers"
(setq speedbar-initial-expansion-list-name "buffers")

;; ;; 既然不支持 org-mode，目前也没有什么用处
;; (require 'yasnippet)
;; (setq yas/snippet-dirs '("~/.emacs.d/snippets"
;;                         "/usr/local/share/emacs/site-lisp/yasnippet/snippets"))
;; (yas/load-snippet-dirs)
;; (yas/global-mode)

;; Template
(require 'template)
(template-initialize)
(setq template-default-directories '("~/.emacs.d/templates"))
(setq template-auto-insert t)       ; Don't query
(setq template-auto-update nil)     ; Don't update file header when save


;; dictionary.el settings
(require 'dictionary)

(setq
 dictionary-use-single-buffer t
 ;;dictionary-description-open-delimiter "<"
 ;;dictionary-description-close-delimiter ">"
 dictionary-server "127.0.0.1"
 ;;dictionary-port 2628
 ;;dictionary-default-dictionary "*"
 ;;dictionary-default-popup-strategy "lev"
 )

(global-set-key (kbd "C-\\ l") 'dictionary-lookup-definition)
(global-set-key (kbd "C-\\ d") 'dictionary-search)


(autoload 'gnuplot-mode "gnuplot" "gnuplot major mode" t)
(autoload 'gnuplot-make-buffer "gnuplot" "open a buffer in gnuplot mode" t)
(add-to-list 'auto-mode-alist '("\\.gp\\'" . gnuplot-mode))


(autoload 'sawfish-eval-last-sexp "sawfish" "Sawfish major mode")
(add-to-list 'auto-mode-alist '("\\.jl\\'" . sawfish-mode))


(ffap-bindings)

