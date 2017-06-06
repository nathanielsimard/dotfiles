;;; javascript.el --- Configuration file for handling javascript
;;; Commentary:
;;; Code:

(let (messages-buffer)
  (message "Loading javascript"))

(use-package js2-mode
  :ensure t
  :config
  (let (messages-buffer)
    (message "Config for js2-mode"))
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (add-hook 'js2-mode-hook (lambda ()
                             (let (messages-buffer)
                               (message "Loading js2-mode"))
                             (js2-imenu-extras-mode))))
(use-package flycheck
  :after js2-mode
  :defer t
  :config
  (flycheck-add-mode 'javascript-eslint 'js2-mode))

(use-package js2-refactor
  :after js2-mode
  :ensure t
  :defer t
  :config
  (add-hook 'js2-mode-hook (lambda ()
                            (let (messages-buffer)
                              (message "Loading js2-refactor"))
                            (js2-refactor-mode))))

(use-package tern
  :after js2-mode
  :ensure t
  :defer t
  :config
  (add-hook 'js2-mode-hook (lambda ()
                            (let (messages-buffer)
                              (message "Loading tern-mode"))
                            (tern-mode t))))

(use-package company-tern
  :after tern
  :ensure t
  :defer t
  :config
  (add-to-list 'company-backends 'company-tern)
  (add-hook 'js2-mode-hook (lambda ()
                             (let (messages-buffer)
                               (message "Loading company-tern"))
                             (company-mode))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This section use packages that are already loaded
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package evil-leader
  :after js2-mode
  :defer t
  :config
  (add-hook 'js2-mode-hook (lambda ()
                             (let (messages-buffer)
                               (message "Loading company-tern"))
                             (evil-leader/set-key
                               "g" 'tern-find-definition
                               "r" 'tern-rename-variable
                               "d" 'tern-get-docs))))

(use-package flycheck
  :ensure t
  :defer t
  :init
  (setq-default flycheck-temp-prefix ".flycheck")
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode)
  (flycheck-add-mode 'javascript-eslint 'js2-mode))

;;; javascript.el ends here
