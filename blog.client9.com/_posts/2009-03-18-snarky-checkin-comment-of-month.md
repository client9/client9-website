---
layout: post
updated: 2009-03-18
alias: /2009/03/snarky-checkin-comment-of-month.html
title: Snarky checkin comment of the month
---
<p>
I've been hacking on the <a href="http://www.mozilla.org/js/spidermonkey/">Spidermonkey</a> javascript engine and have been keeping up with the changes.  I also recently bumped into the bizarreness that Windows doesn't define the what-I-thought-was-standard header file <code>stdint.h</code>.  Both are combined in this check in comment.  The MS response is pretty sad.
</p>

<p>Via <a href="http://hg.mozilla.org/mozilla-central/pushloghtml?changeset=5917a57686c3">http://hg.mozilla.org/mozilla-central/pushloghtml?changeset=5917a57686c3</a>

<pre>
Bug 479258: Don't define <stdint.h> types in public headers. r=brendan

On systems that don't have <stdint.h> (i.e., Microsoft, which is
tragically underfunded and cannot spare the resources necessary to
provide and support this header: <a href="http://tinyurl.com/absoh8">http://tinyurl.com/absoh8</a>),
SpiderMonkey header files should not introduce definitions for these
types, as doing so may conflict with client code's attempts to provide
its own definitions for these types.
</pre>