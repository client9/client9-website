---
layout: post
updated: 2008-11-13
alias: /2008/11/python-default-string-encoding-woes.html
title: Python default string encoding woes
---
<p>
The most excellent Ian Bicking wrote a few articles in 2005 on python unicode madness (<a href="http://blog.ianbicking.org/do-i-hate-unicode-or-do-i-hate-ascii.html">[1]</a>, <a href="http://blog.ianbicking.org/illusive-setdefaultencoding.html">[2]</a>, <a href="http://blog.ianbicking.org/why-python-unicode-sucks.html">[3]</a>)
and writer commented here <a href="http://faassen.n--tree.net/blog/view/weblog/2005/08/02/0">here</a>.
</p>

<p>Ok that was in 2005, so you might have forgotten the issue.  When you convert a unicode string to a 'normal' string, python by default converts using ASCII, and will fail <i>hard</i> if the unicode string is not pure ascii.  Which makes this function explode if you pass in non ascii character:
</p>

<pre>
def printit(x):
    print(str(x))
</pre>

<p>
Which make the <code>unicode</code> object the only python type that breaks <code>str</code>.
</p>

<p>And to make matters worse, there is no nice way to change the default encoding.  Which is more bizarre.</p>

<p>Here's a concrete example.  Let's say you are making a python extension of a C-library.   Most C libraries pass in and out using UTF8.  Why?   Unicode doesn't have a well defined data type and is not portable.  The Posix <code>wchar_t</code> might be 2 bytes, or might be 4 bytes.  Then you might have endian encoding issues.  UTF-8 is based on 1 byte <code>char</code> types so it's portable.</p>

<p>Now you are using a extension to use this C library.  It expects a UTF-8 encoded <code>string</code>  You have a unicode python string, and pass it in.  Python will convert the <code>unicode</code> to <code>string</code> and explode the first time a non-ascii character is found.  To fix this, you'll have to change <i>every call</i> to this library to do this "if type(s) is unicode, then s = s.encode('utf8')'  <i>or</i> rewrite the wrapper library.  Great.
</p>

<p>Or you can use this hack to fix this: </p>
<pre>
reload(sys)
sys.setdefaultencoding('utf8')
</pre>

<p>You need to reload the <code>sys</code> module since after it loads the <code>setdefaultencoding</code> is <i>removed</i>.  It's not even in the pydoc for <code>sys</code></p>

<p>yuck.</p>