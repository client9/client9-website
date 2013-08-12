---
layout: post
updated: 2008-08-29
alias: /2008/08/is-compressing-output-of-your-webserver.html
title: Is compressing the output of your webserver cost effective?
---
<p>
For a minute, forget <i>how</i> to compress output from your webserver, and if it's a good idea in general, and instead <i>is it cost effective?</i>
</p>

<p>Ok, for you executive types the answer is <b>yes</b>, and very much so.</p>

<p>For the rest of us: with compression you are using less bandwidth, but compressing content also  takes CPUs.   If you have your own setup in a datacenter, this is really painful to estimate since you buy bandwidth in huge increments.  In other words, there is no reason to save bandwidth until you hit your limits, and then it's <i>really important</i>.   Likewise with CPU costs: you have mixed-use machines all using the same datacenter, using the same power all of which is priced in large increments.
</p>

<p>Fortunately, someone else already figured this stuff out:  Amazon with it's EC2.   On the low end it's: </p>

<ul>
<li>$0.10 per CPU hour</li>
<li>$0.17 per gigabyte data out.</li>
</ul>

<p>
  Let's also assume:
</p>

<ul>
<li>gzip will provide 2x compression </li>
<li>gzip can compress 1G in 3minutes (5% of one hour)</li>
</ul>


<p>So if you pump out 2G of data without compression, the serving cost is  2 &times; $0.17 = $0.34, plus incidental cpu cost of course</p>

<p>With compression, the cost is 0.5 &times; 2  &times; $0.17 +  (3 / 60) &times; $0.10 = $0.171.</p>

<p>Doing a bit more thinking, for compression to <i>not</i> be cost effective, the compression ratio has to be very low, or be very slow, no matter what the bandwidth cost is.</p>

<p>In other words, compress away!</p>

<p>Now <i>how</i> is a different question.  Since it's the wonderful world of <i>web development</i> almost nothing works correctly and has lots of special cases.   But that's another article.</p>