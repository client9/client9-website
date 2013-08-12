---
layout: post
updated: 2009-01-13
alias: /2009/01/decoupling-server-development-from-os.html
title: Decoupling Server Development from the OS
---
<p>
The OS has various libraries and tools to allow development for the OS.
You are developing a high performance server, and you need perhaps a different set of libraries and tools.  What's the solution?  The "obvious" answer is to use the OS-level packaging (RPM, apt-get, yum, port, pkgadd)  to "upgrade the OS". Except it never really works well:
</p>

<ul>
<li>The library you need might not even be provided</li>
<li>You might need a more modern version</li>
<li>The OS-library might be compiled without optimization or the wrong optimization</li>
<li>The OS-library might have an obnoxious set of dependencies, that you don't need ( I love it when some library links in all of X).</li>
<li>Then it's also had comparing different versions because OS-level packaging doesn't allow for concurrent versions to exist.</li>
</ul>

<p>Worse, is that development and sysadmin hard directly coupled.  you need to get operations or sysadmin or security to sign off on upgrading <i>every</i> box.  And why should they care what version of Boost you need?  And they should be concerned since your changes could destabilize the box</p>

<p>Now, add this support for multiple versions of OS, and it's a mess.   This could be one Linux distro to another, or Linux vs a Unix, or, Linux vs. you local Mac.
Now you have two different packaging systems.  And the odds of them using them version of anything is about 0.  There is nothing wrong with OS-packaging.   It's just has a different set of requirements than you, the server developer have.  In particular upgrading compilers and libraries means the <i>every</i> package they have needs tests.  You just need <i>your</i> stuff to work, which  is maybe a dozen libraries.</p>

<h3>Sysadmin and Development: Loosely Coupled</h3>

<p>Back to the problem of server development:  decoupling or loosely couple the sysadmin and development group solves this problem.  Instead of using the OS-level packaging to solve all problems... use it to solve one problem: make a great core OS, and let the developers do what they do best: develop:</p>

<ul>
<li>With the operations/sysadmin  group pick a distribution/kernel that is solid.  You just want a solid kernel, good threading performance, works well with your hardware.  You don't need the latest and greatest of anything.</li>
<li>Add using the native system any package that is needed by the operations/sysadmin group.  And probably whatever outdated versions of perl and python.  These are fine for sysadmin and operation tasks and boostrapping</li>
<li>Add any especially painful development packages.  By painful I mean basic compilers (gcc) and perhaps some servers (mysql/postgres) that are hard to install and want the OS distribution to handle security issues.</li>
<li>With the exception of the few things from #3, the development group is now 100% responsible for <i>their</i> environment.  On the flip side, sysadmin/ops.
</ul>

<p>This means you have step up and:</p>

<ul><li>compile or install new compilers. Yeah painful, but also gives you flexibility in testing and changing them.  It's near impossible to do tests of new compilers with a OS-level package.  here's it just a rebuild.</li>
<li>Build all those little things you need: autoconf, libtool, zlib, bzlib2, libxm2, whatever.  If you are on Unix, that means Gnu's versions of tar and make.</li>
<li>learn crazy configure and build systems -- most of the time it's just CMM -- configure, make, sudo make install.  If it's more than that you can cheat by looking at what the OS does (e.g. RPM spec file, Port file, etc).</li>
</ul>

<h3>Developer Deployment</h3>

<p>Ok, I know what you are saying... every developer has to do this?  Perhaps, or... now that everything is built  <i>once</i>.  tarball it up that directory and give it to your friends.  In 30 seconds they'll have the complete, correct build environment.
 Being really clever you could make it an ISO, and have them mount it (read-only) even.
</p> 

<h3>Operations Deployment</h3>

<p>With the new system, sysadmin will need to install <i>one tarball</i>  for you. Or of course you can compile statically, and just hand over the final bits.</p>

<h3>Upgrades and Changes</h3>
<p>
What about upgrades or changes?  Ahhh nice...  You don't.  You rebuild from scratch and make a new image.  The whole mess of uninstall/reinstall and getting some weird amalgamation is gone.
</p>

<h3>Security</h3>
<p>
And security?  It's actually better since there are clear lines of responsiblity.  Currently if you ask sysadmin to install some library they don't need, who is responsible for it if some security flaw pops up?  You can already hear the argument in VP's office.  When the developer is responsible for their libraries -- - either your application caused it or it didn't.
</p>

<h2>Next time... </h2>
<p> Great you say, now how to do it.  That's next</p>

*****
Comment 2009-02-19 by None

We're waiting....


*****
Comment 2009-02-19 by None

coming soon, for real this time!


*****
Comment 2009-02-20 by None

Still waiting...<BR/><BR/>(Seriously, though, this is a great idea that I, as a sysadmin, wish would take the world by storm.  Having been in dependency hell too many times to count, it would be nice if things 'just worked' once in a while.)


*****
Comment 2009-03-15 by None

How about just using a chroot?  I have a fairly stable chroot env that doesn't get affected when I blow up my configs on my OS and I can upgrade the daylights out of my chroot and not worry about breaking the OS.  I just untar a saved copy of my chroot and I have a pristine new env to work in.  :)
