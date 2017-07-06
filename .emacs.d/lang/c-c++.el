;;; c-c++.el --- Configuration file for handling c c++
;;; Commentary:
;;; Code:
  
(use-package rtags
  :ensure t)

(use-package cmake-ide
  :after rtags
  :ensure t
  :config
  (cmake-ide-setup))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This section uses packages that are already loaded
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package evil-leader
  :after rtags
  :defer t
  :config
  (add-hook 'c++-mode-hook (lambda ()
                             (let (messages-buffer)
                               (message "Loading c/c++ kybindings"))
                             (evil-leader/set-key
                               "g" 'rtags-find-symbol-at-point
                               "h" 'rtags-find-all-references-at-point
                               "r" 'rtags-rename-symbol))))

;;; c-c++.el ends here
