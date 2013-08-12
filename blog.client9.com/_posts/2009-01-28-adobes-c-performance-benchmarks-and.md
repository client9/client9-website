---
layout: post
updated: 2009-01-28
alias: /2009/01/adobes-c-performance-benchmarks-and.html
title: Adobe's C++ Performance Benchmarks and Blog
---
<p><a href="http://stlab.adobe.com/performance/">Adobe's C++ Performance Benchmarks</a>  is a set of simple C and C++ benchmarks in order to test compiler code generation.   While it "C++" in the title, half the tests are in C.  The author Chris Cox has also written a <a href="http://blogs.adobe.com/c++performance/">blog on C++ performance</a>.

<p>On my Mac (which is gcc 4.0.1), look at these fun things</p>

<pre>
    "int64_t equal constants"   7.36 sec   2175.19 M     0.46
 "int64_t notequal constants"  15.97 sec   1001.98 M     1.00
</pre>

<p>Yeah, "!=" is twice as slow as "==" for this type</p>


<p>Sorting is another fun one:</p>
<pre>
   "qsort array with function pointer"   4.52 sec    4.42 M     1.00
    "sort array with standard functor"   1.61 sec   12.41 M     0.36
</pre>

<p>Which translated says:</p>
<pre>qsort( table, tablesize, sizeof(double), less_than_function1 );</pre>
<p>is almost 3x slower than</p>
<pre>sort( table, table + tablesize );</pre>

<p>These are the simple ones, but the goal is to <a href="http://stlab.adobe.com/wiki/index.php/Performance/WhatToTest"> test performance of basic idioms</a> and things you do all the time.
</p>