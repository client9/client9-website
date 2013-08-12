---
layout: post
updated: 2013-07-01
alias: /2013/07/squid-slow-dns-udp-and-juniper.html
title: Squid, Slow DNS, UDP, and Juniper
---
<br />
TLDR; Having problems with squid and slow DNS?  Might be Juniper's firewall using some more advanced DNS features squid can't handle.  Solution: run a local <code>named</code> as DNS caching server and have squid talk to it.  Works great.<br />
<br />
Ok! long version:  Your test setup of <a href="http://www.squid-cache.org">squid</a> works correctly and is fast.  Then you put it into production (or maybe you move your laptop to the office), and it works... but very slowly.  Pages sometimes load but only have a big pause of maybe 10 seconds.   Sometimes they do not load.  You've added <a href="https://developers.google.com/speed/public-dns/">Google's DNS servers</a> in the config using <code>dns_nameservers 8.8.8.8 8.8.4.4</code>, but it does not help.  Other command line tools such as <code>dig</code>, <code>nslookup</code>, and <code>curl</code> all seem to be fine. <br />
<br />
By any chance are you behind a Juniper firewall or router?  If you are then read this gem from their knowledge base: <a href="http://kb.juniper.net/InfoCenter/index?page=content&id=KB12312&actp=RSS">DNS reply packet is dropped thru the firewall. How is DNS traffic handled?</a> I'm not expert in DNS, so I can't comment if this is reasonable or not.   Regular DNS tools don't seem to have problems with it.  Unfortunately, <code>squid</code>'s internal DNS client is incomplete and can't handle Juniper's response.  So it times out and tries again. Sometimes it gets lucky, and a response comes back.  In other cases, it just gives up.<br />
<br />
<code>Squid</code> is an old piece of code.  It's original solution was to fork off a bunch of children to do name resolution.   I'm sure that was pretty clever back in the day.  It's kinda gross now, and to re-enable it you'll have to recompile <code>squid</code>.   Anyways, at some point their decided to write their own asynchronous DNS client.  Which is normally great, except when it's not.  Like in this case.  <br />
<br />
I got around this by running a local <code>named</code> server just to resolve and cache queries. It and squid are best friends, and <code>named</code> can deal with anything Juniper throws at it.  Enjoy!