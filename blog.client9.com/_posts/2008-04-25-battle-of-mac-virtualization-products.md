---
layout: post
updated: 2008-04-25
alias: /2008/04/battle-of-mac-virtualization-products.html
title: Battle of Mac Virtualization Products
---
<p>
I just evaluated three virtualization product for the Mac:  <a href="http://www.parallels.com/en/products/desktop/">Parallels Desktop</a> For Mac 3.0 (build 5584), <a href="http://www.vmware.com/products/fusion/">VMware Fusion</a> 1.1.2, and <a href="http://www.virtualbox.org/">Virtual Box</a> (Version 1.5.51) to run Ubuntu Linux 8.0.4 (Hardy) <i>server</i>.  (not the desktop version).  My test system is a MacBook (not pro) with 2G of RAM and 2.2 Ghz Intel Core 2 Duo on Mac OS X 10.5.2 (Leopard).  This is an 64-bit CPU and OS.
</p>

<p>
Ok, now that I'm done with adding keywords for search engine, you might <i>why?</i>.   The goal is develop software on a platform that is as close as possible to the final deployed version.   But isn't Mac with it's "BSD-core"  along with MacPorts or Fink or Gentoo Linux for Mac good enough?  The short answer is no, and I'll write that up in another post.   You might also ask why don't I just ditch Mac altogether and just Ubuntu Desktop.   Here the answer is because I like the Mac hardware, the OS, and mostly because cause I don't want to.   I suppose later on that well might be a good answer, but even then, I'd still use virtualization (again, another post).
</p>

<p>
Most of these product heavily advertise on Windows-Mac integration and accelerated graphics and whatnot.  I'm not testing any of that.  I'm testing how easy is it to install and the performance.
</p>

<h3><a href="http://www.parallels.com/en/products/desktop/">Parallels Desktop</a> For Mac 3.0</h3>

<p>I downloaded this, got my 15-day trial key and we are off to the races.</p>

<p>The UI is pretty good, and the installed answering a few questions wasn't bad, although it wasn't always very clear.  A few options I needed were hidden and took a few times to figure out what exactly I needed to do.  To be fair, it was my first time using <i>any</i> virtualization product.</p>

<p>Ok the bad news is that Parallel needs a bit of help to get the server install to boot.  The installer kernel is fine, but the stock server kernel does not boot.  You need to then "Repair broken install" drop down to root, uninstall the kernel and then install th stock desktop kernel.  (Read about it:  <a href="http://snippets.aktagon.com/snippets/101-Solution-for-Kernel-panic-CPU-too-old-for-this-kernel-when-installing-Ubuntu-on-Parallels">here</a>, <a href="https://bugs.launchpad.net/ubuntu/+source/linux-source-2.6.22/+bug/151942">here</a>, and <a href="http://virtualbox.org/ticket/212">here</a>)
</p>

<p>64-bit Ubuntu kernels did not boot either.  I didn't try the hack to swap kernel versions</p>

<p>Anyways, once it's up, it works, and works well.  Networking is no problem,  ifconfig works, you can find your IP and ssh into the box, no problem.  I did find occasionally if I put the computer to sleep, the networking didn't always return.   Doing "nothing" (waiting for login prompt)  the Parallels VM takes 12-16% of the CPU.    If you suspend the VM, 3% of CPU is being used (for what?).   That said, over all the performance is very good.   For a few of the processes I tested, the overall runtime was about equal to native, but much more CPU was used (which is fine).
</p>

<p>Ok here's one crazy thing.  The file system seems faster on the VM than on the native mac osx!  (there are many ways this could be possible but who can say).

<h3><a href="http://www.virtualbox.org/">Virtual Box</a> 1.5.51 Beta 3</h3>

<p>Their big claim to fame is that it's open source and free. These guys just got bought by Sun.  It's not clear what they are intending to do with them.   But you can guess.  It's a GPL VM so any Linux distro can include it.  This will make OpenSolaris easy to install and try out.  And you can guess that OpenSolaris will run the best.  Who can say.  Anyways...
</p>

<p>
Sadly, at least for now on Mac, you get what you pay for.  The UI is very confusing, and frequently dead-ends, where you effectively have to restart (you get a modal dialog with no buttons... nice).   While the install kernel booted the final image did not (this appears to be fixed in an <a href="http://virtualbox.org/ticket/212">upcoming version</a>)  Also compared Parallels, it was noticeably slower.  The idle VM took 25% of the CPU (!!) during the install.
</p>

<p>Given the price point it's worth checking out, and the version I checked was a "beta 3".  We'll see what Sun does.</p>


<h3><a href="http://www.vmware.com/products/fusion/">VMware Fusion</a> 1.1.2</h3>

<p>
I spoke  with a VC yesterday and we had a nice chat on virtualization on Mac and recommended <a href="http://www.vmware.com/products/fusion/">VMware Fusion</a>.
</p>

<p>Downloaded, 30-day trial key (retail is $80 same as Parallels), and..</p>

<p>Whoa.   So litterally in about 5 seconds of starting this up, my Ubuntu iso image was booting and installing.
</p>

<p>The final install booted without any monkey business like Parallels and VirtualBox</p>

<p> VMWare correctly emulated, and I <i>did not</i> have to use 
<p>The idle VM takes on 5%, and when suspending VMWare takes 0% CPU.  I like that!</p>

<p>And without any modifications, VMware can install and boot 64-bit kernels (i.e. ubuntu-8.04-server-amd64.iso)</p>

<p>And as a bonus, VMware provide pre-configured VMs with various linux distributions (Fedora, Cent, etc).</p>

<h3>Conclusion</h3>

<p>
So right <i>now</i>, 25-Apr-2008, VMware is the clear winner.  But honestly, the VM space is hyper-competitive.  In a few months, this will probably be wrong.  Parallels certainly works and works well.   If the VirtualBox cleans up it's act, the whole basic server VM space on Mac might be commodity.
</p>