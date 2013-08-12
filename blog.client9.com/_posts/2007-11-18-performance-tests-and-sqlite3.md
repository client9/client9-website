---
layout: post
updated: 2007-11-18
alias: /2007/11/performance-tests-and-sqlite3.html
title: Performance Tests and Sqlite3
---
<p>
Performance "unit tests" present a bit of problem to the usual QA tools since it's not the usual  "pass/fail" so typically you'll have to write your own harness and store the results and apply some extra logic to determine if the build was ok or not</p>

<p>I can't help you write the harness, but I can help with where to store the results.</p>

<p><a href="http://oss.oetiker.ch/rrdtool/">RRDtool</a> is great.  However it has a lot of options and I've found unless the engineer is already familiar with it, it's a bit of overkill for a performance database.  It also works best when the test is run regularly.  (I should actually write up a HOWTO for this).  MySQL also excellent, but it requires setting up a server, and permissions, and all that.</p>

<p> <a href="http://sqlite.org/">sqlite</a> is perfect.  No server. No config. One File. Standard SQL.   Here's the SQL for  a sample metrics db:</p>

<pre>
DROP TABLE IF EXISTS metric;
CREATE TABLE metric (
       date       TEXT NOT NULL DEFAULT CURRENT_DATETIME,
       name      TEXT NOT NULL,
       value       REAL NOT NULL 
);

DROP INDEX IF EXISTS datename;
CREATE UNIQUE INDEX datename ON metric (date,key);
</pre>

<p>You might want to jazz up this table and add a build number, SVN/CVS id or product version.  The 'name' field is just the name of the test.</p>

<p>
To create the database, just do <code>sqite3 DBNAME < FILE</code>, where <code>FILE</code> contains the SQL above
</p>

<p>
python and php are now shipping with sqlite3 out of the box and you can use the fancy APIs, however you can use sqlite3 directly: just add the sql statement as the last argument, <code>sqlite3 <i>db</i> '<i>sql</i>'</code>:
</p>
<pre>
# python example
import os
os.spawnlp(os.P_WAIT, 'sqlite3', <i>databasename</i>, 
                 "INSERT INTO metric SET name='%s', value=%f' % (<i>name</i>,<i>value</i>')
</pre>


<p>In php, see <a href="http://us3.php.net/function.exec">exec</a>, in perl see <a href="http://perldoc.perl.org/functions/exec.html">exec</a>.

<p>Sleazy, yes.  By all means, actually use the real API.  But it's not available, this works.   It also means you can use sqite3 via bash.</p>

<p>Now go make your intern make pretty graphs for you and do alerts if the last run is 20% slower than the last.</p>