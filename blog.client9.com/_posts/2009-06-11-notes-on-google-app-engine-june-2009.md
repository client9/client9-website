---
layout: post
updated: 2009-06-11
alias: /2009/06/notes-on-google-app-engine-june-2009.html
title: Notes on Google App Engine June, 2009
---
<p>For a personal project I started to use Google's App Engine.  The application is a bit non-traditional in that is requires a good amount of batch data to be send to the server regularly and a good amount of the data needs to be deleted as well.</p>

<h2>Constraints</h2>

<p>
I can't remember where: but  each request better take less than 1M in memory and take less than 2-3 seconds to complete.  For a normal webby app that should be fine.   Anything requiring service more than that will be painful to do.  Everything is a "web request".. meaning if you have admin work, it's a URL,  and the http request better complete in a second or two, else it will be cut off.
</p>

<h2>Good News</h2>

<p>I didn't find using the datastore particularly confusing or restrictive (mostly, see below).  One may need to create indexes or keys a bit different than one might in normal SQL, but over all it works well</p>

<p>The python performance is great.   Content gets compressed and served from Google's CDN.</p>

<p>Lot of tools, dev-kits, consoles and monitoring.</p>

<p>I suspect that the app runs from a distributed set of geographically distributed nodes (a CDN for the app).  That's hot</p>

<h2>The Bad News</h2>

<p>
App Engine is really <i>bad</i> for bulk uploads.  It's fine for the first-time uploads, but not so great for regular updates and downloads.  They have a nice remote_api but things time out in under 5 seconds.  To work around this, they have a bunch of tools that splits up uploads in numerous parallel requests.   It works "mostly" well, but even modest uploads can consume -10% of your quota. 
</p>

<P>There is no batch delete; you have to make a web request to delete a chunk of data and keep going until there is no more data.  I finally gave up on App Engine, when deleting a whole 500 records (small, with no indexes) can't be completed in 5 seconds.</p>

<p>And then there is the python issues.  Really it's not bad, but if your existing code is in 2.6 you may find it annoying to downgrade to 2.5 (the only version Google supports).   Any extension that uses a C-library or uses the local filesystem is off limits too (e.g. no Sqlite3 -- you must use their data store)</p>

<p> The local development AppEngine that runs locally is <i>really</i> slow, and doesn't enforce the same constraints as the live version.
</p>

<h2> What it's good for</h2>

<p>
You probably know this already.  It good for user based apps where most of the data is created organically.   It's not good for data processing and things involving bulk uploads.  I knew this too, but wanted to see if could bend my app to use google's infrastructure. Sadly it's not a fit.
</p>

<p>IIf you have a webby application that matches App Engine's sweet spot , I would high recommend it.</p>