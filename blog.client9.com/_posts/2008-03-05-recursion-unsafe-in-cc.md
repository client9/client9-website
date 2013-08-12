---
layout: post
updated: 2008-03-05
alias: /2008/03/recursion-unsafe-in-cc.html
title: Recursion unsafe in C/C++?
---
<p>
One of the guys who is writing CouchDB, wrote up this this interesting note: <a href="http://damienkatz.net/2008/02/recursion_unsaf.html">Recursion unsafe in C/C++</a>.  It starts off with this
</p>

<blockquote>
The question of "why disallow recursion in C++?" came up in a comment to the C++ coding standards for the Joint Strike Fighter. 
</blockquote>

<p> I was just thinking the same thing.  ha!</p>

*****
Comment 2009-01-20 by None

Recursion is also unsafe from a security perspective in C++, as depending how your address space is layed out the stack can overflow into library code. Particulary, if you are going to accept user generated regexes (always dangerous) you need to stay away from PCRE because it is recursion based and possible to generate pathological regexes that will overflow the stack.
