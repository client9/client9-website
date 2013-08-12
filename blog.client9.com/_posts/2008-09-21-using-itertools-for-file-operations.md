---
layout: post
updated: 2008-09-21
alias: /2008/09/using-itertools-for-file-operations.html
title: Using itertools for file operations
---
<p>
Using the <a href="http://docs.python.org/lib/itertools-functions.html">Itertools</a> module in python, you can get rid of a lot of boiler plate code and get a minor performance boost at the same time.
</p>

<h2>Skipping or Taking the first N lines of a file</h2>

<p>NO:</p>
<pre>
#skip first line
count = 0
for line in file:
    count += 1
    if count == 1:
 continue
</pre>

<p><b>Yes:</b></p>
<pre>

import  itertools

for line in itertools.islice(file, 1, None):
    ...
</pre>

<p>First arg is the <i>iterable</i>, second is the initial lines to skip, and second arg is when to stop.  So taking the first 10 lines of a file would be <code>islice(f,0, 10)</code>.  This case can be abbreivated with <code>islice(f, 10)</code>. </p>

<p>
Since <code>islice</code> may not make clear your intentions on what is happening with a <i>file</i>, make some helper functions:
</p>

<pre>
def take(iter, n):
     """ take first n items """
    return itertools.islice(iter, n)

def drop(iter, n):
    """ drop first n items from sequence """
    return itertools.islice(iter, n, None)
</pre>

<h2> Making progress monitors </h2>

<p>If you are doing a batch processing a large file, a lot of code in the main loop can be for console "user interface".    Get rid of it using a generator.
</p>

<p><b>NO</b></p>
<pre>
count = 0
for f in file:
   count += 1
   if count % 10000 == 0:
       sys.stderr.write("Read %10d features    \r" % count)
   ...

sys.stderr.write("Read %10d features, total   \n" % count)
</pre>

<p><b>YES</b></p>

<pre>
import itertools

def countstatus(iter, mod=0):
    for item, c in itertools.izip(iter, itertools.count()):
        if mod and c % mod == 0:
            sys.stderr.write("Read %10d items\r" % c)
        yield item
    sys.stderr.write("Read %10d items, total\n" % c)
</pre>

<p>You can sex up the code by showing total elapsed time, or lap time or transactions per second.   Then to do use it:</p>

<pre>
for f in countstatus(file, 10000):
    ...
</pre>

<h2>Mix and Match</h2>

<pre>
# start at 1,000,000th item
for f in countstatus(drop(f, 1000000), 1000):
    ...
</pre>

<p>or</p>

<pre>
# use only the first 1,000,000 items
for f in countstatus(head(f, 1000000), 1000)
   ...
</pre>