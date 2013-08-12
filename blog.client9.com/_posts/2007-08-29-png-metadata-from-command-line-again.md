---
layout: post
updated: 2007-08-29
alias: /2007/08/png-metadata-from-command-line-again.html
title: PNG metadata from the command line, again
---
<p>You may have noticed that <a href="http://www.imagemagick.org/script/index.php">ImageMagick</a>'s <code>identify -verbose</code> output is huge, and if the key or data part is a bit long, the formating is all wacky.  Here's a quick and dirty python script that uses <a href="http://www.pythonware.com/products/pil/">PIL</a> to print <a href="http://www.libpng.org/pub/png/spec/1.2/PNG-Chunks.html#C.Anc-text">PNG metadata</a> to the command line.  It's simple enough that even if you don't know python you should be able to hack it to do what you want.  Save this file as <code>pngmeta</code>, and then do a <code>chmod a+x pngmeta</code>.  Then it should work just like any other shell command, e.g. <code>./pngmeta file1 file2 file3....</code>  This might work with other image types as well.</p>

<pre>
#!/usr/bin/env python                                                                                                                   

# public domain, nick galbreath
# http://blog.modp.com/2007/08/png-metadata-from-command-line-again.html

import sys
from PIL import Image

# These are not user-added meta data, skip                                                                                              
reserved = ('interlace', 'gamma', 'dpi', 'transparency', 'aspect')

# sys.argv[0] is the name of the program.. skip it                                                                                      
# for each file on the command line
for file in sys.argv[1:]:
    print file
    im = Image.open(file)
    for k,v in im.info.iteritems():
        # if auto-generated metadata, skip it
        if k in reserved: continue
        print k + " = " + v
</pre>

<p>Oh great, I'm becoming a PNG metadata <i>expert</i>.  Just what I always wanted to be.</p>

*****
Comment 2008-11-22 by None

Only too bad it is so hard to get in touch with when someone finally needs an <I>PNG metadata expert</I>.<BR/><BR/>Have you made any more improvements to writing metadata from the command line?
