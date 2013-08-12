---
layout: post
updated: 2008-09-03
alias: /2008/08/python-generators-and-yield.html
title: python, generators, and yield
---
<p>
<p>
Does anyone else think the python documentation is oddly organized?  My search for "python generators yield" kinda sucked, here's my take.
</p>

<p>
A basic for loop:
</p>
<pre>
for i in xrange(10):   # or range(10)
    print i
</pre>

<p>could be rewritten with generators as:</p>

<pre>
def myrange(maxi):
    i = 0
    while i < maxi:
        yield i
        i += 1

for i in myrange(10):
       print i
</pre>
 
<p>A function is a a <i>generator</i> if and only if it has a <code>yield</code> statement in it.  You don't need to do anything else except use <code>yield</code></p>

<p>A generator also automagically creates an <i>iterator</i> too.  You can also iterate manually using <code>next()</code> and catch the <code>StopIteration</code> exception.</p>

<pre>
z = myrange(10)
try:
    while True:
        print z.next()
    except StopIteration:
        pass
</pre>

<p>
Now you know just about everything you need to know about generators.  Looking for more?  Here's the <a href="http://docs.python.org/tut/node11.html#SECTION00111000000000000000000">tutorial section</a>,  notes on <a href="http://docs.python.org/ref/yield.html">yield</a>, and the <a href="http://www.python.org/dev/peps/pep-0255/">Official Spec</a>
</p>