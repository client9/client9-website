---
layout: post
updated: 2012-06-02
alias: /2012/06/making-shared-libraries-on-mac-os-x-107.html
title: Making shared libraries on Mac OS X 10.7
---
Compile with  <code>-fPIC -fno-common</code> and link with <code>-dynamiclib -flat_namespace</code> and use the suffix <code>.dyld</code> for the library (e.g. <code>libfoo.dyld</code>).  At least this worked under Mac OS X 10.7.4 using <code>gcc 4.2.1</code>.   Find out more on the linker by typing <code>man dyld</code>.<br />
<br />
See also:<br />
<ul><li><a href="http://blog.client9.com/2012/06/what-is-ldd-on-mac-os-x.html">Where is <code>ldd</code> on Mac OS X</a></li>
<li><a href="http://blog.client9.com/2012/06/ldpreload-on-mac-os-x.html"><code>LD_PRELOAD</code> on Mac OS X</a></li>
</ul><br />