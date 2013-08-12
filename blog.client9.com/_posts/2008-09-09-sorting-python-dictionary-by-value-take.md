---
layout: post
updated: 2008-09-10
alias: /2008/09/sorting-python-dictionary-by-value-take.html
title: Sorting Python Dictionary By Value, Take 2
---
<p>
Here's why another reason why you should <a href="http://blog.modp.com/2008/08/if-you-are-in-tech-and-dont-have-blog.html">blog all your technical problems and solutions</a>.  Sometimes someone finds a better way.
</p>

<p>In my original <a href="http://blog.modp.com/2007/11/sorting-python-dict-by-value.html">sorting a dict by value</a> entry, I said the best way is:</p>

<pre>
sorted(adict.iteritems(), key=lambda (k,v): v)
</pre>

<p>Turns out I'm wrong.  Gregg Lind (aka "write-only") replied to the article with a comment pointing to his  <a href="http://writeonly.wordpress.com/2008/08/30/sorting-dictionaries-by-value-in-python-improved/">performance notes</a>.  <a href="http://www.python.org/dev/peps/pep-0265/">PEP 0265</a> has the "best answer" that is at least 2x faster:
</p>

<pre>
from operator import itemgetter
sorted(d.iteritems(), key=itemgetter(1))
</pre>

<p>
Thanks all!
</p>

<p>
My performance test is here:
</p>
<pre>
#!/usr/bin/env python                                                           

import cProfile

def sbv0(adict,reverse=False):
    return sorted(adict.iteritems(), key=lambda (k,v): v, reverse=reverse)

from operator import itemgetter
def sbv6(d,reverse=False):
    return sorted(d.iteritems(), key=itemgetter(1), reverse=reverse)


imax= 10000
dmax = 500
D = dict(zip([str(i) for i in range(dmax)],range(dmax)))
cProfile.run('for i in xrange(imax): sbv0(D, reverse=False)')
cProfile.run('for i in xrange(imax): sbv6(D, reverse=False)')
</pre>

<p>Results are</p>

<pre>
Old Way:
5020002 function calls in 6.623 CPU seconds

New Way:
     20002 function calls in 3.920 CPU seconds
</pre>

*****
Comment 2008-09-10 by None

You have a small mistake that doesn't affect the result:<BR/>In sbv0 you are not sorting by value, but by value and then by key.<BR/><BR/>To sort by value you would write <BR/><BR/>key = lambda (k,v): v<BR/><BR/>This improves the result by a little bit, but still the itemgetter wins.


*****
Comment 2008-09-10 by None

thanks lorg!  updated with corrections. --nickg


*****
Comment 2008-09-10 by None

I'm glad that this topic has created so much good discussion.  There aren't a whole lot of people doing performance profiling on python code.
