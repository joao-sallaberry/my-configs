;; tab in C is 4 spaces
(setq-default c-basic-offset 4)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("55c81b8ddb2b6c3fa502b1ff79fa8fed6affe362447d5e72388c7d160a2879d0"
     "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26"
     "1297a022df4228b81bc0436230f211bad168a117282c20ddcba2db8c6a200743"
     default)))

;; No welcome screen
(setq inhibit-startup-message t)

;; Disable toolbar
(tool-bar-mode -1)

;; Init maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;;(toggle-frame-maximized) ;; emacs 24.4 only

;; Add solarized theme path
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/emacs-color-theme-solarized")
;; Set theme, dark variant
(load-theme 'solarized)
(solarized-update-background-mode 'dark)


;; Prolog
(autoload 'run-prolog "prolog" "Start a Prolog sub-process." t)
(autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)
(autoload 'mercury-mode "prolog" "Major mode for editing Mercury programs." t)
(setq prolog-system 'swi)
(setq auto-mode-alist (append '(("\\.pl$" . prolog-mode)
				("\\.m$" . mercury-mode))
			      auto-mode-alist))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
