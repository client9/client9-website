---
layout: post
title: libinjection v3.9.0 released
---

The Black Friday 3.9.0 edition of [libinjection](https://libinjection.client9.com/), the open source SQLi detection library, was released today, 2013-11-29. [Source code is available on github](https://github.com/client9/libinjection/). If you want to try it out, see the [diagnostics pages](https://libinjection.client9.com/diagnostics).

The big news is that `libinjection.h` now contains a super-simple C api.  The "old" API is in `libinjection_sqli.h`.  It's likely you can just change `#include "libinjection.h` to `#include "libinjection_sqli.h` and everything will work.  Although I recommend using the new API, as it will simplify your life.   Other changes were made to the header file, but mostly to make it easier for using [Foreign Function Interface](http://cffi.readthedocs.org/).  They shoudn't cause any compatibility issues, but let me know if they do.

In other news, a lot of other bypasses are fixed, and some dead fingerprints are removed (i.e. fingerprints that aren't SQLi).  I'm pleased the bypasses are becoming fewer in numbers, and the ones coming in are getting weirder.  This is good.

And finally, this release also has have a good number of documentation, website, and QA improvements where made as well.  Here's the full [changelog](https://github.com/client9/libinjection/blob/master/CHANGELOG.md)

# v3.9.0 - 2013-11-29

Black Friday Edition

* Big API Change!! everything in `libinjection.h` is now `libinjection_sqli.h`.  And a new super simple API is in `libinjection.h`
* Improvements to folder to prevent bypasses using SQL types (casts).  This eliminated about 400 fingerprints as well.
* Blacklisted a very degenerate MySQL ODBC case, that is highly unlike to be used in 'real inputs'. thanks to @LightOS foreporting.. not clear who found it originally.
* Over 400 unit tests now!
* Compiles clean under clang with `-Weverything -Wno-padded`   `-Wno-padded` is excluded since it's architecture dependant.   See `clang.sh` to see how to invoke.
* PHP documentation fixes, thanks @LightOS

Enjoy!

nickg
