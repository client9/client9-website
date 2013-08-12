---
layout: post
updated: 2007-09-02
alias: /2007/08/compiling-pngcrush-164-on-mac-os-x.html
title: Compiling pngcrush 1.6.4 on Mac OS X 10.4.10
---
Just in case you are trying to compile <a href="http://pmt.sourceforge.net/pngcrush/">pngcrush 1.6.4</a> on Mac OS 10.4.10.  Apple's version of <code>as</code> (the assembler, based on GAS 1.3.8) is retarded.  Anyways, it's easy to patch up.

Edit the pngcrush Makefile and replace the <code>GAS_VERSION</code> macro as such:
<pre>
# OLD
#GAS_VERSION := $(shell as --version | grep "GNU assembler" | sed -e 's/GNU assembler //' -e 's/ .*//')

# MAC OS X
GAS_VERSION := $(shell echo "" | as -v 2>&1 | grep "GNU assembler" | sed -e 's/.*GNU assembler version //')
</pre>
<p>
then do <code>make</code>, etc.
</p>

<p>
And if that doesn't work, change it to <code>GAS_VERSION:= "Apple"</code>
</p>

<p>
I'm sure this applies to other versions of pngcrush and other versions of OS X
</p>
<p>Update 29-Aug-2007:  You can use the most excellent <a href="http://macports.org/">macports</a> to install this instead.
</p>
<pre>
sudo  ports -v install pngcrush
</pre>

*****
Comment 2009-04-16 by None

btw it's "sudo port" not ports.
