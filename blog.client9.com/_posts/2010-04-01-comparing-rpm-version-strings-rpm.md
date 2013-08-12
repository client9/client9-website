---
layout: post
updated: 2010-04-01
alias: /2010/04/comparing-rpm-version-strings-rpm.html
title: Comparing RPM version strings, RPM version algorithm, rpmvercmp
---
<p>Given two RPM version strings, which one is more recent?  The algorithm isn't explained (at least not that I could find), and apparently it's been screwed up a few times (where a < b and b < a for certain values)</p>

<p>I had to hack the source to make a command tool.  The source is <a href="http://client9.com/downloads/rpmvercmp.c"> here</a>.  Just compile and go

<pre>
$ gcc rpmver.c
$ ./a.out 1 2
1 < 2
</pre>

<p>  For simple stuff, yeah, </p>

<pre>
1.9.2 < 1.9.2.8
1.9.2 < 1.9.3
1.9 < 2
</pre>

<p>
others aren't so obvious.
</p>
<pre>
1 < 2010
1 < -2010
1 < +2010
1 < ~2010
1 < 02010
1 > 0.2010
1 < 2010x
1 > x2010
0.201 < 0.2010
1 < 1-0
1-0 < 1-1
</pre>

*****
Comment 2010-04-06 by None

1 &lt; 2010<br />    this isn&#39;t &quot;obvious&quot;?<br /><br />1 &lt; -2010<br />1 &lt; +2010<br />1 &lt; ~2010<br />    The comparison does _NOT_ include signs. In fact<br />    all non-alpha, non-digits, are created equal and<br />    ignored by rpmvercmp (and RPM comparisons).<br /><br />1 &lt; 02010<br />    I guess this _REALLY_ isn&#39;t &quot;obvious&quot;  (to you). ;-)<br /><br />1 &gt; 0.2010<br />    These are integer, not float, comparisons. 1 is indeed larger than 0.<br /><br />1 &lt; 2010x<br />    This is still very very &quot;obvious&quot; even if your repetion obscures.<br /><br />1 &gt; x2010<br />    This _ISNT_ obvious. In fact its counter intuitive if<br />    one is used to ASCII collation. But breaking ASCII<br />    collation ordering is/was a RFE from Mandriva (nee Mandrake)<br />    a long time ago. See bugzilla #50977 @redhat.com for the RFE.<br /><br />0.201 &lt; 0.2010<br />   This isn&#39;t obvious if one is expecting float comparisons<br />    because of the single decimal point. But note that<br />    interpreting 0.201 fractionally will never generalize<br />    to ISO versioning like MAJOR.MINOR.MICRO. And its<br />    true that &quot;201 &lt; 2010&quot; which is actually the comparison<br />    being performed.<br /><br />1 &lt; 1-0<br />1-0 &lt; 1-1<br />    rpmvercmp is _NEVER_ passed a &#39;-&#39; character by RPM itself,<br />    and a &#39;-&#39; character is FORBIDDEN in all Version: and Release:<br />    strings so that a single dependency string like E:V-R<br />    (E == Epoch, V == Version, R == Release) can be unambigously<br />    split into components in spite of missing (as in unspecified) R.


*****
Comment 2010-04-07 by None

Hi there.  Many in the second box are, yes, obvious.  And all your points are very valid (and helpful). In fact your comments are better than anything I found on the Red Hat or RPM website!  Maybe I missed something.<br /><br />My examples above aren&#39;t too complicated.  But many times people start throwing whole words and whatnot -- then It&#39;s not so clear.  And then try and compare it to the debian algorithm.  They differ in subtle ways, especially in characters that are ignored.<br /><br />Anyways it would be nice if RPM had a command line option to compare two versions strings.


*****
Comment 2010-04-07 by None

if for some reason you are reading this, you might be interested in this<br /><br />http://semver.org/
