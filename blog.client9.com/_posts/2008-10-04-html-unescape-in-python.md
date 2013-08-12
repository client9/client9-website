---
layout: post
updated: 2008-10-04
alias: /2008/10/html-unescape-in-python.html
title: HTML Unescape in Python
---
<p>
Ok, if you read the <a href="http://blog.modp.com/2008/10/escaping-html-in-python.html">last post</a>, you knew this one was coming.
</p>

<h2>Yes</h2>

<p>Here's how to unescape html text:</p>

<pre>
from htmlentitydefs import name2codepoint 
def replace_entities(match):
    try:
        ent = match.group(1)
        if ent[0] == "#":
            if ent[1] == 'x' or ent[1] == 'X':
                return unichr(int(ent[2:], 16))
            else:
                return unichr(int(ent[1:], 10))
        return unichr(name2codepoint[ent])
    except:
        return match.group()

entity_re = re.compile(r'&amp;(#?[A-Za-z0-9]+?);')
def html_unescape(data):
    return entity_re.sub(replace_entities, data)
</pre>

<p>You can fiddle with regexp to make the ending colon optional or not.   Right now if it can't decode the entity, it just copies it.   If you want to  skip then,  change the ending <code>return match.group()</code> to <code> return ''</code>
</p>

<h2> The Really Slow Way </h2>

<p>As usual, google pointed me to the <a href="http://wiki.python.org/moin/EscapingHtml">slowest way possible</a>:</p>

<pre>
import htmllib
def html_unescape_parser(s):
    p = htmllib.HTMLParser(None)
    p.save_bgn()
    p.feed(s)
    return p.save_end()
</pre>

<p>This is <b>5x slower</b>, and does not decode hexadecimal entities</p>

<h2>Better, but not quite</h2>

<p>A nice post  in <a href="http://groups.google.com/group/comp.lang.python/msg/ce3fc3330cbbac0a">comp.lang.python</a> provides a better implementation.  But has a few problems:
</p>
<ul>
<li>Missing obvious optizations (precompiling regexp, etc).</li>
<li>Pops exceptions when it encounters bad numeric entities (e.g. &amp;#12ZZZ;)<li>
<li>Doesn't encode numeric entities in hexadecimal prefixed by "X"</li>
</ul>

<p>But big props to the author for <b>writing unit tests</b>.  I'll post mine shortly.</p>

<h2>Because you are a dork like me</h2>

<p>The spec for all this is <a href="http://www.w3.org/TR/REC-html40/charset.html">here</a>.