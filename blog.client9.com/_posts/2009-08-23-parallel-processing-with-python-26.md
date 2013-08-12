---
layout: post
updated: 2009-08-23
alias: /2009/08/parallel-processing-with-python-26.html
title: parallel processing with python 2.6
---
<p>
Parallel processing in python has been a bit challenging.  The <a href="http://docs.python.org/library/thread.html#module-thread">thread module</a> and the new <a href="http://docs.python.org/library/threading.html">threading module</a>, certainly work and are complete.  However, due the <a href="http://docs.python.org/glossary.html#term-global-interpreter-lock">Global Interpreter Lock</a> you may find you are only using 1 CPU inspite of how many threads or CPU you have (this is also true of perl and some other scripting languages).   This is in addition to the traditional challenges of using threads.  (Node: how the GIL works is actually more subtle, but that's a topic for another day).
</p>

<p>Prior to 2.6, the standard party line has been to say "don't use threads, use processes", which sounds great, but a bit tricky and non-trivial to do with <a href="http://docs.python.org/library/subprocess.html#module-subprocess">subprocess module</a>.</p>

<p><a href="http://docs.python.org/library/multiprocessing.html">multiprocessing module</a> was introduced in 2.6 to solve this problem.  Now you can use processes instead of threads, using the same interface and concepts you might do with threads.</p>

<p>For <a href="http://en.wikipedia.org/wiki/Embarrassingly_parallel">embarrassingly parallel</a> batch problems such as  log processing, you load up all the filenames in a Queue, and have the Process workers pop items off and do whatever needs to get done.  The workers will run at "full speed" un-encumbered by any locking or threading details.  See the sample code below.
</p>

<p>Of course this doesn't extend beyond one machine.  In those cases, consider using <a href="http://aws.amazon.com/sqs/">Amazon's Simple Queue Service</a>.   It's cheap (hard to use $1.00/month) and easy to use with the <a href="http://code.google.com/p/boto/">Boto library</a>.

<pre>
#!/usr/bin/env python
# Sample code in public domain.

# required
from multiprocessing import Process, Queue
from Queue import Empty

# stuff for demo                
import os
import time
import random

# This is function that is run in a separate process
def f(q):
    pid = os.getpid()
    try:
        while True:
            msg = q.get(block=True, timeout=1)
            # DO WORK WITH THE MSG
            print("%d got %s" % (pid, str(msg)))
            time.sleep(random.random())
    except Empty:
        print("%d is all done, exiting" % (pid))


if __name__ == '__main__':
    # the q is passed to each worker
    q = Queue()

    # make a bunch of messages
    for x in range(100):
        q.put("msg%03d" % x)

    # make a bunch of workers
    num_workers = 8
    workers = [ Process(target=f, args=(q,)) for i in range(num_workers) ]

    # start them       
    for w in workers:
        w.start()

    # wait for them to finish
    for w in workers:
        w.join()
</pre>