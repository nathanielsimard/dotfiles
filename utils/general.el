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

(use-package helm
  :init
  (setq helm-split-window-in-side-p t)
  :config
  (defun spacemacs//hide-cursor-in-helm-buffer ()
    "Hide the cursor in helm buffers."
    (with-helm-buffer
      (setq cursor-in-non-selected-windows nil)))
  (add-hook 'helm-after-initialize-hook 'spacemacs//hide-cursor-in-helm-buffer)
  (define-key helm-map (kbd "M-j") 'helm-next-line)
  (define-key helm-map (kbd "M-k") 'helm-previous-line)
  (define-key helm-map (kbd "M-h") 'helm-next-source)
  (define-key helm-map (kbd "M-S-h") 'describe-key)
  (define-key helm-map (kbd "M-l") (kbd "RET"))
  (define-key helm-map [escape] 'helm-keyboard-quit)
  (helm-mode))

(use-package evil-leader
  :after helm
  :config
  (evil-leader/set-key
    "b f" 'helm-find-files
    "b b" 'helm-mini))


;;; general.el ends here
