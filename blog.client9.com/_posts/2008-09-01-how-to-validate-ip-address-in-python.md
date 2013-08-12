---
layout: post
updated: 2008-09-01
alias: /2008/09/how-to-validate-ip-address-in-python.html
title: How to validate an IP address in python
---
<p> The function you want is <b>socket.inet_aton</b>.  It returns a binary string on success or throws <code>socket.error</code> exception if invalid.  Check out  other conversion functions in the <a href="http://docs.python.org/lib/module-socket.html">socket module</a>
</p>

<pre>
>>> from socket import inet_aton

>>> inet_aton("127.0.0.1")
'\x7f\x00\x00\x01'

# that good.
#  here's a bad example:

>>> inet_aton("127.0.0.12345")
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
socket.error: illegal IP address string passed to inet_aton
>>> 

# tada!
</pre>