---
layout: post
updated: 2010-03-29
alias: /2010/03/using-jslint-with-javascript-getters.html
title: Using jslint with javascript getters and setters
---
<p>
If you the most excellent <a href="http://jslint.org/">jslint</a> on javascript source containing <a href="http://ejohn.org/blog/javascript-getters-and-setters/">getters and setters</a> you find jslint comes to a grinding halt.  jslint doesn't like 'em, and the author isn't keen on adding that support. (I can appreciate that.  He has a clear use-case for jslint, and too many projects are <i>goal-less</i>.)
<p>

<p>That said, if you need this feature you can hack the parser, or do something else. For the short term, I choose the later.  <a href="http://client9.com/downloads/deaccessor.py"><code>deaccessor.py</code></a> is small python program (which could be ported to any language -- it's MIT licensed so go nuts), that converts getters and setters to a more traditional format that jslint and other tools can parse.  It's not perfect, but it also checks that getters don't have an argument, and that setters have only one argument.
<p>

<p>So... this:</p>
<pre>
var x = &#123;
    get foo() &#123;
        return this._foo;
    &#125;,
    set foo(x) &#123;
        this._foo = x;
    &#125;
&#125;;
</pre>
<p>... becomes this which jslint will happily parse.</p>
<pre>
var x = &#123;
    get_foo: function () &#123;
        return this._foo;
    &#125;,
    set_foo: function (x) &#123;
        this._foo = x;
    &#125;
&#125;;
</pre>

<p>You can season to taste.   See the <a href="http://client9.com/downloads/deaccessor.py">source</a> for details on how to use.</p>

<p>Happy linting!</p>