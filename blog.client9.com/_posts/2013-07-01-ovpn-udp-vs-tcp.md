---
layout: post
updated: 2013-07-01
alias: /2013/07/ovpn-udp-vs-tcp.html
title: OVPN UDP vs. TCP
---

OVPN normally defaults to UDP.  This might be better for real-time
applications where all clients and servers are "close" However, if you
want your VPN to work 'everywhere', choose TCP.

* Some firewalls (ahem, <i>juniper</i>) don't seem to like UDP packets
  and you won't be able to connect if you use them.<
* Using UDP over the Internet is likely to have problem due to packet
  loss


Using TCP with OVPN, all these problems go away.  I learned this the
hard way.  Enjoy!
