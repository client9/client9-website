---
layout: post
updated: 2009-07-09
alias: /2009/07/svn-revision-number-in-file.html
title: svn revision number in file
---
<P><tt>svn propset svn:keywords "[Rev|Id|Date|Author|URL]" <span style="font-style:italic;">file</span></tt>
Then add <code>$Rev|Id|Date|Author|URL $</code> and commit the file.  tada.
</p>
<pre>
$ svn propset svn:keywords "Rev" myfile.txt
$ vi myfile.txt

>   $Rev: $

$ svn ci -m 'Add revision id to file' myfile.txt
$ less myfile.txt

> $Rev: 768 $

</pre>

<p>Same with the other tags of <tt>Id</tt>, <tt>Date</tt>, <tt>Author</tt>, <tt>URL</tt>

*****
Comment 2009-07-09 by None

I&#39;m a fan of just setting this in my svn config file:<br /><br />* = svn:keywords=[Rev|Id|Date|Author|URL]<br /><br />...then all new files get it for free.
