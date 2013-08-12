---
layout: post
updated: 2008-01-15
alias: /2008/01/project-for-u-liveblogging-clientserver.html
title: Project for U LiveBlogging Client/Server
---

It's that time of year again.  MacWorld 2008 is just about to start
and already all of the liveblogging sites are clogged.  Some are
completely down due to demand.  Others force you do hit reload, which
fails 50% of the time.  Why doesn't a good liveblogging client/server
exist?

Here's what you'd need and other random notes:

* A simple client library that does a poll to the server asking for
  everything since "last update" and updates the page appropriately
  (incremental).  A little icon saying when next poll is, that a
  network connection is happing would be swell.  If the "event" is
  over, then it knows to stop sending the request.
* The server is more interesting.  First you need a way of publishing
  (writing) data and no matter how busy the server is, the publisher
  must be able to get in.  This probably means two servers to be
  absolutely sure, but who knows.
* The ability to add more front end servers.
* A ridiculously fast HTTP server.  As a goal a single server should
  do about 10k connections per SECOND.  If you poll once a minute this
  hopefully will be able to serve 50k people per box.
* Event-driven http is probably the way to go since you are going to
  be I/O bound, not CPU bound, but you could start with anything
  server for kicks and swap out the server as you go.
* You could use fixed-size message block internally, say 1-4k, to make
  memory or file lookups easy.  (e.g. append to the file, then the
  clients can stat the file and read from the end and go backwards to
  get the updates). Or something</li>
* A very fast time out.. any client taking more than a second, or even
  less, should get the boot!
* You get the idea

It's a good project to work since you'll be able to work with all the
fun stuff you normally don't get to do fool around with. It's not much
of a *business* but who knows.  Start with an open source and then do
consulting and then hosting.  If anyone is hell bent on doing this,
let me know!

Note: [CoverItLive](http://coveritlive.com/) appears to do this, but
uhhh, not so well, since it's front door says it's out of capacity