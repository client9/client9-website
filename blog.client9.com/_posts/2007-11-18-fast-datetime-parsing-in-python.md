---
layout: post
updated: 2010-02-19
alias: /2007/11/fast-datetime-parsing-in-python.html
title: Fast datetime parsing in python
---
<p>
So you need parse a date time string in a log file a zillion times?  For instance the <a href="http://httpd.apache.org/docs/1.3/logs.html#accesslog"> Apache log</a> has this lovely time format <code>08/Nov/2007:04:05:07</code>
</p>

<p>
The <a href="http://docs.python.org/lib/node85.html">python docs</a> say use <code>datetime</code> and <code>strptime</code> like this:</p>
<pre>
import datetime
import time
def apachetime_slow(line):
    return datetime.datetime(*time.strptime(line, "%d/%b/%Y:%H:%M:%S")[0:6])
</pre>

<p>Short, ugly, and <b>slow</b>.   In my application, 25% of my runtime was this function!  The Apache time format is gross, but it is fixed length.  This means you can use string slices to get the individual bits.   The only "trick" is mapping the month abbreviations to a number.</p>

<pre>
import datetime

month_map = &#123;'Jan': 1, 'Feb': 2, 'Mar':3, 'Apr':4, 'May':5, 'Jun':6, 'Jul':7, 
    'Aug':8,  'Sep': 9, 'Oct':10, 'Nov': 11, 'Dec': 12&#125;

def apachetime(s):
    global month_hash
    return datetime.datetime(int(s[7:11]), month_map[s[3:6]], int(s[0:2]), \
         int(s[12:14]), int(s[15:17]), int(s[18:20]))

</pre>

<p>
On my box this is a full 10x faster!  Enjoy!
</p>

*****
Comment 2007-11-25 by None

True! I have just implemented this - following your advice and it is fast enough. I'm working on a remote Apache logging and I need to go through a lot of messages as fast as possible (and in python) in order to sort them by virtual host, machine, AND TIME.


*****
Comment 2008-07-23 by None

Unfortunately, it will only be accurate through August. September is missing and the remaining months are off.<BR/><BR/>Indeed with proper error checking any script using this verbatim will fail when it attempts to parse September's logs.
