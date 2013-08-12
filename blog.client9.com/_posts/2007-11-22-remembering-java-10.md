---
layout: post
updated: 2007-11-23
alias: /2007/11/remembering-java-10.html
title: Remembering Java 1.0
---
<p>In November 2007, <a href="http://www.tiobe.com/index.htm?tiobe_index">Java is the #1 programming language</a>.  Yet for all it's popularity, there are probably an equal number of malcontents.  You've heard the issues: that it's excessively verbose, bloated, neither fish-nor-fowl (ie. what is Java's goal? Or what is Java? A language? A runtime?), causes developers to focus on secondary issues and excessive abstraction, etc.    Regardless if you agree or not, for now let's pretend all the complaints are valid.  If so, then how did this clunky language climb to the top?</p>

<p>It's easy to forget what a <i>revolution</i> Java was when it came out in 1995.  Back then C++ barely worked and was slow, you had perl4, a million Unix variants, and you were lucky if you had 90Mhz computer.  The number of high quality open source libraries was a lot smaller, and it was always a issue getting them to compile.</p>

<style type="text/css">
span.bullet &#123;
  padding-right: 5px;
  font-weight: bold;
  color: #999
&#125;
</style>





<h2>The Promise of Java</h2>
<p> Here's what I recall when java came out, and how those advantages compare now days</p>

<h4>Compiler - Features</h4>
<p> <span class="bullet">Pre-Java</span> Each unix platform had a different compiler than implemented C++differently.  So needed either lots of #ifdefs or custom libraries working around compiler bugs</p>

<p><span class="bullet">Java</span> One compiler on every platform.  Worked</p>

<p><span class="bullet">Now</span>C/C++ compilers are relatively mature now.   Many scripting languages have replaced C/C++ code.</p>

<h4>Compiler - Speed</h4>
<p> <span class="bullet">Pre-Java</span> Compiling the entire application could take hours.  ClearCase (source repository) provided a system of <i>pre-compiled source files</i> on a central server to help the speed compilation.</p>

<p><span class="bullet">Java</span>When Java came out it was a godsend.  The entire application was compiled in seconds or minutes</p>
<p><span class="bullet">Now</span>Today, compilers are a lot better and the time to compile is "reasonable".</p>

<h4>Basic Types</h4>
<p><span class="bullet">Pre-Java</span> Different platforms has different sized integer and floating point types, signed and unsigned, with strange casting rules.  And different endians, so long term storage was problematic</p>

<p><span class="bullet">Java</span>Double, Int, Long, Byte.  Done.</p>
<p><span class="bullet">Now</span>Everyone uses x386 now so endian isn't an issue (haha).   Interestingly the big Java champions are IBM and Sun, whose chips use big endian not x386 little endian.   Types still are a problem in C/C++ but can be mitigated with good practices.</p>

<h4>Basic Data Structures</h4>
<p><span class="bullet">Pre-Java</span> STL did not work or exist or could not be compiled or were slow. Had to <i>buy</i> libraries since open source versions didn't exist or were not mature.</p>

<p><span class="bullet">Java</span> Rich types: strings, vectors, hash tables, etc</p>

<p><span class="bullet">Now</span>STL works and works well, numerous platform libraries (APR, NSPR, GLib), scripting languages.</p>

<h4>Basic OS libraries</h4>

<p><span class="bullet">Pre-Java</span> Every OS had different implementations of libc and posix calls</p>

<p><span class="bullet">Java</span> Standardized and worked.</p>

<p><span class="bullet">Now</span>posix compliance is pretty good.  Autotools works well.  numerous platform libraries (APR, NSPR, GLib), scripting languages</p>

