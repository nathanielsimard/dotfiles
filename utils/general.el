;;; general.el --- General configuration
;;; Commentary:
;;; Code:

(setq make-backup-files nil)

(setq-default message-log-max 10)

(use-package flycheck
  :ensure t
  :defer t
  :config
  (flycheck-mode-on-safe))

;;; general.el ends here
