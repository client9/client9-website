---
layout: post
title: libinjection v3.9.1 released
---

The Day-After-Christmas 3.9.1 edition of [libinjection](https://libinjection.client9.com/), the open source SQLi detection library, was released today, 2013-12-26. [Source code is available on github](https://github.com/client9/libinjection/). If you want to try it out, see the [diagnostics pages](https://libinjection.client9.com/diagnostics).

The change for this release is strict C90 compliance for use in embedded systems, Windows and FreeBSD.   Previously, some C99-isms snuck-in breaking some downstream builds.  See the full [changelog](https://github.com/client9/libinjection/blob/master/CHANGELOG.md) for details.

Enjoy!

nickg


# v3.9.1 - 2013-12-26

Day-After-Christmas Edition

* No functional changes
* Code reverted to strict C90 style to allow builds on embedded systems, Windows and FreeBSD
* For gcc this means `-std=c90 -pedantic`, which seems to simulate Windows behavior on Linux
* Other minor style changes to header files.

