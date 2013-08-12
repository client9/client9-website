---
layout: post
updated: 2008-01-27
alias: /2008/01/another-projectbusiness-idea-for-you.html
title: Another project/business idea for you
---
<p>
Previously I mentioned the need for a "liveblogging" server (and javascript client code) to handle millions of concurrent users.  Perhaps not the biggest market, but in time you could extend it to other markets
</p>

<p>
Here's another idea.  Recently I had the joy of playing around with ActiveMQ, the J2EE messaging api.   I'm sure it's "fine"... the problem is that it doesn't have a focus.  it does every possible type of messaging, pub-sub combination.  And to handle this is uses the typical java bloatware.  The internal engine is Derby.  To store a single message they use a ful SQL database!  Nutty!  Also there are a million parameters, each with <i>different</i> ways of setting them.  Some are in a config file, some are in the connection handler, some are in the message, some are JMX.   As if the usual 1,000,000 java XML files weren't enough.
</p>

<p>On the other end of the spectrum is Amazon's Queue service.   I haven't kicked the tires, but people who have say it's good for small scale applications.  Interesting idea.</p>

<p>Lots of small companies would <i>love</i> to use a queue to allow them to decouple various components.   Most aren't financial.   So if a message happens to get lost, it's not the end of the world.  most of the time it doesn't even matter that much the order (meaning if they are out of sequence it's not horrible either).
</p>

<p>So here's the idea.  Queue in a Box.  Not like <a href="http://tervela.com/">Tervela</a>.  That's too high end.  I'm talking about a $5k box, where you plug it in,  Support a few protocols like memcached or STOMP or HTTP REST.   A nice web interface to configure it, probably doesn't need more than dozen paramters, some monitoring.  Add some raid disks for durable storage. DONE.  One tricky part is to make it so you can just add more Q-in-a-Box and "it just works".
</p>

<p>I personally know a few people <i>right now</i> that would buy these.  hell you could expand the product offering with Squid-in-a-box too.</p>