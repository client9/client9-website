---
layout: post
updated: 2013-07-01
alias: /2013/04/sqli-and-implicit-type-conversion-in.html
title: SQLi and Implicit type conversion in MySQL
---
<br />
<br />
This was inspired by <a href="http://vagosec.org/">vagosec.org</a> article on <a href="http://vagosec.org/2013/04/mysql-implicit-type-conversion/">MySQL Implicit Type Conversion</a>.  I enumerated all the different operators to see how MySQL does type conversions.  The results are surprising in many cases.<br />
<br />
<h3>String Operator Different String</h3><br />
<table><tr style=""><td><code>SELECT "A" AND "B" = "C"</code></td><td>False</td></tr>
<tr style=""><td><code>SELECT "A" &amp;&amp; "B" = "C"</code></td><td>False</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" = "B" = "C"</code></td><td>True</td></tr>
<tr style=""><td><code>SELECT "A" := "B" = "C"</code></td><td>Error</td></tr>
<tr style=""><td><code>SELECT "A" BINARY "B" = "C"</code></td><td>Error</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" &amp; "B" = "C"</code></td><td>True</td></tr>
<tr style=""><td><code>SELECT "A" ~ "B" = "C"</code></td><td>Error</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" | "B" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" ^ "B" = "C"</code></td><td>True</td></tr>
<tr style=""><td><code>SELECT "A" CASE "B" = "C"</code></td><td>Error</td></tr>
<tr style=""><td><code>SELECT "A" DIV "B" = "C"</code></td><td>False</td></tr>
<tr style=""><td><code>SELECT "A" / "B" = "C"</code></td><td>False</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" &lt;=&gt; "B" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" &gt;= "B" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" &gt; "B" = "C"</code></td><td>True</td></tr>
<tr style=""><td><code>SELECT "A" IS NOT NULL "B" = "C"</code></td><td>Error</td></tr>
<tr style=""><td><code>SELECT "A" IS NOT "B" = "C"</code></td><td>Error</td></tr>
<tr style=""><td><code>SELECT "A" IS NULL "B" = "C"</code></td><td>Error</td></tr>
<tr style=""><td><code>SELECT "A" IS "B" = "C"</code></td><td>Error</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" &lt;&lt; "B" = "C"</code></td><td>True</td></tr>
<tr style=""><td><code>SELECT "A" &lt;= "B" = "C"</code></td><td>False</td></tr>
<tr style=""><td><code>SELECT "A" &lt; "B" = "C"</code></td><td>False</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" LIKE "B" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" - "B" = "C"</code></td><td>True</td></tr>
<tr style=""><td><code>SELECT "A" % "B" = "C"</code></td><td>False</td></tr>
<tr style=""><td><code>SELECT "A" MOD "B" = "C"</code></td><td>False</td></tr>
<tr style=""><td><code>SELECT "A" != "B" = "C"</code></td><td>False</td></tr>
<tr style=""><td><code>SELECT "A" &lt;&gt; "B" = "C"</code></td><td>False</td></tr>
<tr style=""><td><code>SELECT "A" NOT LIKE "B" = "C"</code></td><td>False</td></tr>
<tr style=""><td><code>SELECT "A" NOT REGEXP "B" = "C"</code></td><td>False</td></tr>
<tr style=""><td><code>SELECT "A" NOT "B" = "C"</code></td><td>Error</td></tr>
<tr style=""><td><code>SELECT "A" ! "B" = "C"</code></td><td>Error</td></tr>
<tr style=""><td><code>SELECT "A" !! "B" = "C"</code></td><td>Error</td></tr>
<tr style=""><td><code>SELECT "A" OR "B" = "C"</code></td><td>False</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" + "B" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" REGEXP "B" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" &gt;&gt; "B" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" RLIKE "B" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" SOUNDS LIKE "B" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" * "B" = "C"</code></td><td>True</td></tr>
<tr style=""><td><code>SELECT "A" XOR "B" = "C"</code></td><td>False</td></tr>
</table><br />
<h3>String Operator Same String</h3><table><tr style="background:#DDDDDD"><td><code>SELECT "A" &amp; "A" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" | "A" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" ^ "A" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" &gt; "A" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" &lt;&lt; "A" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" &lt; "A" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" - "A" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" != "A" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" &lt;&gt; "A" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" NOT LIKE "A" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" NOT REGEXP "A" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" NOT RLIKE "A" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" + "A" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" &gt;&gt; "A" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" * "A" = "C"</code></td><td>True</td></tr>
</table><br />
<h3>String Operator String-That-Starts-With-A-Number</h3><p>Note: the example used <code>"1"</code> but <code>"9foobar"</code> or <code>"1.foobar"</code> or <code>".1foobar"</code> or <code>"-9foobar"</code> or <code>"+.4foobar"</code> will work too.<br />
</p><br />
<table><tr style="background:#DDDDDD"><td><code>SELECT "A" = "1" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" &amp; "1" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" DIV "1" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" / "1" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" &lt;=&gt; "1" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" &lt;&lt; "1" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" &lt;= "1" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" &lt; "1" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" LIKE "1" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" % "1" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" MOD "1" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" REGEXP "1" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" &gt;&gt; "1" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" RLIKE "1" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" SOUNDS LIKE "1" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" * "1" = "C"</code></td><td>True</td></tr>
</table><br />
<h3>String Operator String, Both Strings are Numeric, Not Zero</h3><table><tr style="background:#DDDDDD"><td><code>SELECT "123A" = "-3A" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "123A" &lt;=&gt; "-3A" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "123A" &lt;&lt; "-3A" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "123A" &lt;= "-3A" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "123A" &lt; "-3A" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "123A" LIKE "-3A" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "123A" % "-3A" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "123A" MOD "-3A" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "123A" OR "-3A" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "123A" || "-3A" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "123A" REGEXP "-3A" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "123A" &gt;&gt; "-3A" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "123A" RLIKE "-3A" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "123A" XOR "-3A" = "C"</code></td><td>True</td></tr>
</table><br />
<h3>Single Empty String </h3><table><tr style="background:#DDDDDD"><td><code>SELECT "A" = "" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" &amp; "" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" | "" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" ^ "" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" &lt;=&gt; "" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" &lt;&lt; "" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" &lt;= "" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" &lt; "" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" LIKE "" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" - "" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" + "" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" &gt;&gt; "" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" SOUNDS LIKE "" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "A" * "" = "C"</code></td><td>True</td></tr>
</table><br />
<h3>Double Empty String </h3><br />
<table><tr style="background:#DDDDDD"><td><code>SELECT "" &amp; "" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "" | "" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "" ^ "" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "" &gt; "" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "" &lt;&lt; "" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "" &lt; "" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "" - "" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "" != "" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "" &lt;&gt; "" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "" NOT LIKE "" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "" + "" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "" &gt;&gt; "" = "C"</code></td><td>True</td></tr>
<tr style="background:#DDDDDD"><td><code>SELECT "" * "" = "C"</code></td><td>True</td></tr>
</table>