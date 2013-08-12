---
layout: post
updated: 2007-12-19
alias: /2007/12/google-charts-api.html
title: Google Charts API
---
<p>I was poking around <a href="http://code.google.com/">code.google.com</a> and bumped into the weirdest Google API yet:  The <a href="http://code.google.com/apis/chart/">Google Charting API</a>.  It's how <a href="http://finance.google.com/">finance.google.com</a> makes it's charts.  You give 'em a URL, they give you a good looking graph png image.   For instance:</p>

<pre>
&lt;img src="http://chart.apis.google.com/chart?cht=p3&amp;chd=s:hW&amp;chs=250x100&amp;chl=Hello|World" alt="achart" /&gt;
</pre>

<p>
makes this (live example):
<img src="http://chart.apis.google.com/chart?cht=p3&amp;chd=s:hW&amp;chs=250x100&amp;chl=Hello|World" alt="achart"  />
</p>

<p>Ta-Da.  Lots of other chart types are available, too.  It's good for 50k request per day.  And of course you need more than that, your backend process can make the graph and copy it to your local image server.</p>

<p>What's sad is that the quality of the graphs is a lot better than most other graphing/charting solutions out there.</p>