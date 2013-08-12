---
layout: post
updated: 2010-02-04
alias: /2010/01/installing-virtual-box-guest-additions.html
title: Installing Virtual Box Guest Additions for Linux
---
<p>The guest additions add all sorts of goodies, most importantly, syncing the time with your host computer. 

<p>Since I always forget here are the instructions:</p>

<ul>
<li>Click on the console (the black screen) of a running VBox.</li>
<li>In the menu bar, select Menu -&gt; Install Guest Additions</li>
<li>Then....</li>
</ul>

<pre>
# on the virtual box menubar
# select Devices > Install Guest Additions....
#  this "inserts a fake CD"
#
sudo mkdir /mnt/cdrom
sudo mount /dev/cdrom /mnt/cdrom/
cd /mnt/cdrom
# pick the amd64 for 64bit
# pick x86 for 32bit
sudo ./VBoxLinuxAdditions-amd64.run
date
# should be synced with your computer
</pre>