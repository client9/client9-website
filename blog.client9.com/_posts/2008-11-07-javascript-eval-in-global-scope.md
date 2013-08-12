---
layout: post
updated: 2008-11-07
alias: /2008/11/javascript-eval-in-global-scope.html
title: javascript eval in global scope
---
<p>
Yeah I know, <code>sprintf</code> one day, and <i>javascript</i> the next.  That's how I roll.
</p>

<h3> Short answer</h3>

<p>By default, <code>eval</code> runs in the local scope.  To do an eval in the global scope do this trick:
</p>
<p style: font-size: large><code> eval.call(null, <i>script</i>); </code></p>

<h3> Long Answer</h3>

<p>This is a bit esoteric, and <code>eval</code> is not something you should use very often (if at all) in normal client-side programming.</p>

<p>A HTML browser when seeing a <code>&lt;code&gt;</code> tag, either loads the <code>src</code> url or the script body and does an internal <code>eval</code> <i>at the global scope</i>.
</p>

<p>For example, let's say in your XMLHttpRequest passed back some javascript.  How can you <i>eval</i> it in the global scope?  I'm not recommending this pattern but for instance</p>

<pre>
function http_callback(ascript) &#123;
    eval(ascript);
&#125;
</pre>


<p>If the callback text is something like "<code>var x = 1;</code>",  then the <code>eval(text)</code> just makes a local variable just like either of these functions:
</p>
<pre>
js> function f_local() &#123; var x = 1; &#125;
js> f_local();
typein:10: ReferenceError: x is not defined
js> function f_local_eval() &#123; eval('var x = 1;'); &#125;
js> f_local_eval();
typein:12: ReferenceError: x is not defined
</pre>


<p>Eval doesn't have an option to run in the global scope, which seems odd <i>at first.</i>   Javascript is kinda cool since even built-in functions such as <code>parseInt</code>, and yes, <code>eval</code> are a true javascript <code>function</code>.   And if you poke around in the <code>Function</code> methods you'll find the <code><a href ="http://developer.mozilla.org/en/Core_JavaScript_1.5_Reference/Global_Objects/Function/call">call</a></code> method.   If the first arg is <code>null</code> then it runs in the global scope.   Finally we have <code>eval.call(null, script_text)</code> as the magic invocation.
</p>

<pre>
js> x
typein:24: ReferenceError: x is not defined
js> function f_global_eval() &#123; eval.call(null, "var x = 1;"); &#125;
js> f_global_eval();
js> x
1
</pre>

<p>ta-da!</p>

*****
Comment 2008-11-30 by None

Excellent article and well argumented. But as often IE is breaking ranks. This <A HREF="http://josephsmarr.com/2007/01/31/fixing-eval-to-use-global-scope-in-ie/" REL="nofollow"> article</A> covers that case. To me an optimal solution looks like this:<BR/><BR/>var evalCode = function(code) &#123;<BR/>  if (window.execScript) window.execScript(code);<BR/>  else eval.call(null, code);<BR/>&#125;;


*****
Comment 2008-12-03 by None

hie, i am also using eval but i face an issue in firefox, actually i am using it something like this<BR/><BR/>    var evalCode = function(code) &#123;<BR/>         //alert(code);<BR/>         if (window.execScript) window.execScript(code);<BR/>         else eval(unescape(code));<BR/>         //alert(&quot;code executed..&quot;);<BR/>    &#125;;<BR/><BR/>    function ShowUploadPopUp() &#123;<BR/>         //alert(&quot;OK.&quot;);<BR/>         evalCode(document.getElementById(&quot;JScriptCall&quot;).innerHTML);<BR/>     &#125;<BR/>where JScriptCall is span element in which i write the following lines from code behind using C# with ASP.Net<BR/><BR/>    &lt;span id=&quot;JScriptCall&quot; class=&quot;DisplayNone&quot;&gt;<BR/>    window.open(&#39;test.aspx?uid=MzU5-OlWfO7Q3&amp;catid=NDUGM67ISI&#39;, &#39;page&#39;, &#39;toolbar=0, scrollbars=1, location=0, statusbar=0, menubar=0, resizable=0, width=600, height=410, left=50, top=50, titlebar=yes&#39;);<BR/>    &lt;/span&gt;<BR/><BR/>but when i use it in firefox, it opens the window but the url created is not right.<BR/>it convets &#39;&amp;&#39; to <B><I>&#39;&amp; amp;&#39;</I></B> <I>(without space)</I> because of which i can not get the values of the querystring....<BR/><BR/>any help, how can i keep ascii charaters in the querystring using eval function...


*****
Comment 2009-06-18 by None

Great! You save my morning, Thanks
