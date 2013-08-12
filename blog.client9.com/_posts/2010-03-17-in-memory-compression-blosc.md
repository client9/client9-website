---
layout: post
updated: 2010-03-17
alias: /2010/03/in-memory-compression-blosc.html
title: In-memory compression using blosc
---
Just read:

[Why Modern CPUs Are Starving and What Can Be Done About
It](http://www.computer.org/portal/web/computingnow/0310/whatsnew/cise).
The summary is that CPUs are way faster than memory, so memory access
is the performance bottleneck. Ok great, now what.

The author proposes using in-memory compression.  We ain't talking
gzip either.  It's some new fangled algorithm called "blosc".  Read
all about it here http://blosc.pytables.org/

I haven't kicked the tires on it yet, but if you are use shared memory
for a ton of data (sound familiar wink wink), this might allow you to
put more into memory and access it faster.