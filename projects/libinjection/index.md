---
layout: page
title: libinjection
summary: "libinjection: a c library of high-speed detection of SQLi in user input"
alias: libinjection
---

`libinjection` is a C library that detects SQLi attacks in user input.
It is designed to be embedded in existing or new applications:

* Fast > 100k inspections per second
* No memory allocation
* No threads
* Stable memory usage (approximately 500 bytes on stack)
* 500 lines of C code (plus a few kiobytes of data)

It is based on lexical analysis of SQL and SQLi attempts and does not
use regular expressions.

A python port is planned and ports to other languages should not be difficult.

## Source Code ##

[https://github.com/client9/libinjection](https://github.com/client9/libinjection)

License: BSD

### Presentations ###

#### [libinjection and SQLi Obfuscation](/2012/09/20libinjection-and-sqli-obfuscation/) ####

First presented at OWASP NYC at DTCC's headquarters at 55 Water Street in NYC on September 20, 2012.

#### [libinjection: New Techniques for Detecting SQLi Attacks](/2012/09/06/libinjection-new-techniques-in-detecting-sqli-attacks/) ####

First presented at [iSEC Partners](http://isecpartners.com/) Open Forum, at [Gilt Group](http://www.gilt.com/) headquarters in New York City on September 6, 2012

#### [libinjection: a C library for SQLi detection and generation through lexical analysis of real world attacks](/2012/07/25/libinjection/) ####

First presented at [Black Hat USA, July 25, 2012, 2:45 PM](https://www.blackhat.com/html/bh-us-12/bh-us-12-briefings.html#Galbreath)

#### [New techniques in SQL Obfuscation: SQL never before used in SQLi](/2012/07/27/new-techniques-in-sql-obfuscation/) ###

Research based on libjection, first presentated at [DefCon 20, July 27, 2012, 4:20pm](http://defcon.org/html/defcon-20/dc-20-speakers.html#Galbreath)

### More More More ###

Code-coverage report coming soon.

### Elsewhere ###

On [reddit](http://www.reddit.com/r/netsec/comments/x5pmr/libinjection_c_library_to_detect_sqli_attacks/)
