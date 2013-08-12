---
layout: post
updated: 2007-08-29
alias: /2007/08/python-pil-and-png-metadata-take-2.html
title: Python, PIL and PNG metadata, take 2
---
Contrary to my original post, the <a href="http://www.pythonware.com/products/pil/">Python PIL</a> library does have support for reading <i>and writing</i> <a href="http://www.libpng.org/pub/png/spec/1.2/PNG-Chunks.html#C.Anc-text">PNG metadata</a>.  This is based on the 1.6 and devel snapshot, as of 28-Aug-2007.  

<h4>The Short Story</h4>
<p> The short story is that <code>Image.load</code> reads most PNG metadata into the <code>Image.info</code> dict. <b>But, <code>Image.save</code> ignores <code>Image.info</code> and will erase all metadata!</b>.  Use this wrapper function instead:</p>
<pre>
#                                                                                                                                      
# wrapper around PIL 1.1.6 Image.save to preserve PNG metadata
#
# public domain, Nick Galbreath                                                                                                        
# http://blog.modp.com/2007/08/python-pil-and-png-metadata-take-2.html                                                                 
#                                                                                                                                       
def pngsave(im, file):
    # these can be automatically added to Image.info dict                                                                              
    # they are not user-added metadata
    reserved = ('interlace', 'gamma', 'dpi', 'transparency', 'aspect')

    # undocumented class
    from PIL import PngImagePlugin
    meta = PngImagePlugin.PngInfo()

    # copy metadata into new object
    for k,v in im.info.iteritems():
        if k in reserved: continue
        meta.add_text(k, v, 0)

    # and save
    im.save(file, "PNG", pnginfo=meta)

</pre>

<p>Just edit the <code>Image.info</code> as you like and it will get written out.</p>

<pre>
from PIL import Image
im = Image.new("RGB", (128,128), "Black")
im.info["foo"] = "bar"
pngsave(im, "foo.png")
</pre>

<p>You can see that it worked by either doing <code>strings foo.png</code> or if you use <a href="http://www.imagemagick.org/">ImageMagick</a>, <code>identify -verbose foo.png</code>

<h4> The Long Story </h4>
<p>
The next section is mostly for PNG nerds and developers of PIL.
</p>

<h5>Reading</h5>
<p>
It dumps the metadata key/value pairs into the standard <code>Image.info</code> field.  So far so good.  
</p>

<p>
What's not so good is that is also puts <code>transparency</code>, <code>gamma</code>, <code>aspect</code>, and <code>dpi</code> into the same array.  While I guess this is metadata, it is rendering metadata which is treated differently in the PNG file than user-added metadata. I'm not sure what PIL does for other image types -- there may be other keywords.  This is really only a problem when it comes to writing metadata, in the next section.
</p>

<p>
Another issue is that PIL only reads only one of the three different type of metadata chunks that PNG supports. (<code>tEXt</code>: yes,  <code>zTXt</code>: no, <code>iTXt</code>: no).  This <a href="http://mail.python.org/pipermail/image-sig/2007-February/004343.html">post</a> provides a patch for <code>zTXt</code>.
</p>


<h5>Writing</h5>
<p>
<b>By default PIL will erase any user-metadata with <code>Image.save</code></b>.  I would think this is a bug.  Editing the <code>Image.info</code> dictionary does not result in changes either.  It is completely ignored on write.</p>

<p>
Oddly PIL has support for writing metadata, as either uncompressed <code>tEXt</code> or compressed <code>zTXt</code> data (which it isn't able to read!).  Here's what you do:</p>

<pre>
>>> from PIL import Image
>>> from PIL import PngImagePlugin

>>> # let's make an image
>>> im = Image.new("RGB", (128,128), "Black")
>>> 
>>> # HERE'S THE SECRET
>>> meta = PngImagePlugin.PngInfo()
>>> meta.add_text("foo", "bar")
>>> im.save("foo.png", "png", pnginfo=meta)
>>>
>>> 
>>> # But im.info is not modified
>>> im.info
&#123;&#125;
>>> # but if we re-open the image, we get out
>>> # metadata back
>>> im2 = Image.open("foo2.png")
>>> im2.info
&#123;'foo': 'bar'&#125;
>>> #
>>> # but remember if we save it without
>>> # explicitly adding the metadata, we lose it
>>> im2.save("foo3.png")
>>> im3 = Image.open("foo3.png")
>>> im3.info
&#123;&#125;
>>> # whoops
</pre>

<p>
The secret is making a <code>PngImagePlugin.PngInfo()</code> object, and then adding key/value pairs using the <code>add_text</code> method.  It has an optional third argument whether to compress the value text or not (true/false). 
</p>

<p>Technically, the PNG spec says that <code>tEXt</code> and <code>zTXt</code> should only contain latin-1 characters.  I don't see the writer code enforcing this rule, but it's doubtful it matters at all.   There is also no support for the <code>iTXt</code> block, which is for UTF-8 data.  This doesn't seem to be a big deal since few (if any) image programs support it.</code>

<h5> Ideas </h5>

<p>Adding support for <code>zTXt</code> seems like a no-brainer.  Especially since the writer exists.</p>

<p>Adding support for <code>iTXt</code> would be nice, but it appears nobody really uses it.</p>

<p>Adding support for the <a href="http://www.libpng.org/pub/png/spec/1.2/PNG-Chunks.html#C.tIME"><code>tIME</code></a> (last modified time) seems like another no-brainer.  It is currently not read or written.</p>

<p>Lumping together rendering metadata and user metadata in the same dict is not great. In a ideal world it would be nice to store the metadata in a special dict, that said what type of chunk it was in.  Loading and saving a file would result in a near identical file.  You then could also specify if a metadatum needed compressing or not. This is bonus.  I'd be happy with <i>any</i> interface that allowed one to write plain 'ol <code>tEXt</code> chunks.</p>

<p>The hard part is making a uniform system of metadata that can work between different image types.</p>

*****
Comment 2007-09-12 by None

Thanks for this one. Any idea on how to carry out the same trick for jpegs and tiffs? The JpegImagePlugin module doesn't have an equivalent JpegInfo function, and there is no TiffImagePlugin module at all ...


*****
Comment 2007-09-14 by None

Hi, thanks for the comment. I have not explored metadata for other image types very much. For JPEG images, I know http://www.adobe.com/products/xmp/ and http://www.disc-info.org/ are widely used so some tool must exist for them.<BR/><BR/>I'll take a look at what PIL offers here and report back.


*****
Comment 2007-09-26 by None

Hey there...<BR/><BR/>I'm actually trying to save out a PNG  at a new bitdepth using PIL and Python with no success so far. Is this at all related to what you're exploring here? Have any suggestions?


*****
Comment 2007-09-30 by None

Hi Taylor,<BR/><BR/>Saving the PNG with a new bit depth is a little different than what I'm talking about in this article. But, if you just need to convert to grayscale, look at PIL.Image.convert.<BR/><BR/>Beyond that I would recommend using ImageMagick's convert function.  Changing bit depth gets tricky since you might need to quantize colors.


*****
Comment 2008-05-19 by None

1.1.6 as opposed to 1.6, I take it.


*****
Comment 2008-10-27 by None

Good for people to know.


*****
Comment 2009-02-11 by None

Thanks for the bit of code, it was very helpful considering the lack of documentation.<BR/><BR/>I hope you don't mind I used your snippet of code (with credit) <A HREF="http://code.google.com/p/pngaddcomment/" REL="nofollow">here</A>.<BR/><BR/>PS: Great blog.


*****
Comment 2009-06-02 by None

Thanks a lot for this snippet, it saved me a lot of time!
