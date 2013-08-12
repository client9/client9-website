---
layout: post
updated: 2010-02-20
alias: /2010/02/mysql-query-cache-vs-memcache.html
title: mysql query cache vs. memcache
---
<p>
If for some reason the official snippet on <a href="http://code.google.com/p/memcached/wiki/FAQ#How_does_it_compare_to_MySQL's_query_cache?">How does memcache compare to MySQL's query cache</a> was not satisfying, here's a more concrete example using <a href="http://www.python.org">python"</a> and <a href="http://sourceforge.net/projects/mysql-python/">MySQLdb</a>.
</p>

<h2> MySQL Query Cache</h2>

<p><a href="http://dev.mysql.com/doc/refman/5.1/en/query-cache.html">MySQL's query cache</a> is good, especially for smaller sites, or for static data.  The problem is that saving time for the MySQL <i>server</i> is only half the battle.  You still got the MySQL C client, the mysql client for your language, and then all your crappy code to process the rows.</p>

<p>Here's the mysql log of a cache query that returns about 100 rows of data</p>

<pre>
Query_time: 0.000157  Lock_time: 0.000000 Rows_sent: 0  Rows_examined: 0
</pre>

<p>So it takes about 0.15 milliseconds.  Without the cache, this can take seconds, so the query cache is definitely working. Good.</p>

<p>Yet, when I run 1000 calls to the database (using the same connection, to a database on the same machine), it take 30 seconds or 30ms per call, or 200x slower!  This function doesn't do much.  Just makes the query, and iterates over the rows.  Here's what <a href="http://docs.python.org/library/profile.html">cProfile</a> says:
</p>

<pre>
   1621150 function calls in 29.343 CPU seconds

   Ordered by: cumulative time
   List reduced from 100 to 30 due to restriction <30>

   ncalls  tottime  percall  cumtime  percall filename:lineno(function)
        1    0.000    0.000   29.343   29.343 <string>:1(<module>)
        1    0.101    0.101   29.343   29.343 coreapi.py:204(driver)
     1000    2.270    0.002   29.241    0.029 coreapi.py:117(getlineup)
     1000    0.189    0.000   25.062    0.025 .../tornado/database.py:104(query)
     1000    0.017    0.000   24.649    0.025 .../tornado/database.py:149(_execute)
     1000    0.075    0.000   24.633    0.025 .../MySQLdb/cursors.py:129(execute)
     1000    0.025    0.000   24.402    0.024 .../MySQLdb/cursors.py:311(_query)
     1000    0.020    0.000   23.152    0.023 .../MySQLdb/cursors.py:316(_post_get_result)
     1000    0.018    0.000   23.132    0.023 .../MySQLdb/cursors.py:282(_fetch_row)
     1000    3.312    0.003   23.114    0.023 &#123;built-in method fetch_row&#125;
   343000    5.406    0.000   19.802    0.000 .../MySQLdb/connections.py:189(string_decoder)
   343000    5.760    0.000   14.395    0.000 &#123;method 'decode' of 'str' objects&#125;
   343000    5.390    0.000    8.635    0.000 .../encodings/utf_8.py:15(decode)
   343000    3.245    0.000    3.245    0.000 &#123;_codecs.utf_8_decode&#125;
     1000    0.037    0.000    1.225    0.001 .../MySQLdb/cursors.py:273(_do_query)
    98000    1.036    0.000    1.036    0.000 &#123;cjson.decode&#125;
     1001    0.945    0.001    0.945    0.001 &#123;method 'query' of '_mysql.connection' objects&#125;
    49000    0.427    0.000    0.427    0.000 .../tornado/database.py:160(__getattr__)
    49004    0.366    0.000    0.366    0.000 &#123;method 'append' of 'list' objects&#125;
</pre>

<p>I wrapped the raw MySQLdb with the new <a href="http://github.com/facebook/tornado/blob/master/tornado/database.py">Facebook Tornado wrapper</a>.  It adds a second or two the total time, and I'm JSON decoding a few fields, but most of the time is just doing mysql-ly things.  The MySQL protocol isn't pretty and takes a lot of work translating it to native python datatypes.</p>.

<h2>All Hail Memcache</h2>

<p>All that client-side work can be recycled by putting it into <a href="http://memcached.org/">memcached</a>.  In this example, it improves performance by 10x.</p>

<pre>
         124900 function calls in 2.832 CPU seconds

   Ordered by: cumulative time
   List reduced from 162 to 30 due to restriction <30>

   ncalls  tottime  percall  cumtime  percall filename:lineno(function)
        1    0.000    0.000    2.832    2.832 <string>:1(<module>)
        1    0.056    0.056    2.832    2.832 coreapi_tv2.py:209(driver)
     1000    0.053    0.000    2.775    0.003 coreapi_tv2.py:117(getlineup)
     1000    0.101    0.000    2.565    0.003 .../memcache.py:614(get)
     1001    0.540    0.001    1.037    0.001 .../memcache.py:870(check_key)
      999    0.067    0.000    0.954    0.001 .../memcache.py:722(_recv_value)
      999    0.561    0.001    0.561    0.001 &#123;built-in method load&#125;
    66066    0.474    0.000    0.474    0.000 &#123;ord&#125;
      999    0.155    0.000    0.296    0.000 .../memcache.py:852(recv)
     1000    0.031    0.000    0.233    0.000 .../memcache.py:710(_expectvalue)
     2000    0.055    0.000    0.225    0.000 .../memcache.py:826(readline)
     5996    0.205    0.000    0.205    0.000 &#123;method 'recv' of '_socket.socket' objects&#125;
    15995    0.118    0.000    0.118    0.000 &#123;len&#125;
     1001    0.043    0.000    0.108    0.000 .../memcache.py:229(_get_server)
</pre>