;;; my-org-misc.el ---  -*- lexical-binding: t -*-

;; Copyright (C) 2020 Benson Chu

;; Author: Benson Chu <bensonchu457@gmail.com>
;; Created: [2020-04-29 21:30]

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

(require 'org)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key (kbd "<f5>") 'org-agenda)
(global-set-key (kbd "C-x C-o") 'org-agenda)

(define-key org-agenda-mode-map (kbd "a") 'org-agenda)

(setq org-src-window-setup 'current-window)

(setq org-list-allow-alphabetical t)
(setq org-todo-repeat-to-state t)

(setq org-src-ask-before-returning-to-edit-buffer nil)

(with-eval-after-load 'outline
  (add-hook 'ediff-prepare-buffer-hook #'org-show-all))

(setq org-ctrl-k-protect-subtree t)

(add-hook 'org-mode-hook #'visual-line-mode)
(add-hook 'org-mode-hook #'auto-fill-mode)

(add-to-list 'org-structure-template-alist
             '("sv" . "src :results value"))
(add-to-list 'org-structure-template-alist
             '("so" . "src :results output"))



(set-face-attribute 'org-agenda-date-today nil :inherit 'org-agenda-date :foreground "cyan" :slant 'italic :weight 'bold :height 1.1)
(set-face-attribute 'org-agenda-structure  nil :foreground "LightSkyBlue" :box '(:line-width 1 :color "grey75" :style released-button))
(set-face-attribute 'org-ellipsis          nil :foreground "turquoise" :underline nil)
(when (and (not (eq system-type 'windows-nt))
           (find-font (font-spec :name "Font Awesome 5 Free")))
  (setq org-ellipsis " "))

(setq org-log-done 'time)


(setq org-cycle-separator-lines 0)
(setq org-catch-invisible-edits 'show-and-error)
(setq org-link-abbrev-alist 
      '(("youtube" . "https://youtube.com/watch?v=")))

(setq org-use-speed-commands t)

(provide 'my-org-misc)
;;; my-org-misc.el ends here
