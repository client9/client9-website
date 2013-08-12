---
layout: post
updated: 2009-01-12
alias: /2009/01/st-croix-usvi-interweb-infrastructure.html
title: St. Croix USVI Interweb Infrastructure
---
<p>
In case you are in the tech biz and thinking of moving to <a href="http://www.gotostcroix.com/">St. Croix USVI</a> ...
</p>

<ul>
<li>Electrical equipement doesn't last.  Voltage spikes and brownout occur regularly.  "Buy new every year" was one description.</li>
<li>ATT is effectively the only cell phone provider worth having. Coverage is good. They do support 3G and works well (probably cause no on uses it).  They have a store on island</li>
<li>DSL internet is hit or miss.  If the place you are in doesn't have it, then you won't get it either due to lack of ability or lack of motivation to install it.</li>
<li>The other option is <i>microwave</i> wireless, but better be in line-of-sight.</li>
<li>St. Croix uses another microwave link to  connect to St. Thomas, which connects to ATT WorldNet in Florida.</li>
<li>At night performance decreases due to humidity and wind</li>
<li>Believe it or not, bandwidth is good 300KB/sec download, and upload was good too (can't remember).</li>
<li>But....Latency is deadly -- 1 - 2 <i>seconds</i> is common.  See the traceroute below</Ii>
<li>VOIP and video conferencing, needless to say, doesn't work</li>
<li>SSH is painful</li>
<li>There are no satellite internet providers on the island</li>
</ul>

<p>Ok here's the fun part.  <a href="http://www.globalcrossing.com/network/network_interactive_map.aspx">Global Crossing</a> has a direct cable from STX to Boston.  But it's a repeater station, <i>not</i> a router.    Otherwise it would be direct to mainland in a few milliseconds.  So sad.  One financial company down there is trying to crack it open, but the rumous is GC has no interest.</p>

<p>For laughs, here's a traceroute from St. Croix to a data center in Newark, NJ</p>
<pre>
Me to St. Croix to St. Thomas via 2 microwave links
 2  192.168.2.1 (192.168.2.1)  5.417 ms  3.176 ms  2.956 ms
 3  66.185.42.1 (66.185.42.1)  2175.185 ms  2167.668 ms  2021.946 ms
 4  66.185.32.49 (66.185.32.49)  1797.172 ms  1725.228 ms *
 5  66.185.32.145 (66.185.32.145)  1759.276 ms *  1454.276 ms

ATT WorldNet: West Palm Beach To Orlando to Atlanta
 6  12.124.80.161 (12.124.80.161)  1542.547 ms  1453.833 ms  1485.562 ms
 7  12.123.32.74 (12.123.32.74)  1455.981 ms *  1452.895 ms
 8  12.122.1.70 (12.122.1.70)  1645.229 ms  2039.913 ms *
 9  12.122.31.29 (12.122.31.29)  1600.652 ms  1619.203 ms  1652.630 ms
10  12.122.87.153 (12.122.87.153)  1901.846 ms  1210.305 ms  1267.692 ms
11  192.205.35.210 (192.205.35.210)  1413.746 ms  1570.563 ms  1602.673 ms

Level 3 -- Atlanta to Washington DC to Newark
12  4.68.103.62 (4.68.103.62)  1905.632 ms  1811.243 ms *
13  4.69.132.86 (4.69.132.86)  1658.731 ms *  2060.085 ms
14  4.69.134.142 (4.69.134.142)  2244.329 ms  2731.755 ms  2717.131 ms
15  4.69.134.157 (4.69.134.157)  2505.639 ms  2634.133 ms  2848.191 ms
16  4.69.132.102 (4.69.132.102)  2528.648 ms  3148.725 ms  3064.920 ms
17  4.68.99.103 (4.68.99.103)  2985.497 ms 4.68.99.167 (4.68.99.167)  2918.541 ms 4.68.99.39 (4.68.99.39)  2480.194 ms
18  4.71.144.6 (4.71.144.6)  1801.014 ms  2416.501 ms  2123.173 ms

10 more hops once inside the datacenter (to a virtual machine)
</pre>

*****
Comment 2010-02-01 by None

Update!  t-mobile bough some local cell phone company so tmobile or att works well on the island.<br /><br />Update!  That &quot;tech company&quot; was stanford financial.   ha!
