---
layout: post
updated: 2009-01-12
alias: /2008/12/packaging-libmozjs-javascript.html
title: Packaging libmozjs Javascript Spidermonkey
---
<p>
If you are trying to get a snapshot of the to-be-released the Spidermonkey Javascript engine V1.8, you'll run into some issues since it uses Mercurial for source repository.  Depending on your system this might challenging in and of itself.  I might be missing something, but Mercurial forces you to get the <i>entire repository</i>  And since Spidermonkey is part of "mozilla-central" you have to download over 600M of source code and change logs to get about 1M of code from the <code>js/src</code> directory.  This can't be right, but I give up reading the Mercurial doco.
</p>

<p>Once you get the source code, it needs to be autoconf'ed with <code>autoconf-2.13</code> and <i>not</i> whatever the latest autoconf on your system is.  I don't know why.
</p>

<p>Then there are lot of directories you don't want (test files, misc integration tools, etc).  Stripping those out takes some time too</p>

<p>
I've done all this mess, the results is here: <a href="http://client9.com/downloads/libmozjs-2009-01-12.tar.bz2">libmozjs-2009-01-12.tar.bz2</a>.  Enjoy!
</p>

<p>My latest packaging script is: <a href="http://client9.com/downloads/make-js-tar.sh">make-js-tar.sh</a></p>