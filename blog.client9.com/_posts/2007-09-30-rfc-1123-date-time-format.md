---
layout: post
updated: 2007-09-30
alias: /2007/09/rfc-1123-date-time-format.html
title: RFC 1123 Date Time Format
---
Using strftime format specifiers (used by every scripting language), the RFC 1123 time format is

<pre>
%a, %d %b %Y %H:%M:%S GMT
</pre>

(assuming you are using the "C" or a english local, and UTC time).  In python this would be:

<pre>
$ python
>>> import datetime
>>> datetime.datetime.utcnow().strftime("%a, %d %b %Y %H:%M:%S GMT")
'Sun, 30 Sep 2007 14:58:05 GMT'
>>> 
</pre>

<p>
Note, the "%a, " is optional.
</p>

<p>
Good luck looking that up directly.  It's on page 55 of RFC 1123, which it's just a change to RFC 822 to be "year 2000 compliant" so you have go track down the original spec (it's in section 5).  Which is in BNC format.</p>

<p>
I should really make a master page listing standard time formats and their equivalent strftime format.
</p>

*****
Comment 2007-09-30 by None

Why on earth are you reading an RFC on a Sunday afternoon?<BR/><BR/>Why on earth am I reading this blog post on a Sunday afternoon?


*****
Comment 2008-06-12 by None

Thank you. Very useful.
