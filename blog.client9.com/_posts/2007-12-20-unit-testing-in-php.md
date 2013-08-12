---
layout: post
updated: 2007-12-20
alias: /2007/12/unit-testing-in-php.html
title: Unit testing in PHP
---
<p>
I needed to do some unit testing for some PHP5 utility classes, and wanted some unit test framework.  Here are my requirements:
</p>

<ul>
<li> Simple. If it's more than one file, something is wrong.
<li> Unrestrictive license.  I  should be able to include the one file in any package I create for distribution, give to clients, whatever.</li>
<li> Short namespace.  I don't want to type <code>SomeBloatedClass::testIfTrueOnTruesdayOnly(...)</code>, when something like <code>assert("foo" == "bar")</code> will do.</li>
<li>Easy to run, no need for anything more than a command line</li>
</ul>

<p>Oddly I couldn't find anything.  Lots of links to outdated information.  Lots of monster web framework testing things. PHPUnit is baffling.  I found out of date versions, links to PEAR that didn't work, etc.  And it's huge!  Why?  Unit testing should be short and sweet.</p>

<p>So screw it: here's <a href="http://modp.com/downloads/UnitTest.php.txt">my 100-line version</a>.  It does just about everything the fat ones do.  Here's the "manual" (more samples in source file)</p>

<ul>
<li>Add <code>require_once('UnitTest.php');</code></li>
<li>Create a class that <code>extends UnitTest</code></li>
<li>Make a test by adding a method to the class.  The method name <b>must</b> start with <code>test</code></li>
<li>Test values in the test method with <code>assert</code> and <code>assertEquals($val, $expected)</code></li>
<li>Optionally define a <code>public function setup()</code>, <code> public function teardown()</code> functions.  These will be called before and after <i>each</i> test.</li>
<li>Add at the bottom <code>unittest('<i>classname</i>')</code></li>
<li>Run test with <code>php <i>yourfile</i></code></li>
<li>Script will return 0, if all tests succeeded, 1 if failures occurred, and 2 if the class couldn't even be loaded</li>
</ul>

<p> For example: </p>
<pre>
#!/usr/bin/env php
&lt;?php
require_once('UnitTest.php');

class ATest extends UnitTest
&#123;
 
    public function testPass()
    &#123;
        assert(1 == 1);
    &#125;

    public function testNot()
    &#123;
        assert(1 == 2);
    &#125;

    public function testFail()
    &#123;
        assertEquals("foobar", 10);
        assertEquals("foobar", 10, "optional message goes here";
    &#125;

    public function testError()
    &#123;
        throw new Exception("wtf");
    &#125;
&#125;


// RUN IT
unittest('ATest');
?&gt;
</pre>

<p>Running this will produce: </p>

<pre>
$  ./sample.php 
testPass: OK
testNot: Fail : Assertion failed @ line 63 in ATest::testNot
testFail: Fail : foobar != 10 @ line 63 in ATest::testFail
testError: Error : wtf @ line 24 in <i>filename</i>
Total Tests: 4
total = 4, pass = 1, fail = 2, error = 1
$ echo $?
1
</pre>

<p>
Yeah the output isn't so pretty.  So... change it!  Need more fancy methods?  Add 'em!  You can modify the base, or subclass it.
need "Test Suites" ... use directories!</p>

<p>And go forth and make unit tests!</p>

<p>Oh yeah, improvements and suggestions welcome.  One more method might be <code>assertEqualsFloat</code> which would take 2 floats and a tolerance.</p>