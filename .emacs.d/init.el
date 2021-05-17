(setq save-abbrevs nil)

;;;;;;;;;1;;;;;;;;;2;;;;;;;;;3;;;;;;;;;4;;;;;;;;;5;;;;;;;;;6;;;;;;;;;7;;;;;;;;;
;;; package management

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(when (file-accessible-directory-p "~/.emacs.d/elpa")
  (package-install 'flycheck)
  (package-install 'auto-complete)
  (package-install 'markdown-mode)
  (package-install 'js2-mode)
  (package-install 'tss)
  (package-install 'ess)
  (package-install 'polymode)
)

;(add-to-list 'auto-mode-alist '("\\.Rmd$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.ts$" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.R$" . R-mode))
(autoload 'R-mode "ess-site" "Emacs Speaks Statistics mode" t)

(setq markdown-enable-math t)
(setq markdown-command "hoedown --math --math-explicit")
(setq markdown-xhtml-header-content "<script type=\"text/javascript\" src=\"https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.2/MathJax.js?config=TeX-AMS_CHTML\"> </script>")
(setq markdown-open-command "open")

(add-to-list 'auto-mode-alist '("\\.Snw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rnw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))

(setq ess-toggle-underscore nil)
(setq inferior-R-args "--quiet --no-save --no-restore-data ")

(setq ruby-insert-encoding-magic-comment nil)

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
 '(package-selected-packages '(polymode ess tss js2-mode markdown-mode auto-complete))
 '(scroll-conservatively 42)
 '(show-trailing-whitespace t)
 '(truncate-lines t)
 '(truncate-partial-width-windows nil)
 '(vc-follow-symlinks t)
 '(whitespace-display-mappings '((newline-mark 10 [36 10]) (space-mark 12288 [9632 9632])))
 '(whitespace-style
   '(face trailing spaces tabs newline space-mark tab-mark newline-mark)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:foreground "#666666"))))
 '(font-lock-string-face ((t (:foreground "#888888"))))
 '(hl-line ((t (:background "#151515"))))
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



;;;;;;;;;1;;;;;;;;;2;;;;;;;;;3;;;;;;;;;4;;;;;;;;;5;;;;;;;;;6;;;;;;;;;7;;;;;;;;;
;;; Mac Emacs.app

(setq default-frame-alist
    '((width . 163) (height . 60)))
