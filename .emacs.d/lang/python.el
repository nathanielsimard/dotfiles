;;; python.el --- Configuration file for handling python
;;; Commentary:
;;; Code:

(use-package company-jedi
  :ensure t
  :config
  (add-to-list 'company-backends 'company-jedi)
  (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
  (add-to-list 'auto-mode-alist '("\\.py\\'" . jedi:setup)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This section uses packages that are already loaded
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package evil-leader
  :after company-jedi
  :defer t
  :config
  (add-hook 'python-mode-hook (lambda ()
                             (let (messages-buffer)
                               (message "Loading python kybindings"))
                             (evil-leader/set-key
                               "g" 'jedi:goto-definition
                               "d" 'jedi:show-doc))))

;;; python.el ends here
