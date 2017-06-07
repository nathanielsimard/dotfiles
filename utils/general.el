;;; general.el --- General configuration
;;; Commentary:
;;; Code:

(setq make-backup-files nil)

(set-language-environment "UTF-8")
(setq-default message-log-max 10)
(setq-default truncate-lines t)
(setq truncate-partial-width-windows t)
(setq-default tab-width 2)
(setq tab-width 2)
(setq-default indent-tabs-mode nil)

(use-package flycheck
  :ensure t
  :demand t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package multi-term
  :ensure t
  :demand t
  :init
  (setq multi-term-program "/usr/bin/zsh")
  :config
  (defun such-emacs/term-toggle()
      (interactive)
      (multi-term-dedicated-toggle)
      (multi-term-dedicated-select))
  (evil-leader/set-key
    "t n" 'multi-term
    "t t" 'such-emacs/term-toggle))

;;; general.el ends here
