;;; autocomplete.el --- Autocomplete Setup
;;; Commentary:
;;; Code:

(use-package company
  :ensure t
  :demand t
  :init
  (setq company-dabbrev-downcase 0)
  (setq company-idle-delay 0)
  (setq company-tooltip-align-annotations t)
  (setq company-minimum-prefix-length 1)
  :config
  (company-mode t)
  (add-hook 'after-init-hook 'global-company-mode)
  (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
  (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle))

(use-package company-quickhelp
  :ensure t
  :demand t
  :config
  (company-quickhelp-mode 1))

;;; autocomplete.el ends here
