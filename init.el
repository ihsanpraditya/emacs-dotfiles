;; INDEX
;; emacs configuration
;; packages
;; themes

;; --- COMMAND ---
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; --- EMACS CONFIGURATION ---
;; App and GUI-app Setting
(set-face-attribute 'default nil :height 140)
(tab-bar-mode 1) ;; Show tab bar in all frame
(setq inhibit-startup-screen t) ;; Disable startup screen
(setq initial-scratch-message "") ;; empty the initial \*scratch*\ buffer
(tool-bar-mode -1) ;; Hide toolbar
(scroll-bar-mode -1) ;; Hide scroll bar

;; Editing Setting
(setq-default
  indent-tabs-mode nil ; Prefers spaces over tabs, tabs are evil
  tab-width 4) ; Set width for tabs
(global-display-line-numbers-mode 1) ;; Display number for every buffer
(set-fill-column 80) ;; set max column is 80 char
(setq-default auto-fill-function 'do-auto-fill) ;; auto-fill-mode
(global-display-fill-column-indicator-mode) ;; Display line for 80
(column-number-mode 1) ; Show the column number
(display-time-mode 1) ; Display time in the mode-line
(fset 'yes-or-no-p 'y-or-n-p) ; Replace yes/no prompts with y/n
(global-hl-line-mode) ; Highlight current line
(show-paren-mode 1) ; Show the matching set of parentheses
(display-battery-mode 1) ; Display battery percentage

(setq-default
  load-prefer-newer t  ; Prefers the newest version of a file
  user-full-name "Ihsan MacBook"  ; Set the full name of the user
  user-mail-address "ihsanumar2017@gmail.com"  ; Set the email of the user
  confirm-kill-emacs 'y-or-n-p)  ; The confirmation string when exiting Emacs

;; --- PACKAGES ---
;; connecting to GNU and MELPA
;; Use-Package Packages List
;; Use-Package Packages Config

;; connecting to the GNU and MELPA package archives
(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;; (setq package-enable-at-startup nil)
(package-initialize)

;; download use-package from MELPA for you if it’s not installed
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Use-Package Packages List
(use-package aggressive-indent)
(use-package apheleia) ;; code-formatter by Prettier.io
(use-package tex
  :ensure auctex) ;; IDE for writing TEX
(use-package company) ;; showing a popup for compliting writing.
(use-package evil) ;; VIM mode movement
(use-package exec-path-from-shell)
(use-package flycheck) ;; for checking code
(use-package focus) ;; for focus in writting
(use-package js2-mode)
(use-package json-mode) ;; highlighting json file
(use-package lua-mode)
(use-package magit) ;; git plugin
(use-package markdown-mode ;; highlighting
  :mode ("\\.md\\'" . markdown-mode))
(use-package minimap) ;; shown in side
(use-package neotree) ;; Directory Tree at sidebar
(use-package rainbow-delimiters) ;; highlighting bracket
(use-package smartparens) ;; automatic closing bracket
(use-package typescript-mode ;; highlighting .ts file
  :mode ("\\.tsx?\\'" . typescript-mode)
  :config
  (setq typescript-indent-level 2))
(use-package vimrc-mode) ;; highlighting .vim file
(use-package yaml-mode) ;; highlighting .yml file
(use-package yasnippet)
(use-package yasnippet-snippets) ;; official snippet for YASnippet

;; Use-Package Packages Config
;;;; Company
;;;; Exec-Path
;;;; FlyCheck
;;;; Neotree
;;;; Rainbow
;;;; SmarParens
;;;; YASnippet

;;;; Company
(add-hook 'after-init-hook 'global-company-mode) ;; enable for all
;; buffer

;; Exec-Path
(exec-path-from-shell-initialize)

;; FlyCheck
(global-flycheck-mode)
(add-to-list 'load-path
             "/Users/user/.nvm/versions/node/v18.12.1/bin/node")
(add-to-list 'load-path "~/.emacs.d/jshint.json")
(defun my-parse-jslinter-warning (warning)
  (flycheck-error-new
   :line (1+ (cdr (assoc 'line warning)))
   :column (1+ (cdr (assoc 'column warning)))
   :message (cdr (assoc 'message warning))
   :level 'error
   :buffer (current-buffer)
   :checker 'javascript-jslinter))
(defun jslinter-error-parser (output checker buffer)
  (mapcar 'parse-jslinter-warning
          (cdr (assoc 'warnings (aref (json-read-from-string output) 0)))))
(flycheck-define-checker javascript-jslinter
  "A JavaScript syntax and style checker based on JSLinter.

See URL `https://github.com/tensor5/JSLinter'."
  :command ("/Users/user/.nvm/versions/node/v18.12.1/bin/jshint" source)
  :error-parser jslinter-error-parser
  :modes (js-mode js2-mode js3-mode))

;; Neotree
(global-set-key [f8] 'neotree-toggle) ;; set <F8> as the toggle key

;; Rainbow-Delimiters Config
;; This will start the mode automatically in most programming modes
;; Emacs 24 and above:
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; SmartParens Config
(smartparens-global-mode 1) ;; smartparens on all buffers

;;;; YASnippet
(yas-global-mode)
(setq yas-snippet-dirs "~/.emacs.d/elpa/yasnippet-snippets-20220713.1234/snippets")

;; --- THEMES ---
(use-package monokai-theme) ;; just dark
(use-package spacemacs-theme ;; light and dark
  :defer t)
(use-package twilight-bright-theme)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(lua-mode js2-mode flymake-easy yaml-mode vimrc-mode use-package typescript-mode twilight-bright-theme spacemacs-theme smartparens monokai-theme markdown-mode magit json-mode focus)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
