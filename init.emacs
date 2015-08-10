
(cd "~")

(setq user-full-name "BuHongBo")
(setq user-mail-address "buhongbo@163.com")

;; ������Ӣ������
;; Set English font
(set-face-attribute 'default nil :font "Dejavu Sans Mono 10")
;; Set Chinese font
;; ����ʱע��SIZEҪ�ø�����������������
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font) charset
		    (font-spec :family "Microsoft Yahei" :size 10.0)))
;; ����Emacs�����ʱ��ܵĳ�ʼ��Ⱥ͸߶�
(setq initial-frame-alist '((width . 100)
			    (height . 42)))

;; ����Emacs������͸����
;; Anchor: March Liu (����) <march.liu@gmail.com>
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

;; ���ö�ʵ�Emacs
(load-file "~/.emacs.d/color-theme-6.6.0/color-theme.el")
(load-file "~/.emacs.d/color-theme-6.6.0/themes/color-theme-library.el")
(require 'color-theme)
;; (color-theme-gnome2)

;; �Զ�����������
(setq inhibit-startup-screen t)
;; (defconst fancy-startup-text '())
;; (defconst fancy-about-text '())
;; PNG : 275Wx188H
;; (setq fancy-splash-image "~/xinxin-145x188.xpm")

;; Finally maximize current Emacs frame
;; ���ѵ�ǰEmacs��󻯡�ò���ڴ����ʼǱ�WIN7ϵͳ�ϲ���Ч��
;;(global-set-key (kbd "A-<f7>") #'(w32-send-sys-command  #xf030))


;; (setq load-path (cons "~/.emacs.d/org-8.2.10/lisp" load-path))
;; (setq load-path (cons "~/.emacs.d/org-8.2.10/contrib/lisp" load-path))
(setq load-path (cons "~/.emacs.d/elpa/org-20150720/lisp" load-path))
(setq load-path (cons "~/.emacs.d/elpa/org-20150720/contrib/lisp" load-path))
(set-face-foreground 'font-lock-keyword-face "DeepSkyBlue1")
(set-face-foreground 'font-lock-string-face "Goldenrod")
(require 'org)
(org-add-hook 'org-mode-hook 'auto-fill-mode 'append)
(setq-default fill-column 80)
;; (load-file "~/org-config.el")
