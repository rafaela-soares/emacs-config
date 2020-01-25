;;; exwm-tag.el ---  -*- lexical-binding: t -*-

;; Copyright (C) 2020 Benson Chu

;; Author: Benson Chu <bensonchu457@gmail.com>
;; Created: [2020-01-23 08:11]

;; This file is not part of GNU Emacs

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:
(use-package exwm-x)
(require 'my-exwmx-quickrun)
(require 'exwmx-appconfig)

(defun lock-screen ()
  (interactive)
  (shell-command "~/Github/my-projects/i3lock-fancy/i3lock-fancy & disown"))

(defun exwmx-name-buffer ()
  (interactive)
  (let* ((xprograms (mapcar (lambda (a) (plist-get a :instance)) (exwmx-appconfig--get-all-appconfigs)))
         (name (completing-read "Name: " xprograms)))
    (if (and (get-buffer name)
             (not (equal (get-buffer name) (current-buffer)))
             (y-or-n-p (format "Already a buffer named \"%s\". Would you like to swap?" name)))
        (let ((oname (completing-read "Name of other buffer: " xprograms)))
          (exwm-workspace-rename-buffer "This is a stupid name that no one would ever choose for a buffer, hopefully")
          (save-window-excursion
            (switch-to-buffer (get-buffer name))
            (exwm-workspace-rename-buffer oname)
            (setq-local exwm-instance-name oname))
          (exwm-workspace-rename-buffer name)
          (setq-local exwm-instance-name name))
      (exwm-workspace-rename-buffer name)
      (setq-local exwm-instance-name name))))

(defun exwm-rename-buffer ()
  (interactive)
  (when my/window-name
    (exwm-workspace-rename-buffer my/window-name)
    (setq-local exwm-instance-name my/window-name)
    (setq my/window-name nil)))

;; Add these hooks in a suitable place (e.g., as done in exwm-config-default)
(add-hook 'exwm-manage-finish-hook 'exwm-rename-buffer)

(defun launch-program-with-name (cmd name)
  (interactive)
  (when name (setq my/window-name name))
  (start-process-shell-command cmd nil cmd))

(add-hook 'exwm-manage-finish-hook
          (lambda ()
            (when (and exwm-class-name (string= exwm-class-name "Emacs"))
              (exwm-input-set-local-simulation-keys nil))))

(defmacro exec (body)
  `(lambda ()
     (interactive)
     ,body))

(defun toggle-notifications ()
  (interactive)
  (shell-command "kill -s USR1 $(pidof deadd-notification-center)"))

(add-to-list 'exwm-input-prefix-keys ?\C-t)
(defun simulate-C-t (arg)
  (interactive "P")
  (if (eq major-mode 'exwm-mode)
      (exwm-input--fake-key ?\C-t)
    (transpose-chars arg)))
(use-package zeal-at-point)
(define-key *root-map* (kbd "C-d") (quickrun-lambda "zeal" "zeal"))
(define-key *root-map* (kbd "d") #'zeal-at-point)
(define-key *root-map* (kbd "C-t") 'simulate-C-t)
(define-key *root-map* (kbd "C-p") 'exwmx-launch-program)
(define-key *root-map* (kbd "e") (quickrun-lambda "emacs" "emacs"))
(define-key *root-map* (kbd "s") (quickrun-lambda "steam" nil))
(define-key *root-map* (kbd "V") (quickrun-lambda "VBoxManage startvm \"Windows 7\"" "VirtualBox Machine"))
(define-key *root-map* (kbd "r") 'exwmx-name-buffer)
(define-key *root-map* (kbd ")") (lambda () (interactive) (leaving-computer) (shell-command "sleep 2s ; xset dpms force off")))

(define-prefix-command '*firefox-map*)
(define-key *firefox-map* (kbd "c") (quickrun-lambda "google-chrome-stable" "chrome"))
(define-key *firefox-map* (kbd "f") (quickrun-lambda "firefox" "firefox"))
(define-key *firefox-map* (kbd "1") (quickrun-lambda "firefox" "firefox1"))
(define-key *firefox-map* (kbd "2") (quickrun-lambda "firefox" "firefox2"))
(define-key *firefox-map* (kbd "3") (quickrun-lambda "firefox" "firefox3"))
(define-key *firefox-map* (kbd "4") (quickrun-lambda "firefox" "firefox4"))
(define-key *firefox-map* (kbd "d") (quickrun-lambda "firefox" "development"))
(define-key *firefox-map* (kbd "s") (quickrun-lambda "firefox" "school"))
(define-key *firefox-map* (kbd "w") (quickrun-lambda "firefox" "work"))
(define-key *firefox-map* (kbd "y") (quickrun-lambda "firefox" "youtube"))

(define-key *root-map* (kbd "f") '*firefox-map*)

(define-prefix-command '*music-map*)
(define-key *music-map* (kbd "SPC") (exec (shell-command "clementine -t")))
(define-key *music-map* (kbd "n") (exec (shell-command "clementine --next")))
(define-key *music-map* (kbd "p") (exec (shell-command "clementine --previous")))
(define-key *music-map* (kbd "r") (exec (shell-command "clementine --restart-or-previous")))
(defhydra clementine-volume-hydra (*music-map* "v")
  "Clementine volume up and down"
  ("j" (lambda () (interactive) (shell-command "clementine --volume-down")))
  ("J" (lambda () (interactive) (shell-command "clementine --volume-decrease-by 25")))
  ("k" (lambda () (interactive) (shell-command "clementine --volume-up")))
  ("K" (lambda () (interactive) (shell-command "clementine --volume-increase-by 25")))
  ("q" nil))

(define-key *root-map* (kbd "m") '*music-map*)

(provide 'exwm-tag)
;;; exwm-tag.el ends here
