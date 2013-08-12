---
layout: post
updated: 2008-11-29
alias: /2008/11/handy-emacs-functions-for-code-cleanup.html
title: handy emacs functions for code cleanup
---
<p>Here are my "secret" functions for cleaning up a source code file (biased for C or C++).</p>

<pre>
;; Code Cleanup for Emacs V1.0
;; http://blog.modp.com/2008/11/handy-emacs-functions-for-code-cleanup.html
;; PUBLIC DOMAIN

;; zap tabs
;;
(defun buffer-untabify ()
  "Untabify an entire buffer"
  (interactive)
  (untabify (point-min) (point-max)))

;;
;; re-indent buffer
;;
(defun buffer-indent()
  "Reindent an entire buffer"
  (interactive)
  (indent-region (point-min) (point-max) nil))

;;
;; Untabify, re-indent, make EOL be '\n' not '\r\n'
;;   and delete trailing whitespace
;;
(defun buffer-cleanup()
  "Untabify and re-indent an entire buffer"
  (interactive)
  (if (equal buffer-file-coding-system 'undecided-unix )
      nil
    (set-buffer-file-coding-system 'undecided-unix))
  (setq c-basic-offset 4
        tab-width 4
        indent-tabs-mode nil)
  (buffer-untabify)
  (buffer-indent)
  (delete-trailing-whitespace))
</pre>