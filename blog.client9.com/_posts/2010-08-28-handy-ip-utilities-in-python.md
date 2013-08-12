---
layout: post
updated: 2011-10-16
alias: /2010/08/handy-ip-utilities-in-python.html
title: Handy IP utilities in python
---
There are some frameworks for python to handle IP addresses.  Sadly they are all very complicated.  The following converts an "IPv4 Address" back and forth between a plain old integer and a string in dots-notation (127.0.0.1).   From this you can do just about anything. <br />
<br />
PUBLIC DOMAIN, but credit always welcome.  thanks!<br />
<br />
<pre>def ip2int(s):
    """ Converts a known-good ip address in dots notation into an 32-bit int    
    """
    parts = [ int(i) for i in  s.split('.') ]
    return (parts[0] &lt;&lt; 24) | (parts[1] &lt;&lt; 16) | (parts[2] &lt;&lt; 8) | parts[3]

def int2ip(s):
    """ Converts an int into dots notation """
    return '.'.join((
        str((s &gt;&gt; 24) &amp; 0xFF),
        str((s &gt;&gt; 16) &amp; 0xFF),
        str((s &gt;&gt; 8) &amp; 0xFF),
        str( s &amp; 0xFF)
        ))

def is_internal_ip(s):
    """ returns true if ip is 0.0.0.0 or between the intervals                  
    10.0.0.0 / 10.255.255.255
    127.0.0.0 / 127.255.255.255                                                
    172.16.0.0 / 172.31.255.255                                                   
    192.168.0.0 / 192.168.255.255                                                 
    """
    ipi = ip2int(s)
    return ipi == 0 or \
        (167772160 &lt;= ipi &lt;= 184549375) or \
        (2130706432 &lt;= ipi &lt;= 2147483647) or \
        (2886729728 &lt;= ipi &lt;= 2887778303) or \
        (3232235520 &lt;= ipi &lt;= 3232301055)

</pre>