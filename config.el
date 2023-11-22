;;; distribution/nyan-mode-with-pomodoro/config.el -*- lexical-binding: t; -*-

(use-package! nyan-mode
  :after org-pomodoro
  :init
  (defvar nyan-mode-width 20)

  :config
  (defun get-pomodoro-time-remaining ()
    (if (org-pomodoro-active-p)
        (let ((time-remaining (org-pomodoro-remaining-seconds)))
          (floor time-remaining 60)
          )
      0)
    )
  (defun nyan-number-of-rainbows ()
    (let ((remaining-minutes (get-pomodoro-time-remaining)))
      (/ (* (- org-pomodoro-length remaining-minutes) nyan-mode-width) org-pomodoro-length))
    )
  (defun nyan-mode-toggle ()
    (setq nyan-mode (not nyan-mode))
    (if nyan-mode
        (nyan-start-animation)
      (nyan-stop-animation))
    )
  (setq nyan-mode nil)
  (setq nyan-wavy-trail t)
  (setq nyan-animate-nyancat t)
  (setq nyan-animation-frame-interval 0.1)
  (setq nyan-bar-length nyan-mode-width)
  (setq nyan-minimum-window-width nyan-mode-width)
  (add-hook 'org-pomodoro-started-hook 'nyan-mode-toggle)
  (add-hook 'org-pomodoro-finished-hook 'nyan-mode-toggle)
  (add-hook 'org-pomodoro-killed-hook 'nyan-mode-toggle)
  )
