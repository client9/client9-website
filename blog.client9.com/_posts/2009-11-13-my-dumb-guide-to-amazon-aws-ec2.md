---
layout: post
updated: 2009-11-13
alias: /2009/11/my-dumb-guide-to-amazon-aws-ec2.html
title: My Dumb Guide to Amazon AWS EC2 - Networking Basics
---

Every instance comes with two IP addresses with associated  DNS names.

A private one has a name similar to:

<pre>
ip-10-213-139-117.ec2.internal
</pre>


You can guess the IP address 10.243.23.231.  This is assigned at
random when you start an instance.  As mentioned it's "private",
meaning you can't dig or nslookup it unless you are on an ec2
instance.  It shows up if you do an <code>ifconfig</code>:


<pre>
ubuntu@ip-10-213-139-117:~$ ifconfig
eth0      Link encap:Ethernet  HWaddr 12:31:3b:04:84:87
          inet addr:10.213.139.117  Bcast:10.212.139.255  Mask:255.255.254.0
          inet6 addr: fe80::1031:3bff:fe04:8487/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:67201 errors:0 dropped:0 overruns:0 frame:0
          TX packets:38520 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:53093196 (53.0 MB)  TX bytes:5305545 (5.3 MB)
</pre>


The public one has a domain name that looks like this:

<pre>
ec2-174-129-187-35.compute-1.amazonaws.com
</pre>

Again you can guess the IP address from the name.  This is
routable from anywhere.  (it doesn't mean you are allowed to connect
the machine, but can use <code>dig</code> or <code>nslookup</code> and
attempt to connect to it).


The public IP does NOT show up in <code>ifconfig</code>.  This
assigned magically (probably some router-like thing in the amazon
datacenter).  I'm not sure there is an easy way to interrogate the OS
to determine the public IP, but you can certainly use EC2 API calls to
figure out the public IP.  The fact that Amazon handles the public IP
and the OS doesn't touch it directly allows amazon to do fun things
like Elastic IP (another article).


If you connect to a EC2's public IP you will be billed for bandwidth,
even if you are on another EC2 instance.  If you need
instance-to-instance communication, use the private addresses.

And lastly, if you terminate an instance that public and private IP
get released back into the sea.  It's unlikely if you start a new
instance you'll get the same ones back.