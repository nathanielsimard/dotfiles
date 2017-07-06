;;; ui.el --- UI configuration
;;; Commentary:
;;; Code:

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq scroll-conservatively 10000)
(add-to-list 'default-frame-alist '(font . "Source Code Pro-12"))

(use-package linum
  :ensure t
  :demand t
  :config
  (linum-mode t)
  (add-hook 'prog-mode-hook 'linum-on))

(use-package linum-relative
  :ensure t
  :demand t
	:config
	(linum-relative-on)
	(column-number-mode t))

(use-package dashboard
  :ensure t
  :demand t
	:config
	(dashboard-setup-startup-hook))

(use-package highlight-indent-guides
  :ensure t
  :demand t
  :init
  (setq highlight-indent-guides-method 'character)
  :config
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode))

(use-package powerline
  :ensure t
  :demand t
  :init
  (setq powerline-height 16)
  (setq powerline-default-separator 'utf-8)
  :config
  (powerline-center-evil-theme))


;(use-package noctilux-theme
;(use-package nord-theme
(use-package kaolin-theme
;(use-package jbeans-theme
;(use-package molokai-theme
  :after powerline
  :ensure t
  :demand t
  :config
;  (load-theme 'nord t))
;  (load-theme 'molokai t))
  (load-theme 'kaolin t))

;;;
;;;(use-package airline-themes
 ;;; :after kaolin-theme
  ;;;:ensure t
;;;  :demand t
 ;;; :init
;;;  (setq powerline-utf-8-separator-left        #xe0b0
;;;      powerline-utf-8-separator-right       #xe0b2
;;;      airline-utf-glyph-separator-left      #xe0b0
;;;      airline-utf-glyph-separator-right     #xe0b2
;;;      airline-utf-glyph-subseparator-left   #xe0b1
;;;      airline-utf-glyph-subseparator-right  #xe0b3
;;;      airline-utf-glyph-branch              #xe0a0
;;;      airline-utf-glyph-readonly            #xe0a2
;;;      airline-utf-glyph-linenumber          #xe0a1)
;;;  :config
;;;  (load-theme 'airline-luna))

;;; ui.el ends here
