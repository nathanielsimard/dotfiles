;;: init.el --- SUCH-Emacs Initialization File
;;; Commentary:
;;; Code:

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))


;; Basic configuration files
(load-file "~/Documents/projects/Config/emacs/utils/ui.el")
(load-file "~/Documents/projects/Config/emacs/utils/evil.el")
(load-file "~/Documents/projects/Config/emacs/utils/buffers.el")
(load-file "~/Documents/projects/Config/emacs/utils/windows.el")
(load-file "~/Documents/projects/Config/emacs/utils/autocomplete.el")

;; Lang configuration files
(load-file "~/Documents/projects/Config/emacs/lang/javascript.el")

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (use-package tern-auto-complete spaceline noctilux-theme neotree linum-relative js2-refactor jbeans-theme imenu-anywhere font-utils flycheck evil-leader dashboard darkmine-theme company-tern company-quickhelp clues-theme blackboard-theme base16-theme ample-theme all-the-icons))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
