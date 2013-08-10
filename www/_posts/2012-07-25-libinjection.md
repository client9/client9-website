---
layout: page
tags: ["presentations"]
title: "libinjection: a C library for SQLi detection and generation through lexical analysis of real world attacks."
summary: "libinjection: a C library for SQLi detection and generation through lexical analysis of real world attacks.  First presented on July 25, 2012 at Black Hat USA, Las Vegas."
og-image: "/assets/2012_bhb_ul3.jpg"
conf-location: "Las Vegas, NV, USA"
conf-name: "Black Hat USA"
conf-date: "2012-07-25"
alias: "20120725"
---

See the [libinjection](/projects/libinjection/) project page for more details.

First presented [Wednesday July 25, 2012 at Black Hat USA, Las Vegas,
NV.  Augustus I/II at 2:45pm](https://www.blackhat.com/html/bh-us-12/bh-us-12-briefings.html#Galbreath).

{{ 13621872 | slideshare }}

---

{{ "/assets/2012_bhb_ul3" | videojs }}

---

Original Abstract

> SQLi and other injection attacks remain the top OWASP and CERT
> vulnerability. Current detection attempts frequently involve a myriad
> of regular expressions which are not only brittle and error prone but
> also proven by Hanson and Patterson at Black Hat 2005 to never be a
> complete solution. libinjection is a new open source C library that
> detects SQLi using lexical analysis. With little upfront knowledge of
> what SQLi is, the algorithm has been trained on tens of thousands of
> real SQLi attacks and hundreds of millions of user inputs taken from a
> Top 50 website for high precision and accuracy. In addition, the
> algorithm categorizes SQLi attacks and provides templates for new
> attacks or new fuzzing algorithms. libinjection is available now on
> github for integration into applications, web application firewalls,
> or porting to other programming languages.

Nice shoutout from [Veracode's blog](http://www.veracode.com/blog/2012/07/veracode-research-at-blackhat-2012/) on what to see at Black Hat 2012:

> “Libinjection: A C library for SQLi Detection and Generation Through
> Lexical Analysis of Real World Attacks”. Comments: “Although there’s
> been some nifty research in mitigation and prevention of SQL
> injection at the language/compiler/API level, there’s been a strong
> tendency for people to publish a PoC and let it languish. The
> description appears to be aimed straight at app developers, which is
> great.”

See the [libinjection](/projects/libinjection/) project page for more details.