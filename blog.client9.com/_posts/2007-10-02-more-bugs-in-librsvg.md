---
layout: post
updated: 2007-10-02
alias: /2007/10/more-bugs-in-librsvg.html
title: Path parsing bug in librsvg
---
<p>When it rains it pours, and somehow I always get wet.  Just after this <a href="http://blog.modp.com/2007/10/number-parsing-bug-in-librsvg.html">bug</a> in librsvg I find another.</p>

<P> From the <a href="http://www.w3.org/TR/SVG/paths.html#PathDataMovetoCommands">SVG Spec</a>, it says:
</p>

<blockquote>
If a moveto is followed by multiple pairs of coordinates, the subsequent pairs
are treated as implicit lineto commands.
</blockquote>

<p> So the following should be equivalent:</p>
<pre>
&lt;path d="M0,0  1,1"&gt;
&lt;path d="M0,0 L1,1"&gt;
</pre>

<p>In librsvg 2.18 the first version does nothing.   In Firefox and Opera, both work.  How can I be the first person to bump into this?</p>

<p>The excitement continues <a href="http://bugzilla.gnome.org/show_bug.cgi?id=482787">here</a>.</p>