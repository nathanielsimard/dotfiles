;;; evil.el --- UI configuration
;;; Commentary:
;;; Code:

(use-package evil
  :ensure t
  :demand
  :init
  (setq evil-shift-width 2)
  :config
  (evil-mode t))

(use-package evil-leader
  :ensure t
	:config
	(global-evil-leader-mode t)
	(evil-leader/set-leader "<SPC>"))

;;; evil.el ends here
