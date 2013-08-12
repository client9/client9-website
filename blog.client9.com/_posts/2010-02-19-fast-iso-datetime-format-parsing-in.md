---
layout: post
updated: 2010-02-19
alias: /2010/02/fast-iso-datetime-format-parsing-in.html
title: Fast ISO datetime format parsing in python
---
<p> Python is missing a method to parse a ISO format datetime. Here's the fastest way I've found:
</p>
<pre>
# PUBLIC DOMAIN.  SEASON TO TASTE.  ALWAYS TEST.
from datetime import datetime
def isoparse(s):
    try:
        return datetime(int(s[0:4]),int(s[5:7]),int(s[8:10]),
                        int(s[11:13]), int(s[14:16]), int(s[17:19]))
    except:
        return None
</pre>

<p>This "technique" can be used for other <a href="http://blog.client9.com/2007/11/fast-datetime-parsing-in-python.html">fixed-sized time formats</a>.</p>

<p>Here's some crappier ways, followed by some timing results:</p>

<pre>
# similar to what is used in MySQLdb
def isoparse_mysql(s):
    if ' ' in s:
        sep = ' '
    elif 'T' in s:
        sep = 'T'
    else:
        return None

    try:
        d, t = s.split(sep, 1)
        return datetime(*[ int(x) for x in d.split('-')+t.split(':') ])
    except:
        return None

# Using Strptime
def isoparse_strptime(s):
    try:
        return datetime.strptime(s, "%Y-%m-%d %H:%M:%S")
    except:
        return None
</pre>

<pre>
$ python isoformat_parse.py 
Version1 mysql: 11.59
Version2 strptime: 50.63
Version3 fixed: 7.48
</pre>