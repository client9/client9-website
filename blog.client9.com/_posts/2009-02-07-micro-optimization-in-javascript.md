---
layout: post
updated: 2009-02-07
alias: /2009/02/micro-optimization-in-javascript.html
title: Micro-optimization in Javascript
---
<p>Micro-optimization should really be the last thing you worry about when writing Javascript, but I was working on a related project, and this fell out of it:
</p>

<ul>
<li> <code>i++</code>,<code>++i</code> are speed-equivalent, and are mostly a style issue for loop counters.</li>
<li> <code>i++</code>,<code>++i</code> are about 1.5x faster than <code>i = i + 1</code> or <code>i += 1</code></li>
<li> JIT makes the differences between all forms vanish</li>
<li> Do remember to use <code>var</code> in loop counters (and in general).  With out it, loops can be 4x slower.</li>
</ul>


<p>This is based from <a href="http://hg.mozilla.org/mozilla-central/file/6d058c77b563/js/src/">07-Feb-2009 mainline</a> of the <a href="http://www.mozilla.org/js/spidermonkey/">Spidermonkey</a> javascript <a href="http://www.selenic.com/mercurial/wiki/">mercurial</a> repository.   (This snapshot includes what is known as <a href="https://wiki.mozilla.org/JavaScript:TraceMonkey">TraceMonkey</a>.) The results here probably do not apply to other javascript engines, or even future Spidermonkey releases.  The differences between <code>i++</code> and <code>i += 1</code> are probably a bugfix away from being speed-equivalent ( via bytecode optimization).</p>

<h2>The Details</h2>

<p>This was tested using a custom C++ application that fires up a javascript context, and directly executes a code snippet.  The JIT was explicitly turned on or off.  No browser was harmed during these tests.   Time is in microseconds.
</p>

<table>
<tr><th>Snippet</th><th>Normal</th><th>JIT</th></tr>
<tr><td><code>for (var i= 0; i &lt; 10000000; ++i) &#123;&#125;</code></td><td>1380000</td><td>39000</td></tr>
<tr><td><code>for (var i= 0; i &lt; 10000000; i++ ) &#123;&#125;</code></td><td>1380000</td><td>39000</td></tr>
<tr><td><code>for (var i= 0; i &lt; 10000000; i += 1) &#123;&#125;</code></td><td>2230000</td><td>40000</td></tr>
<tr><td><code>for (var i= 0; i &lt; 10000000; i = i + 1) &#123;&#125;</code></td><td>2230000 </td><td>40000</td></tr>
</table>

<ul>
<li><code>++i</code>, <code>i++</code> are equivalent, and are mostly a stylistic issue.</li>
<li><code>i +=1</code>, <code>i = i + 1</code> are equivalent, but 1.6x slower than <code>++i</code></li>
<li>In this trivial case, the  JIT makes the code 30-60x faster.</li>
</ul>

<p>What happens when you forget to put in the <code>var</code></p>

<table>
<tr><th>Snippet</th><th>Normal</th><th>With JIT</th></tr>
<tr><td><code>for (i= 0; i &lt; 10000000; ++i) &#123;&#125;</code></td><td>4270000</th><td>32000</td></tr>
<tr><td><code>for (i= 0; i &lt; 10000000; i++ ) &#123;&#125;</code></td><td>4240000 </th><td>32000</td></tr>
<tr><td><code>for (i= 0; i &lt;  10000000; i += 1) &#123;&#125;</code></td><td>6800000</th><td>49000</td></tr>
<tr><td><code>for (i= 0; i &lt; 10000000; i = i + 1) &#123;&#125;</code></td><td>7080000</th><td>49000</td></tr>
<tr><td><code>j=0;for (i= 0; i &lt;10000000; i = i + 1) &#123;&#125;</code></td><td>7800000</td><td>49000</td></tr>
</table>
<br/>

<p>Holy smokes.  It makes the code 4x slower.  Oddly JIT'ed version actually goes faster, but it's "only" 140x faster than the interpreted version. As for the last entry, I have no idea why another variable added to the script makes it go 10% slower</th>

<p>There you have it.  Don't obsess over this too much.  It's more interesting than useful.</p>

*****
Comment 2009-05-04 by None

Hmm why does adding a variable slow it down.  Hashing?  Because of the way "with" works in JavaScript it's very tempting for an implementation to put local variables in an actual hash table.  So adding more variables may affect the lookups in that hash table.
