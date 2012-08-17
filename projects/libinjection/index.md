---
layout: page
title: libinjection
summary: "libinjection: a c library of high-speed detection of SQLi in user input"
alias: libinjection
---

`libinjection` is a C library (and soon a python port) that detects
SQLi attacks in user input.  It is designed to be embedded in existing
or new applications:

* Fast > 100k inspections per second
* No memory allocation
* No threads
* Stable memory usage (approximately 500 bytes on stack)
* 1000 lines of code (plus a few kiobytes of data)

It is based on lexical analysis of SQL and SQLi attempts and does not
use regular expressions.

A python port is planned and ports to other languages should not be difficult.

## Source Code ##

[https://github.com/client9/libinjection](https://github.com/client9/libinjection)

Note that it currently depends on [stringencoders](stringencoders/)
library.  We are working on removing this requirement.

License: I'm temporarily using GPLv2 to force commericial interests to
get in contact.  If this license is a problem, please get in contact.
The goal is to get this used, and not create a legal problem, and I'm
happy to relicense.

### Presentations ###

#### [libinjection: a C library for SQLi detection and generation through lexical analysis of real world attacks](/2012/07/25/libinjection/) ####
First presented at [Black Hat USA, July 25, 2012, 2:45 PM](https://www.blackhat.com/html/bh-us-12/bh-us-12-briefings.html#Galbreath)

#### [New techniques in SQL Obfuscation: SQL never before used in SQLi](/2012/07/27/new-techniques-in-sql-obfuscation/) ###

Research based on libjection, first presentated at [DefCon 20, July 27, 2012, 4:20pm](http://defcon.org/html/defcon-20/dc-20-speakers.html#Galbreath)

### More More More ###

Code-coverage report coming soon.

### Elsewhere ###

On [reddit](http://www.reddit.com/r/netsec/comments/x5pmr/libinjection_c_library_to_detect_sqli_attacks/)
