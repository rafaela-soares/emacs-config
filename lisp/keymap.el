(defmacro exwm-global-set-key (keybinding function)
  `(progn
     (use-exwm
       :config
       (with-eval-after-load "exwm"
         (add-to-list 'exwm-input-global-keys
                      (cons ,keybinding ,function))))
     (global-set-key ,keybinding ,function)))

(exwm-global-set-key (kbd "M-T") 'flop-frame)
(exwm-global-set-key (kbd "s-k") (lambda () (interactive) (kill-buffer (current-buffer))))
(exwm-global-set-key (kbd "M-Q") #'bury-buffer)
(exwm-global-set-key (kbd "M-o") #'other-window)
(exwm-global-set-key (kbd "s-o") #'org-agenda)
(exwm-global-set-key (kbd "s-u") #'org-capture)

(ec/load-or-ask-key 'my/keymap-key
                    'my/keymap-key-key
                    "What would you like *root-map* to be bound to?")

(use-exwm
  :config
  (with-eval-after-load "exwm"
    (add-to-list 'exwm-input-prefix-keys my/keymap-key-key)))

;; Disable C-t for all others
(with-eval-after-load "dired"
  (define-key dired-mode-map my/keymap-key nil))

(define-prefix-command '*root-map*)
(define-key *root-map* (kbd my/keymap-key) (key-binding (kbd "C-t")))
(exwm-global-set-key (kbd my/keymap-key) '*root-map*)

(define-key *root-map* (kbd "C-n") 'switch-window)
(define-key *root-map* (kbd "i") 'org-mru-clock-in)
(define-key *root-map* (kbd "C-i") 'leaving-computer)
(define-key *root-map* (kbd "C") 'org-resolve-clocks)
(define-key *root-map* (kbd "j") 'org-clock-goto)
(define-key *root-map* (kbd "o") 'org-agenda)
(define-key *root-map* (kbd "RET") 'dired-jump)
(define-key *root-map* (kbd "C-b") 'previous-buffer)

(with-eval-after-load "org"
  (define-key *root-map* (kbd "!") #'(lambda ()
                                       (interactive)
                                       (org-time-stamp-inactive t))))

(define-prefix-command '*lazy-map*)
(exwm-global-set-key (kbd "<f1>") '*lazy-map*)

(define-key *lazy-map* (kbd "1") #'org-capture)
(define-key *lazy-map* (kbd "2") #'org-agenda)

(defun toggle-notifications ()
  (interactive)
  (shell-command "kill -s USR1 $(pidof deadd-notification-center)"))
(define-key *root-map* (kbd "n") 'toggle-notifications)

(when (<= 27 emacs-major-version)
  (require 'switch-tabs))

(provide 'keymap)
