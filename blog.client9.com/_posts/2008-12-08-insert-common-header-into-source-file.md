---
layout: post
updated: 2008-12-22
alias: /2008/12/insert-common-header-into-source-file.html
title: Insert a common header into source file with Emacs
---
<p>
Sometimes you want every source file to have a common header.  Perhaps a copyright notice, perhaps <a href="http://www.gnu.org/software/emacs/manual/html_node/emacs/Specifying-File-Variables.html">specifying emacs local variables.</a>
</p>

<p>The following emacs command does just this that.  It uses a end-of-header sentinel.  If it's exists, the header is updated.  If not, it is added at the beginning of the file</p>

<p><code>insert-header-core</code> is the main program, and <code>insert-header</code> is your locally customized version.  For whatever reason, make sure your <code>headertag</code> ends with a newline <code>\n</code>
</p>

<pre>
(defun insert-header-core (headertag headerfile)
   "insert a source file header"
   (interactive)
   (goto-char (point-min))
   (kill-region (point-min)
                (progn (search-forward headertag nil t 1)
                       (point)))
   (insert-file headerfile)
)

(defun insert-header ()
  (interactive)
  (insert-header-core "/* HEADER END */\n" "header.txt")
)
</pre>