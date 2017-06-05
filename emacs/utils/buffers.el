;;; buffers.el --- Configuration file for handling buffers
;;; Commentary:
;;; Code:
(use-package neotree
  :ensure t
  :demand t
	:init
	(setq neo-theme 'arrow)
	:config
	(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
	(evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)
	(evil-leader/set-key
	"b t" 'neotree-toggle))

;;; buffers.el ends here
