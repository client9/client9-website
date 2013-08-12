---
layout: post
updated: 2009-12-06
alias: /2009/12/virtual-box-31-ubuntu-and-mac.html
title: Virtual Box 3.1, Ubuntu and Mac - Networking Tricks
---
<p>
Yup, it's that time again, more Virtual Box and Mac tricks.  First <a href="http://www.virtualbox.org/wiki/Downloads">Virtual Box 3.1</a> came out recently. It contains something called "Host Only Network" which is very handy
</p>

<p>If you are running a guest desktop OS and do not need to network connect to a server running on the guest OS, then the NAT networking option is all you need.  Ignore the rest of the article.   NAT "shares" an interface with the host,  it's great to allow the <i>guest</i> make <i>outbound</i> connections.    But you can't SSH in.</p>

<p>To do that, you need to use "Bridged Adapter." It behaves like a "different computer" on the network.  The guest gets it's own IP address from the whatever DHCP server is out there.  But: No wifi, no IP. Which means you can't log into the server.  Ooops. And if there is wifi, the IP address might (will) be different every time.   It also means your guest can be <i>attacked</i> by the outside world.</p>

<p>With Virtual Box 3.1, comes with a new type of networking called "Host Only".   It is a bit weird.  The guest can't connect to the internet, and "only your computer" (the host) can connect to it (the guest).    The IP address it gets is "stable" (the same every time it boots)</p>

<p>So if you set up two networking adapters (virtual box supports 4), one being the "NAT", and the other being "Host Only", you get <a href="http://www.youtube.com/watch?v=wcMX-tXntS0">the best of both worlds</a>.  Outbound connectivity when it exists, and inbound activity <i>only from your host</i> (which likely means YOU at the keyboard).  Ta-da!</p>

<h3>Adding a new network and existing Ubuntu Server</h3>

<p>Great you updated your VBox settings and have a snazzy new interface.  How can you get Ubuntu recognize it?  Hack the <code>/etc/network/interfaces</code> file.  You probably just want to add to the end:</p>
<pre>
auto eth1
iface eth1 inet dhcp
</pre>

<p>New installs should recognize the adapters automatically.</p>