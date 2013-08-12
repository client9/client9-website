---
layout: post
updated: 2008-10-22
alias: /2008/10/why-you-should-never-use-sprintf.html
title: Why you should never use sprintf
---
<p>
I'm quite convinced a lot of people just should not be coding C at all after reading <a href="http://discuss.joelonsoftware.com/default.asp?joel.3.681534.37">this discussion from Joel On Software</a>.   And <a href="http://discuss.fogcreek.com/joelonsoftware3/default.asp?cmd=show&ixPost=91333&ixReplies=17">this one</a> has some serious security problems.   If the dude implemented some of them, I'm sure his app server is now a spam bot.
</p>

<p><i>Anyways</i>, never use <code>sprintf</code> or it's more horrible variant <code>vsprintf</code> functions.  You <i>will</i> have a buffer overrun and then you will cry.  Using <code>snprintf</code> take almost no more work and is always safe.</p>

<p>Yes this code is technically ok: </p>

<pre>
char buf&#123;100];
sprintf(buf, 'this is a message');
</pre>

<p> You are so smart you counted the length of your message, and made a buffer than can hold it.  Good for you.</p>

<p>There are compilers, static analyzers, runtime analyzers, call graph analysis, heap profilers, but I have a <i>temporal analyzer</i> that can <i>see into the future</i> and in some 100 line patch, that will come in <i>right before code freeze</i> which part of a <i>critical feature</i> my boss is <i>ranting and raving about</i> that <i>must go live now</i> this snippet will show up in the patch:
</p>

<pre>
&lt;&lt;&lt; sprintf(buf, 'this is a message');
----
&gt;&gt;&gt; sprintf(buf, 'this is a message. User input was %s", input);
</pre>

<p>Looks great! I approve it, and <i>bam!</i>, I'm in my bosses office explaining why we had to rollback a release at prime time and had 30 minutes of downtime.</p>

<p>Was this the future or the past?  The temporal analyzer isn't always clear.  The point is <i>do not use <code>sprintf</code></i>.  It's not about how smart you are, it's how dumb the next guy is or rather how stressed out there are while on deadline</p>

<p>Replacing <code>sprintf</code> with <code>snprintf</code> is probably a day job for someone and then it's done.  Depending on your code, it might just be a clever regexp.</p>

<p>Keep your code clean, by preventing it from being re-entered. Future versions of gcc will have a new warning flag <a href="http://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#Warning-Options">-Wdisallowed-function-list=sym,sym,...</a>.  Failing that you'll need to write a scanner (I'm working on one) to do it manually.  This will prevent anyone doing this to begin with.
</p>