---
layout: post
updated: 2007-09-02
alias: /2007/08/compiling-imagemagick-on-mac-os-x-using.html
title: Compiling ImageMagick on Mac OS X using MacPorts
---
<p>If you work with graphic formats, you probably are or will use <a href="http://www.imagemagick.org/">ImageMagick</a>.  And if you are using a pre-built binary, at some point you'll bump into a limitation and will need to compile it yourself.</p>

<p>Normally, one might try and do the <code>./configure; make; make install</code> cycle using <a href="http://www.imagemagick.org/script/advanced-unix-installation.php">their instructions</a>, but the dependencies are really complicated.  You might get a minimally functional version to work, but will be missing fonts and functionality (believe me I tried).</p>

<p>On linux et al, mostly like some type package manager is available and you can use that.  On Mac, you have two choices, <a href="http://finkproject.org/">fink</a> and <a href="http://macports.org/">macports</a> to automate the pain.  Personally I've found macports a bit easier to use, and it worked out of box.
</p>

<p>However ImageMagick is a complicated program and I found macports needed a few tweeks to make the ultimate binary.   Here's what you need to do to install.  Advanced users might have already done the first two steps.
</p>

<h4>1. Install XCode and X11 SDK </h4>

<p>Head over to Apple's <a href="http://developer.apple.com/tools/download/">Developer Connection</a> and download xcode.  You might need to create a user id.  Anyways, it's a monster download of around one gig.</p>

<p>Open up the file, and click on the <code>XcodeTools.mpkg</code> and go through the install.  <b>Then</b> open up the <code>Packages</code> directory and click on <code>X11SDK.pkg</code> and install that.</p>

<h4>2. Install MacPorts </h4>

<p>This is an adbridged version of the official page <a href=" http://trac.macosforge.org/projects/macports/wiki/UsingMacPortsQuickStart">UsingMacPortsQuickStart</a>. 
Refer to this page if you run into trouble.</p>

<p>Go to <a href="http://www.macports.org/">MacPorts.org</a> (note its plural, not <code>MacPort</code>).  And find the latest download.  Make sure you pick the right version for your OS.  Download it and install.
</p>

<p>Open up a Terminal and do <code>sudo port -v selfupdate</code></p>

<h4>3. Install special libraries </h4>

<p> These are not technically necessary, but they make life better.  The change to <code>freetype</code> allows for TrueType font-hinting to be turned.  It's turned off since it's patented, but you can turn it on.  It makes certain fonts look better</p>

<p> The <code>librsvg</code> is for rastering SVG images.  ImageMagick uses it, but it also provides a direct SVG to PNG encoder ('man rsvg').
</p>

<p> This takes a a while.  Like it's time to get lunch.  Somehow most of GTK is being downloaded and linked (although you won't be using much if any of it).</p>

<pre>
sudo port -v install freetype +bytecode
sudo port -v install librsvg
</pre>

<h4>4. Install ImageMagick</h4>

<p>Finally, let's install it with lots of special formats turned on.  It doesn't take that long.</p>

<pre>
sudo port -v install ImageMagick +graphviz +gs +wmf +jbig +jpeg2 +lcms
</pre>

<h4>5. Quick Check </h4>

<p>If all goes well, <code>which identify</code> shoudl return <code>/opt/local/bin/identify</code> and <code>identify -list type</code> should list a lot of fonts.</p>

<p>Now you are ready to get some work done!</p>

<h4>6. Man pages</h4>

<p>Oh you want manpages?  Sheesh.  Add <code>export MANPATH="/opt/local/man:$MANPATH"</code> to your <code>~/.profile</code>
</p>