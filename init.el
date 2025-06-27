;;окна
; загружает встроенную библиотеку package, которая отвечает за управление пакетами
; возможность использовать функции для установки, обновления и управления сторонними пакетами
; Обычно её используют в начале конфигурации, чтобы подключить систему пакетного менеджмента, после чего можно добавлять репозитории, устанавливать пакеты и настраивать их.
(require 'package)


; Инициализация списка установленных пакетов
(setq package-archives
             '(("melpa-stable" . "https://stable.melpa.org/packages/")
            ("melpa" . "https://melpa.org/packages/")
            ("local" . "/home/gladyshevaa@mks.local/.emacs.d/lisp")))
(package-initialize)


; Добавление вручную расширения markdown-preview-eww
(add-to-list 'load-path "/home/gladyshevaa@mks.local/.emacs.d/lisp/markdown-preview-eww-20160111.1502/")
(require 'markdown-preview-eww)


; Добавление вручную расширения markdown-mode
(add-to-list 'load-path "/home/gladyshevaa@mks.local/.emacs.d/lisp/markdown-mode/")
(require 'markdown-mode)







;; изменение горячих клавиш
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-S-SPC") 'toggle-input-method)


;; отображение колонки с номерами строк
(global-linum-mode 1)  ; Включить номера строк везде
;;(global-display-line-numbers-mode 1)
;;(setq display-line-numbers-width 3)








; Emacs keeps track of files that you are currently editing
; by creating a symbolic link that looks like .#-emacsa08196. 
; disable creation of lock files in Emacs versions >= 24.3 with the following setting
; https://www.emacswiki.org/emacs/LockFiles
(setq create-lockfiles nil)

;; если при выделенном фрагменте текста начинаю печатать или вставлять
;; удалить выделеленный фрагмент
(delete-selection-mode 1)


;; Emacs будет использовать стандартные диалоговые окна (например, для открытия файлов, подтверждения и т.п.), вместо встроенных в интерфейс сообщений или мини-окон.
;; Если установить (setq use-dialog-box nil), то Emacs не будет показывать диалоговые окна и вместо них будет использоваться текстовые интерфейсы в мини-буфере или в другом месте.
;; Если убрать эту строку, то Emacs будет использовать значение по умолчанию, которое обычно — t, то есть диалоговые окна будут отображаться.
(setq use-dialog-box t)


; Настройки курсора
(setq-default cursor-type 'bar)
(blink-cursor-mode 1)


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)


;; Не спрашивать перед закрытием, даже если есть несохранённые изменения
(setq kill-buffer-query-functions nil)
(setq confirm-kill-emacs nil)


;; Установить размер окна при запуске: ширина 80 символов, высота 24 строки
;; (add-to-list 'default-frame-alist '(width . 80))
;; (add-to-list 'default-frame-alist '(height . 24))
;; (setq default-frame-alist (append (list '(width . 80) '(height . 40))))
(when (display-graphic-p)
 (add-to-list 'default-frame-alist '(fullscreen . maximized)))



(setq save-silently t)


(setq auto-save-default nil)
(setq make-backup-files nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(inhibit-startup-screen t)
 '(package-selected-packages (quote (grip-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )









;; Проверка орфографии
;; Указываем Emacs использовать hunspell
;; (setq ispell-program-name "hunspell")
(setq ispell-program-name "/usr/bin/hunspell") ;

;; Проверка, что hunspell доступен
(unless (executable-find ispell-program-name)
  (error "Hunspell не найден! Установите hunspell и словари"))

;; Добавляем поддержку русского языка
(setq ispell-extra-args '("-d"  "/usr/share/myspell/ru_RU"))
(setq ispell-extra-args '("-d"  "/usr/share/myspell/en_US"))

;; Сообщает Emacs, что вы используете hunspell, а не классический ispell
;; t = true
;; Установить переменной ispell-really-hunspell значение истина (включено)
(setq ispell-really-hunspell t)


;; Активирует «ультра»-рекомендации Hunspell
(setq ispell-extra-args '("--sug-mode=ultra"))

;; Правильная инициализация словарей
(with-eval-after-load 'ispell)
;; Очищаем возможные некорректные настройки
(setq ispell-dictionary-alist nil)


;; (setq ispell-dictionary "ru_RU") ;; или "ru_RU", в зависимости от языка

(with-eval-after-load 'ispell
  (add-to-list 'ispell-dictionary-alist
               '("ru_RU"
                 "[А-Яа-яЁё]"
                 "[^А-Яа-яЁё]"
                 ""
                 nil
                 ("-d" "ru_RU")
                 nil utf-8)))

;; Функция для безопасного включения Flyspell
(defun my-flyspell-enable ()
  (interactive)
  (when (executable-find ispell-program-name)
    (setq ispell-local-dictionary "ru_RU")
    (flyspell-mode 1)))

;; Включаем проверку орфографии в нужных режимах
 (dolist (hook '(text-mode-hook markdown-mode-hook))
   (add-hook hook 'my-flyspell-enable))







;; Включить подсветку парных скобок
(show-paren-mode 1)
;; Настроить стиль подсветки (выражение или только скобки)
(setq show-paren-style 'expression)  ; 'expression' или 'parenthesis'
;; Убрать задержку подсветки
(setq show-paren-delay 0)
;; Цвета подсветки (если не работает, попробуйте другие варианты)
;; (set-face-attribute 'show-paren-match nil 
   ;;                 :background "yellow" :foreground "black" :weight 'bold)





