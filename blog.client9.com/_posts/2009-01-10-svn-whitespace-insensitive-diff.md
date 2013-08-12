---
layout: post
updated: 2009-01-10
alias: /2009/01/svn-whitespace-insensitive-diff.html
title: svn whitespace insensitive diff
---
<pre>
alias sdiff='svn diff -x -w'
</pre>

<p>At least in <a href="http://subversion.tigris.org/">SVN</a> 1.4.X.  More info can be found doing <code>svn diff --help</code><p>

<p>Older versions of SVN had to call out to an external diff program.</p>

<pre>
svn diff --diff-cmd='diff' -x '-w'
</pre>