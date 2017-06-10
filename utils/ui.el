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
