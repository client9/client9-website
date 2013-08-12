---
layout: post
updated: 2008-09-09
alias: /2007/11/sorting-python-dict-by-value.html
title: Sorting a python dict by value
---
<h1>SEE <a href="http://blog.modp.com/2008/09/sorting-python-dictionary-by-value-take.html">UPDATED VERSION</a>.</h1>

<p>09-Sept-2008. It works, but there is a better way that is faster.</p>
<hr />


<p>Don't search for "python dict sort by value" since you'll get outdated answers.  As of python 2.4, the "right" way to do this is:

<pre>
alist = sorted(adict.iteritems(), key=lambda (k,v): (v,k))
</pre>

<p>
to get the reverse order, add on a <code>,reverse=True</code>
</p>

<p>This is the fastest way to do this and it uses the least amount of memory.  Enjoy.</p>

<pre>
>>> adict = &#123;'first':1, 'second':2,'third':3, 'fourth': 4&#125;
>>> adict
&#123;'second': 2, 'fourth': 4, 'third': 3, 'first': 1&#125;
>>> sorted(adict.iteritems(), key=lambda (k,v):(v,k))
[('first', 1), ('second', 2), ('third', 3), ('fourth', 4)]
>>> sorted(adict.iteritems(), key=lambda (k,v):(v,k), reverse=True)
[('fourth', 4), ('third', 3), ('second', 2), ('first', 1)]
</pre>

*****
Comment 2008-06-29 by None

Wow, this was a golden post. Thanks!


*****
Comment 2008-08-28 by None

excellent


*****
Comment 2008-08-30 by None

I think that PEP 265 has some relevance to your claims here.  I did a few tests a well, posted at <A HREF="http://writeonly.wordpress.com/2008/08/30/sorting-dictionaries-by-value-in-python-improved/" REL="nofollow">http://writeonly.wordpress.com/2008/08/30/sorting-dictionaries-by-value-in-python-improved/</A>, and I think this is not the quickest sort by value implementation.  <BR/><BR/>I hope you'll prove me wrong!  <BR/><BR/>gL


*****
Comment 2008-08-30 by None

Hi "writeonly" -- your work looks very interesting!  I'll look into this later in the weekend. --nickg


*****
Comment 2008-09-08 by None

many more ways to do it here with some benchmarks in the comments:<BR/><BR/>http://coreygoldberg.blogspot.com/2008/06/python-sort-dictionary-by-values.html


*****
Comment 2009-01-06 by None

ok. that worked great except that it didn't sort numerican values correctly.<BR/>So things ended up being sorted as <BR/>0.12<BR/>2.3<BR/>22.4<BR/>3<BR/>4<BR/>..<BR/>..


*****
Comment 2009-03-31 by None

I love you.<BR/>That was exactly what I was looking for!


*****
Comment 2009-10-17 by None

Anonymous... because you stored them as strings
