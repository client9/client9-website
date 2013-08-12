---
layout: post
updated: 2009-11-25
alias: /2009/11/virtualbox-guest-additions-ubuntu.html
title: VirtualBox, Guest Additions, Ubuntu
---
<p>
Just the facts ma'am.
</p>

<ul>
<li>Click on the console of a running Ubuntu VM.</li>
<li>In the DEVICES menu bar, select <code>Install Guest Additions</code></li>
<li>Do the following in the console (or terminal)</li>
</ul>

<pre>
sudo apt-get install linux-headers-generic gcc
# apt-cache search linux-headers if this isn't quite right

sudo mount /media/cdrom0 /dev/cdrom

sudo /media/cdrom0 VBoxLinuxAdditions-x86.run
# OR VBoxLinuxAdditions-amd64.run if 64-bit linux

sudo reboot
</pre>
<ul>
<li>Unmount the cdrom.  Click the cdrom icon on the bottom of the console</li>
</ul>