---
layout: post
updated: 2007-11-21
alias: /2007/11/sqlite3-and-on-duplicate-key-update.html
title: sqlite3 and "ON DUPLICATE KEY UPDATE"
---
<p>
MySQL has  a great SQL extension "INSERT ... ON DUPLICATE KEY UPDATE" (doco <a href="http://dev.mysql.com/doc/refman/5.0/en/insert.html">here</a>).  As you might guess it either inserts a new row, but if it exists already, you can specify an update.  It's particular great for doing frequency counts:
</p>

<pre>
INSERT INTO atable SET name='foo', count=4 ON DUPLICATE KEY UPDATE count=count+4
</pre>

<p>sqlite3 doesn't have this functionality, but it's easy to fake with a little programming.  I'm going to use python as an example, but I'm sure it applies to other languages.</p>

<pre>
import sqlite3

# setup code here

try:
   cursor.execute("INSERT INTO atable SET name='foo', count = 4")
except sqlite3.IntegrityError, m:
    cursor.execute("UPDATE atable SET count = count + 4")

# more
</pre>

<p>With Sqlite3 you'll need to make sure a unique index exists (in this example, for the 'name' field).
</p>

*****
Comment 2009-01-23 by None

I think it's easier using 'replace into' which does the same as multi-liner.


*****
Comment 2009-12-16 by None

&#39;REPLACE INTO&#39; does a &#39;DELETE&#39; before an &#39;INSERT&#39;, and this is not the behaviour intended with &#39;ON DUPLICATE KEY UPDATE&#39;
