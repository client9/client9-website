---
layout: post
updated: 2011-10-16
alias: /2008/10/core-dumps.html
title: Everything you wanted to know about core dumps, but were afraid to ask
---
<h3>Basics</h3>The latest trend in Linux (and Mac OS X) distributions is to turn off core dumps.  And since core dumps are your friend if you are developer, you'll want to fix this.<br />
You can check the size of the core dump file with the bash command <code>ulimit</code>:<br />
<pre>$ ulimit -c
0
</pre>Means, "no core dumps".  To turn them back on:<br />
<pre>$ ulimit -c unlimited
$ ulimit -c
unlimited
</pre><h3>Core Dump Unit Test</h3>If you are testing how and where core dumps occur, changing ulimits in system files, etc, you want some way of making core dumps "on demand" to make sure you got it right.  This little C program can be compiled with <code>gcc -o coredump coredump.c</code>.  Now you can make all core dumps you want. <br />
<pre>#include &lt;stdlib.h&gt;

int main(int argc, char**argv) &#123;
  abort();
  return 0;
&#125;
</stdlib.h></pre><h3>Linux</h3>Detailed notes can be found with <code>man core</code>.  Since it's linux, it may vary for your version.  The main point is that you can control the core file naming using the <code>/proc</code> filesystem or <code>sysctl</code>.  <br />
<pre>$ ls -l /proc/sys/kernel/core*
-rw-r--r-- 1 root root 0 2008-10-15 18:06 /proc/sys/kernel/core_pattern
-rw-r--r-- 1 root root 0 2008-10-15 18:06 /proc/sys/kernel/core_uses_pid

$  cat /proc/sys/kernel/core_pattern
core
</pre>The core pattern uses a <code>printf</code> style string (from the <code>core</code> man page:<br />
<pre>%%  A single % character
         %p  PID of dumped process
         %u  real UID of dumped process
         %g  real GID of dumped process
         %s  number of signal causing dump
         %t  time of dump (seconds since 0:00h, 1 Jan 1970)
         %h  hostname (same as ’nodename’ returned by uname(2))
         %e  executable filename
</pre>For instance: <br />
<pre>echo "/var/corefiles/core-%e-%p.core" &gt; /proc/sys/kernel/core_pattern
</pre>Make sure the filename is "unique" using the PID if you have multiple instances running<br />
<b>Important!</b> If you are debugging a server, note this little detail on the man page (<code>man 2 setuid</code>):<br />
<blockquote>If uid is different from the old effective uid, the process will be forbidden from leaving core dumps. </blockquote>I guess this is some security check but can make debugging difficult.<br />
<h3>Core File Cleanup</h3>Core files can be large.  And if you are having problems, your disk can filled up fast interferring with regular operations.  You'll have to have a <code>cron</code> process to find and remove old core files.<br />
Another option is to make a special disk partition where core files can live. If it fills up, nothing particularly bad happens.<br />
<h3>Forcing an application to dump core </h3>You can make a running application dump core by send the right signal via <code>kill</code>.   Which signal may depend your application but <code>SIGTRAP</code> frequently works.  You can get a list of signals with <code>kill -l</code><br />
<pre>$ kill -s SIGTRAP 4321
FATAL ERROR (5) Trace/breakpoint (core dumped)
</pre><h3>Mac OS X</h3>Core files are in the <code>/cores</code> directory.  I'm not sure if this can be changed.  By default <code>ulimit -c</code> is 0