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
 '(package-selected-packages (quote (ox-ioslide evil)))
 '(tab-always-indent nil)
 '(tab-width 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 142))))
 '(cursor ((t (:background "azure4")))))
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)


; third-party archives  第三方套件庫
(require 'package)                                          ; 需要 package 這個套件
(add-to-list 'package-archives 
             '("melpa" . "https://melpa.org/packages/") t)  ; 加入 melpa 套件庫
(package-initialize)                                        ; 讀入套件資料
; end third-party archives

; mode settings  模式設定
(column-number-mode 1)  ; 在 mode line 顯示列號
(menu-bar-mode -1)      ; 關閉 menu bar
(tool-bar-mode -1)      ; 關閉 tool bar
(display-time-mode 1)   ; 在 mode line 顯示時間

(add-hook 'prog-mode-hook 'linum-mode ) ; 在 prog mode 下顯示行號
; end mode settings

; key bindings  按鍵設定
(global-set-key "\C-ca" 'org-agenda) ; 設定 C-c a 開啟 org agenda dispatcher
; end key bindings

; evil mode settings  evil mode 設定
(require 'evil) ; 需要 evil 這個套件
(evil-mode 1)   ; 開啟 evil mode
; end evil mode settings

; org mode settings  org mode 設定
(setq org-agenda-files "~/Documents/orgAgendaFiles.org")  ; 設定 agenda file 的列表設定檔
(setq org-export-backends '(html latex odt ioslide beamer))
; end org mode settings
