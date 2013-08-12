---
layout: post
updated: 2007-11-21
alias: /2007/11/joys-of-rounding.html
title: The Joys of Rounding
---
<p>
Quick! What is the output of this:
</p>

<pre>
#include <stdio.h>
int main() &#123;
    printf("%.1f %1.f %.1f", 1.5, 2.5, 3.5);
    return 0;
&#125;
</pre>

<p>
It turns out  Unix based systems (at least on linux glibc and bsd/mac systems), use <a href="http://www.diycalculator.com/popup-m-round.shtml#A5">Round-To-Even</a> rules (this is good):
</p>

<pre>
2 2 3
</pre>

<p>But on Windows, it's <a href="http://www.diycalculator.com/popup-m-round.shtml#A3">Round-Half-Up</a> (this is bad)</p>
<pre>
2 3 4
</pre>

<p>For truly portable programs, you'll need to use a 3rd party implementation of printf (see <a href="http://apr.apache.org/">APR</a>, <a href="http://www.mozilla.org/projects/nspr/">NSPR</a> or <a href="http://library.gnome.org/devel/glib/unstable/index.html">GLIB</a>)

<p>Unfortunately I can't test this for C++ and it's formatting styles and see if there is a difference between Unix and Microsoft systems.</p>