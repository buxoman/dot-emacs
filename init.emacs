;; -*- mode:emacs-lisp;coding:utf-8 -*-
;;
;; This file should be saved with UTF-8 encoding.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
;;org-mode位于单独的仓库
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
;; 应该在下列调用之前把仓库设置好
(package-initialize)
;;以上这一段应该放在配置文件的顶部。

(cd "~")

(setq user-full-name "buxoman")
(setq user-mail-address "buhongbo@163.com")

;; 直接关闭buffer，（默认是用kill-buffer，会询问是否真的kill，挺烦的）
;;(global-key-binding (kbd "C-x k") 'kill-this-buffer) ;; 貌似不起作用
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; 设置临时文件目录
(setq tempdir (concat (file-name-directory
		       (expand-file-name "~/.emacs"))
		      "temp/"))
(if (not (file-directory-p tempdir))
    (mkdir tempdir))
(setq temporary-file-directory tempdir)
(setq ediff-temp-file-prefix tempdir)


(defvar system-address "0.0.0.0")
(if (string= system-type "windows-nt")
    (progn (setq ipconfig (shell-command-to-string "ipconfig"))
	   (if (string-match "IPv4.*\\(192\.168\.[0-9]+\.[0-9]+\\)" ipconfig)
	       (setq system-address (match-string 1 ipconfig)))))

;; Setup English font 设置英文字体
(set-face-attribute 'default nil :font "Dejavu Sans Mono 10")
;; Setup Chinese font 设置中文字体
(set-fontset-font t 'han (font-spec :family "Microsoft Yahei" :size 10.0))

;; 设置Emacs程序打开时框架的初始宽度和高度
(setq initial-frame-alist '((width . 100)
			    (height . 36)
			    (vertical-scroll-bars . nill)))
;; 设置行间距：若是浮点数则该值乘以缺省行高度作为行间距；若是整数则是以十分之一点为单位的距离。
(setq-default line-spacing 0.3)
;; 在窗口的标题条上显示当前buffer的名称或者文件名（带有绝对路径）
;; 并显示Windows系统的IP地址
(setq frame-title-format
      '((:eval (or buffer-file-name (buffer-name)))
	(:eval (if (buffer-modified-p) " * " " - "))
	invocation-name
	"@"
	system-address))

;; 设置Emacs背景的透明度
;; Anchor: March Liu (刘鑫) <march.liu@gmail.com>
;; (global-set-key [(f11)] 'loop-alpha)

(setq alpha-list '((100 100) (95 65) (85 55) (75 45) (65 35)))

(defun loop-alpha ()
  (interactive)
  (let ((h (car alpha-list)))                ;; head value will set to
    ((lambda (a ab)
       (set-frame-parameter (selected-frame) 'alpha (list a ab))
       (add-to-list 'default-frame-alist (cons 'alpha (list a ab))))
     (car h) (car (cdr h)))
    (setq alpha-list (cdr (append alpha-list (list h))))))

;; Functions for display
(menu-bar-mode 0)
(tooltip-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(transient-mark-mode 1)
(show-paren-mode 1)
(column-number-mode 1)
(display-time-mode 1)
(fset 'yes-or-no-p 'y-or-n-p)


;; 设置多彩的Emacs
;; (if (file-exists-p "~/zenburn-emacs/zenburn-theme.el")
;;     (progn
;;       (load-file "~/zenburn-emacs/zenburn-theme.el")
;;       (add-to-list 'custom-theme-load-path "~/zenburn-theme/")
;;       (load-theme 'zenburn t))
;;   (if (file-exists-p "~/.emacs.d/color-theme-6.6.0/color-theme.el")
;;       (progn
;; 	(load-file "~/.emacs.d/color-theme-6.6.0/color-theme.el")
;; 	(load-file "~/.emacs.d/color-theme-6.6.0/themes/color-theme-library.el")
;; 	(require 'color-theme)
;; 	(color-theme-gnome2))))
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'monokai t)
;; 自定义启动画面
(setq inhibit-startup-screen t)
;; (defconst fancy-startup-text '())
;; (defconst fancy-about-text '())
;; PNG : 275Wx188H
;; (setq fancy-splash-image "~/xinxin-145x188.xpm")

;; Finally maximize current Emacs frame
;; 最后把当前Emacs最大化。貌似在戴尔笔记本WIN7系统上不生效？
;;(global-set-key (kbd "A-<f7>") #'(w32-send-sys-command  #xf030))


;; (setq load-path (cons "~/.emacs.d/org-8.2.10/lisp" load-path))
;; (setq load-path (cons "~/.emacs.d/org-8.2.10/contrib/lisp" load-path))
(setq load-path (cons "~/.emacs.d/elpa/org-20150720/lisp" load-path))
(setq load-path (cons "~/.emacs.d/elpa/org-20150720/contrib/lisp" load-path))

;; (set-face-foreground 'font-lock-keyword-face "DeepSkyBlue1")
;; (set-face-foreground 'font-lock-string-face "Goldenrod")
(require 'org)
(org-add-hook 'org-mode-hook 'auto-fill-mode 'append)
(setq-default fill-column 80)
;; (load-file "~/org-config.el")

;;;;
;;;; minibuf config
;;;;
(setq read-file-name-completion-ignore-case t) ;;补完文件名称时忽略大小写
(setq completion-auto-help 'lazy) ;; 按第二次TAB键才显示补完备选列表


(defun c-source-list (dir)
  "递归地列出一个目录及其子目录下的所有C文件和H文件, 但不包含圆点开头的文件."
  (if (file-directory-p dir)
      (append
       (directory-files dir t "\\.\[hHcC\]$")
       (apply 'append (mapcar 'c-source-list (directory-files dir t "[^\\.]+"))))))

(defun cpp-source-list (dir)
  "递归地列出一个目录及其子目录下的所有C文件和H文件, 但不包含圆点开头的文件."
  (if (file-directory-p dir)
      (append
       (directory-files dir t "\\.[hH]$")
       (directory-files dir t "\\.[hH][pP][pP]$")
       (directory-files dir t "\\.[cC][pP][pP]$")
       (apply 'append (mapcar 'c-source-list (directory-files dir t "[^\\.]+"))))))

(defun c-project (dir)
  "打开目录DIR及其子目录下的所有C文件和H文件."
  (interactive "Dinput c source root: ")
  (setq allfiles (c-source-list dir))
  ;;(message "%s" allfiles)
  ;;(message "length %d" (safe-length allfiles))
  (with-temp-buffer
    ;; 预先在C文件根目录下通过Windows命令dir /B /S显示所有文件
    ;; 然后将每一个文件都作为etags命令的输入：
    ;; @etags.exe -a --lang=c xxxx.c
    (setq cmdfile (concat dir "/etags.bat"))
    (setq tagfile (concat dir "/TAGS"))
    (if (file-exists-p cmdfile)
	(delete-file cmdfile))
    (if (file-exists-p tagfile)
	(delete-file tagfile))
    (mapc (lambda (file)
	    (insert (format "\@etags\.exe \-a \-\-lang=c %s\n" file)))
	  allfiles)
    (if (file-writable-p cmdfile)
	(write-file cmdfile)))
    (cd dir)
    (shell-command "etags.bat" nil nil)
    (visit-tags-table "TAGS")
    (mapc (lambda (file)
	    (find-file file))
	  allfiles))

(defun cpp-project (dir)
  "打开目录DIR及其子目录下的所有C文件和H文件."
  (interactive "Dinput c source root: ")
  (setq allfiles (cpp-source-list dir))
  ;;(message "%s" allfiles)
  ;;(message "length %d" (safe-length allfiles))
  (with-temp-buffer
    ;; 预先在C文件根目录下通过Windows命令dir /B /S显示所有文件
    ;; 然后将每一个文件都作为etags命令的输入：
    ;; @etags.exe -a --lang=c xxxx.c
    (setq cmdfile (concat dir "/etags.bat"))
    (setq tagfile (concat dir "/TAGS"))
    (if (file-exists-p cmdfile)
	(delete-file cmdfile))
    (if (file-exists-p tagfile)
	(delete-file tagfile))
    (mapc (lambda (file)
	    (insert (format "\@etags\.exe \-a \-\-lang=cxx %s\n" file)))
	  allfiles)
    (if (file-writable-p cmdfile)
	(write-file cmdfile)))
    (cd dir)
    (shell-command "etags.bat" nil nil)
    (visit-tags-table "TAGS")
    (mapc (lambda (file)
	    (find-file file))
	  allfiles))
