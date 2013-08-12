---
layout: post
updated: 2008-01-05
alias: /2008/01/making-finder-be-more-like-ls.html
title: Making Finder be more like 'ls -a'
---
<p>Finder has this annoying habit of hiding files and extensions it thinks will confuse you.  As if!</p>

<h2>Show all files</h2>
<p>By default Finder hides files that start with "." (dot) and perhaps others too.  To see all files,  in Terminal type this
<pre>
defaults write com.apple.finder AppleShowAllFiles true &amp;&amp; killall Finder
</pre>
<p>
To revert, change the <code>true</code> to <code>false</code>.  I originally bumped into this <a href="http://www.jappler.com/blog/archive/2006/04/26/show-hidden-files-in-mac-os-x">here</a>.
</p>

<h2>Show all extensions</h2>
<p>Finder sometimes likes hiding the file extention like ".html" from you.  To fix this:  go into Finder's preferences, click the Advanced, and then click "Show all file extensions"<p>


<p>Enjoy!</p>