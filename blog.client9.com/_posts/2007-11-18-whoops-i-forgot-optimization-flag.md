---
layout: post
updated: 2007-11-21
alias: /2007/11/whoops-i-forgot-optimization-flag.html
title: Whoops, I forgot the optimization flag
---
<p>So it turns out if you use macports on Mac OS 10.5, python2.5 is compiled without any optimization.  This makes it run at least 2x slower than the version in <code>/usr/bin</code> (the bug report is <a href="http://trac.macports.org/projects/macports/ticket/13335">here</a>).

<p>I only noticed this since I'm a nerd and tuned on verbose/debug flags on macports and then thought it was weird that I didn't see the usual <code>-O2</code>.   I then wrote a minor benchmark to confirm that indeed, the macports version is slower.</p>

<p>Which reminds me of major screwups I have done involving pushing debug code live instead of the normal optimized version (in that case it was C++ code).  In this case I think it took 6 hours of many people's time to "undo" since all the servers  were on fire and end customers were pissed off.</p>

<p>Besides turning on al compiler warnings, besides running your unit tests, besides running your integration tests, <b>you also need to have some type of minor performance test</b> to catch these problems.   Even the simplest test will catch these type of problems.  And it's not just for C++:  even if you are writing using a scripting language, the packager of the language can screw up, or use a different optimization between builds, or use a different compile or just not use the best optimization possible. </p>

<p> In the macport example, it appears that some tweeks needed to be done to make python compile on the new OS.  In the process of fixing that, the optimizer flags were ignored silently.  Nothing was "removed".   I've done the same thing fiddling with Makefiles.  I didn't remove optimization, I just screwed up some rules, so the wrong flags were used.  In other words, it's really easy to this.</p>

<p><b>Have a performance smoke test</b></p>