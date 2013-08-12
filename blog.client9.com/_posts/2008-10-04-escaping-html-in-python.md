---
layout: post
updated: 2008-10-04
alias: /2008/10/escaping-html-in-python.html
title: Escaping HTML in Python
---
<p>
The short answer is do this:
</p>

<pre>
def html_escape(text):
    text = text.replace('&amp;', '&amp;amp;')
    text = text.replace('"', '&amp;quot;')
    text = text.replace("'", '&amp;#39;')
    text = text.replace("&gt;", '&amp;gt;')
    text = text.replace("&lt;", '&amp;lt;')
    return text
</pre>

<p>
I know, I know it seems kinda "unsophisticated" and too simple.  But I tell you it's the fastest way.
</p>

<h2>How not to do it</h2>

<p><a href="http://wiki.python.org/moin/EscapingHtml">Elsewhere on the web</a>, I found this lovely snippet:
</p>
<pre>
html_escape_table = &#123;
    "&": "&amp;",
    '"': "&quot;",
    "'": "&#39;",
    ">": "&gt;",
    "<": "&lt;",
    &#125;

def html_escape_orig(text):
    parts = []
    for c in text:
        parts.append(html_escape_table.get(c,c))
    return ''.join(parts)
</pre>

<p><b>FAIL</b> Python is not C.  It's not so hot at character by character iteration.  Also, let's say you have a 100 character input.  Then you can going to make 100 calls to <code>get</code>, 100 calls to <code>append</code> and depending what the guts of python does, 100 mini one-character strings.
</p>

<p>The performance?  I whipped up some sample runs using <code>cProfile</code>.  The first method using <code>replace</code> ran
</p>
<pre>
6002 function calls in 0.040 CPU seconds
</pre>
<p>
versus, the character by character method:
</p>
<pre>
1184002 function calls in 6.331 CPU seconds
</pre>

<p>Yeah, it's about 200x faster</p>

<h2> And one more thing </h2>

<p>Poking around a bit further, you can do the same thing (although a touch slower) with:</p>

<pre>
from xml.sax.saxutils import escape
def html_escape(text):
    return escape(text, &#123;'"', '&quot;', "'":'&#39;'&#125;
</pre>

<p>The code for <code>escape</code> is just a bunch of replace statements, and iteration through the dictionary to do other replacements</p>

*****
Comment 2008-12-07 by None

Thank you, quick and easy way to escape html :)


*****
Comment 2009-06-04 by None

Or simply use the <b>escape</b> function in the <b>cgi</b> module.
