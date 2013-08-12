---
layout: post
updated: 2009-06-14
alias: /2009/06/making-atom-feeds-with-googles-gdata.html
title: Python, Atom Generator, and Google gdata
---
<p>It's hidden, but google provides a python Atom module in the <a href="http://code.google.com/p/gdata-python-client/">gdata API</a>.</p>


<p>Installing is just the usual "easy_install <i>URL</i>" with the latest tarball from the downloads section. If having all the other gdata apis makes you uncomfortable, just checkout the atom bits with: </p>

<pre>
svn co http://gdata-python-client.googlecode.com/svn/trunk/src/atom/
</pre>

<p>(consider usng <code>svn:external</code>)
<p>The pedantic implementation of the first example from the <a href="http://www.atomenabled.org/developers/syndication/atom-format-spec.php">Atom spec</a> is:</p>

<pre>
from gdata.client import atom
# or "import atom" if you did the svn checkout method

feedauthor = atom.Author(name = atom.Name(text='John Doe'))
feedtitle = atom.Title(text = "Example Feed")
feedlink = atom.Link(href = "http://example.org/")
# anything as long as it is unique                                                                                                          
feedid = atom.Id(text="urn:uuid:60a76c80-d399-11d9-b93C-0003939e0af6")
# datetime.datetime.now().isoformat()                                                                                                       
feedupdated = atom.Updated("2003-12-13T18:30:02Z")


entries = []
e_title   = atom.Title(text="Atom-Powered Robots Run Amok")
e_link    = atom.Link(href= "http://example.org/2003/12/13/atom03")
e_id      = atom.Id(text="urn:uuid:1225c695-cfb8-4ebb-aaaa-80da344efa6a")
e_updated = atom.Updated("2003-12-13T18:30:02Z")
e_summary = atom.Summary(text="Some text.")

entries.append( atom.Entry(title=e_title, link=e_link, atom_id=e_id, summary=e_summary))

feed = atom.Feed(entry=entries, title=feedtitle, link=feedlink, atom_id=feedid, updated=feedupdated)

print(str(feed))
</pre>

<p>As you can see it's kinda <i>verbose</i>, but hey, we are dealing with XML so whattdoya expect.  <code>pydoc</code> is your friend.</p>

<p>The output will look <i>something</i> like the following.  If you throw it under Apache with "junk.atom" you should be able to see it with your fav RSS reader or view it in your browser.</p>

<pre>
&lt;?xml version='1.0' encoding='UTF-8'?&gt;
&lt;ns0:feed xmlns:ns0="http://www.w3.org/2005/Atom"&gt;
&lt;ns0:title&gt;Example Feed&lt;/ns0:title&gt;
&lt;ns0:id&gt;urn:uuid:60a76c80-d399-11d9-b93C-0003939e0af6&lt;/ns0:id&gt;
&lt;ns0:link href="http://example.org/" /&gt;
&lt;ns0:updated&gt;2003-12-13T18:30:02Z&lt;/ns0:updated&gt;
&lt;ns0:entry&gt;
  &lt;ns0:id&gt;urn:uuid:1225c695-cfb8-4ebb-aaaa-80da344efa6a&lt;/ns0:id&gt;
  &lt;ns0:link href="http://example.org/2003/12/13/atom03" /&gt;
  &lt;ns0:summary&gt;Some text.&lt;/ns0:summary&gt;
  &lt;ns0:title&gt;Atom-Powered Robots Run Amok&lt;/ns0:title&gt;
&lt;/ns0:entry&gt;
&lt;/ns0:feed&gt;
</pre>

<p>I'm sure this library also does parsing, but I haven't tested that</p>