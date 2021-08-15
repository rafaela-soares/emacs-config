;;; my-org-agenda-files.el ---  -*- lexical-binding: t -*-

;; Copyright (C) 2020 Benson Chu

;; Author: Benson Chu <bensonchu457@gmail.com>
;; Created: [2020-05-06 18:47]

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
(ec/load-or-ask-file 'my/org-folder "Where's the org root directory? ")
(ec/load-or-ask-pred 'my/separate-org-agenda-folder "Is the agenda folder separate? ")

(when my/separate-org-agenda-folder
  (ec/load-or-ask-file 'my/org-agenda-folder "Where's the org agenda directory? "))

(defconst my/agenda-folder
  (if my/separate-org-agenda-folder
      my/org-agenda-folder
    (expand-file-name "agenda" my/org-folder)))

(defun my/org-file (str)
  (expand-file-name str my/org-folder))
(defun my/agenda-file (str)
  (expand-file-name str my/agenda-folder))

(defconst my/non-agenda-files
  `(,(my/org-file "entries/reviews.gpg") 
    ,(my/agenda-file "datetree.org") 
    ,(my/agenda-file "reference.org") 
    ,(my/org-file "entries/journal.gpg")))

(defconst my/all-agenda-files
  (cons (my/agenda-file "eternal.org")
        org-agenda-files))

(provide 'my-org-agenda-files)
;;; my-org-agenda-files.el ends here
