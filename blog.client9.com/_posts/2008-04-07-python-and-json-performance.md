---
layout: post
updated: 2008-04-07
alias: /2008/04/python-and-json-performance.html
title: Python and  JSON performance
---
<p>
Ola.  So I was working on a project and noticed that json encoding/decoding of a string to string dictionary was taking... uhhh 70% of the time.  The are a few other benchmarks out there (<a href="http://kbyanc.blogspot.com/2007/07/python-serializer-benchmarks.html">kbyanc</a>,  <a href="http://blog.hill-street.net/?p=7">hill-street</a>), but none including the new simplejson 1.8.1 which has extensions to improve performance (links below).
</p>

<h3>My Tests</h3>
<p>
I'm only serializing dictionary mapping strings to strings.  Maybe occasionally dict within a dict, but always primitive types.  I don't need special ways of serializing custom objects.  This test is just raw primitive types and data structure performance.
</p>

<p> For this test, I made two dictionary with a dozen entries.  One has both keys and value as ascii regular python strings, the other had the same data but used unicode strings.
</p>

<h3> cjson 1.0.6 </h3>

<a href="http://www.vazor.com/cjson.html">cjson 1.0.6</a>, which has the bug fix described <a href="http://blog.extracheese.org/2007/07/when-json-isnt-json.html">here</a> and the original source and homepage is <a href="http://python.cx.hu/python-cjson/">over here</a>.   It's bit confusing, but it's worth it:

<pre>
Serialization, cjson, ascii: 94
Serialization, cjson, unicode: 117
Deserialization, cjson, ascii: 80
</pre>

<h3> simplejson 1.8.1</h3>

<p> Available <a href="http://pypi.python.org/pypi/simplejson/1.8">here</a>  The author maintains a <a href="http://bob.pythonmac.org/archives/category/python/simplejson/
">blog</a>.

<p>
This version has c-extensions for both encode and decode
</p>

<pre>
Serialization, simplejson, ascii: 549
Serialization, simplejson, unicode: 592
Deserialization, simplejson, ascii: 2068
</pre>

<h3> simplejson 1.6 </h3>

<p>
This version is 100% pure python.  It can be grabbed <a href="http://pypi.python.org/pypi/simplejson/1.6">here</a>
</p>

<pre>
Serialization, simplejson, ascii: 2150
Serialization, simplejson, unicode: 1744
Deserialization, simplejson, ascii: 3318
</pre>


<h3> Conclusion </h3>

<p>Well,  guess which version I'll be using.  simplejson has all sorts of other features that you might want.  Sometimes speed isn't everything, but for my application it is.  Enjoy!</p>