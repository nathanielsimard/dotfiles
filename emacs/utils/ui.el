;;; ui.el --- UI configuration
;;; Commentary:
;;; Code:

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq truncate-partial-width-windows t)
(set-language-environment "UTF-8")
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq tab-width 2)
(setq scroll-conservatively 10000)
(set-default-font "monospace 11")

(use-package linum
  :ensure t
  :demand t
  :config
  (linum-mode t)
  (linum-on))

(use-package linum-relative
  :ensure t
  :demand t
	:config
	(linum-relative-on)
	(global-linum-mode t)
	(column-number-mode t))

(use-package dashboard
  :ensure t
  :demand t
	:config
	(dashboard-setup-startup-hook))

(use-package powerline
  :ensure t
  :demand t
  :init
  (setq powerline-height 20)
  (setq powerline-default-separator 'utf-8)
  :config
  (require 'spaceline-config)
  (spaceline-spacemacs-theme))

(use-package noctilux-theme
  :ensure t
  :demand t
  :config
  (load-theme 'noctilux t))

;;; ui.el ends here
