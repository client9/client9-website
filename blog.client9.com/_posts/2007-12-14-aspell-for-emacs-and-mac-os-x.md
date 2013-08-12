---
layout: post
updated: 2007-12-14
alias: /2007/12/aspell-for-emacs-and-mac-os-x.html
title: aspell for emacs and Mac OS X
---
<p>Here's how to add a spelling checker to Emacs on Mac OS X.  This will work for both terminal based or GUI based versions.</p>

<p>First, for goodness sake, install <a href="http://www.macports.org/">MacPorts</a>.  After it is installed from terminal do:
</p>
<pre>
$ sudo port -v selfupdate
$ sudo port install aspell-dict-en
</pre>

<p> You can install other languages too.  Take a look at "<code>port search aspell</code>" for the list.</p>

<p> Then just add the following line to your <code>.emacs</code></p>

<pre>
(setq ispell-program-name "/opt/local/bin/aspell")
</pre>

<p>Load you your text (or html or xm) file and do <code>M-x ispell</code></p>
<p>Oh yeah!   You can read more on the Emacs commands <a href="http://www.gnu.org/software/emacs/manual/html_node/emacs/Spelling.html#Spelling">here</a></p>

*****
Comment 2009-02-08 by None

This still works for you?<BR/>Emacs still tries to find aspell whithin emacs.app's dir.


*****
Comment 2013-01-23 by None

on mac, the path to aspell shoud be /usr/local/bin/aspell