<h4>Program Structure</h4>
<p><span class="bullet">Pre-Java</span> one header file, one source file, each could contain multiple classes or gasp, <i>functions</i></p>
<p><span class="bullet">Java</span> one class, one source file.  Everything is in a class.  At the time, this was viewed as a great simplification</p>
<p><span class="bullet">Now</span>C++ is still the same.  Java now supports "inner classes".   Not so sure that Java is a better solutions (it's different but it has pluses and minuses</p>

<h4>Object Serialization</h4>
<p><span class="bullet">Pre-Java</span> Custom, or had to buy 3rd party library (if it existed)</p>
<p><span class="bullet">Java</span>Built-in, with versioning!</p>
<p><span class="bullet">Now</span> for C++ there is Boost, most scripting languages have a native way of doing this and/or JSON</p>

<h4>Remote Method Invocation</h4>
<p><span class="bullet">Pre-Java</span> Horrible CORBA, which barely worked or different versions were incompatible.</p>
<p><span class="bullet">Java</span> RMI !  while nobody uses it now (?), at the time, it was considered amazing, as compared to CORBA</p>
<p><span class="bullet">Now</span>Use HTTP and/or XMLRPC</p>

<h4>Exceptions</h4>
<p><span class="bullet">Pre-Java</span>As I recall, even C++ exceptions were "experimental" or had performance issues due to crappy compilers.</p>
<p><span class="bullet">Java</span>Built in, worked.  You could get a stack trace!</p>
<p><span class="bullet">Now</span>They certainly work in C++, but not as rich as Java</p>

<h4>Threading</h4>
<p><span class="bullet">Pre-Java</span></p>
<p><span class="bullet">Java</span>Builtin, with nice syntax.  Current concurrencies libraries are really excellent.</p>
<p><span class="bullet">Now</span>posix libraries work.  C++/OS abstraction libraries (boost) make it even easier. Atomic operations can be provided by other libraries. Many scripting languages don't have true threads.</p>

<h4>Robustness</h4>
<p><span class="bullet">Pre-Java</span> Delicate.  Easy to core dump.</p>
<p><span class="bullet">Java</span>Solid.  (crashes are a very rare event).</p>
<p><span class="bullet">Now</span>Easy to make mistakes, but can be greatly reduced by using STL and references not raw pointers.  But of course the risk exists. Of course scripting languages provide the same safety.</p>

<h4>Memory Management</h4>
<p><span class="bullet">Pre-Java</span> DYI.  Easy to leak.  Had to <i>buy</i> tools to find them.</p>
<p><span class="bullet">Java</span>garbage collector!</p>
<p><span class="bullet">Now</span>Leaks still exists in C/C++, but by careful engineering, with constructors/destructors you make
 leaks go away, and by avoid raw pointers. Plenty of free tools to help catch them. Scripting languages of course do this too.</p>

<h4>Simplicity</h4>
<p><span class="bullet">Pre-Java</span> C++ is a complicated language.  Perl4's concept of OO was very primitive</p>
<p><span class="bullet">Java</span>Java, when it came out billed as being simple and self-contained.  I seem to recall some demo they gave where they printed out the complete java spec and compared it to 3 meter stack of books for Win32.  Also I see to recall that 1 line of Java was like the equivalent of 3 lines in C++ or something.  At the time, perhaps it was true.</p>
<p><span class="bullet">Now</span>Well, C++ is still complicated, no doubt.  The STL and other standard libraries are greatly improved too, improving productivity.  But Java has exploded, not just in libraries but the language itself. I don't think anyone can say java is a simple language anymore.</p>

<h4>Modular</h4>
<p><span class="bullet">Pre-Java</span> Shared libaries are tricky.</p>
<p><span class="bullet">Java</span>JAR files are simple.  You can give someone a JAR file and they can use it instantly</p>
<p><span class="bullet">Now</span>not as much as an advantage.  Setting CLASSPATH is still annoying</p>

<h4>Documentation</h4>
<p><span class="bullet">Pre-Java</span> What documentation? </p>
<p><span class="bullet">Java</span>javadoc!</p>
<p><span class="bullet">Now</span>Now days, every scripting language has some type of autodoc system, frequently inspired by Java.  For C/C++ Doxygen works well.</p>

<h5>GUI</h5>
<p><span class="bullet">Pre-Java</span>Back in 90s, writing for Unix meant writing for X.  The widgets looked horrible.  or you could buy a Motif license, which looked a lot better but was buggy.  And then how to write something cross platform so it worked on Windows too.  And the Win32 was terrifying.</p>
<p><span class="bullet">Java</span>Java's AWT allowed mere mortals to write cross platform GUIs.</p>
<p><span class="bullet">Now</span>Of course now for Java there is AWT, Swing, and SWT.   And on the other side there is <a href+"http://www.wxwidgets.org/">wxWidgets</a> and others.</p>

<h2> Java Today</h2>
<p>As you can see when it came out, Java was quite compelling, but those advantages don't always hold anymore.</p>

<p>So what is Java good for <i>now</i>? This is an easy question to answer for just about any other language, but for some reason it's hard to answer with Java.   It's not that I'm saying Java is bad, and it certainly has some good features, libraries, and applications, but what does it excel at that other languages have a hard time doing?  What type of project would you use it for if starting from scratch (and besides the fact you know it already).</p>