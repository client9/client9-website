---
layout: post
updated: 2010-02-19
alias: /2010/02/dont-waste-time-with-python-mysql-and.html
title: Don't Waste Time With Python, MySQL, and datetime
---
<p>I've often suspected this, but now I have proof.  <a href="http://www.python.org/">Python's</a> <a href="http://sourceforge.net/projects/mysql-python/">MySQLdb</a>
mapping from a "timestamp" or "datetime" to a native python <a href="http://docs.python.org/library/datetime.html#datetime.datetime">datetime</a>
is slow.  No, <i>really</i> slow.  Fortunately the fix is easy.</p>

<p>Here's 1000 runs of a a query that is returning quite a few rows,
each with two timestamp fields:
</p>

<pre>
# using automatic conversion to datetime.datetime

SELECT start_time, end_time ....

2681150 function calls in 48.673 CPU seconds

# and some snippets from cProfile

  114000    1.912    0.000    9.561    0.000
/usr/lib/pymodules/python2.6/MySQLdb/times.py:91(mysql_timestamp_converter)
  114000    4.806    0.000    7.649    0.000
/usr/lib/pymodules/python2.6/MySQLdb/times.py:43(DateTime_or_None)
</pre>

<p>Yikes! That's saying 25% of my CPU is converting datetime formats??</p>

<p>Besides the performance problems, there other issues with
automatically converting to a datetime.  Sometimes, you don't need a
full datetime object if you are computing, say, a difference betwen
two times.  Here, the conversion is completely not needed.
</p>

<p>The other issue is that datetimes from MySQL are without a timezone, not
even UTC (this is called a "native datetime").  This causes problems
for some modules, so you may need to use this datetime to create
identical datetime, but with a timezone.  As an example, one needs to
do something like this:</p>

<pre>
from dateutil.tz import *
TZ_UTC=tzutc()
TZ_EST=tzfile('/usr/share/zoneinfo/America/New_York')

def user_localtime(nativedt):
    return nativedt.replace(tzinfo=TZ_UTC).astimezone(TZ_EST)
</pre>

<p>Yuck</p>

<p> Let's rewrite that so we pass back the native timestamp directly
to python as a int (or long)</p>

<pre>
# using UNIX_TIMPSTAMP()
SELECT UNIX_TIMESTAMP(start_time), UNIX_TIMESTAMP(end_time) .....

1883150 function calls in 33.714 CPU seconds
</pre>

<p>Sweet.  If you need to convert this to a datetime, no problem.
<code>datetime.datetime.utcfromtimestamp()</code> is all you need, and
will be faster than the automatic conversion.</p>

<p>While using <a
href="http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html#function_unix-timestamp"><code>UNIX_TIMESTAMP</code></a>
and <a
href="http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html#function_from-unixtime"><code>FROM_UNIXTIME</code></a>
is ugly, the end result is well worth it.</p>

<h2>Sidenotes</h2>

<p>The MySQLdb isoformat parser could be improved a bit.  See <a href="http://blog.client9.com/2010/02/fast-iso-datetime-format-parsing-in.html">Fast ISO datetime format parsing</a> for details.   That said, it's best not doing <i>any</i> conversion until you absolutely need it.
</p>