---
layout: post
updated: 2007-09-02
alias: /2007/09/ruby-mode-for-emacs.html
title: ruby-mode for emacs
---
I'm not really a ruby guy, but recently I had to do some ruby hacking, which means I needed ruby-mode for emacs.  Between the <a href="http://www.google.com/search?q=ruby+emacs">InterWeb</a>, <a href="http://www.rubygarden.org/Ruby/page/show/InstallingEmacsExtensions">RubyGarden</a>, and <a href="http://www.emacswiki.org/cgi-bin/emacs-en/RubyMode">EmacsWiki</a>, I couldn't find a clear, <i>correct</i> description of how to get ruby-mode.  Here's my take.

<h4> Step 1: Why not upgrade emacs? </h4>

<p>
Did you know emacs finally released a <a href="http://blog.modp.com/2007/09/emacs-221.html">new version</a>?!
</p>

<p> If you are using <a href="http://macports.org/">MacPorts</a>, do this for a terminal (non-gui version).  Do <code>port variants emacs</code> for other options.</p>

<pre>
sudo port install -v emacs
</pre>

<h4> Step 2: Download the code</h4>

<p>We are going to install our lisp code in <code>~/.emacs.d/site-lisp</code> which I <i>think</i> is more-or-less standard, but you could use any directory. 
</p>

<pre>
export SITE_LISP=~/.emacs.d/site-lisp
mkdir -p $SITE_LISP
svn export http://svn.ruby-lang.org/repos/ruby/trunk/misc $&#123;SITE_LISP&#125;/ruby
emacs -batch -f batch-byte-compile $&#123;SITE_LISP&#125;/ruby
</pre>

<p>Don't forget that last step!  That compiles the lisp code, and will make emacs run faster (handy if you re-indent a large file).</p>

<h4> Step 3: Configure your <code>.emacs</code></h4>

<p>
Add this to your <code>.emacs</code>.  This is a complete rip from RubyGardens's <a href="http://www.rubygarden.org/Ruby/page/show/InstallingEmacsExtensions">Installing Emacs Extensions</a>, with the exception of the first line.
</p>

<pre>
;; ruby                                                                         
;; based on http://www.rubygarden.org/Ruby/page/show/InstallingEmacsExtensions  
;;                                                                              

(add-to-list 'load-path "~/.emacs.d/site-lisp/ruby")

 (autoload 'ruby-mode "ruby-mode"
     "Mode for editing ruby source files")
 (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
 (add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
 (autoload 'run-ruby "inf-ruby"
     "Run an inferior Ruby process")
 (autoload 'inf-ruby-keys "inf-ruby"
     "Set local key defs for inf-ruby in ruby-mode")
 (add-hook 'ruby-mode-hook
     '(lambda ()
         (inf-ruby-keys)))
 ;; If you have Emacs 19.2x or older, use rubydb2x                              
 (autoload 'rubydb "rubydb3x" "Ruby debugger" t)
 ;; uncomment the next line if you want syntax highlighting                     
 (add-hook 'ruby-mode-hook 'turn-on-font-lock)
</pre>

<h4> Step 4: Get back to work</h4>

EOF

*****
Comment 2007-10-06 by None

Hey,<BR/><BR/>Just wanted to thank you for posting this. I've spent all morning trying to get ruby mode to work, and this finally did it for me. Thanks!<BR/><BR/>-Jacob


*****
Comment 2008-01-12 by None

Thank you! I was surprised by how little Emacs/Ruby info was available, I believe your page is the only one that clearly tells what needs to happen to turn ruby mode on.


*****
Comment 2008-01-23 by None

Thanks alot!  After reading like a dozen other sites and getting nowhere, this finally worked.


*****
Comment 2008-02-17 by None

Another satisfied customer. Thank you


*****
Comment 2008-04-24 by None

My thanks also! This was way too easy! And now back to work with increased ruby productivity ...<BR/><BR/>Vern


*****
Comment 2008-07-13 by None

I've spent so much time looking for a decent guide. Yours worked! Thanks!


*****
Comment 2008-09-05 by None

worked for me as well on openSUSE 11, thanks a lot


*****
Comment 2009-04-14 by None

Thank you! This was simple and straightforward - now I've got ruby mode working in emacs on windows :-)


*****
Comment 2010-09-01 by None

Yay!


*****
Comment 2011-07-06 by None

Thank you so much for this direct and simple set of steps. I appreciate it
