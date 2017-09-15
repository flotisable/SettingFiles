(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-tab-always-indent nil)
 '(custom-enabled-themes (quote (misterioso)))
 '(indent-tabs-mode nil)
 '(make-backup-files nil)
 '(org-enforce-todo-checkbox-dependencies t)
 '(org-enforce-todo-dependencies t)
 '(tab-always-indent nil)
 '(tab-width 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)


; third-party archives
(require 'package)
(add-to-list 'package-archives 
             '("melpa" . "https://melpa.org/packages/") t)
; end third-party archives

; evil mode settings
(add-to-list 'load-path "~/.emacs.d/elpa/evil-20170815.1422" )
(require 'evil)
(evil-mode 1)
; end evil mode settings

; mode settings
(column-number-mode 1)
(menu-bar-mode -1)
(display-time-mode 1)

(add-hook 'prog-mode-hook 'linum-mode )
; end mode settings

; key bindings
(global-set-key "\C-ca" 'org-agenda)
; end key bindings

; org mode settings
(setq org-agenda-files "~/Documents/orgAgendaFiles.org")
; end org mode settings
