---
layout: post
updated: 2007-11-19
alias: /2007/10/number-parsing-bug-in-librsvg.html
title: Number parsing bug in librsvg
---
<p>Why lord me</p>

<p>I seem to have an odd knack at finding really obscure bugs.  Today's episode, librsvg which converts SVG files to PNG, appears to have <b>number parsing bug</b>.  Good grief.<p>

<p>In particular, if <code>stroke-width</code> is between 0 and 1, and has a lot of digits, then the CSS is parsed differently than if it was defined inline with <code>style</code>.
</p>

<pre>
&lt;style&gt;
.foo &#123; stroke-width: 0.11111111111111111111 &#125;
...
&lt;/style&gt;
&lt;rect clas="foo" ... &gt;
</pre>
<p>
will be parsed with a stroke of 0, i.e. invisible.  While
</p>
<pre>
&lt;rect style="stroke-width: 0.11111111111111111111" ....&gt;
</pre>

<p>
is just fine.  Firefox and Opera render both cases just fine.</p>

<p>Read all about it <a href="http://bugzilla.gnome.org/show_bug.cgi?id=482648">here</a>.


<p>
UPDATE 02-Oct-2007: This probably a bug in <a href="http://www.freespiders.org/projects/libcroco/">libcroco</a> which parses CSS2
</p>

<p>
UPDATE 19-Nov-2007:  Yes libcroco. Read all about it <a href="http://bugzilla.gnome.org/show_bug.cgi?id=498240">here</a>.
</p>