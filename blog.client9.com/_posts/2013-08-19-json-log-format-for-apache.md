---
layout: post
title: Apache and JSON log format
---

Summary
------------------

In Apache httpd, using a JSON format for logging has many advantages
over the traditional logging format. However, Apache does not emit 100%
compliant JSON. It is important that you properly pre-process the log
entry before JSON parsing, or alert on parsing failures. Failure to
do allows an attacker to hide their attacks by adding high-bit
characters to the request.

Background
-------------------

The apache log format looks like something designed 20 year ago.
Oh... damn.  It was! ([Apache httpd 1.0 came out in
1995](https://httpd.apache.org/ABOUT_APACHE.html), and it was based on
NCSA httpd which was around for a few year before.  Sadly the
[wikipedia article on NCSA
httpd](http://en.wikipedia.org/wiki/NCSA_HTTPd) is missing details on
this important part of Internet history!).

Back then, logs were comparitively low volume, not indexed, and
designed to be read by humans.  This explains the odd date formats,
the use of backets which makes all those parsing regular expression so
ugly, the not-quite a space-delimited format, and so on.

Enter JSON.  It has a simple structure, self-documenting, standard
parsing, easily exensible.  Some databases such as
[Splunk](http://www.splunk.com), [Mongo](http://www.mongodb.org), and
[CouchDB](http://couchdb.apache.org) natively process data in the JSON
format.  Not surprisingly there are now [many documents on how to
convert the Apache log format into a JSON
format](https://duckduckgo.com/?q=apache+json+logs).

Each log line, is a mini-JSON document.  To process, the workflow is
typically something like the following (from [Catch404.net](http://catch404.net/2012/07/apache-access-logging-in-json-and-a-php-script-to-parse-it/)):

```php
foreach($file as $line) {
    if(!$line) continue;

    $log = json_decode($line);
    if(!is_object($log)) continue;

    print_r($log);
}
```

Apache `mod_log_config`
-----------------------

Apache HTTPD logging is handled by [mod\_log\_config](http://httpd.apache.org/docs/2.2/mod/mod_log_config.html).

There are lots of examples of using `LogFormat` to generate a JSON-like log.  Here's one I used previously:

```
LogFormat "{\"timestamp\":%{\%s}t,\"remote_ip\":\"%a\",\"request\":\"%U%q\","
          "\"method\":\"%m\",\"status\":%s,\"user_agent\":\"%{User-agent}i\","
          "\"referrer\":\"%{Referer}i\",\"duration_usec\":%D }" jsonlog

CustomLog ${APACHE_LOG_DIR}/access-json.log jsonlog
```

But is it 100% JSON?

Forget the docs, let's look at the source code:

from [server/util.c](https://github.com/apache/httpd/blob/trunk/server/util.c):

```c
if (TEST_CHAR(*s, T_ESCAPE_LOGITEM)) {
    *d++ = '\\';
    switch(*s) {
    case '\b':
        *d++ = 'b';
        break;
    case '\n':
        *d++ = 'n';
        break;
    case '\r':
        *d++ = 'r';
        break;
    case '\t':
        *d++ = 't';
        break;
    case '\v':
        *d++ = 'v';
        break;
    case '\\':
    case '"':
        *d++ = *s;
        break;
    default:
        c2x(*s, 'x', d);
        d += 3;
    }
}
else {
    *d++ = *s;
}
```

(and `c2x` emits 'x' plus *two* hex digits.)

It's a bit of pain to find out how TEST_CHAR is defined, but it's in [server/gen\_test\_char.c](https://github.com/apache/httpd/blob/trunk/server/gen_test_char.c)

```c
/* For logging, escape all control characters,
 * double quotes (because they delimit the request in the log file)
 * backslashes (because we use backslash for escaping)
 * and 8-bit chars with the high bit set
 */
if (c && (!apr_isprint(c) || c == '"' || c == '\\' || apr_iscntrl(c))) {
    flags |= T_ESCAPE_LOGITEM;
}
```

`apr_isprint` is false for char < 32 and char > 127.  `apr_iscntrl` is
true for any value < 32 (I assume.. I didn't look too carefully at the
details here as these functions are mostly standard).


How does this compare to the JSON spec?
---------------------------------------

The [main JSON specification](http://json.org/) and related [RFC
4627](http://www.ietf.org/rfc/rfc4627.txt) is that JSON uses UNICODE as it's internal representation.

> All Unicode characters may be placed within the
> quotation marks except for the characters that must be escaped:
> quotation mark, reverse solidus, and the control characters (U+0000
> through U+001F).

and you use these backslash escapes:

```
  "    quotation mark  U+0022
  \    reverse solidus U+005C
  /    solidus         U+002F
  b    backspace       U+0008
  f    form feed       U+000C
  n    line feed       U+000A
  r    carriage return U+000D
  t    tab             U+0009
  uXXXX                U+XXXX (where X is a hex digit)
```

Ok, Apache and JSON has in common \b, \n, \r, \t, \\, \".  Great.

Apache also emits \v.  This is *not* valid JSON and will cause JSON parsers to break.

For other control characters, or for high bit characters, Apache emits
'\xXX'.  JSON doesn't understand this either, since it doesn't unknow
what "\x" is.

Preprocessing to fix JSON issues
----------------------------------

The sleezy fix to converting Apache output to JSON can be done with the following:

```python
line = line.replace('\\v', '\\u0013')
line = line.replace('\\x', '\\u00')
```

The unsleezy way would require checking that the previous character is
NOT a blackslash as well (since then the input is already escaped).
This is a rare care however.

Security
---------

If you do not do pre-processing, converting the log line into proper
JSON, then an attacker can just add adding a high-bit character in the
referrer will make all your requests not get logged to the final
destination.  Very Handy!  Yes the original log line is still present
but that's not what the target system is using for alerting or
monitoring.

Alternative you could alert on improper JSON lines.  Ideally a working
browser shouldn't be sending non-URL-encoded characters.

Interesting Ruby does not seem to do any JSON un-escaping.  "\v\x12"
in the log line, is "\v\x12" in the output.  So there are not
problems.  I'm not that familiar with Ruby, so I can't tell if this is
smart-lazy or sloppy programming, but here, in this case, there is not security issue.

For python and PHP, invalid JSON encoding causes the log line to not
be parsed.  Either you have to handle this or do pre-processing. I
assume Java works the same.

I didn't test Perl or other libraries.

Can we make Apache emit 100% JSON?
----------------------------------------

Can we change Apache (or extend it) to log in pure JSON?  Certainly
using `\x13` instead of `\v` would eliminate an exception.

We don't really know what character set is being used (if any), but
for high bit characters we emit "\u0090" instead of "\x90".  This
works since *unicode* has the same encoding as Latin-1.  (note UTF-8
is NOT the same as Latin-1).

If anyone is interesting on developing a patch with me, let me know.

What about performance?
------------------------

JSON is not without some costs.  Parsing JSON is fast but typically
more expensive than regular expressions (not quite fair comparison
since the regular expression is often converted into a hash-table of
some type).

This could be improved by a Simple JSON processor designed for logging:

* Everything is on one line.
* No un-escaping (like Ruby)
* No parsing of integers or floating point numbers.  Everything is a string.  Numeric literals will be treated like a string.
* No arrays.
* No dictionaries or hash tables (other that the initial one).

Basically it's just a hash table / dictionary / map of string keys, and string values.

This means `"12"` and `12` would produce identical output.

Conclusion
------------------

Do it.

I've been using the JSON format for a while.  The preprocessing step
is annoying, but really not a big deal.  I don't have a performance
critical ETL, so performance of JSON processing isn't a problem.  It's
fast enough.

Some ProTips:

* Keep your JSON format simple and flat.  Adding arrays or sub-hashtables may seem useful but really just generates overhead and complexity.  Just because you can add more structure doesn't mean you should.
* Use a timestamp (unix epoch or equivalent) instead of a text format.  Parsing date formats actually is quite expensive so either keep it to format your end-target knows natively, or use unix epoch.  Avoid manually trying to parse it.
* Alert on errors in processing -- something very strange is going on and need investigating.
* Delete all those gross regexp you where using.
* Profit!

Got comments?  Send me email, and I'll post them here.
