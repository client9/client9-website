---
layout: post
updated: 2010-02-20
alias: /2010/02/facebook-tornados-excellent-python.html
title: Facebook Tornado's Excellent Python MySQLdb Wrapper
---
<p>
<code><a
href="http://github.com/facebook/tornado/blob/master/tornado/database.py">tornado.database</a></code>
is part of the FriendFeed/Facebook <a
href="http://www.tornadoweb.org/">Tornado webserver and web
framework</a> and is a wrapper around MySQLdb.  It is a single file and has no other dependencies.   If you are already using Tornado, jump down for <a href="#gotchas">gotchas section</a>.
</p>

<p><b>Use it</b>.  I've always found <a
href="http://www.python.org/dev/peps/pep-0249/">DBAPI2</a> to be in
the sweet spot of simulatenously not being low level enough to take
advantage of the native documentation and not being high level enough
so I don't really now what the "right way" is (e.g. Do we really need
3 different cursor types?  Isn't the entire concept of a 'cursor' a leftover from the 80s?). This wraps up that mess and solves some
common MySQL quirks.
</p>

<h2>Connections</h2>
<p>
Connections are opened so that they are in UTF8 character encoding and
UTC timezone.  But you are doing this already, right? Yeah I thought so.
</p>

<h2>Bye Bye Cursors</h2>
<p>To the end user, cursors are gone.  They are now under the hood where they belong and properly managed so they don't leak.
</p>

<h2>Columns by Name</h2>

<p>You can do <code>row['foo']</code> instead of <code>row[0]</code>.
While this does add some (minor) overhead, the benefit of developer
time, self.documenting code, and the prevention of future bugs is well
worth it.</p>

<h2>Query Replacement: no more tuples</h2>

<p>Gone!</p>

<pre>
# Native
conn.fetchone(astring, (arg1, arg2, arg3))

# Tornado
conn.get(astring, arg1, arg2, arg3)
# or if you have a tuple
conn.get(astring, *arglist)
</pre>

<a name="gotchas"><h3>Gotchas</h3></a>

<p>It ain't perfect</p>

<h2>Other connection parameters</h2>

<p>There is no automatic way of adding to changing how a MySQL
connection is created.  Fortunately, python to the rescue.  For
instance, adding the <a
href="http://blog.client9.com/2010/02/python-mysqldb-auto-reconnect.html">autoreconnect
feature</a> you can do this:</p>

<pre>
conn = Connection(host, database)

# hack in new args, or replace them
conn._db_args['reconnect'] = 1

# close current connection and get a new one
conn.reconnect()
</pre>

<p>Hopefully a future release will allow a cleaner mechanism for adding other paramters</p>

<a name="rowwoe"><h2>Row Woe</h2></a>

<p>With a tornado query row, you can access the collumns using dict
style <code>row['foo']</code> or property style <code>row.foo</code>
(see the Row object at the end of <code><a
href="http://github.com/facebook/tornado/blob/master/tornado/database.py">database.py</a></code>).
</p>

<p>Nifty, huh?  <b>But</b>, accessing rows as <code>row.foo</code> comes with a hefty price:
</p>

<pre>
#  Using attributes/property style, row.foo
3418150 function calls in 61.843 CPU seconds

# Using dict style, row['foo']
2681150 function calls in 48.673 CPU seconds
</pre>

<p>Using <code>row.foo</code> made my query run 25% slower!  So don't use 'em.</p>


<h3> Conclusion </h3>

<p>If you have a new project, whether or not you are using the rest of Tornado, use this wrapper for MySQL.</p>

<p>
<code>pydoc tornado.database</code> is your friend, but the code is so straighword and in one file, it should be a snap to read.
</p>