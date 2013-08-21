---
layout: post
title: libinjection 3.5.0 released
---

Version 3.5.0 of [libinjection](https://libinjection.client9.com/),
the open source SQLi detection library, was released today, 2013-08-21.  [Source code is available on github](https://github.com/client9/libinjection/).   If you want to try it out, see the [diagnostics pages](https://libinjection.client9.com/diagnostics).

It's a big change.  The quick summary is:

* better detection of "exotic" SQLi attacks (using dark corners of the SQL spec or parser bugs)
* better false positive detection
* improvements in software engineering

As always, it's likely some of these changes was may have caused a regression or exposed a new bypass.  If you find anything, please send me an email, [a bug report on github](https://github.com/client9/libinjection/issues?state=closed), or [tweeet tweet away](https://twitter.com/NGalbreath).  I'll add it to the [automated tests](https://libinjection.client9.com/cicada/), and update the [bypass clock](https://libinjection.client9.com/days-since-last-bypass).

Here's the [changelog](https://github.com/client9/libinjection/blob/master/CHANGELOG.md):

v3.5 -- 2013-08-21
------------------------
* Bug fix for `libinjection_sqli_reset` [@brianrectanus](https://twitter.com/brianrectanus) [pull/50](https://github.com/client9/libinjection/pull/50)
* Non-critical parser fix for numbers with Oracle's ending
  suffix.  `SELECT 1FROM ..` is `(SELECT, 1, FROM)` not
  `(SELECT, 1F, ROM)`
* Yet another fix for disambiguating Oracle's "f" suffix for numbers HT [@LightOS](https://twitter.com/LightOS)
* Better parsing of generated number forms of `10.e` and `10.10e`
  (these are actually table specifiers!) HT [@LightOS](https://twitter.com/LightOS)
* Change sizing of some static arrays to have a length >= 8
  For GCC based applications, this allows `-fstack-protector` to work
  and `-Wstack-protector` will now not emit errors.
* Added `-fstack-protector-all -D_FORTIFY_SOURCE=2` to default CFLAGS.
  About 10% performance loss with `-fstack-protector-all`
* Improvements in reducing false positives, HT [@modsecurity](https://twitter.com/modsecurity) team
* Add fingerprint, HT [@FluxReiners](https://twitter.com/FluxReiners)
* Support for parsing of old ODBC-style typing, e.g. `select {foo 1};` (valid in MySQL)
* Fix tokenization of `IF EXISTS(....`, `IF NOT EXISTS(...`
* Fix possible stack over-read, and improve detection of `sp_password` flag
  in short sqli HT [@modsecurity](https://twitter.com/modsecurity) team
