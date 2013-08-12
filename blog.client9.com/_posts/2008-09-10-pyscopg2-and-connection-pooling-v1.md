---
layout: post
updated: 2008-09-21
alias: /2008/09/pyscopg2-and-connection-pooling-v1.html
title: pyscopg2 and connection pooling, v1
---
<p>This blog entry is certainly to be "version 1", with updates to follow</p>

<p>Again, why is finding information on something so basic, so hard to find?  Anyways, the short answer is this:</p>

<pre>
# we need the 'with' statement, python 2.5 or greater
from __future__ import with_statement
from contextlib import contextmanager

import psycopg2
import psycopg2.pool

# create pool with min number of connections of 1, max of 10
a = psycopg2.pool.SimpleConnectionPool(1,10,database='YOURDB', otherstuff...)

@contextmanager
def getcursor():
    con = a.getconn()
    try:
        yield con.cursor()
    finally:
        a.putconn(con)
</pre>

<P>That's it.   To use it do something like this:</p>
<pre>
with getcursor() as cur
    cur.execute("select count(*) from foo")
    # do something with result

# all done, other code goes here
</pre>

<h2>About psycopg2's pools</h2>

<p>Crude infomation on the pooling code can be found with </p>
<pre>
 pydoc psycopg2.pool
</pre>

<p>From this you can see three pool types:</p>
<ul>
<li>SimpleConnectionPool</li>
<li>PersistantConnectionPool </li>
<li>ThreadedConnectionPool </li>
</ul>
<p> I'm haven't studied which one is appropriate for different server types and configurations  (fcgi, mod_wsgi, mod_python)</p>

<p> The "constructor" for all them are the same.  The first and second arguments are the minimum and maximum number of connections.  The remaining arguments are the same ones you use in <code>psycopg2.connect</code>.  To get a connection, call <code>getconn</code>, then when you are done, you <i>must</i> return it with <code>putconn</code>.  That is kinda clunky.    Using <code>with</code> and <code>contextmanger</code> makes it easy.  How that works is another article.
</p>

<h2>Performance</h2>

<p>You know already, but </p>

<pre>
imax = 1000
def withpool():
    for i in xrange(imax):
        with getcursor() as cur:
            cur.execute("select 1")

def withoutpool():
    for i in xrange(imax):
        con = psycopg2.connect(database='geocode')
        cur = con.cursor()
        cur.execute("select 1")
        con.close()
</pre>

<p> has the results of </p>
<pre>
         18003 function calls in 0.679 CPU seconds
</pre>
<p>
versus
<pre>
         3003 function calls in 18.232 CPU seconds
</pre>

*****
Comment 2008-09-21 by None

Thanks for this tip !


*****
Comment 2011-10-02 by None

Still the best example on the Internet and its 2011 now...


*****
Comment 2011-10-02 by None

Still the best example around and its now 2011...


*****
Comment 2012-02-26 by None

This is cool. I tweaked this so that I don&#39;t have to worry about committing my changes or closing the connections as well:<br /><br />import psycopg2<br />from contextlib import contextmanager<br /><br />@contextmanager<br />def connect(dsn):<br />  connection = psycopg2.connect(dsn)<br />  cursor = connection.cursor()<br />  try:<br />    yield cursor<br />    connection.commit()<br />  except:<br />    connection.rollback()<br />  finally:<br />    connection.close()
