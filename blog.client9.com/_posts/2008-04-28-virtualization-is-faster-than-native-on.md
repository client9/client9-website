---
layout: post
updated: 2008-04-28
alias: /2008/04/virtualization-is-faster-than-native-on.html
title: Virtualization is faster than Native on Mac OS X 10.5?
---
<p>
That little article on Battle of Mac Virtualization Products caused quite a stir with Parallels and another web publisher contacting me.  I'll follow up with them and report back but in the meantime check this out.
</p>

<p>I mentioned last time that on Parallels, the linux filesystem (ext3) seemed quite a bit faster than <i>the native filesystem</i>.   They are many ways this could happen and honestly I have neither time not expertise to learn about the finer details of HFS3 vs. ext3.  Filesystems are messy.
</p>

<p>Not that CPU benchmarks are much better, but I do have a silly python benchmark that tests raw performance.  I stole the idea from <a href="http://furryland.org/~mikec/bench/">http://furryland.org/~mikec/bench/</a>.   I use it mostly to see if compiler flags make any difference when compiling python from source, or what the performance of a pre-made version of python is. The code is at the end.
</p>

<h3>Apple OS X 10.5</h3>

<pre>
$ ./benchmark.py 
test_hash: 2.833932
test_list: 3.647719
</pre>


<h3> Ubuntu 8.0.4 Server 64-Bit in VMWare Fusion</h3>
<pre>
$benchmark.py 
test_hash: 1.697652
test_list: 2.255775
</pre>

<p>Uhhhh, say what? VMWare is 33%+ faster than native? Remember this is running the same code, on the <i>same machine</i>. I have no idea if Ubuntu being 64-bit (vs. 32) makes any difference.  This code doesn't do very much, so I suspect that the Linux memory allocators must be <i>quite</i> a bit better than Mac OS X.
</p>

<p>This is of course a bit synthetic, and I can find other examples of the virtualized linux being a lot slower than native mac, however, it is interesting.</p>

<p>Comments most welcome.</p>

<hr />
<h3>The Lame Test</h3>

<pre>
from timeit import Timer

test_hash = """
for i in xrange(100):
    x=&#123;&#125;
    for j in xrange(1000):
        x[j]=i
        x[j]
"""

test_list = """
v=['a','b','c','d','e','f','g']
for j in xrange(1000):
    v.append(j)
    v[j]
"""

t = Timer(stmt=test_hash)
print "test_hash: %f" % t.timeit(100)

t = Timer(stmt=test_list)
print "test_list: %f" % t.timeit(10000)
</pre>

*****
Comment 2008-04-28 by None

Benchmarking virtual machines is very, very tricky for two reasons:<BR/><BR/>1) The virtual disk may be cached by the host operating system.<BR/><BR/>The reason your filesystem benchmark performed so well was probably because you were effectively doing it on a RAM disk: your Mac was likely caching reads and writes to the virtual disk in memory.<BR/><BR/>2) Benchmarks depend on accurate timers.<BR/><BR/>In the virtual world, time is a flexible concept.  Whenever benchmarking something in a virtual machine, make sure to use a stopwatch to see how much actual time progresses when running a test.  <BR/><BR/>You may be surprised to learn that a test thinks it runs for 10 minutes, but it actually takes 11 or 12 minutes of wall-clock time in some virtualized environments.
