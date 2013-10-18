---
layout: post
title: libinjection v3.8.0 released
---

Version 3.8.0 of [libinjection](https://libinjection.client9.com/), the open source SQLi detection library, was released today, 2013-10-13. [Source code is available on github](https://github.com/client9/libinjection/). If you want to try it out, see the [diagnostics pages](https://libinjection.client9.com/diagnostics).

The main feature is parsing correctly MySQL's use of %%A0 as whitespace in it's default `latin1` configuration.  This is tricky since we don't want to detect A0 when it's used in UTF-8 as part of a larger word.   Feedback and false-positives from non-English SQLi would be most welcome!

Here's the full [changelog](https://github.com/client9/libinjection/blob/master/CHANGELOG.md)

# v3.8.0 - 2013-10-18

LAMP Special Edition: MySQL and PHP improvements

* [Issue #33](https://github.com/client9/libinjection/issues/54) Fixes MySQL in latin1-mode use of `%A0` as whitespace.  This was tricky since `%A0` might be part of larger UTF-8 encoding as well.  Or perhaps `%C2%A0` (utf-8 encoding) might be treated as whitespace.  Fortunately, MySQL only seems to treat `%A0` as whitespace in latin1 mode.   HT [@ru_raz0r](https://twitter.com/ru_raz0r)
* Fixes to Lua testdriver and portability fixes
* Much improved PHP build and test.  It now uses `phpize` and builds and tests like a real module.
* API CHANGE:  the macro `LIBINJECTION_VERSION` has been replaced by `const char* libinjection_version()`.  This allows us to increment the version number without having to regenerate SWIG (or other) bindings for minor releases.

NOTE:
Pregenerated [SWIG](http://www.swig.org/) bindings are removed.  You'll need to install SWIG before running `make`.  SWIG is packaged on virtually every OS so this should not be a problem.

Here's why:

* Latest versions of swig appear to generate poor quality bindings for LUA and Python.  Bugs are filed upstream [1341](https://sourceforge.net/p/swig/bugs/1341/), [1343](https://sourceforge.net/p/swig/bugs/1343/), [1345](https://sourceforge.net/p/swig/bugs/1345/).  These are fixed or will be fixed in swig 3.0.0.
* In addition, I've recieved a number of reports of generated code failing various static analysis
* I can't triangulate which SWIG for which langauge for which OS will work for you
* I may be switching to [libffi](http://cffi.readthedocs.org/) for python, and [luajit.ffi](http://luajit.org/ext_ffi.html) for lua(jit) in the future, anyways.

Enjoy!

nickg
