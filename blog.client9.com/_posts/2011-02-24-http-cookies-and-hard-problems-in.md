---
layout: post
updated: 2011-10-16
alias: /2011/02/http-cookies-and-hard-problems-in.html
title: HTTP Cookies and Hard Problems in Computer Science
---
<blockquote>
<span class="Apple-style-span" style="font-family: inherit;"><a href="http://www.blogger.com/%E2%80%9Chttp://www.tbray.org/ongoing/When/200x/2005/12/23/UPI%22">There are only two hard things in Computer Science: cache invalidation and naming things</a> </span></blockquote>
<span class="Apple-style-span" style="font-family: inherit;">or </span><br />
<blockquote>
<span class="Apple-style-span" style="font-family: inherit;"><a href="http://twitter.com/kellan/status/11110460227">There are 2 hard problems in computer science: caching, naming, and off-by-1 errors</a> </span></blockquote>
<span class="Apple-style-span" style="font-family: inherit;"><br /></span><br />
<span class="Apple-style-span" style="font-family: inherit;">With HTTP cookies we get all three. Upgrading your cookie metadata such as the domain and security attributes can frequently lead to duplicate values being passed in and weird data shadowing problems (delete one value, and another shines through).   And upgrading the format of the data in the cookie value is dangerous since there is no rollback with out severe data loss. However by treating the cookie formats/metadata as a row in a <a href="http://en.wikipedia.org/wiki/Multiversion_concurrency_control">MVCC</a> database, a lot of pain can go away. The analogy isn't quite exact, but helps illustrate the ideas. </span><br />
<span class="Apple-style-span" style="font-family: inherit;"><br /></span><br />
<b><span class="Apple-style-span" style="font-family: inherit;">Cache Invalidation -- Upgrading Cookies</span></b><br />
<span class="Apple-style-span" style="font-family: inherit;"><br /></span><br />
<span class="Apple-style-span" style="font-family: inherit;">Cookies are "the most distributed user database."   Upgrading is somewhat painful as you don't know when someone is going back to your site with an old outdated version, or with a crappy browser.  (Ok this isn't quite cache invalidation, but close enough.  I can't directly cleanout everyone's old cookie on demand.  I have to wait for them to show up.) </span><br />
<span class="Apple-style-span" style="font-family: inherit;"><br /></span><br />
<span class="Apple-style-span" style="font-family: inherit;">Lots of people put a version number in a cookie value to aid in doing an upgrade.  This is certainly useful but if there is a screwup (frequently caused by one of the domain issues described below), you just over-wrote your old data.  No going back now with out data loss.</span><br />
<span class="Apple-style-span" style="font-family: inherit;"><br /></span><br />
<b><span class="Apple-style-span" style="font-family: inherit;">Naming -- The Asymmetric Protocol</span></b><br />
<span class="Apple-style-span" style="font-family: inherit;"><br /></span><br />
<span class="Apple-style-span" style="font-family: inherit;">The <a href="http://curl.haxx.se/rfc/cookie_spec.html">HTTP Cookie protocol</a> we all know and love is woefully asymmetric.  As a server, you use <code>Set-Cookie</code> and provide the name/value, expiration, domain, the path, if it's secure or not, and if it's http-only or not, but the incoming <code>Cookie</code> header only has the name and value.  You loose all the other stuff. </span><br />
<span class="Apple-style-span" style="font-family: inherit;">To make it more interesting is that you can get multiple values back for the same name.  How so?</span><br />
<span class="Apple-style-span" style="font-family: inherit;"><br /></span><br />
<pre><span class="Apple-style-span" style="font-family: inherit;">Set-Cookie: foo=bar; domain=www.client9.com; path=/
Set-Cookie: foo=goo; domain=.client9.com; path=/
</span></pre>
<span class="Apple-style-span" style="font-family: inherit;"><br /></span><br />
<span class="Apple-style-span" style="font-family: inherit;">can result in the client returning: </span><br />
<span class="Apple-style-span" style="font-family: inherit;"><br /></span><br />
<pre><span class="Apple-style-span" style="font-family: inherit;">Cookie: foo=bar; foo=goo
</span></pre>
<span class="Apple-style-span" style="font-family: inherit;"><br /></span><br />
<span class="Apple-style-span" style="font-family: inherit;">(and perhaps not in this order).  To make it more interesting, most web platforms  provide the application with an associative array of cookies (for instance <a href="http://php.net/manual/en/reserved.variables.cookies.php">PHP's $_COOKIE</a>), meaning, it's picking one of those cookies to present back to you.   You have no way of knowing which one you are getting. </span><br />
<span class="Apple-style-span" style="font-family: inherit;"><br /></span><br />
<span class="Apple-style-span" style="font-family: inherit;">The same issue can occur also with the cookie <code>path</code> as well.  However, I strong recommend you just set path to "/".  It creates needless complication, and fine grain logic is best handled by the application. (&gt;And another.  While I'm not certain, a different type of problem occurs when switching a cookie from "plain" to <code>secure</code> only SSL.)</span><br />
<span class="Apple-style-span" style="font-family: inherit;"><br /></span><br />
<span class="Apple-style-span" style="font-family: inherit;">If you go this far, you might be thinking, "yeah, but why would ever use the same name twice for overlapping domains".  It happens.  You switch your canonical domain name from "www.client9.com" to "client9.com" or vice versa.  Or the site is growing fast and people are slapping cookies everywhere sometimes using different cookie domains, and then at some point you need to consolidate.   Or you starting using subdomains for something unanticipated. <i>It happens.</i>  </span><br />
<span class="Apple-style-span" style="font-family: inherit;"><br /></span><br />
<span class="Apple-style-span" style="font-family: inherit;">And if it happens, it's tricky to fix.  You get two (or more) cookies with the same name - you you aren't sure how to delete them unless you know exactly how they were originally set.  Which by now is probably lost or buried in your source control log, somewhere.</span><br />
<span class="Apple-style-span" style="font-family: inherit;"><br /></span><br />
<b><span class="Apple-style-span" style="font-family: inherit;">Solution: Duplicate your Metadata</span></b><br />
<span class="Apple-style-span" style="font-family: inherit;"><br /></span><br />
<span class="Apple-style-span" style="font-family: inherit;">The solution to all of this is oddly simple looks wasteful and looks like it looks like it violates the <a href="http://www.blogger.com/blogger.g?blogID=8885167082319491081">DRY principal</a>.  And the cookie protocol is so wacky is hard to see that it's really a database row and you can <a href="http://en.wikipedia.org/wiki/Multiversion_concurrency_control">MVCC</a> on it (well, <i>almost</i>). </span><br />
<span class="Apple-style-span" style="font-family: inherit;"><br /></span><br />
<span class="Apple-style-span" style="font-family: inherit;">To fix the upgrade pain, you add a version in the <i>name</i> of the cookie.  You are free to put another version in the value of the cookie too of course, but in the name is really important.  When you upgrade the cookie value format, or when you change any of the meta data of the cookie (secure or not secure, httponly, the domain), you increment the version.  This is just like writing a new row in a MVCC database.</span><br />
<span class="Apple-style-span" style="font-family: inherit;">On update you can leave the old cookie alone, and write the code to do the upgrade.  If you launch and fail, no problem, you can rollback and the old data is still there.  If it works, you can write your <a href="http://www.postgresql.org/docs/9.0/static/sql-vacuum.html">VACUUM</a> code, which deletes the old cookie or the broken new cookie when it sees it.  Or at some point they'll expire on their own.</span><br />
<span class="Apple-style-span" style="font-family: inherit;"><br /></span><br />
<span class="Apple-style-span" style="font-family: inherit;">Now to fix the duplicate values.  Here we add to cookie name, the domain the cookie was set to, if it's secure and if's it http-only.  We add all this since it segments the namespace so it's impossible for one to get duplicate cookies.   It looks gross, but cookies aren't here to win beauty contests.</span><br />
<span class="Apple-style-span" style="font-family: inherit;"><br /></span><br />
<pre><span class="Apple-style-span" style="font-family: inherit;">Set-Cookie: foo-v1-0-1-.client9.com; ....
</span></pre>
<span class="Apple-style-span" style="font-family: inherit;"><br /></span><br />
<span class="Apple-style-span" style="font-family: inherit;">There isn't anything special about this format, but here <code>foo</code> is the original name, <code>v1</code> is the version, and the next two bits say if was set with <code>secure</code> (in this case no) or <code>httponly</code> (in this case yes), and finally the domain.  Keeping track of <code>secure</code>, <code>httponly</code> isn't necessarily as the version could tell you that indirectly, but I find it useful for at a glance inspection.  It also completely self-describes the cookie and provides everything you need to be able to delete the cookie correctly.  Expiration is not encoded, but that's ok.  </span><br />
<span class="Apple-style-span" style="font-family: inherit;"><br /></span><br />
<b><span class="Apple-style-span" style="font-family: inherit;">Off-By-One: If you are using PHP...</span></b><br />
<span class="Apple-style-span" style="font-family: inherit;"><br /></span><br />
<span class="Apple-style-span" style="font-family: inherit;">And of course if you are using PHP, an "undocumented feature" is turning "." into "_" in the cookie name.  So the cookie above in <code>$_COOKIE</code> will be</span><br />
<span class="Apple-style-span" style="font-family: inherit;"><br /></span><br />
<pre><span class="Apple-style-span" style="font-family: inherit;">foo-v1-0-1-_client9_com
</span></pre>
<span class="Apple-style-span" style="font-family: inherit;"><br /></span><br />
<span class="Apple-style-span" style="font-family: inherit;">Sigh.</span>