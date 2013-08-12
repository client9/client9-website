---
layout: post
updated: 2008-11-24
alias: /2008/11/reports-from-field-optional-arguments.html
title: Reports from the field - Optional Arguments Considered Dangerous
---
<p>Today we have a guest post!  Andy is managing a large C++ project at a Big Company You Know.</p>

* * *


Hey Nick - can I guest post on your blog?


Here's my story:


This is a cautionary tale about why optional parameters are
dangerous.  A long time ago a request was made to modify the behavior
of a certain function under certain circumstances.  So a call was made
to our contractor to provide a patch.  In addition to the patch, a
test was written to accompany the code change, and added to the suite
of tests for our product.

The code change involved adding an additional parameter at the
end, so that where the original signature was <code>foo(arg1,
arg2)</code>, we now had <code>foo(arg1, arg2, arg3 = null).</code>.
Around the time this happened, we had a major code reorganization, and
what was once a relatively simple collection of libraries was ripped
apart by our corporate overlord's proprietary software package
management system.  In the wake of this code diaspora, the patch that
the contractor had written was no longer applicable.  So the decision
was made to patch the code by hand, and I was the one to do.

Unfortunately, the patch did not go 100% as planned, and a single but
extremely important line,was forgotten in the process.  This one lined
was the one that called the extra parameter.  Because it was optional,
the application continued to compile OK, even though the patch was not
fully applied.  To make matters worse, the test was also lost in the
shuffle, and as a result we were looking at false positives: the test
should have failed due to the bad merge, but since the test code was
not applied properly, the test continued to merrily pass.

Months went by, and this mistake was discovered only because this
change is to be backported to an earlier version of our product.
Explaining this to the manager was not fun.  So the lesson learned is:


* Optional parameters can mistakenly hide errors if you forget to call
  those optional parameters.
* Patching by hand is very, very dangerous.
* Ideally, the one applied patch should be the one who also wrote it.


Beware!


Andy

* * *

Nice.  Sounds like in the chaos no one looked at the code-coverage
to see if all was tested.  Hmmm never thought of having a check that
make sures code coverage percentage doesn't go <i>down</i>.  Thanks
Andy for the post.  --nickg