---
layout: post
updated: 2008-01-05
alias: /2008/01/change-leopard-dock-to-2d.html
title: Change Leopard Dock to 2D
---
<p>
This is old news by now, but essential.  It changes that gratuitous 3D shinny Dock to a more plain and usable 2D version.  I learned about this tip <a href="http://www.silvermac.com/2007/change-leopard-dock-to-2d"/>here</a> (which also has screenshots).
</p>

<p>From Terminal, type:</p>
<pre>
defaults write com.apple.dock no-glass -boolean true && killall Dock
</pre>

<p>Ta-Da.  To undo change the <code>true</code> to <code>false</code></p>