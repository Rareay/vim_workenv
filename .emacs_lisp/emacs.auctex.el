;;.emacs

(add-to-list 'load-path "~/.emacs_lisp/auctex/site-lisp/site-start.d")
(add-to-list 'load-path "~/.emacs_lisp/auctex/site-lisp/auctex")

(load "AucTeX.el" nil t t)
(load "preview-latex.el" nil t t)
(if (string-equal system-type "windows-nt")
    (require 'tex-mik))

(mapc (lambda (mode)
      (add-hook 'LaTeX-mode-hook mode))
      (list 'auto-fill-mode
            'LaTeX-math-mode
            'turn-on-reftex
	    'outline-minor-mode
            'linum-mode)) 

;;(add-hook 'LaTeX-mode-hook
;;          (lambda ()
;;            (setq TeX-auto-untabify t     ; remove all tabs before saving
;;                  TeX-engine 'xetex       ; use xelatex default
;;                  TeX-show-compilation t) ; display compilation windows
;;            (TeX-global-PDF-mode t)       ; PDF mode enable, not plain
;;            (setq TeX-save-query nil)
;;            (imenu-add-menubar-index)
;;            (define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)))
;;
(add-hook 'LaTeX-mode-hook (lambda()
            (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
	    (add-to-list 'TeX-command-list
                          (list "dvipdfm" "dvipdfmx %s" 
                                'TeX-run-command nil t))
	    (add-to-list 'TeX-command-list
                         (list "view-pdf" "D:/software/办公/FoxitReader22/FoxitReader22/FoxitReader.exe %t.pdf"
                               'TeX-run-command t t))
            (setq TeX-command-default "XeLaTeX")
            (setq TeX-save-query  nil )
            (setq TeX-show-compilation nil)
;;	    ;;代码折叠
;; 	    (TeX-fold-mode 1)
;; 	    (setq TeX-fold-env-spec-list
;; 	          (quote ((”[figure]” (”figure”))
;; 	          (”[table]” (”table”))
;; 	          (”[itemize]”(”itemize”))
;; 	          (”[overpic]”(”overpic”)))))
                                       ))

(setq tex-engine 'xetex)

;;(setq TeX-view-program-list
;;      '(("SumatraPDF" "D:/software/办公/FoxitReader22/FoxitReader22/FoxitReader.exe %o")
;;        ("Gsview" "gsview32.exe %o")
;;        ("Okular" "okular --unique %o")
;;        ("Evince" "evince %o")
;;        ("Firefox" "firefox %o")))
;;
;;(cond
;; ((eq system-type 'windows-nt)
;;  (add-hook 'LaTeX-mode-hook
;;            (lambda ()
;;              (setq TeX-view-program-selection '((output-pdf "SumatraPDF")
;;                                                 (output-dvi "Yap"))))))
;; 
;; ((eq system-type 'gnu/linux)
;;  (add-hook 'LaTeX-mode-hook
;;            (lambda ()
;;              (setq TeX-view-program-selection '((output-pdf "Okular")
;;                                                 (output-dvi "Okular"))))))) 
