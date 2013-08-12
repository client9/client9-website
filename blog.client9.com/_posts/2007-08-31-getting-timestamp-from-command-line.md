---
layout: post
updated: 2007-08-31
alias: /2007/08/getting-timestamp-from-command-line.html
title: Getting the timestamp from the command line
---
<p>it's</p>

<pre>
date +%s
</pre>

<p>
I just saved you looking at a minimum of three man pages.
</p>

<p> While we are on the topic, here's how to do simple timings.  Yes I know about <code>time</code> but sometimes that's not quite what you want.</p>

<pre>
$ TIME_START=`date +%s`
$ #... stuff
# TIME_END=`date +%s`
# echo "It took `expr $TIME_END - $TIME_START` seconds."
</pre>

<p>enjoy</p>