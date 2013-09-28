---
layout: post
title: libinjection 3.6.0 released
---

Version 3.6.0 of [libinjection](https://libinjection.client9.com/), the open source SQLi detection library, was released today, 2013-09-12. [Source code is available on github](https://github.com/client9/libinjection/). If you want to try it out, see the [diagnostics pages](https://libinjection.client9.com/diagnostics).

The quick summary is:

* Big detection improvements mostly due to code contributions from
  Reto Ischi (no Twitter!!) and some other anonymous people.
* [New PHP module](https://github.com/client9/libinjection/blob/master/php/).  Detect SQLi from inside your PHP application.  HT to [@marpaia](https://twitter.com/marpaia) for testing and moral support. Check out the [example code](https://github.com/client9/libinjection/blob/master/php/example.php)
* Possible API or recompile will be needed due to adjust in how typedef and structs were defined. This was required for [SWIG](http://swig.org/).   Let me know if you need help with the transition (really no changes -should- be needed).
* Code coverage tests are now at [98.0%](https://libinjection.client9.com/cicada/artifacts/libinjection-coverage-unittest/lcov-html/c/libinjection_sqli.c.gcov.html) Doing this uncovered lots of dead code (now removed) and in general made things better.

As always, it's likely some of these changes was may have caused a regression or exposed a new bypass.  If you find anything, please send me an email, [a bug report on github](https://github.com/client9/libinjection/issues?state=closed),
or [tweeet tweet away](https://twitter.com/NGalbreath).  I'll add it to the [automated tests](https://libinjection.client9.com/cicada/), and update the [bypass clock](https://libinjection.client9.com/days-since-last-bypass).

Here's the [changelog](https://github.com/client9/libinjection/blob/master/CHANGELOG.md):

# v3.6.0 -- 2013-09-12
* New [PHP API](https://github.com/client9/libinjection/blob/master/php/)
* Big fingerprint update
** about 500 new fingerprints added based on fuzzing tests by Reto Ischi
** about 700 impossible, dead fingerprints removed
** adding folding rule for "sqltype sqltype -> sqltype" since
   `select binary binary binary 1` is valid
* Other minor fingerprints added
* -maybe- API change as typedefs and structs were re-arranged for SWIG

# v3.5.3 -- 2013-08-25
* Fingerprint update -- `BETWEEN` operation bypasses
* Fingerprint update -- `ANY/SOME` quasi-function bypasses
* Fixed issue with folding where `1-(2-3)` would fold to "nothing" instead of `1`
* Improved test coverage to [98.0%](https://libinjection.client9.com/cicada/artifacts/libinjection-coverage-unittest/lcov-html/c/libinjection_sqli.c.gcov.html)
* More adjustments to the PHP/MYSQL backtick to reduce false positives

# v3.5.2 -- 2013-08-21
* Fingerprint update.  Credit: Reto Ischi

# v3.5.1 -- 2013-08-21
* found regression in handling of PHP/MySQL backticks.  Tests added
* Dead code removed.
* Improved test coverage to [97.7%](https://libinjection.client9.com/cicada/artifacts/libinjection-coverage-unittest/lcov-html/c/libinjection_sqli.c.gcov.html)
