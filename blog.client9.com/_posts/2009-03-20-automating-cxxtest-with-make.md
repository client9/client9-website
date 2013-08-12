---
layout: post
updated: 2009-03-20
alias: /2009/03/automating-cxxtest-with-make.html
title: Automating CXXTEST with Make
---
<p>
<a href="http://cxxtest.tigris.org/">CXXTEST</a> is the best unit testing tool for C++.  It's so good i used for C as well.  Since test s are programatically generated from a <code>.h</code> file, it can be a bit tricky to integrate with your <code>Makefile</code> system.  Here's the snippets I use auto automate building and running your unit tests.
</p>

<p>You define your test file ending with <code>_test.h</code> and it will generate the <code>_test.cc</code> file, compile it and run it. It should be easy to modify the suffixes to suite your taste.
</p>

<pre>
# Define all your usual stuff.  This could come from 'configure'
FLAGS=-g -Wall -Wextra
LD_LIBRARY_PATH=/usr/local/lib
LDFLAGS -L/usr/local/lib
LIBS=-luuid -lz

# where is this program
CXXTESTGEN=/usr/bin/cxxtestgen.py

# name your tests corresponds to foobar_test.h, dingbat_test.h
TESTS = foobar dingbat
</pre>

<pre>
#-----------------------------------------
# should not need to modify

.PHONY: test
test: $(TESTS)
        @(for i in $(TESTS); do ./$$i; done)

all: test

TESTS_H = $(TESTS:=_test.h)
TESTS_CC = $(TESTS:=_test.cc)

$(TESTS): $(TESTS_CC)

%_test.cc : %_test.h
        $&#123;CXXTESTGEN&#125; --error-printer -o $@ $<

%: %_test.cc
        $&#123;CXX&#125; $&#123;FLAGS&#125; -o $@ $< $&#123;LDFLAGS&#125; $&#123;LIBS&#125;

clean:
        -rm -f *~
        -rm -f core*
        -rm -f $(TESTS) $(TESTS_CC)
</pre>

<p>Here's a sample stub <code>foobar_test.h</code></p>

<pre>
* -*- mode: c++; c-basic-offset: 4; indent-tabs-mode: nil; tab-width: 4 -*- */

#include <cxxtest/TestSuite.h>
class foobar_test : public CxxTest::TestSuite
&#123;
 public:
  void testFirst()
  &#123;
    TS_ASSERT_EQUALS(1,2);
  &#125;

  void testSecond()
  &#123;
    TS_ASSERT_EQUALS(1,1);
  &#125;
&#125;;
</pre>