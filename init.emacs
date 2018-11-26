;; -*- mode:emacs-lisp;coding:utf-8 -*-
;;
;; This file should be saved with UTF-8 encoding.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq user-full-name "buxoman")
(setq user-mail-address "buhongbo@163.com")
(cd "~")

;; 插件管理系统在Emacs 24以后才引入，必须要判断Emacs版本号。
(when (>= emacs-major-version 24)
    (require 'package)
    (package-initialize))

(setq package-archives
      '(("melpa-stable" . "http://elpa.emacs-china.org/melpa-stable/")
        ;; ("melpa" . "http://elpa.emacs-china.org/melpa/")
        ("gnu"   . "http://elpa.emacs-china.org/gnu/")
        ("org"   . "http://elpa.emacs-china.org/org/")))

;; 不加载过期的字节码文件
(setq load-prefer-newer t)
;; 当显示中文字体卡顿时,可以开启下列变量
(setq inhibit-compacting-font-caches t)

;; 一键(F2)打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs"))
;; 这一行代码，将函数 open-init-file 绑定到 <f2> 键上
(global-set-key (kbd "<f2>") 'open-init-file)

;;========================================
;; 更喜欢的通用外观设定 General UI  (GUI)
;;========================================
;;  英文字体的选择
;;(set-face-attribute 'default nil :font "Consolas 11")
;;(set-face-attribute 'default nil :font "Consolas italic 9")
;;(set-face-attribute 'default nil :font "Consolas 11")
(set-face-attribute 'default nil :font "Microsoft YaHei Mono 11")
;;(set-face-attribute 'default nil :font "Liberation Mono 10")
;;(set-face-attribute 'default nil :font "Source Code Pro 10")
;;(set-face-attribute 'default nil :font "Dejavu sans mono 10")
;;(set-face-attribute 'default nil :font "Monaco 9")
;;(set-face-attribute 'default nil :font "Menlo 9")
;;(set-face-attribute 'default nil :font "Inconsolata 12")
;; 中文字体的选择, 应使用浮点数
;;(set-fontset-font t 'han (font-spec :family "Microsoft Yahei Mono" :size 11.0))
(set-fontset-font t 'han (font-spec :family "Microsoft Yahei" :size 11.0))
;;(set-fontset-font t 'han (font-spec :family "方正宋刻本秀楷_GBK" :size 10.0))
;; 行间距的设定 (若英文字体或中文字体显示太密，可以调整这个值)
(setq-default line-spacing 0.2)

(setq inhibit-startup-screen t) ;;禁止显示启动画面
(display-time-mode 1) ; 显示时间
(setq display-time-24hr-format t) ; 24小时格式
(setq display-time-day-and-date t) ; 显示日期
(mouse-avoidance-mode 'animate) ; 光标移动到鼠标下时，鼠标自动弹开
(setq fill-column 100)
;; 显示列号
(column-number-mode t)
;; TAB键作为缩进字符
(setq-default indent-tabs-mode nil) ;
;;关闭滚动条
(scroll-bar-mode -1)
;;括号匹配高亮显示
(show-paren-mode t)
;;设置tab位宽度
(setq tab-width 4)
;;关闭工具栏显示
(tool-bar-mode 0)
;工具栏提示信息关闭
(tooltip-mode nil)
;;菜单栏隐藏
(menu-bar-mode 0)
;; 始终开启行号模式
(if (and (>= emacs-major-version 26)
         (>= emacs-minor-version 0))
    (display-line-numbers-mode 1))
 
;; 轮转选择窗口透明度
;; 默认透明值
;; (set-frame-parameter (selected-frame) 'alpha (list 94 94))
(setq alpha-list '((100 100) (95 65) (85 55) (75 45) (65 35) (94 94)))
(defun loop-alpha ()
  (interactive)
  (let ((h (car alpha-list)))                ;; head value will set to
    ((lambda (a ab)
       (set-frame-parameter (selected-frame) 'alpha (list a ab))
       (add-to-list 'default-frame-alist (cons 'alpha (list a ab)))) (car h) (car (cdr h)))
    (setq alpha-list (cdr (append alpha-list (list h))))))
(global-set-key [(f11)] 'loop-alpha)

;;;;
;;;; minibuf config
;;;;
;; (setq read-file-name-completion-ignore-case t) ;;补完文件名称时忽略大小写
;; (setq completion-auto-help 'lazy) ;; 按第二次TAB键才显示补完备选列表

;; ===========================================
;; 窗口的划分与布局
;; ===========================================
(require 'neotree)
(setq neo-window-width 40)

;; Color theme
;;(require 'atom-one-dark-theme)
;;(require 'sexy-monochrome-theme)

;; ============================================
;; 更舒服的通用编辑行为设定
;; ============================================
;; 允许修改文件时自动备份; 大部分文件按都已经采用版本管理了; 此处不需要做备份了。
(setq make-backup-files t)
;; 总是用 utf-8 编码保存文件
(setq buffer-file-coding-system 'utf-8)
;; 文件保存时自动清除行尾空白
(add-hook 'before-save-hook
	  (lambda ()
            ;; xml 文件就不要乱删空格了
            ((buffer-file-name))
            (delete-trailing-whitespace)))
;; 默认行为是提示一个buffer名称然后删除;
;; 重新绑定为直接删除当前的BUFFER
(global-set-key (kbd "C-x k") 'kill-this-buffer)
;; 允许选中文本变更为全小写和全大写
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
;; 允许将可编辑区域收窄到选中区域
(put 'narrow-to-region 'disabled nil)
;; 开启删除替换模式：即对选中的一段文本，输入一个字符即删除所选并替换为新的输入字符。
;; 这种编辑行为与其它编辑器是一样的。
(delete-selection-mode 1)
;; 确认某个命令时需要输入 (yes or no) 比较麻烦
;; 设置一个别名将其简化为只输入 (y or n)
(fset 'yes-or-no-p 'y-or-n-p)
;; 利用 Shift-<arrow> 在一个frame内的多个Window之间移动。
;; 替代 'C-x o'的一个方式。
;; 由于<S-left>、<S-right> 已经被 org-mode 使用;
;; 必须换一个 MODIFIER 按键: 左边的微软系统按键
(require 'windmove)
(setq windmove-default-keybindings 'control)
(setq windmove-wrap-around t)
;; Emacs 自动加载外部修改过的文件,不用确认直接刷新.
;; 绑定到<F5>,大部分Windows应用软件都使用F5实现刷新.
(global-auto-revert-mode 1)
(setq revert-without-query '(".*"))
(global-set-key (kbd "<f5>") 'revert-buffer)
;; 不喜欢听到错误时的“哔哔”的警告提示音
(setq ring-bell-function 'ignore)
;;
;; Automatically convert line endings to unix:
;;
(defun no-junk-please-were-unixish ()
  (let ((coding-str (symbol-name buffer-file-coding-system)))
    (when (string-match "-\\(?:dos\\|mac\\)$" coding-str)
      (set-buffer-file-coding-system 'unix))))
;;(add-hook 'find-file-hooks 'no-junk-please-were-unixish) ;; are yor sure?
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; ==============================================================
;; 指定常用工具的可执行路径
;; ==============================================================
(setq exec-path '("~/bin"
		  "C:/emacs-27.0.50/bin"
                  "C:/msys64/usr/bin"
		  ;; "C:/cygwin/bin"
                  "C:/Program Files/Python36"
                  "C:/Program Files/Python36/Scripts"
		  "C:/Program Files/Graphviz2.26.3/bin"
		  "C:/Program Files/GNU/GnuPG/pub"
		  "C:/Program Files/GNU/GnuPG"
		  "C:/Program Files/GNU/GnuPG/bin"
		  ))

;; 使用 Cygwin 环境
;; 必须放在`exec-path'变量的定义之后，需要指定Cygwin的bin目录。
;; (add-to-list 'load-path "~/.emacs.d/cygwin")
;; (require 'cygwin-mount)
;;(require 'setup-cygwin)

;; Windows 上使用 git-bash 作为 Emacs 的交互式 shell( M-x shell 调用 )
;;
;; 为了避免显示 PS1 提示符乱码，在 ~/.bash_profile 文件中添加下列配置：
;; if [ -n "$INSIDE_EMACS" ]; then
;;     export PS1='\[\033[32m\]\u@\h \[\033[33m\]\w\[\033[36m\]`__git_ps1`\[\033[0m\]\n$ '
;; fi
;;
(setq explicit-shell-file-name "C:/Program Files (x86)/Git/bin/bash.exe")
(setq explicit-bash.exe-args '("--login" "-i"))
;; 在执行命令中显示时若乱码，可以尝试下列配置
(prefer-coding-system 'utf-8)

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

;;====================================================================
;; C/C++语言代码的一些设置
;;   <f11>  绑定到 hs-hide-block
;;   <f10>  绑定到 hs-show-block
;;====================================================================
(setq c-basic-offset 4)
(setq c-offsets-alist '((substatement-open . 0))) ;子语句偏移量缩进不增加
;; 函数名后面的括号紧跟函数
;; (setq c-cleanup-list '(scope-operator space-before-funcall compact-empty-funcall))
(add-hook 'c-mode-hook (lambda ()
                         (linum-mode 1)
                         (hs-minor-mode 1)
                         (global-set-key [(f11)] 'hs-hide-block)
                         (global-set-key [(f10)] 'hs-show-block)))
(add-hook 'c++-mode-hook (lambda ()
                           (linum-mode 1)
                           (hs-minor-mode 1)
                           (global-set-key [(f11)] 'hs-hide-block)
                           (global-set-key [(f10)] 'hs-show-block)))

;; 文件的模式： 比默认的模式更合适的设定
;; 以`.mak'为扩展名的文件，自动用 `GNUMakefile' 模式
;; 以`.o'或者`.obj'为扩展名的文件，自动用`hexl-mode'模式
;; 对于C/H、cpp、cxx、hpp等C/C++文件，全部用`c++-mode'模式
(add-to-list 'auto-mode-alist '("\\.mak\\'" . makefile-gmake-mode))
(add-to-list 'auto-mode-alist '("\\.o\\(bj\\)?\\'" . hexl-mode))
(add-to-list 'auto-mode-alist '("\\.[ch]\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))

;; ===================================================================
;;  Speedbar包的相关设定
;; ===================================================================
(require 'speedbar)
;; 显示函数列表时会分组, 不太方便查找，因此关闭tag分组功能。
(setq speedbar-tag-hierarchy-method nil)
(setq speedbar-default-position 'left)
(setq speedbar-frame-parameters
      (quote
       ((minibuffer)
        (width . 40)
        (border-width . 0)
        (menu-bar-lines . 0)
        (tool-bar-lines . 0)
        (unsplittable . t)
        (left-fringe . 0))))
;; 通过F1键显示或隐藏Speedbar窗口。
(add-hook 'speedbar-mode-hook
          (lambda ()
            (global-set-key [(f12)] 'speedbar-get-focus)))

;;====================================================================
;; GNU Global包的相关设定
;;====================================================================
(add-to-list 'load-path "~/.emacs.d/gtags/")
(autoload 'gtags-mode "gtags" "" t)
(add-hook 'gtags-select-mode-hook
          (lambda ()
            (setq hl-line-face 'underline)
            (hl-line-mode 1)))
(add-hook 'c-mode-hook (lambda() (gtags-mode 1)))
(add-hook 'c++-mode-hook (lambda() (gtags-mode 1)))
(setq gtags-suggested-key-mapping t)
(setq gtags-auto-update t)

;; ===================================================================
;; PlantUML
;; ===================================================================
(setq plantuml-jar-path "~/.plantuml")
;; Enable plantuml-mode for PlantUML files
(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
(add-to-list 'auto-mode-alist '("\\.we\\'" . plantuml-mode))

;; ===================================================================
;;  Deft 笔记管理
;; ===================================================================
;; 设置从哪个目录下查找匹配的文件
(setq deft-directory "e:/appnotes")
;; 设置使用文件名作为标题
(setq deft-use-filename-as-title t)
;; 设置编辑文件时默认的major-mode
(setq deft-text-mode 'org-mode)
;; 设置默认使用正则搜索
;;(setq deft-incremental-search nil)
;; 允许对子目录进行搜索
(setq deft-recursive t)
;; 自定义调出快捷键
(global-set-key [f3] 'deft)
;; 指定管理哪些文件,以扩展名表示
(setq deft-extensions '("org" "md" "txt" "tex"))


;; ===================================================================
;;  Org-mode包的相关设定
;; ===================================================================
;;
;; 设置 #+begin #+end 行的颜色
;; 要求在 require org 之前设置这些 faces.
;; suite-1
;; (defface org-block-begin-line
;;   '((t (:underline "#A7A6AA" :foreground "#008ED1" :background "#EAEAFF")))
;;   "Face used for the line delimiting the begin of source blocks.")
;; (defface org-block-background
;;   '((t (:background "#FFFFEA")))
;;   "Face used for the source block background.")
;; (defface org-block-end-line
;;   '((t (:overline "#A7A6AA" :foreground "#008ED1" :background "#EAEAFF")))
;;   "Face used for the line delimiting the end of source blocks.")

(defface org-block-begin-line
  '((t (:underline "#A7A6AA" :foreground "#A7A6AA")))
  "Face used for the line delimiting the begin of source blocks.")
(defface org-block-background
  '((t (:background "#A7A6AA")))
  "Face used for the source block background.")
(defface org-block-end-line
  '((t (:overline "#A7A6AA" :foreground "#A7A6AA")))
  "Face used for the line delimiting the end of source blocks.")


(require 'org)
(add-to-list 'load-path "~/.emacs.d/htmlize/")
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)
;; 开启自动换行
(add-hook 'org-mode-hook 'auto-fill-mode)
(require 'htmlize)
;; 'css' : export the CSS selectors only
;; 'inline-css': export the CSS attribute values inline in the HTML
;; 'nil': export plain text
(setq org-html-htmlize-output-type 'css)
;; 打开内嵌图片模式
(add-hook 'org-mode-hook 'iimage-mode)
;; 关闭下划线的识别字符
;; 增加反单引号(`)作为新的 verbatim 识别符号(用于文本行内的 verbatim 设置)  
(setq org-emphasis-alist  (quote
                           (("*" bold)
                            ("/" italic)
                            ("_" underline)
                            ("`" verbatim)
                            ("=" org-verbatim verbatim)
                            ("~" org-code verbatim)
                            ("+" (:strike-through t)))))
;; 采用 + xxx :: 描述形式，指定第二行的最大缩进字符数
(setq org-description-max-indent 5)
;; 对于文件链接，始终采用相对路径方式
(setq org-link-file-path-type 'relative)

(setq org-agenda-files '("~/org/gtd.org" "~/org/notes.org"))

;; org文件中就显示代码的高亮颜色
(setq org-src-fontify-natively t)
(require 'color)
(set-face-attribute 'org-block nil :background
                    (color-darken-name
                     (face-attribute 'default :background) 3))

(setq org-src-block-faces '(("emacs-lisp" (:background "#EEE2FF"))
                            ("python" (:background "#E5FFB8"))
                            ;;("c" (:background "#E5FFB8"))
                            ("c" (:background "#EEE2FF"))))
;; 让不同级别的标题使用不同大小的字体
(set-face-attribute 'org-level-1 nil
                    :inherit 'outline-1 :weight 'ultra-bold)
(set-face-attribute 'org-level-2 nil
                    :inherit 'outline-2 :weight 'ultra-bold)
(set-face-attribute 'org-level-3 nil
                    :inherit 'outline-3 :weight 'ultra-bold)
(set-face-attribute 'org-level-4 nil
                    :inherit 'outline-4 :weight 'extra-bold)
(set-face-attribute 'org-level-5 nil
                    :inherit 'outline-5 :weight 'extra-bold)

;; 让checklist中的done条目具有不同的颜色
(font-lock-add-keywords
 'org-mode
 `(("^[ \t]*\\(?:[-+*]\\|[0-9]+[).]\\)[ \t]+\\(\\(?:\\[@\\(?:start:\\)?[0-9]+\\][ \t]*\\)?\\[\\(?:X\\|\\([0-9]+\\)/\\2\\)\\][^\n]*\n\\)" 1 'org-headline-done prepend))
 'append)

;; 设置TODO关键字
(setq org-todo-keywords
      '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w@)" "|" "DONE(d)" "CANCELED(c@)" )))

;; 让 org-mode 支持 plantuml 语言代码块的语法高亮
(add-to-list
 'org-src-lang-modes '("plantuml" . plantuml))

;; 指定 org-mode 支持的 literal-programming 的语言
;; 设置后可以按照以下方式调用:
;; #+BEGIN_SRC plantuml :file export-file-name :cmdline -charset UTF-8
;;
(org-babel-do-load-languages
 'org-babel-load-languages
 '(;; other Babel languages
   (ditaa . t)
   (plantuml . t)
   (dot . t)
   (python . t)
   ))
;; 生成图像时不予提示
(setq org-confirm-babel-evaluate nil)
;; jar 包路径设置
(setq org-plantuml-jar-path
      (expand-file-name "~/.plantuml/plantuml.jar"))

;; 默认导出页面语言为中文
(setq org-export-default-language "gb2312")
;; 导出时字符 `^_' 不转换成上/下角标
(setq org-export-with-sub-superscripts nil)

;; 设置内部块的快捷字母表
(setq org-structure-template-alist
      '(("s" "#+begin_src ?\n\n#+end_src")
        ("e" "#+begin_example\n?\n#+end_example")
        ("q" "#+begin_quote\n?\n#+end_quote")
        ("v" "#+begin_verse\n?\n#+end_verse")
        ("V" "#+begin_verbatim\n?\n#+end_verbatim")
        ("c" "#+begin_center\n?\n#+end_center")
        ("l" "#+begin_latex\n?\n#+end_latex")
        ("L" "#+latex: ")
        ("h" "#+begin_html\n?\n#+end_html")
        ("H" "#+html: ")
        ("a" "#+begin_ascii\n?\n#+end_ascii")
        ("A" "#+ascii: ")
        ("i" "#+index: ?")
        ("I" "#+include: %file ?")
        ("n" "#+name: ?")
        ("t" "*************** ?\n*************** end")))

;; 设置Capture: 快速记录任务/记录想法的目标文件
(setq org-default-notes-file (concat org-directory "/notes.org"))
;; 设置Capture: 定制一些模板
(setq org-capture-templates
      ;; 把TODO任务放到gtd.org文件的Tasks头条下面作为其子条目
      '(("t" "Todo" entry (file+headline (concat org-directory "/gtd.org") "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree (concat org-directory "/journal.org"))
         "* %?\nEntered on %U\n  %i\n  %a")))
;;模板中%a表示一个位置链接，指向你发起这个操作的地方，比如在察看元文件时就记录文件名和行号
;; 完成todo条目的编辑后，按C-c C-c就完成并返回到发起操作的地方。

;; 指定 Agent 视图的数据来源文件
(setq org-agenda-files (list (concat org-directory "/gtd.org")
                             (concat org-directory "/journal.org")
                             (concat org-directory "/notes.org")
                             ))
(defun org-publish-org-sitemap-with-setupfile (project &optional sitemap-filename)
  "Create a sitemap of pages in set defined by PROJECT.
Optionally set the filename of the sitemap with SITEMAP-FILENAME.
Default for SITEMAP-FILENAME is `sitemap.org'."
  (let* ((project-plist (cdr project))
	 (dir (file-name-as-directory
	       (plist-get project-plist :base-directory)))
	 (localdir (file-name-directory dir))
	 (indent-str (make-string 2 ?\s))
	 (exclude-regexp (plist-get project-plist :exclude))
	 (files (nreverse
		 (org-publish-get-base-files project exclude-regexp)))
	 (sitemap-filename (concat dir (or sitemap-filename "sitemap.org")))
	 (sitemap-title (or (plist-get project-plist :sitemap-title)
			    (concat "Sitemap for project " (car project))))
	 (sitemap-style (or (plist-get project-plist :sitemap-style)
			    'tree))
	 (sitemap-sans-extension
	  (plist-get project-plist :sitemap-sans-extension))
	 (visiting (find-buffer-visiting sitemap-filename))
	 file sitemap-buffer)
    (with-current-buffer
	(let ((org-inhibit-startup t))
	  (setq sitemap-buffer
		(or visiting (find-file sitemap-filename))))
      (erase-buffer)
      (insert "#+SETUPFILE: ../Publish/setup/theme-readtheorg-local.setup \n\n")
      (insert "#+LANGUAGE:   zh-CN \n\n")
      (insert (concat "#+TITLE: " sitemap-title "\n\n"))
      (while (setq file (pop files))
	(let ((link (file-relative-name file dir))
	      (oldlocal localdir))
	  (when sitemap-sans-extension
	    (setq link (file-name-sans-extension link)))
	  ;; sitemap shouldn't list itself
	  (unless (equal (file-truename sitemap-filename)
			 (file-truename file))
	    (if (eq sitemap-style 'list)
		(message "Generating list-style sitemap for %s" sitemap-title)
	      (message "Generating tree-style sitemap for %s" sitemap-title)
	      (setq localdir (concat (file-name-as-directory dir)
				     (file-name-directory link)))
	      (unless (string= localdir oldlocal)
		(if (string= localdir dir)
		    (setq indent-str (make-string 2 ?\ ))
		  (let ((subdirs
			 (split-string
			  (directory-file-name
			   (file-name-directory
			    (file-relative-name localdir dir))) "/"))
			(subdir "")
			(old-subdirs (split-string
				      (file-relative-name oldlocal dir) "/")))
		    (setq indent-str (make-string 2 ?\ ))
		    (while (string= (car old-subdirs) (car subdirs))
		      (setq indent-str (concat indent-str (make-string 2 ?\ )))
		      (pop old-subdirs)
		      (pop subdirs))
		    (dolist (d subdirs)
		      (setq subdir (concat subdir d "/"))
		      (insert (concat indent-str " + " d "\n"))
		      (setq indent-str (make-string
					(+ (length indent-str) 2) ?\ )))))))
	    ;; This is common to 'flat and 'tree
	    (let ((entry
		   (org-publish-format-file-entry
		    org-publish-sitemap-file-entry-format file project-plist))
		  (regexp "\\(.*\\)\\[\\([^][]+\\)\\]\\(.*\\)"))
	      (cond ((string-match-p regexp entry)
		     (string-match regexp entry)
		     (insert (concat indent-str " + " (match-string 1 entry)
				     "[[file:" link "]["
				     (match-string 2 entry)
				     "]]" (match-string 3 entry) "\n")))
		    (t
		     (insert (concat indent-str " + [[file:" link "]["
				     entry
				     "]]\n"))))))))
      (save-buffer))
    (or visiting (kill-buffer sitemap-buffer))))

;; 禁止使用默认内联的 css 样式
(setq org-html-head-include-default-style nil)

;; 发布org文件到WEB服务器目录
(setq org-publish-project-alist
      '(("OVS"
         :base-directory "e:/appnotes/OpenVSwitch/"
         :base-extension "org"
         :publishing-directory "e:/appnotes/Publish/OVS"
         :publishing-function org-html-publish-to-html
         :exclude ".html"   ;; regexp
         :style "<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/myorg.css\"/>"
         :auto-sitemap t
         :setupfile "../Publish/setup/theme-readtheorg-local.setup"
         :sitemap-filename "index.org"
         :sitemap-title    "站点地图"
         :sitemap-file-entry-format "%t"
         :sitemap-style "list")

        ("OVS-images"
         :base-directory "e:/appnotes/OpenVSwitch/images/"
         :base-extension "jpg\\|gif\\|png"
         :publishing-directory "e:/appnotes/Publish/OVS/images/"
         :publishing-function org-publish-attachment)
          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        
        ("appnotes" :components ("OVS"
                                 "OVS-images"
                                 ))))
