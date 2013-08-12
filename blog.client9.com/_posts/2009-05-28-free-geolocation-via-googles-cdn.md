---
layout: post
updated: 2009-05-28
alias: /2009/05/free-geolocation-via-googles-cdn.html
title: Free geolocation via Google's CDN
---
<p>
Google is now hosting a variety of popular javascript libraries on it's CDN under the name of lovely name of "<a href="http://code.google.com/apis/ajaxlibs/">Google AJAX Library API</a>".    The benefits of having Google hosting common code should be clear so I'm not going to babble about  it.
</p>

<p>What this document does not tell you is that you get free geolocation with it.  This fact is hidden in the similarly named "<a href="http://code.google.com/apis/ajax/">Google AJAX API</a>" (not missing "library").  These are common APIs for Google websites, but lookee here: <a href=" http://code.google.com/apis/ajax/documentation/#ClientLocation">Client Location</a>  (and of 2009-05-29, "New").</p>

Add:
<pre>
&lt;script src="http://www.google.com/jsapi" type="text/javascript"&gt;&lt;/script&gt;
</pre>

And the following is filled out (or is null if they can't figure it out):
<ul>
<li>google.loader.ClientLocation.latitude</li>
<li>google.loader.ClientLocation.longitude</li>
<li>google.loader.ClientLocation.address.city</li>
<li>google.loader.ClientLocation.address.country</li>
<li>google.loader.ClientLocation.address.country_code</li>
<li>google.loader.ClientLocation.address.region<li>
</ul>

*****
Comment 2009-05-29 by None

No idea how you find time to blog. I gotta get started on that.
