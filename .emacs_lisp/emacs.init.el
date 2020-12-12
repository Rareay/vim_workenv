;;.emacs
;;(setq org-hide-leading-stars 'hidestars)
;;(setq org--leading-stars 'hidestars)
(add-to-list 'load-path "~/.emacs_lisp")
(add-to-list 'load-path "~/.emacs_lisp/org-9.1.1")
(add-to-list 'load-path "~/.emacs_lisp/org-9.1.1/lisp")
(add-to-list 'load-path "~/.emacs_lisp/org-9.1.1/contrib/lisp")
(add-to-list 'load-path "~/.emacs_lisp/auto-complete-1.5.1")
(add-to-list 'load-path "~/.emacs_lisp/popup-el-0.5.3")
(add-to-list 'load-path "~/.emacs_lisp/tabbar")
(add-to-list 'load-path "~/.emacs_lisp/colortheme")

(add-to-list 'load-path "~/.emacs_lisp/evil-1.2.12")

(load "~/.emacs_lisp/config-mkd.el")
;;(load "~/.emacs_lisp/verilog-mode.el")
;;load planner setting
(load "~/.emacs_lisp/emacs.orgmode.el")


;;load unicad
;;(load "~/.emacs_lisp/unicad.el")
;;(require 'unicad)

;;字数统计
(defun word-count ()
  "Count chinese/latin characters, words in region"
  (interactive)
  (let ((from (region-beginning))
        (end (region-end))
        (in-latin-word nil)
        (chinese-chars 0)
        (chinese-punctuations 0)
        (latin-chars 0)
        (latin-words 0)
        (latin-punctuations 0)
        (blank-chars 0))
    (when (use-region-p)
      (save-excursion
        (goto-char from)
        (while (< (point) end)
          (cond
           ((looking-at "[ \t\n]")
            (setq in-latin-word nil)
            (setq blank-chars (1+ blank-chars)))
           ((looking-at "\\cc")
            (setq in-latin-word nil)
            (if (looking-at "\\s.")
                (setq chinese-punctuations
                      (1+ chinese-punctuations))
              (setq chinese-chars
                    (1+ chinese-chars))))
           ((looking-at "\\ca")
            (if (looking-at "\\sw")
                (progn
                  (setq latin-chars (1+ latin-chars))
                  (when (not in-latin-word)
                    (setq in-latin-word t)
                    (setq latin-words (1+ latin-words))))
              (setq in-latin-word nil)
              (setq latin-punctuations
                    (1+ latin-punctuations)))))
          (forward-char))
        (message "CN: %d (%d + %d), EN: %d (%d: %d + %d), BLANK: %d"
                 (+ chinese-chars chinese-punctuations) chinese-chars chinese-punctuations
                 latin-words (+ latin-chars latin-punctuations) latin-chars latin-punctuations
                 blank-chars
                 )))))

(global-set-key (kbd "M-p") 'word-count)

;;(eval-after-load "filecache"
;;  '(progn
;;     (message "Loading file cache...")
;;     (let ((file-cache-filter-regexps
;;            (list "\\.html$" "\\.png$" "~$" "\\.o$" "\\.exe$" "\\.a$" "\\.tex$"
;;                  "\\.elc$" ",v$" "\\.output$" "\\.$" "#$" "\\.class$")))
;;       (file-cache-add-directory "d:/emacs_home/emacs_lisp/")
;;       (file-cache-add-directory "~/.emacs_home/everyday/org")
;;       (file-cache-add-directory "~/.emacs_home/everyday/org/project/")
;;       (file-cache-add-directory "~/.emacs_home/everyday/org/research/")
;;       (file-cache-add-directory "~/.emacs_home/everyday/org/plans/")
;;       (file-cache-add-directory "~/.emacs_home/everyday/org/others/")
;;       (file-cache-add-directory "~/.emacs_home/everyday/org/tools")
;;       (file-cache-add-directory "~/.emacs_home/everyday/org/"))
;;     ))

;;Alt + J 相当于 vi 的  J
;;Alt + M 相当于 vi 的 gJ
;;;;可以 C-u 指定多少行
(defun my-join-lines(&optional arg)
  (interactive "P")
  (setq arg (abs (if arg (prefix-numeric-value arg) 1)))
  (while (> arg 0)
    (save-excursion
      (end-of-line) 
      (delete-char 1)
      (just-one-space))
    (setq arg (- arg 1))))

(defun my-merge-lines(&optional arg)
  (interactive "P")
  (setq arg (abs (if arg (prefix-numeric-value arg) 1)))
  (while (> arg 0)
    (save-excursion
      (end-of-line) 
      (delete-char 1)
      (delete-horizontal-space))
    (setq arg (- arg 1))))

(global-set-key (kbd "M-J") 'my-join-lines)
(global-set-key (kbd "M-M") 'my-merge-lines)


;; Enable column num
(column-number-mode t)
(scroll-bar-mode nil)


;; window-number-mode 用于对 split window 方式下的多个 window 进行编号，可以方便
;; 的在多个 window 之间跳转。默认快捷键是 C-x C-j n，如果开启 Meta- 模式，可以用
;; M-n 跳转。
(load "~/.emacs_lisp/window-number.el")
(require 'window-number)
(window-number-mode t)
(window-number-meta-mode t)             ; 使用 Meta- 前缀来跳转

(iswitchb-mode 1)                       ; 方便的切换 buffer

;; auto-complete 是一个非常强悍的补全插件
(require 'auto-complete)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
(add-to-list 'ac-modes 'org-mode)       ; enable auto-complete-mode in org-mode
(add-to-list 'ac-modes 'latex-mode)       ; enable auto-complete-mode in org-mode
(add-to-list 'ac-modes 'orgtbl-mode)       ; enable auto-complete-mode in org-mode
(add-to-list 'ac-modes 'gfm-mode)       ; enable auto-complete-mode in org-mode
(add-to-list 'ac-modes 'verilog-mode)       ; enable auto-complete-mode in org-mode
(add-to-list 'ac-modes 'text-mode)       ; enable auto-complete-mode in org-mode

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


;; Evil Mode 设置
(setq evil-want-C-u-scroll t
      evil-shift-width 4
      evil-want-fine-undo t
      evil-want-C-w-delete nil
      evil-default-state 'emacs
      evil-default-cursor '("red" t)
      evil-word "a-zA-Z0-9_"
      )
(load "~/.emacs_lisp/evil-1.2.12/evil.el")
(require 'evil)

(setq  evil-normal-state-modes
       '( text-mode
          emacs-lisp-mode
          latex-mode
          c-mode
          c++-mode
          org-mode
          sawfish-mode
          bibtex-mode
          diff-mode
          gfm-mode
          python-mode
          markdown-mode
          fundamental-mode
	      verilog-mode
          shell-script-mode
          shell-mode
          shell-script-mode
          ))

;;(add-to-list 'evil-emacs-state-modes 'help-mode)
;;(add-to-list 'evil-emacs-state-modes 'Info-mode)
(setq evil-motion-state-modes
      (remove 'view-mode
              (remove 'help-mode
                      (remove 'Info-mode
                              evil-motion-state-modes)))
      evil-motion-state-modes
      (remove 'apropos-mode evil-motion-state-modes))

(evil-mode 1)

(define-key evil-insert-state-map "\C-k" nil)
(define-key evil-insert-state-map "\C-r" nil)
(define-key evil-insert-state-map "\C-y" nil)
(define-key evil-insert-state-map "\C-e" nil)
(define-key evil-insert-state-map "\C-p" nil)
(define-key evil-insert-state-map "\C-n" nil)
(define-key evil-insert-state-map "\M-x" nil)
(define-key evil-insert-state-map "\C-x\C-p" nil)
(define-key evil-insert-state-map "\C-x\C-n" nil)

(define-key evil-normal-state-map "\C-p" nil)
(define-key evil-normal-state-map "\M-x" nil)
(define-key evil-normal-state-map "\C-n" nil)
(define-key evil-normal-state-map "\C-]" 'cscope-find-global-definition-no-prompting)
(define-key evil-normal-state-map "\C-t" 'cscope-pop-mark)

(define-key minibuffer-local-map [escape] 'keyboard-escape-quit)
(define-key isearch-mode-map [escape] 'isearch-cancel)


;;(load "vi-find-char")                ; support to find multi-byte chars in vi
;;(load "~/.emacs_lisp/vi-find-char.el")

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


;;tabbar setting
(require 'tabbar)  
(tabbar-mode 1)  
;;显示所有的buffers
;;(setq tabbar-buffer-groups-function
;;(lambda (buffer)
;;(list "All Buffers")))

;;隐藏特殊的buffers，主要是Emacs自己的buffers，大多以“*”开头
(setq tabbar-buffer-list-function
     	(lambda ()
     	  (remove-if
     	   (lambda(buffer)
     	     (find (aref (buffer-name buffer) 0) " *"))
     	   (buffer-list))))
 
;;(global-set-key (kbd "M-[") 'tabbar-backward-group)
;;(global-set-key (kbd "M-]") 'tabbar-forward-group)
;;(global-set-key (kbd "M-p") 'tabbar-backward-tab)
(global-set-key (kbd "C-`") 'tabbar-backward-tab)
(global-set-key (kbd "C-q") 'tabbar-forward-tab)
;;(global-set-key (kbd "M-n") 'tabbar-forward-tab)
;;(global-set-key [(control tab)] 'tabbar-forward-tab)
(global-set-key (kbd "M-<left>") 'tabbar-backward-tab)
(global-set-key (kbd "M-<right>") 'tabbar-forward-tab)


;;设置语言环境
;;(set-language-environment 'Chinese-GB)
;;(set-keyboard-coding-system 'utf-8)
;;(set-clipboard-coding-system 'gb2312)
;;(set-terminal-coding-system 'utf-8)
;;(set-buffer-file-coding-system 'utf-8)
;;(set-default-coding-systems 'utf-8)
;;(set-selection-coding-system 'gb2312)
;;(modify-coding-system-alist 'process "*" 'utf-8)
;;(setq default-process-coding-system '(utf-8 . utf-8))
;;(setq-default pathname-coding-system 'utf-8)
;;(set-file-name-coding-system 'utf-8)
;;
(prefer-coding-system 'utf-8)
;;
;;
;;(if (fboundp 'tool-bar-mode)
;;    (tool-bar-mode -1))
(setq inhibit-startup-message t)
(setq make-backup-files nil)
;;
;;
;;
;;支持外部程序粘贴  
(setq x-select-enable-clipboard t) 

;;显示行号
;;(require 'linum)
(global-linum-mode t)
;;颜色主题
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-hober)))

;; Function to copy lines 
;; "C-c w" copy one line, "C-u 5 C-c w" copy 5 lines 
(defun copy-lines(&optional arg) 
(interactive "p") 
(save-excursion 
(beginning-of-line) 
(set-mark (point)) 
(if arg 
(next-line (- arg 1))) 
(end-of-line) 
(kill-ring-save (mark) (point)) 
) 
) 
;; set key 
(global-set-key (kbd "C-c w") 'copy-lines)


;;set time-stamp
(add-hook 'write-file-hooks 'time-stamp)
;;(setq time-stamp-format "%:u %02m/%02d/%04y %02H:%02M:%02S")
;;(setq time-stamp-start "Time-stamp:<>")
;;(setq time-stamp-start "最后更新: [ ]+\\\\?")
;;(setq time-stamp-end: "\n")
(setq time-stamp-format "%:y-%:m-%:d %02H:%02M:%02S")

;;insert time-stamp
(defun insert-time-stamp()
(interactive)
  (let ((hour (nth 2 (decode-time)))
    (min (nth 1 (decode-time)))
    (day (nth 3 (decode-time)))
    (mon (nth 4 (decode-time)))
    (year (nth 5 (decode-time))))
    (insert (format "%d-%02d-%02d %02d:%02d" year mon day hour min))
  )
)
(global-set-key [f12] 'insert-time-stamp)

(defun insert-time-stamp1()
(interactive)
  (let ((day (nth 3 (decode-time)))
    (mon (nth 4 (decode-time)))
    (year (nth 5 (decode-time))))
    (insert (format "%d-%02d-%02d" year mon day))
  )
)
;;(global-set-key [f9] 'insert-time-stamp1)



;; 改变 Emacs 固执的要你回答 yes 的行为。按 y 或空格键表示 yes，n 表示 no。
(fset 'yes-or-no-p 'y-or-n-p)

;;default 80 columns
(setq-default auto-fill-function 'do-auto-fill)
(setq default-fill-column 120)


;; ido setting
;;(require 'ido-hacks)
;;(require 'ido-vertical-mode)
;;(require 'flx-ido)

(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
(setq ido-everywhere t)
(setq ido-separator "\n")
(ido-mode 1)
;;(ido-hacks-mode 1)
;;(ido-vertical-mode 1)
;;(flx-ido-mode 1)
(global-set-key [f9] 'ido-switch-buffer)

;; markdown setting
(load "~/.emacs_lisp/config-mkd.el")
;; verilog extension written by myself
(load "~/.emacs_lisp/verilog-extension.el")

;; define function to shutdown emacs server instance
(defun server-shutdown()
  "Save buffers, Quit, and Shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs)
  )

;; disable tab  and auto indent tab
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq tag-width 4)
(setq tab-stop-list ())
(setq indent-tabs-mode nil)
(setq indent-tab-always-indent nil)
(setq tab-always-indent nil)
;;(setq indent-tabs-mode t)
;;(setq verilog-auto-reset-widths      t
;;	  verilog-date-scientific-format t)
