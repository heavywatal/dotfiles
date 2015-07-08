;;;;;;;;;1;;;;;;;;;2;;;;;;;;;3;;;;;;;;;4;;;;;;;;;5;;;;;;;;;6;;;;;;;;;7;;;;;;;;;
;;; package management
(add-to-list 'load-path "~/.cask")
(require 'cask)
(cask-initialize)

;(add-to-list 'auto-mode-alist '("\\.Rmd$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.ts$" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.R$" . R-mode))
(autoload 'R-mode "ess-site" "Emacs Speaks Statistics mode" t)

(setq markdown-enable-math t)
(setq markdown-command "hoedown --math --math-explicit")
(setq markdown-xhtml-header-content "<script type=\"text/javascript\" src=\"http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML\"> </script>")
(setq markdown-open-command "open")

(add-to-list 'auto-mode-alist '("\\.Snw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rnw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))

;;;;;;;;;1;;;;;;;;;2;;;;;;;;;3;;;;;;;;;4;;;;;;;;;5;;;;;;;;;6;;;;;;;;;7;;;;;;;;;
;;; customize-face/variable

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(font-lock-maximum-decoration t)
 '(global-auto-complete-mode t)
 '(global-font-lock-mode t)
 '(global-hl-line-mode t)
 '(global-whitespace-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(make-backup-files nil)
 '(scroll-conservatively 42)
 '(show-trailing-whitespace t)
 '(truncate-lines t)
 '(truncate-partial-width-windows nil)
 '(vc-follow-symlinks t)
 '(whitespace-display-mappings
   (quote
    ((newline-mark 10
                   [36 10])
     (space-mark 12288
                 [9632 9632]))))
 '(whitespace-style
   (quote
    (face trailing spaces tabs newline space-mark tab-mark newline-mark))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background "black" :foreground "#ffffff"))))
 '(buffer-menu-buffer ((t (:inherit menu :inverse-video t :weight bold))))
 '(font-lock-builtin-face ((t (:foreground "#99ff33"))))
 '(font-lock-comment-face ((t (:foreground "#666666"))))
 '(font-lock-constant-face ((t (:foreground "#66cc99"))))
 '(font-lock-function-name-face ((t (:foreground "#ffff66"))))
 '(font-lock-keyword-face ((t (:foreground "#33ffff"))))
 '(font-lock-preprocessor-face ((t (:inherit font-lock-comment-face))))
 '(font-lock-string-face ((t (:foreground "#666666"))))
 '(font-lock-type-face ((t (:foreground "#6699ff"))))
 '(font-lock-variable-name-face ((t (:foreground "#cc9999"))))
 '(hl-line ((t (:background "#151515"))))
 '(menu ((t (:background "#2277cc" :foreground "#000000"))))
 '(minibuffer-prompt ((t (:inherit menu :inverse-video t))))
 '(mode-line ((t (:inherit menu))))
 '(mode-line-buffer-id ((t (:foreground "#ffffff" :weight bold))))
 '(mode-line-inactive ((t (:inherit mode-line :background "#778888"))))
 '(region ((t (:background "#cc6600"))))
 '(rst-level-1 ((t (:background "grey35" :weight bold))))
 '(rst-level-2 ((t (:background "grey28"))))
 '(whitespace-newline ((t (:background "#3a3a3a" :foreground "black"))))
 '(whitespace-space ((t (:foreground "#3a3a3a"))))
 '(whitespace-tab ((t (:inherit whitespace-newline)))))

; M-x list-colors-display
; M-x list-faces-display
; 	 TAB 	, 　 SPACE 　

;;;;;;;;;1;;;;;;;;;2;;;;;;;;;3;;;;;;;;;4;;;;;;;;;5;;;;;;;;;6;;;;;;;;;7;;;;;;;;;
;;; keybind

;; backspace and help
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\M-?" 'help-for-help)

;; tmux compatibility
(global-unset-key "\C-t")

;; suppress indentation (mainly for pasting)
(electric-indent-mode 0)

;; page up/down
(global-set-key [next] (lambda () (interactive) (scroll-up 2)))
(global-set-key [prior] (lambda () (interactive) (scroll-down 2)))
;; home/end
(global-set-key [home] 'beginning-of-buffer)
(global-set-key [end] 'beginning-of-buffer)

;; enable scrolling in Terminal.app on Mac
;; https://bitheap.org/mouseterm/
;; http://www.culater.net/software/SIMBL/SIMBL.php
(unless window-system
  (xterm-mouse-mode 1)
  (global-set-key [mouse-4] '(lambda ()
                               (interactive)
                               (scroll-down 1)))
  (global-set-key [mouse-5] '(lambda ()
                               (interactive)
                               (scroll-up 1))))
