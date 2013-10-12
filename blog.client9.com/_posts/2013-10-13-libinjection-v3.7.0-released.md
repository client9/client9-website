---
layout: post
title: libinjection v3.7.1 released
---

Version 3.7.1 of [libinjection](https://libinjection.client9.com/), the open source SQLi detection library, was released today, 2013-10-13. [Source code is available on github](https://github.com/client9/libinjection/). If you want to try it out, see the [diagnostics pages](https://libinjection.client9.com/diagnostics).

This release contains an important security update and closes numerous false-negatives:

* Fixes a buffer over-read.  This went undetected due to a GCC option that (incorrectly?) disables some automated memory checkes.  You can read more on this [other blog post](http://blog.client9.com/2013/10/12/gcc-valgrind-stackprotector.html).  This may cause core-dumps and other nastyness on long inputs.
* Parses MS SQLServer \[bracket\] quoting for table and column names.  This closes a lot of false-negatives.
* Other improvements and fixes to reduce false-negatives.

Here's the full [changelog](https://github.com/client9/libinjection/blob/master/CHANGELOG.md)

* [Issue #54](https://github.com/client9/libinjection/issues/54): Add test vectors from [Arne Swinnen](http://www.arneswinnen.net/2013/09/automated-sql-injection-detection/). Thanks [qerub@github](https://github.com/qerub)
* Minor fingerprint update for [Issue #54](https://github.com/client9/libinjection/issues/54).  I don't really think it's valid SQL but it's safe enough to detect without false positives.
* [Issue #55](https://github.com/client9/libinjection/issues/55): Parse MS SQLSERVER use of \[brackets\] for column and table names. This is a big one that closes a lot of holes.  Thanks [nroggle@github](https://github.com/nroggel)
* [Issue #56](https://github.com/client9/libinjection/issues/56): fix buffer over-read.  Thanks [safe3@github](https://github.com/Safe3) and [flily@github](https://github.com/flily)
* Remove use of `-fstack-protector` as it breaks valgrind detecting memory problems
  Read more about it http://blog.client9.com/2013/10/12/gcc-valgrind-stackprotector.html
* Fixed folding issue where `1,-sin(1))` would be folded as `1 (1)`
* Add more test cases and improved test coverage to [98.8%](https://libinjection.client9.com/cicada/artifacts/libinjection-coverage-unittest/lcov-html/c/libinjection_sqli.c.gcov.html)


3.7.1 was released right after 3.7.0.  This just removed some dead code.

Enjoy!

nickg
