---
layout: post
updated: 2009-06-12
alias: /2009/06/serving-precompressed-static-content.html
title: Serving Precompressed Static Content with Apache
---
<h4> Using <tt>mod_negiotiation</tt></h4>

<P>It's pretty simple but has a big gotcha</p>

<p>First, edit your <tt>mine.conf</tt> file, and uncomment or add: </p>
<pre>
AddEncoding x-compress .Z
AddEncoding x-gzip .gz .tgz
</pre>
<p>
and if you use Indexes comment out:
</p>
<pre>
#AddType application/x-compress .Z
#AddType application/x-gzip .gz .tgz
</pre>
<p>
then add  <code>Options MultiViews</code> to any <code>Directory</code> that has compressible content.
</p>

<p>Now compress your content.  Hack the following as needed: </p>
<pre>
for file in *.js; do
    echo "gzipping $&#123;file&#125;"
    gzip -9 -c $file > $&#123;file&#125;.gz;
done
</pre>

<p>Ok now you are all set, except for one thing</p>

<p><b>You have to get rid of the suffix on your URLs</b>.  For example, if you have:

<pre>
&lt;link src ="foo.css"&gt;
</pre>
You have to change it to:

<pre>
&lt;link src ="foo"&gt;
</pre>

<p>Grump.  I don't really like that.  The good news is that the old links (with the suffix) still work, but aren't compressed.</p>

<h4> mod_rewrite </h4>

<p>
Smart guy <a href="http://mark.aufflick.com/">Mark Aufflick</a> figure it out <a href="http://mark.aufflick.com/blog/2007/12/06/serve-pre-compressed-content-with-apache">another way</a> using <a href="http://httpd.apache.org/docs/2.2/mod/mod_rewrite.html">mod_rewrite</a>.
</p>
<p>
It's a slight differently method.  You are making new mine types  <code>.jsgz</code> and <code>.cssgz</code> and telling apache explicitly what they are.  The compressor script is slightly different. The output should be <code>foo.jsgz</code> not <code>foo.js.gz</code>
</p>
<pre>
for file in *.js; do
    echo "gzipping $&#123;file&#125;"
    gzip -9 -c $file > $&#123;file&#125;gz;
done
</pre>

<p>
Add these to your <code>apache2.conf</code> or <code>http.conf</code>.  This sets up the new mime types:
</p>

<pre>
AddType "text/javascript;charset=UTF-8" .jsgz
AddEncoding gzip .jsgz
AddType "text/css;charset=UTF-8" .cssgz
AddEncoding gzip .cssgz
</pre>

<p>Then add the gzip-if-client-can-do-it command:</p>
<pre>
&lt;Directory "/YOUR/DIRECTORY/WITH/js"&gt;
RewriteEngine on
RewriteCond %&#123;HTTP:Accept-Encoding&#125; gzip
RewriteRule (.*)\.css$ $1\.cssgz [L]
&lt;/Directory&gt;
</pre>

<p>etc..  ta-da!  Now do the same thing with your CSS. </p>