---
layout: post
updated: 2007-11-06
alias: /2007/10/php-string-startswith-let-me-count-ways.html
title: php string "startswith" let me count the ways
---
<p>I bounce around between half a dozen different programming languages, so I forget all the little variations.  Recently I needed to test in php if a string starts with another (a prefix).  So I typed in <code><a href="http://www.google.com?q=php+string+startswith">php string startswith</a></code>, expecting to get the php manual with some built-in function.</p>

<p>oh no.  It's not built in, that's fine.  It's the online advice that frightens me.  In order from google:</p>

<h3> Take 1: use <code>strstr</code></h3>

<pre>
if (strstr($source, $prefix) == $source)) &#123;
    echo "'$source starts with '$prefix'\n";
&#125; else &#123;
    echo "'$source' does not start with '$prefix'\n";
&#125;
</pre>

<p>Uhhh if the source does not contain the prefix, then the entire string is searched.  Worse then you have to do a full string compare.</p>

<h3> Take 2:  use <code>strpos</code></h3>

<pre>
if (strpos($source, $prefix) === 0)) &#123;
    echo "'$source starts with '$prefix'\n";
&#125; else &#123;
    echo "'$source' does not start with '$prefix'\n";
&#125;
</pre>
<p> Marginally better.  Very fast if the source does start with the prefix, very slow if it does not.   Lots of confusion on how to test for false (!!!) online.</p>

<h3> Take 4: Use <code>substr</code></h3>

<p> The first example I saw just had hardwired examples, but it was something like this:</p>
<pre>
if (substr($source, 0, strlen($prefix)) == $prefix)) &#123;
    echo "'$source starts with '$prefix'\n";
&#125; else &#123;
    echo "'$source' does not start with '$prefix'\n";
&#125;
</pre>
<p> Requires creating a new string and doing a full string comparison, however it does not scan the whole string.</p>

<h3> Take 5: Use <code>preg_match</code></h3>

<p>good grief.  My favorite was this "<a href="http://www.tiplib.com/152/check-if-string-starts-character">tip</a>" to "check if a string starts with a specific character."</p>
<pre>
   if (preg_match('/^a/', $str)) &#123;
                echo "String starts with an a";
   &#125;
</pre>

<p>No comment on this one.</p>

<h3>PLEASE READ</h3>
<p>ok team, here it is.</p>

<pre>
function str_startswith($source, $prefix)
&#123;
   return strncmp($source, $prefix, strlen($prefix)) == 0;
&#125;
</pre>

<p>It fails fast, it doesn't create new strings that get thrown away, it works in all cases.  Granted <code>strncmp</code> is a bit cryptic to people who have never used "C", but it's a of shocker that I didn't see this online.</p>

<p>Here's my "unit test" for it.</p>

<pre>
function mytest($source, $prefix) &#123;
    if (str_startswith($source, $prefix)) &#123;
       echo "'$source' starts with '$prefix'\n";
    &#125; else &#123;
       echo "'$source' does not start with '$prefix'\n";
    &#125;
&#125;

mytest("foobar", "foo");
mytest("foobar", "food");
mytest("foobar", "bar");
mytest("foobar", "FOO");
mytest("foobar", "foobar1");
mytest('', '');
mytest('', 'foo');
mytest('foobar', '');
</pre>

<p>It better output:</p>
<pre>
'foobar' starts with 'foo'
'foobar' does not start with 'food'
'foobar' does not start with 'bar'
'foobar' does not start with 'FOO'
'foobar' does not start with 'foobar1'
'' starts with ''
'' does not start with 'foo'
'foobar' starts with ''
</pre>

<h3> Interview Question </h3>

<p>Since it seems that people have trouble with this, it makes a great interview question. </p>

<blockquote>
Here's a list of the php string functions.  Write down <i>as many</i> functions as you can that check to see if one string starts with another.  What are the pros and cons for each method?  What test cases do you need to check?  
</blockquote>

*****
Comment 2008-08-01 by None

Horrifying :).<BR/><BR/>You'll be happy to know you're the 3rd google link for 'php startswith'.  Unfortunately, the 2nd is the php man page for strstr.  Brutal.


*****
Comment 2008-09-16 by None

Thank you very much for your code. I have just started with meddling with php and was trying to find a faster way to check "only" the prefix. Thanks again!


*****
Comment 2009-03-13 by None

Actually, I did some tests and strpos is the fastest for this. The difference in speed varied depending on whether it matched or not but it was always this order:<BR/><BR/>strpos<BR/>strstr<BR/>strncmp<BR/>substr<BR/>preg_match<BR/><BR/>Test code snippet (just change if statement):<BR/><I><BR/>$str = &#39;abcdefghijk&#39;;<BR/>$search = &#39;abc&#39;;<BR/><BR/>echo &quot;strstr: \t&quot;;<BR/>$start = microtime(true);<BR/>for($i=0;$i&lt;10000000;$i++)&#123;<BR/>        if(strstr($str,$search) === $str)<BR/>                continue;<BR/>&#125;<BR/>echo (microtime(true) - $start);<BR/>echo &quot;\n&quot;;<BR/></I>
