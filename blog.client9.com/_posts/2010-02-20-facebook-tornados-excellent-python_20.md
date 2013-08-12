---
layout: post
updated: 2010-02-20
alias: /2010/02/facebook-tornados-excellent-python_20.html
title: Facebook Tornado's Excellent Python Templates
---
<p> The python <a href="http://www.tornadoweb.org/">Torando webserver and framework</a> from the friendly folks at Facebook/FriendFeed comes with a templating system.  You don't need to use the server in order to use the templates.</p>

<p>
The template module were designed to be used by <i>developers</i> that allow the full power of python.  These are not Django-style templates, which could be handed off to interactive designer to hack around on.
</p>

<p>For other python-based templates, I've used <a href="http://www.makotemplates.org/">Mako</a> before since it seemed the simplest of the bunch.  But this is a dozen files, crazy parsers and abstract syntax tree representation.  <a href="http://www.cheetahtemplate.org/">Cheetah</a> templates has 30 files, and so on.</p>

<p>Tornado templates? It's only two files.
<a href="http://github.com/facebook/tornado/blob/master/tornado/template.py">template.py</a> which is the core.  And <a href="http://github.com/facebook/tornado/blob/master/tornado/escape.py">escape.py</a> provides common functions you can use in your template (e.g. <code>url_escape</code>).  That's it.
</p>

<h3>The Templates</h3>
<p>Here's a sample:</p>
<pre>
from tornado.template import Template

ts1 = """
&lt;html&gt;&lt;head&gt;
&lt;title&gt; &#123;&#123; title &#125;&#125; &lt;/title&gt;
&lt;/head&gt;&lt;body&gt;

&#123;% if True %&#125;
&lt;h1&gt;Hello World&lt;/h1&gt;
&#123;% else %&#125;
&lt;h1&gt;Goodbye Cruel World&lt;/h1&gt;
&#123;% end %&#125;

&lt;/body&gt;&lt;/html&gt;
"""

t1 = Template(ts1, name="ts1", compress_whitespace=True)

print(t1.code)
</pre>

<p></p>
<pre>
def _execute():
    _buffer = []
    _buffer.append('\n&lt;html&gt;&lt;head&gt;\n&lt;title&gt; ')
    _tmp = title
    if isinstance(_tmp, str): _buffer.append(_tmp)
    elif isinstance(_tmp, unicode): _buffer.append(_tmp.encode('utf-8'))
    else: _buffer.append(str(_tmp))
    _buffer.append(' &lt;/title&gt;\n&lt;/head&gt;&lt;body&gt;\n')
    if True:
        _buffer.append('\n&lt;h1&gt;Hello World&lt;/h1&gt;\n')
    else:
        _buffer.append('\n&lt;h1&gt;Goodbye Cruel World&lt;/h1&gt;\n')
    _buffer.append('\n&lt;/body&gt;&lt;/html&gt;\n')
    return ''.join(_buffer)
</pre>

<p>That python code is generated once, then compiled for subsequent rendering, so it's as fast as python can be. Oh yeah, rendering.   Use <code>t1.generate(title="foo" <i>, ...other named args...</i>)</code>.  You can use all sorts of other control constructs in the template: <code>try</code>, <code>for</code>, <code>import</code>, etc.
</p>

<p>But "template inheritance" is where it gets interesting.  Wrap parts of the template in <code>&#123;% block <i>name</i> %&#125;</code>  and another <code>&#123;% end %&#125;</code>.  Now you can over-ride these blocks in another template.  </p>

<pre>
ts1 = """
&lt;html&gt;&lt;head&gt;
&lt;title&gt; &#123;&#123; title &#125;&#125; &lt;/title&gt;
&lt;/head&gt;&lt;body&gt;
&#123;% block body %&#125;
&#123;% if True %&#125;
&lt;h1&gt;Hello World&lt;/h1&gt;
&#123;% else %&#125;
&lt;h1&gt;Goodbye Cruel World&lt;/h1&gt;
&#123;% end %&#125;
&#123;% end %&#125;
&lt;/body&gt;&lt;/html&gt;
"""
</pre>

<p>(oh with the added block the generated code doesn't actually change)</p>

<p>Now lets make another template.  We'll need a <code>Loader</code> so we can reference other templates by name.  The Tornado webserver does all this with loader that uses files. For the example, ours is, uhhh, more simple:</p>

<pre>
ts2 = """                                                                                                                    
&#123;% extends ts1 %&#125;                                                                                                            
&#123;% block body %&#125;                                                                                                             
&lt;h1&gt;Hello World&lt;/h1&gt;                                                                                                      
&#123;% end %&#125;                                                                                                                    
"""

class Loader(object):
    def load(self, name, parent_path=None):
        return t1

t2 = Template(ts2, name="ts2", loader=Loader(), compress_whitespace=True)

print(t2.code)
</pre>
<p>Results in the following code:</p>
<pre>
def _execute():
    _buffer = []
    _buffer.append('\n&lt;html&gt;&lt;head&gt;\n&lt;title&gt; ')
    _tmp = title
    if isinstance(_tmp, str): _buffer.append(_tmp)
    elif isinstance(_tmp, unicode): _buffer.append(_tmp.encode('utf-8'))
    else: _buffer.append(str(_tmp))
    _buffer.append(' &lt;/title&gt;\n&lt;/head&gt;&lt;body&gt;\n')
    _buffer.append('\n&lt;h1&gt;Hello World&lt;/h1&gt;\n')
    _buffer.append('\n&lt;/body&gt;&lt;/html&gt;\n')
    return ''.join(_buffer)
</pre>

<p>Ta-Da!</p>

<h3>Conclusion</h3>

<p>Oh yeah!  True, error handling isn't great, but really it's not that complicated. It took me a few hours to swap out from Mako.</p>

<p>Use the source or <code>pydoc tornado.tempalte</code> for more details</p>