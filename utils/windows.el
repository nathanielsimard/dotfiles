;;; windows.el --- Configuration file for handling windows
;;; Commentary:
;;; Code:

(evil-leader/set-key
	"w l" 'windmove-right
	"w h" 'windmove-left
	"w q" 'evil-quit
	"w j" 'windmove-down
	"w k" 'windmove-up
	"w v" 'split-window-right
	"w b" 'split-window-below)

;;; windows.el ends here
