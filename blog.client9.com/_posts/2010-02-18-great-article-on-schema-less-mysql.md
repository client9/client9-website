---
layout: post
updated: 2010-02-19
alias: /2010/02/great-article-on-schema-less-mysql.html
title: Great article on "Schema-less" MySQL
---
<p>
Just dug up this nugget: <a href="http://bret.appspot.com/entry/how-friendfeed-uses-mysql">How FriendFeed uses MySQL to store schema-less data</a>
</p>

<p>This is similar to the postgres feature of <a href="http://www.postgresql.org/docs/8.4/static/hstore.html">h-stores</a></p>

<p>I haven't had the need to index the unstructured data, but I have used a blob to store key-value pairs in a JSON form.  Why JSON?  With cJSON modules it's as fast if not faster than cPickle,and it's text so a bit easier on the eyes.  Also there is a possibility of just slamming it to the client as-is
</p>