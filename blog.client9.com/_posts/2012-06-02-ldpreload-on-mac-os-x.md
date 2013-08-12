---
layout: post
updated: 2012-06-02
alias: /2012/06/ldpreload-on-mac-os-x.html
title: LD_PRELOAD on Mac OS X
---
You want<br />
<pre>DYLD_INSERT_LIBRARIES=/path/to/your.dyld <i>command</i>.
</pre>If that doesn't work, make sure the linker is finding your library by trying: <br />
<pre>DYLD_PRINT_LIBRARIES=1 DYLD_INSERT_LIBRARIES=/path/to/your.dyld <i>command</i>.
</pre>Once you've confirmed that your library is being loaded, but it's still not working, try this<br />
<pre>DYLD_FORCE_FLAT_NAMESPACE=1 DYLD_INSERT_LIBRARIES=/path/to/your.dyld <i>command</i>
</pre><code>man dyld</code> is full of more details.<br />
<br />
See also:<br />
<ul><li><a href="http://blog.client9.com/2012/06/making-shared-libraries-on-mac-os-x-107.html">Making shared libraries on Mac OS X</a></li>
<li><a href="http://blog.client9.com/2012/06/what-is-ldd-on-mac-os-x.html">Where is ldd on Mac OS X</a></li>
</ul>