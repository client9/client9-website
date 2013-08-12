---
layout: post
updated: 2007-08-29
alias: /2007/08/editing-png-metadata-from-command-line.html
title: Editing PNG Metadata from the Command Line
---
<p>
You would think in our Web 2.0 universe with it's tagoholics, that PNG image metadata would be used and easy to use. Oddly it's not.  I know everyone is trying to make their PNG files smaller, but a few bytes describing the owner and copyright information isn't going to kill anyone.  Very few (if any) image APIs and GUI applications let you add or edit the metadata and many just erase any that exist.
</p>

<p>
Here's some tips on read and write PNG metadata from the command line.
</p>

<h4> PNG Metadata and ImageMagick</h4>
<p>
Here's how to manipulate metadata to PNG files using <a href="http://www.imagemagick.org/">Image Magick</a>.
</p>

<h5> How to read metadata </h5>

<pre>
identify -verbose FILE.png
</pre>
<p>
This spits out <i>all</i> metadata, user defined or otherwise.
</p>

<h5> How to write metadata </h5>
<pre>
convert INFILE.png -set Title "foobar the great" OUTFILE.png
</pre>

<p>
<code>INFILE</code> and <code>OUTFILE</code> can be the same.
</p>

<h5> Ugly Details </h5>

<p>
ImageMagick can read tTXt and zTXt but I was unable to get iTXt to work.  It could be that I was not writing the iTXt correctly and I'm too lazy to look at their source code.  I'm also told that the libpng does support iTXt yet.
</p>

<p>
While the <a href="http://www.libpng.org/pub/png/spec/1.2/PNG-Contents.html">PNG spec</a> says you can add chunks in just about any order. In practice, you should put the <code>tEXt</code> chunks before the image data.  If you don't, ImageMagick appears to ignore them.
</p>

<h4> Reading PNG Metadata and PIL</h4>

<p>
The <a href="http://www.pythonware.com/products/pil/">Python Imaging Library</a> allows you to <i>read</i> <del>but <i>not write</i> metadata</del>(see below).   In fact, if you save the image, all metadata will be erased.
</p>

<pre>http://www.blogger.com/img/gl.link.gif
$ python
Python 2.5 (r25:51908, Oct  7 2006, 01:04:15) 
Type "help", "copyright", "credits" or "license" for more information.
>>> import Image
>>> img = Image.open("junk.png")
>>> img.info
&#123;'foo': "bar"&#125;
</pre>

<p>
Also, PIL cannot read zTXt or iTXt chunks.  Boo.
</p>

<p>UPDATE 28-Aug-2007:  PIL 1.6 secretly allows you to add metadata.  See <a href="http://blog.modp.com/2007/08/python-pil-and-png-metadata-take-2.html">this post</a> for details.</p>

<h4> PNG Metadata and PNGCrush</h4>

<p><a href="http://pmt.sourceforge.net/pngcrush/index.html">PNGCrush</a> is a nifty little program for optimizing the size of PNG files. It also let's you write metadata.  But sadly, I think it has a <a href="http://sourceforge.net/tracker/index.php?func=detail&aid=1679310&group_id=1689&atid=101689">little bug</a>.
</p>

<p>
A sister program <a href="http://pmt.sourceforge.net/pngmeta/index.html">pngmeta</a> dumps metadata.  It's old but seems to work.  It does not let you add metadata.
</p>

*****
Comment 2008-06-17 by None

Interesting blog, I have been googling for a simple metadata editor for PNG files, but cannot find one. Strange I would have assumed that adding a GUI to the terminal commands would be easy.<BR/><BR/>Hopefully someone will do this soon.


*****
Comment 2009-04-03 by None

Exactly the info I was looking for.  Thanks.


*****
Comment 2009-06-02 by None

This comment has been removed by a blog administrator.


*****
Comment 2010-03-03 by None

Thanks a lot - I also need to edit the metadata of a large set of png images.<br />However, I cannot get the above commands to preserve the sorting of the text fields. ImageMagick sorts them alphabetically and Python also scrambles the order. Any ideas?


*****
Comment 2010-03-03 by None

@carl  -- it&#39;s unlikely any of these solutions will preserve order.  If you need this, adding a prefix to your keys/fields will allow you with a quick sort to order them correctly.   (e.g. &quot;00-first&quot;, &quot;01-apple&quot;, &quot;02-dog&quot;,  or &quot;TIMESTAMP-name&quot;).  Good luck.
