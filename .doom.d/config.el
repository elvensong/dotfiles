;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Vu Quang Dung"
      user-mail-address "dung.vu.eve@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Fira Code Retina" :size 12)
      doom-symbol-font (font-spec :family "Inconsolata Nerd Font" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-zenburn)
(setq doom-theme 'doom-gruvbox-light)


;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(setq tab-width 4)

(setq custom-tab-width 4)

(defun disable-tabs ()
  (setq indent-tabs-mode nil)
  (setq tab-width custom-tab-width))
(defun enable-tabs ()
  (local-set-key (kbd "TAB") 'tab-to-tab-stop)
  (setq indent-tabs-mode t)
  (setq tab-width custom-tab-width))


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; (when (display-graphic-p)
;;   (require 'all-the-icons))
;; ;; or
;; (use-package all-the-icons
;;   :if (displry-graphic-p))

(add-to-list 'auto-mode-alist
             '("\\.apib$" . apib-mode))

(add-hook! java-mode #'lsp)

(map! :leader
      :desc "Toggle treemacs buffer"
      "t t" #'treemacs)

(require 'treemacs)
(require 'treemacs-scope)
(defun treemacs-show-if-hide()
  (interactive)
  (pcase (treemacs-current-visibility)
    ('none (treemacs--init))
    ('exists (treemacs-select-window))
    ('visible ())))

(add-hook 'projectile-after-switch-project-hook 'treemacs-show-if-hide)
(setq treemacs-follow-after-init t)

;; (setq lsp-java-vmargs
;;             `("-noverify"
;;               "-Xmx1G"
;;               "-XX:+UseG1GC"
;;               "-XX:+UseStringDeduplication"
;;               ,(concat "-javaagent:" "/home/eve/.m2/repository/org/projectlombok/lombok/1.18.12/lombok-1.18.12.jar")
;;               ,(concat "-Xbootclasspath/a:" "/home/eve/.m2/repository/org/projectlombok/lombok/1.18.12/lombok-1.18.12.jar")))
(after! pdf-view
  (add-hook 'pdf-view-mode-hook 'pdf-view-midnight-minor-mode))

;;(add-hook 'prog-mode-hook 'enable-tabs)

(add-hook 'lisp-interaction-mode-hook
	  (lambda () (global-set-key (kbd "<f5>") '+eval/buffer-or-region)))

(require 'ox-latex)
(with-eval-after-load 'ox-latex)
(add-to-list 'org-latex-classes
	     '("org-plain-latex"
	       "\\documentclass{article}
	[NO-DEFAULT-PACKAGES]
	[PACKAGES]
	[EXTRA]"
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	       ("\\paragraph{%s}" . "\\paragraph*{%s}")
	       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(setq org-latex-listings 'minted)

(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(add-to-list 'auto-mode-alist '("\\.qml\\'" . qml-mode))


;; (use-package! apheleia
;;   :config
;;   (setf (alist-get 'qmlformat apheleia-formatters)
;;         '("qmlformat" filepath))

;;   (setf (alist-get 'qml-mode apheleia-mode-alist)
;;         'qmlformat))

;; Login Confluence-el
(use-package! confluence
  :config
  (setq confluence-url "http://confluence.integrosys.com/rpc/xmlrpc")
  (setq confluence-username "dung.vu")
  ;; Optional: Store password securely using auth-source
  ;; Or:
  (setq confluence-password "Nevermore89")
  )

(use-package! beacon
  :config
  (setq beacon-color "#ff9f1c")   ;; Optional: custom color
  (setq beacon-blink-when-point-moves-vertically t)
  (setq beacon-blink-when-focused t)
  (setq beacon-blink-when-window-changes t)
  (setq beacon-blink-when-window-scrolls t)
  (beacon-mode 1))                ;; Enable globally

(defun my/switch-theme (theme)
  (interactive)
  "Disable active themes and load THEME."
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme theme t))

;; Custom function to prepend tab number to tab label
(after! centaur-tabs
  (defun my/centaur-tabs-tab-label (tab)
    "Return a label for TAB with its index number."
    (let* ((buf (car tab))
           (name (format "%s" (buffer-name buf))r
                 (index (1+ (cl-position tab (centaur-tabs-tabs (current-buffer))
                                         :test #'equal))))
           (format "%d:%s" index name)))

    ;; Set centaur tab's label function to above custom function.
    (setq centaur-tabs-buffer-tab-label-function #'my/centaur-tabs-tab-label)))

;; Put this in ~/.doom.d/config.el
(defun my-psvn-fix-toggle-read-only ()
  "Shim for old `psvn` expecting `toggle-read-only`."
  (unless (fboundp 'toggle-read-only)
    (defun toggle-read-only (&optional arg)
      "Compatibility shim for psvn: use `read-only-mode' instead."
      (interactive "P")
      (read-only-mode (if arg (prefix-numeric-value arg) 'toggle)))))

;; Ensure shim is defined before loading psvn
(my-psvn-fix-toggle-read-only)

(use-package! dired-atool
  :after dired
  :config
  (defun my/dired-open-archive-as-folder ()
    "If point is on an archive, extract to a temp dir and open it in Dired.
Otherwise, open the file as usual."
    (interactive)
    (let ((file (dired-get-filename nil t)))
      (if (and file
               (string-match-p
                (regexp-opt '(".zip" ".rar" ".7z" ".tar" ".tar.gz" ".tgz"))
                (downcase file)))
          (dired-atool-do-extract-to-temporary-directory)
        (dired-find-file))))

  ;; Use RET to open archives as folders (like WinRAR/7-Zip)
  (map! :map dired-mode-map
        :n [return] #'my/dired-open-archive-as-folder
        :n "o"      #'my/dired-open-archive-as-folder))
