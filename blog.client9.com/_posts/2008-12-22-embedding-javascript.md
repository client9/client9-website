---
layout: post
updated: 2008-12-22
alias: /2008/12/embedding-javascript.html
title: Embedding Javascript
---
<p>
Recently, for personal and professional projects I've been working with Javascript <i>implementations</i> for embedding.   It's quite interesting that there three separate teams working on an open source  implementation of the same language with the same goal of great performance.   I can't think of another language that has this much focus.
</p>

<p>
 Here's my take on the state of the world 22-Dec-2008. Comments welcome.
</p>

<h3>SpiderMonkey</h3>

<ul>
<li><a href="http://www.mozilla.org/js/spidermonkey/">SpiderMonkey</a> is Mozilla's C implementation. </li>
<li>In development for over 10 years</li>
<lI>API is large, and fine grained, but a bit klunky in some spots to deal with legacy issues</li>
<li>API is in C, with some C++ helpers</li>
<li>Lots of options for error, memory and runtime control</li>
<li>Lots of documentation on Mozilla's site, and via searches</li>
<li>Version 1.7 source code is in CVS and has a wacky install procedure</li>
<li>Version 1.8 source is in Mercurial and uses standard autotools</li>
<li>Has the most Javascript language features and extensions (as you would expect by the creators of Javascript)</li>
</ul>

<p>Version 1.8 isn't out yet but should be soon.   It's a bit tricky to get a snapshot, but I've documented and posted a tarball in my other <a href="http://blog.modp.com/2008/12/packaging-libmozjs-javascript.html">article</a>.

<h3>JavaScriptCore</h3>
<ul>
<li><a href="http://webkit.org/projects/javascript/">JavaScriptCore</a> is the implementation in Safari.</li>
<li>API is in "minimal C++" (nothing too scary)</li>
<li>API looks nice, maybe the best of the bunch but..</li>
<li>ZERO web documentation</li>
<li>Frequently zero code comments in headers... and when they do exist... no line break.  So you have a 600 character single line comment.  Lovely.  What editor are they using!</li>
<li>Code in SVN</li>
<li>Code configured via SCONS, which seems to work once you know where to look</li>
<li>No formal releases I can see (didn't investigate tags)</li>
<li>Didn't see anything on controlling execution (e.g. <code>while (1) &#123; &#125;</code></li>
<li>Main wiki wildly out of date</li>
</ul>

<p>
The API is really nice looking, but hampered due to lack of any documentation.  There are some samples in a <code>test</code> directory -- that's about it.  Apple (or whoever controls it) needs to put in nice release engineering to show the world their handy work.
</p>

<h3>Chrome V8</h3>
<ul>
<li><a href="http://code.google.com/apis/v8/design.html">V8</a> is the implementation in Google's Chrome browser.</li>
<li>API is "maximal C++" -- templates, automatic casting, macros, multiple namespaces, the works</li>
<li>Code is in SVN</li>
<lI>Code configured via SCONS</li>
<li>Semi-formal releases via tags</li>
<li>Some documentation on web for major concepts, less so on getting things done.</li>
<li>I found it hard to know or even find where things were defined, or what some defined things in the API even were</li>
<li>Didn't see anything on controlling execution (e.g. <code>while (1) &#123; &#125;</code>&#125;</li>
<li>Very active development (it's the newest engine)</li>
</ul>

<p>V8 is has a very "clever" api that uses all sorts of C++ tricks to simplify coding.   Good luck if you need a C api.  I think the API is a good start and has a lot of promise,  but right now it's a little too confusing for my tastes.  A good scrub of the main API files will help a lot.</p>