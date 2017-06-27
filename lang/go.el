;;; go.el --- Configuration file for handling go
;;; Commentary:
;;; Code:

(use-package go-mode
  :ensure t
  :config
  (let (messages-buffer)
    (message "Config for go-mode"))
  (add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
  (add-hook 'go-mode-hook (lambda ()
                             (let (messages-buffer)
                               (message "Loading go-mode"))
                             (go-mode))))
(use-package go-eldoc
  :after go-mode
  :ensure t
  :defer t
  :config
  (add-hook 'go-mode-hook (lambda ()
                            (let (messages-buffer)
                              (message "Loading go-eldoc"))
                            (go-eldoc-setup))))
(use-package go-rename
  :after go-mode
  :ensure t
  :defer t
  :config
  (add-hook 'go-mode-hook (lambda ()
                            (let (messages-buffer)
                              (message "Loading go-rename"))
                            (go-rename-mode t))))

(use-package gotest
  :after go-mode
  :ensure t
  :defer t
  :config
  (add-hook 'go-mode-hook (lambda ()
                            (let (messages-buffer)
                              (message "Loading go-rename"))
                            (gotest-mode t))))

(use-package company-go
  :after go-mode
  :ensure t
  :defer t
  :config
  (add-to-list 'company-backends 'company-go)
  (add-hook 'go-mode-hook (lambda ()
                             (let (messages-buffer)
                               (message "Loading company-go"))
                             (company-mode))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This section uses packages that are already loaded
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package evil-leader
  :after go-mode
  :defer t
  :config
  (add-hook 'go-mode-hook (lambda ()
                             (let (messages-buffer)
                               (message "Loading go keybindings"))
                             (evil-leader/set-key
                               "g" 'godef-jump
                               "r" 'go-rename
                               "l" 'gofmt
                               "t" 'go-test-current-file
                               "d" 'godoc-at-point))))


;;; go.el ends here
