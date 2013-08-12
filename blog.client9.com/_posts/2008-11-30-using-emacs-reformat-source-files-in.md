---
layout: post
updated: 2008-11-30
alias: /2008/11/using-emacs-reformat-source-files-in.html
title: Using emacs reformat source files in batch
---
<p>

</p>
<p>In a previous post, I present some <a href="http://blog.modp.com/2008/11/handy-emacs-functions-for-code-cleanup.html">emacs functions for code reformatting</a>.  These are great for interactive work, but what if you need to do this to a whole source directory in bulk or done automatically once a night?  Here's a small shell script that does just that.:
</p>

<pre>
#!/bin/bash
# PUBLIC DOMAIN
if [ -z "$1" ]; then
    echo  usage: $0 file-to-indent file2 file3 ...
    exit 1
fi

for i in $@; do
    echo Loading $i
    emacs --batch --load ~/.emacs --file $i \
        --execute '(buffer-cleanup)' --execute '(save-buffer)'
done
</pre>

<p>
Definitely not the most efficient system, but hopefully this doesn't need to be high performance.
</p>

*****
Comment 2013-06-26 by None

emacs --batch $1 -l ./emacs -f buffer_cleanup -f save-buffer<br /><br />works in latest emacs
