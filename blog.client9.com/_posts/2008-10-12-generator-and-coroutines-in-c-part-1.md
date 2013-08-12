---
layout: post
updated: 2008-10-14
alias: /2008/10/generator-and-coroutines-in-c-part-1.html
title: Generators and Coroutines in C++, Part 1
---
<p>
Python has a pretty interesting concept of generators: functions that, uhh, generate values.  And a whole host of tools (see <a href="http://www.python.org/doc/2.5.2/lib/module-itertools.html">itertools</a>) that iterate or compute on the results that are generated. (Which are apparently inspired by <a href="http://haskell.org/onlinereport/standard-prelude.html">Haskell</a>, section 8.1). Here's a simple generator (function <code>ZeroToNine</code>).  It's too simple, but think of any function that generates something.  Maybe the results of a parser, maybe a network read, maybe just computing something.
</p>
<pre>
def ZeroToNine():
    for i in range(10):
       yield i

for i in ZeroToNine():
   print i
</pre>
<p>I played around trying to fake this in C++ in the STL way.  You end up having to write  a lot of boiler plate code to simulate STL's concept of an iterator, and/or chop up your code in un-natural functions for use in <code>std::for_each</code>, <code>std::transform</code> or <code>std::generate</code>.  STL's data structures are one thing, but the STL for functional programming leaves much to be desired.  Boost has some interesting, uhh, contortions to C++ to attempt to simplify this, but at some point you aren't even sure what language you are programming in.  And good luck trying to read the Boost source code.   Basically the STL way sucked for making generators.
</p>

<p>Then I was thinking "hmmm,maybe co-routines".   Previously I've used things like <a href="http://monkey.org/~provos/libevent/">libevent</a> and some crazy assembly language stuff to do co-routines.  But it turns out there is another way.    Check this:
</p>
<pre>
#include <iostream>
#include <stdexcept>
using namespace std;

class Range &#123;
private:
  int i, iend;
  int __s;

public:
  Range(int start, int end)
    : i(start), iend(end), __s(0)  &#123; &#125;

  int operator() (void) &#123;
    switch (__s) &#123;
    case 0:;
      __s = 30;
      for (; i < iend; ++i) &#123;
        return i;
      case 30: ;
      &#125;
      break;

      default:
        throw std::runtime_error("error -- should never happen");
    &#125;

    throw std::runtime_error("normal end");
  &#125;
&#125;;
</pre>

<p>Yes, that's right --  the <code>case 30</code> statement is <i>inside the for loop</i>!  This is legal and compiles.
</p>

<p>And finally:</p>

<pre>
int main() &#123;
  Range r(0,3);
  try &#123;
    while (true) &#123;
      cout << "r = " << r() << "\n";
    &#125;
  &#125; catch (std::runtime_error& e) &#123;
    cout << e.what() << "\n";
  &#125;
&#125;
</pre>

<p>Compiles, works, prints.   Some clever folks have invented macros to do all the switch-trickery so your editor or source -code checker doesn't vomit.   I didn't use the macros  so you code see the madness .  The main reference is by <a href="http://www.chiark.greenend.org.uk/~sgtatham/coroutines.html">Simon Tatham</a>.  Another variation is described by <a href="http://www.codepost.org/view/101">CodePost.org</a>.  (Oh, just found <a href="http://www.sics.se/~adam/pt/index.html">Protothreads</a>).    Here's a version using the CodePort.org macros:
</p>

<pre>
#define cr_context   int __s;
#define cr_init()    __s = 0;
#define cr_start()   switch (__s) &#123; case 0:
#define cr_return(x) &#123; __s = __LINE__; return x; case __LINE__: ; &#125;
#define cr_end()     &#123; break; default: for (;;) ; &#125; &#125; __s = 0; 

class Range &#123;
private:
  int i;
  int iend;
  cr_context;

public:

  typedef int value_type;

  Range(int start, int end)
    : i(start), iend(end)
  &#123;
    cr_init();
  &#125;

  int operator() (void) &#123;
    cr_start();
    for (; i < iend; ++i) &#123;
      cr_return(i);
    &#125;
    cr_end();
    throw std::runtime_error("all done");
  &#125;
&#125;;
</pre>

<p>That is pretty easy to read and follow.  The exceptions and initialization could be improved, and I'm pretty sure CodePost.org's macros aren't optimal but you get the idea. </p>

<p><code>Range</code> isn't the most interesting example, but now with templates and some basic STL, you are probably able to duplicate most of the python generator and iterator functions.  Now is this a good idea?  Is this useful?  Is it fast?  I don't know yet!
</p>

*****
Comment 2009-01-20 by None

That looks like a variant of duffs device, but I&#39;m not sure how well duffs plays with modern C++ code...<BR/><BR/>What happens when that for loop has something constructed at the top and destructed at the end?<BR/><BR/>for (; i &lt; iend; ++i)<BR/>  String s = &quot;asdf&quot;;<BR/>  return i;<BR/>  case 30: ;<BR/>&#125;<BR/><BR/>If we goto 30, is s initialized with &quot;asdf&quot;, or is the destructor called on the uninitialized variable? Does the language standard handle this case?


*****
Comment 2009-01-20 by None

Hi Brendan, yeah it's duff's device rewired.  I wrote about that in some other post....  That's said, I think this is more "interesting" than useful.   If someone is dying for generators and co-routines it's probably easier just to use libevent to get "real" coroutines. --nickg
