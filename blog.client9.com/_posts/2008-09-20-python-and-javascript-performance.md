---
layout: post
updated: 2008-09-21
alias: /2008/09/python-and-javascript-performance.html
title: python and javascript performance compared v1
---
<p>
Recently the WebKit folks introduced <a href="http://webkit.org/blog/214/introducing-squirrelfish-extreme/">SquirrelFish Extreme</a>, which claims Yet Another Breakthrough in javascript performance, especially when compared to other javascript engines.
</p>

<p>And the PyPy guys posted some notes in their blog on <a href="http://morepypy.blogspot.com/2008/09/pycon-uk-javascript-and-gil.html">Pycon UK, Javascript and the GIL</a>, specifically:</p>

<blockquote>
Just got back from Pycon UK 2008 - here are some impressions. 

Both the keynote speakers Mark Shuttleworth (Canonical) and Ted Leung (Sun Microsystems) expressed their concerns about Javascript becoming so fast and prominent that it could displace Python in the future.
</blockquote>

<p>
So how "bad" is python?  How "good" is javascript? 
</p>

<p>So I went to <a href="http://www2.webkit.org/perf/sunspider-0.9/sunspider.html">SunSpider 0.9</a> got some timings from Safari 3.1.  Then I also checked out the code via </p>

<pre>
svn co http://svn.webkit.org/repository/webkit/trunk/SunSpider/tests
</pre>

<p>A large number of the tests are from the <a href="http://shootout.alioth.debian.org/">The Computer Language  
Benchmarks Game</a>.  This is good, but the goals are a bit different.  In CLBG, the goal is to "get done as fast as possible" using any standard extension available.  My goal is to not use C extensions.  For instance I'm not going to compare a javascript MD5 implementation via the python builtin C-extension.  Also some of the implementations are just different (functional vs. OO style, use of an class/object vs. use of an native array type).  I attempted to standardize and normalize best I could.  most common is making compound strings.  In Javascript you just use "+=" and add more.  In python the standard idiom is to make a list of string pieces and then do a <code>''.join(pieces)</code> at the end.
</p>

<p> Anyways a few select tests were written for python, <i>Highly likely I screwed up in some places too</i>.  Here are the results:
</p>

<pre>
&#123;
                           nop : 1.4 ms,  # cost of doing nothing
                      3d_morpth : 247.3 ms,

           access_binary_trees : 42.8 ms,   # uses lists, not objects
        access_binary_trees_oo : 116.0 ms,  # oo based
               access_fannkuch : 332.2 ms,

      bitops_3bit_bits_in_byte : 130.0 ms,
            bitops_bitwise_and : 289.5 ms,
           bitops_bits_in_byte : 310.7 ms,

         controlflow_recursive : 112.7 ms,

             crypto_md5_native :   3.4 ms,
             crypto_md5_python : 109.2 ms,
            crypto_sha1_native :   1.3 ms,
            crypto_sha1_python : 117.9 ms,

                   math_cordic : 262.5 ms,
             math_partial_sums : 133.5 ms,
             math_spectralnorm : 166.7 ms,

                    regexp_dna : 125.9 ms

                 string_base64 : 120.7 ms,
                  string_fasta : 184.9 ms,
         string_validate_input : 174.9 ms,
&#125;

</pre>
<p>
compared to Safari 3.1
</p>
<pre>

    3d_ morph:              146.0ms +/- 1.3%
    access_binary-trees:        77.2ms +/- 4.3%
    access_fannkuch:           261.0ms +/- 1.3%


    bitops_3bit-bits-in-byte:   76.6ms +/- 11.6%
    bitops_bits-in-byte:       107.4ms +/- 3.7%
    bitops_bitwise-and:        188.8ms +/- 2.3%

    controlflow_recursive:           92.8ms +/- 3.3%

   crypto_md5:                 88.8ms +/- 5.8%
    crypto_sha1:                86.8ms +/- 4.7%

    math_cordic:             192.6ms +/- 3.5%
    math_partial-sums:       212.0ms +/- 2.1%
    spectral-norm:       89.6ms +/- 0.8%

    regexp_dna:                231.4ms +/- 3.7%

    string_base64:             111.4ms +/- 6.6%
    string_fasta:              201.4ms +/- 7.4%
    string_validate-input:     145.8ms +/- 4.6%
</pre>

<p>As you can see I didn't do the date, crypto or 3d ones because I am lazy.   A few of the javascript are too JS-specific (unpack-code, tagcloud).   nsieve-bits is a bit tricky for comparison since in python you can cheat since it has unlimited-precision integers so I'm not sure it's a good comparison.  And some I didn't do since they require more work (lazy).
</p>

<p>From this, javascript is faster than Safari 3.1.2   Firefox 3.02 is even faster.  And both Safari and Firefox have major enhancements coming up that can double their performance.</p>

<p> You could say javascript is cheating since it has Just-In-Time compilers.   Perhaps.... stay tuned as I hook up <a href="http://psyco.sourceforge.net/">pysco</a></p>

*****
Comment 2008-10-08 by None

<EM>&gt; In CLBG, the goal is to &quot;get done as fast as possible&quot; using any standard extension available. My goal is to not use C extensions.</EM><BR/><BR/>Where does it say The Computer Language Benchmarks Game allows any standard C extension available?<BR/><BR/><A HREF="http://shootout.alioth.debian.org/u32q/benchmark.php?test=all&lang=python&lang2=tracemonkey" REL="nofollow">Python :: TraceMonkey</A>


*****
Comment 2008-10-08 by None

Hi, thanks for the comment.<BR/><BR/>It doesn't explicitly say you can use C extensions, but I suspect anything in the "standard library" for a language is usable.<BR/><BR/>Javascript doesn't have much of anything for a standard library, while Python has a huge one (with a lot written in C).<BR/><BR/>My goal was to compare apples to apples, and just look at raw interpreter performance (pure python to pure javascript).  The comparison isn't perfect since javascript has (or can has) a JIT compiler.


*****
Comment 2008-10-10 by None

Use psyco.<BR/>ManiS
