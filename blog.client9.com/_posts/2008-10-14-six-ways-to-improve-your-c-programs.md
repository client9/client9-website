---
layout: post
updated: 2008-10-20
alias: /2008/10/six-ways-to-improve-your-c-programs.html
title: Seven Ways To Improve Your C-Programs With GCC
---
<p>Recently, a colleague mentioned how they were having trouble with their server crashing and some of the errors were due to "functions missing return statements, <code>printf</code> mismatches, etc".   Yikes!
</p>

<p>
 A lot of common C programming gotchas can be eliminated just by using the GCC compiler in creative and not-so-creative ways.  If you aren't using GCC, consider setting up an alternate build system to use it to find new errors you current compiler isn't finding.  Most of these apply to C++ too.
</p>.

<p>There are a few more flags and tricks that can be done but these are the big ones.</p>

<p>Happy Compiling!</p>

<hr />

<h3>Use <code>-Wall -Wextra -Werror</code> now!</h3>

<p>
Without these flags, lovely code like this
</p>
<pre>
int foo(int n) &#123;
  if (n > 0)
    return 1;
&#125;
</pre>

<p> is technically legal C, and compiles and links just fine.  These
flags will catch many of the dumb mistakes like this.</p>

<p>  The one gotcha
is that system or other library headers files might cause some
troubles.  This is very annoying, which has a few less than elegant
hacks to fix, but <i>keep those flags on</i>.  One developer I know
relaxed (ahem, removed) these flags so he could compile against
another library.  Within <i>hours</i> bad code was checked in and
flowing into production.  </p>


<h3>Add <code>-Wformat=2</code></h3>

<p>Bad <code>printf</code>-style format strings can cause core dumps
or major security violations.  This check greatly improves type
checking.  Not sure why this is not part of <code>-Wall</code> or
<code>-Wextra</code>.</p>

<p>However, I'm not sure these checks can prevent 100% of the bad
cases that can cause core dumps, but, it's better than no checks.</p>


<h3>Use C99</h3>

<p>Enable this with <code>-std=c99</code>.  It's slightly more strict and deprecates
some very old C idioms than nobody uses <i>intentionally</i> any more.
</p>

<h3>Compile using the latest gcc</h3>

<p> Even if your production version uses a different compiler, it pays
to compile using the latest gcc just to find errors.  Every point
release contains more checks.  Version <a href="http://gcc.gnu.org/gcc-4.3/changes.html">4.3</a> is especially useful (most new checks are included in <code>-Wall</code></p>

<h3>Compile both  production and <i>debug</i> builds regularly</h3>

<p>I assure you deep inside your source code, someone has put in a
<code>#ifdef DEBUG</code>.  And, I assure you at some point a debug
build will go into production.  Or your developer will run exclusively
a debug build not realizing they broke the production build.</p>

<p> On your build harness (you have one right?), build both debug and
optimizers versions, and run the unit tests against both.  It will find
errors. </p>

<h3>Consider compiling with C++</h3>

<p>Ok, i know this is scary since once the gates are lifted, and C++
developers come out of their cage, your code base can get
<i>weird</i>, fast.  I'm not saying converting to C++, but just
<i>compiling</i> it, just like you are compiling both a production and
debug build.  It will require some tinkering, and adding casts before
<code>malloc</code>, but your code can compile cleanly under C99 <i>and</i> C++.  The benefit is that C++ is much more strict on types and
initialization than C99.  It will find bugs.</p>

<h3>Add <code>-Wconversion</code></h3>

<p>Added 20-Oct-2008:  <code>-Wconversion</code> checks signed-to-unsigned (and vice-versa) conversions and automatic floating-point to integer.  While this can initially produce a lot of warning, some quick cleanups will catch conversions that <i>lose data</i> or <i>lose precision</i>.
<hr /> 

<p>
What are your compiler tricks to get better and safer code?
</p>