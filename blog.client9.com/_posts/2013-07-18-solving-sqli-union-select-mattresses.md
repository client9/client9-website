---
layout: post
updated: 2013-07-18
alias: /2013/07/solving-sqli-union-select-mattresses.html
title: Solving the SQLi 'union select mattresses' problem with libinjection
---
One reason <a
href="https://www.owasp.org/index.php/Web_Application_Firewall">Web
Application Firewalls</a> (WAFs) aren't used is due to false
positives.  Conveniently illustrated by this tweet by <a
href="https://twitter.com/rybolov/status/357690858537099264">@rybolov</a>:

> OH: "We can't use WAF because we sell 'Union Select Mattresses'"

That is an unfortunate 21st-century brand name, as most <a
href="https://www.owasp.org/index.php/Web_Application_Firewall">Web
Application Firewalls</a> will flag "union select mattresses" as being
SQLi.  Regular expression or keyword based filters will trigger on the
"union select" part, fearing that it's part of something like:

<pre>1 UNION SELECT id FROM users LIMIT 1 --
</pre><br />
Given SQL's rich English-like structure, there many other cases of false positives like this.<br />
<br />
<a href="https://libinjection.client9.com/">libinjection</a>, a C library to detect SQLi, fares better than most, but still has problems:<br />
<br />
<ul><li>OK: <a href="https://libinjection.client9.com/diagnostics?id=union+select+mattresses&type=fingerprints">union select mattresses</a></li>
<li>SQLi<a href="https://libinjection.client9.com/diagnostics?id=I+like+union+select+mattresses&type=fingerprints">I like union select mattresses</a> (Hmm probably should not be marked as SQli, will investigate) </li>
<li>OK <a href="https://libinjection.client9.com/diagnostics?id=union+select+mattresses+are+awesome&type=fingerprints">union select mattresses are awesome</a></li>
<li>SQLi: <a href="https://libinjection.client9.com/diagnostics?id=10+white+union+select+mattresses&type=fingerprints">10 white union select mattresses</a></li>
<li>OK: <a href="https://libinjection.client9.com/diagnostics?id=please+order+union+select+mattresses&type=fingerprints">please order union select mattresses</a></li>
</ul>

libinjection understands SQL syntax and parses the input into the
tokens.  The first five tokens are compared against known (and some
unknown) SQLi attacks.  Since it only looks at the start of the input,
any reference to "union select mattress" embedded later in the text
won't trigger a SQLi alert.

But this isn't good enough.  <i>Any false positives</i> with "union
select mattresses" will quickly drive the site owner to unplug the
WAF.

Can we do better?  Yes we can.

You can change how libinjection evaluates specific words.  By default,
a bare word like "mattress" is treated as a SQL column name.  So
assuming "mattress" is not a column name, we can tell libinjection
that it is something else by editing the <code><a
href="https://github.com/client9/libinjection/blob/master/c/sqlparse_map.py">sqlparse_map.py</a></code>
file:

```
"MATTRESS": "?",
"MATTRESSES": "?"
# add typos too
```

You can add as many of these as you like with no performance impact.
Then, recompile and deploy.  Don't like C?  You can also do this via
the <a href="https://libinjection.client9.com/doc-sqli-python">python
API</a> too (and other languages coming soon).

Now, all SQLi fingerprints in libinjection will completely ignore
"union select mattress" but still find attacks like the example
above.

Can we do even better? Yes we can.

If you can insert the names of your database table and column names
into libinjection's `sqlparse_map.py` file, a small patch will change
the behavior of libinjection to ignore bare words that aren't actual
columns names.  Good bye false positives.

So yes, you can sell Union Select Mattresses and use a WAF without
false positives.

<a href="https://libinjection.client9.com/">libinjection</a> is raw C
library with python and lua bindings (and more soon), ready to
integrate into your application.  But if you'd like to try this out in
a full WAF, <a href="https://modsecurity.org">ModSecurity</a> closely
tracks the latest versions of <a
href="https://libinjection.client9.com/">libinjection</a>.

Comments
=============

*****
Comment 2013-07-19 by None

Hi Nick,

you wrote &quot;The first five tokens are compared
against known (and some unknown) SQLi attacks&quot;. But if an attack
is unknown, how can you compare tokens?

Can you clarify a bit?

thanks!


*****
Comment 2013-07-19 by nickg

Hi db1981

Ahh, I didn&#39;t mean to be so mysterious.

Using:

```
1 UNION SELECT id FROM users LIMIT 1 --
```

as an example.  If I did my job right, libinjection should also detect
SQL variations of it such as

```
+1.34234e-12 UNION SELECT id FROM users LIMIT 1--
(-10 mod (@version())  UNION SELECT id FROM users LIMIT 1--
((((1)))) UNION SELECT id FROM users LIMIT 1--
```

These might not have been actually used before, and might have a
slightly different fingerprints.

When I get a new SQLi attack, I run it though a mini-fuzzer to add
these types of variations, to catch future attacks and bypasses.

Does this help clarify?

nickg

