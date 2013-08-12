---
layout: post
updated: 2009-11-20
alias: /2009/11/ubuntu-server-changing-motd-aka-log-on.html
title: Ubuntu Server - changing motd (aka the log-on banner)
---
<p>
Call it a "MOTD" call it a "log-on banner", when you first log on to a Ubuntu server, you get some thing like this:
</p>

<pre>
$ ssh nickg@10.0.1.19
nickg@10.0.1.19's password: 
Linux ubuntu910beta 2.6.31-14-generic #48-Ubuntu SMP Fri Oct 16 14:04:26 UTC 2009 i686

To access official Ubuntu documentation, please visit:
http://help.ubuntu.com/

  System information as of Fri Nov 13 20:57:46 EST 2009

  System load: 0.16              Memory usage: 54%   Processes:       74
  Usage of /:  20.2% of 7.23GB   Swap usage:   0%    Users logged in: 1

  Graph this data and manage this system at https://landscape.canonical.com/

0 packages can be updated.
0 updates are security updates.

Last login: Fri Nov 13 20:47:42 2009 from localhost
</pre>

<p>Blah what a mess.</p>

<p>All this crap comes from the <code>update-motd</code> package.   Looking in the <code>/etc/update-motd.d</code> directory you'll see various bash scripts to generate parts of the output. </p>

<p>Personally, I would remove <code>50-landscape-sysinfo</code>, <code>90-updates-available</code>, <code>91-release_update</code>.  This will make log-in much faster.  Keeping the <code>99-reboot-required</code> is your call.  It's a fast check, but really should be handled by your monitoring system.</p>

<p><code>00-header</code> does two things: print the system/kernel version (via <code>uname</code>) and cat out <code>/etc/motd.tail</code> if it exists.  I get rid of the call to <code>uname</code> and replace <code>/etc/motd.tail</code> to be something useful.
</p>

<p>Fun!</p>