;;; javascript.el --- Configuration file for handling javascript
;;; Commentary:
;;; Code:

(use-package js2-mode
  :ensure t
  :defer t
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (add-hook 'js2-mode-hook #'js2-imenu-extras-mode))

(use-package js2-refactor
  :after js2-mode
  :ensure t
  :defer t
  :config
  (add-hook 'js2-mode-hook #'js2-refactor-mode))

(use-package flycheck
  :ensure t
  :defer t
  :init
  (setq-default flycheck-temp-prefix ".flycheck")
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode)
  (setq-default flycheck-disabled-checkers
    (append flycheck-disabled-checkers
      '(javascript-jshint)))
  (flycheck-add-mode 'javascript-eslint 'js2-mode)
  (defun my/use-eslint-from-node-modules ()
    (let* ((root (locate-dominating-file
                  (or (buffer-file-name) default-directory)
                  "node_modules"))
          (eslint (and root
                        (expand-file-name "node_modules/eslint/bin/eslint.js"
                                          root))))
      (when (and eslint (file-executable-p eslint))
        (setq-local flycheck-javascript-eslint-executable eslint))))
  (add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules))

(use-package tern
  :ensure t
  :defer t
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . tern-mode )))

(use-package company-tern
  :after tern
  :ensure t
  :defer t
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . company-tern ))
  (add-to-list 'company-backends 'company-tern))
 

(evil-leader/set-key
  "g" 'tern-find-definition
  "r" 'tern-rename-variable
  "d" 'tern-get-docs)
  
;;; javascript.el ends here

