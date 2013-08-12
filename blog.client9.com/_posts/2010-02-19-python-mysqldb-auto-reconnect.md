---
layout: post
updated: 2010-02-19
alias: /2010/02/python-mysqldb-auto-reconnect.html
title: Python MySQLdb auto reconnect MYSQL_OPT_RECONNECT
---
<p>
Auto-reconnect (<code>MYSQL_OPT_RECONNECT</code>) is available in the <a href="http://www.python.org/">python</a> MySQLdb client.  Just add "reconnect=1" when you are creating a connection via <code>MySQLdb.connect</code>.  At least it is on <a href="http://releases.ubuntu.com/karmic/">Ubuntu 9.10</a>.  Not documented.
</p>

<p>The easy ways to test is to start your server, make a request to see you do have a connection, then restart mysql, the make a new request.</p>

<p>Note that auto-reconnect totally borks transactions, so this is best used for MyISAM tables and read-only queries elsewhere.
</p>

*****
Comment 2010-03-07 by None

This doesn&#39;t seem to work for me on karmic 9.10.  I will upgrade everything to be sure.<br /><br />The patch seems to have been dropped again in Ubuntu Lucid:<br /><br />https://code.launchpad.net/~ubuntu-branches/ubuntu/lucid/python-mysqldb/lucid
