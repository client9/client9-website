---
layout: post
updated: 2007-08-29
alias: /2007/07/ssh-and-scp-without-passwords.html
title: SSH and SCP Without Passwords
---
<p><em>NOTE: I first posted this in May, 2005, and it turned out to be very popular!   It's still just as accurate now as it was then.  I just re-edited  so everyone can leave comments.  --nickg NYC, July 2007</em></p>

<p>Is the constant typing of your password with SSH and SCP making you nuts?  Are you pulling your hair out trying to figure out public keys? Can't get 'push_keys' to work?  Don't have root access?  Yeah, me neither.  Here's a sleazy way of avoiding passwords with SSH and SCP by using Expect.
</p>

<p>SSH and SCP are essential tools.  At the same time they can make you nuts by constantly having to enter passwords.  You can use "push_keys" to use public/private key pairs, but this is tricky, it requires root powers, and doesn't work on hosts that get reimaged (since your public key gets wiped).
</p>

<p>Expect is a program to automate <em>interactive</em> programs by using a sequence of <code>expect</code> and <code>send</code> commands.  It's very stable, and installed on virtually every Unix/Linux/MacOSX system.  Type in "<code>which expect</code>" and check the result.</p>

<p>Expect was basically "finished" in 1994, and is based on the TCL programming language.  Because of this (or in spite of this), Expect seems to be a bit of a "lost art".  Don't worry about learning TCL: expect is very simple.  You'll get the basics in about 10 seconds.</p>

<h4>SSH</h4>

<p>The following 7 line script automates an ssh login:</p>

<pre>
#!/usr/bin/env expect -f   # -*-tcl-*-
set timeout 60
spawn ssh -l <em>username</em> <em>server</em>
expect "password: $"
send "<em>password</em>\n"
expect "%$"  # or maybe "$ $"
interact</span>
</pre>

<p><strong> Since this script contains an actual password, you should protect it so only you can read it by doing a <code>chmod 700 <em>file</em></code> on it.</strong></p>

<h5>Line By Line</h5>

<p>
<code>#!/usr/bin/env expect -f   # -*-tcl-*-</code>
</p>

<p>
If you never seen it before <code>/usr/bin/env <em>cmd</em></code> means "use whatever version available" using the current environment shell. In our case the comamnd is "expect -f".  The second "#" means a comment it's just for emacs to know we should be in tcl-mode.
</p>

<p>
<code>set timeout -1</code>
</p>

<p>
SSH sessions can take a while to establish.  This eliminates the default timeout value of 10 seconds.
</p>

<p>
<code>spawn ssh -l <em>username</em> <em>server</em></code>
</p>

<p>
The  command <code>spawn</code> just starts up any command that expects  interactive input.  In our case it's ssh.
</p>

<p>
<code>expect "password: $"</code>
</p>

<p>The expect command parses the output from the spawned process, and waits until it finds a string match. The "$" is used for end-of-string, just like regexp.  This great for preventing false-matches, but just make sure to add any spaces.  Here we are waiting for the password prompt.</p>

<p>
<code>send "<em>password</em>\n"</code>
</p>

<p>The send command simulates  typing. In this case our password, and the return key. <code>expect "%$"</code></p>

<p>On my system, I get csh as the default.  It as a prompt of just "%". On sh/bash systems, you'll probably want something like <code>expect "\\$ $"</code> to use the "$" prompt symbol.</p>

<p>
<code>interact</code>
</p>

<p>The automation stops, releases it's connections and hand back the terminal to you.  You are logged in!</p>

<h4> An SCP example</h4>

<p>An automatic SCP is given below:</p>

<pre>
#!/usr/bin/env expect -f   # -*-tcl-*-
set timeout -1            # wait until done

# trick to pass in
# command-line args to spawn
eval spawn scp $argv

expect "password: $"
send "<em>password</em>\n"

# wait for regular shell prompt before quitting
# probably a better way using 'wait'
expect "$ $"
</pre>

<p>
It should work just like scp except you dont need to type your password. The only gotcha is passing flags to scp.  By default, expect will consume any flags it sees, so "ascp -v" is really "expect -v" (and displays the expect version number).  If you want to pass to scp, make "--" by the first flag "ascp -- -v" (pass the verbose flag to scp).
</p>

<h4> Learning more</h4>

<p>Our little examples are fine for simple usage, but don't handle failure cases and are not suitable for a production environment.  For more information, see:</p>

<ul>
<li> RTFM!!  "man expect"</li>
<li><a href="http://expect.nist.gov/">Expect Home</a></li>
<li><a href="http://wiki.tcl.tk/">Tcl Wiki</a></li>

<li> This is the main book on expect.  A <a href="http://www.oreilly.com/catalog/expect/chapter/ch03.html">sample chapter</a> is available online.</li>
</ul>
<iframe src="http://rcm.amazon.com/e/cm?t=modp-20&o=1&p=8&l=as1&asins=1565920902&fc1=000000&=1&lc1=0000ff&bc1=000000&lt1=_blank&IS2=1&f=ifr&bg1=ffffff&f=ifr" marginwidth="0" marginheight="0" frameborder="0" height="240" scrolling="no" width="120"></iframe>

<p>Enjoy!</p>

*****
Comment 2007-11-22 by None

Hi Nick,<BR/><BR/>thanks for this useful script. I had some troubles getting it to work in Ubuntu 7.10.  The error message was:<BR/><B>/usr/bin/env: expect -f: No such file or directory</B>.<BR/><BR/>A workaround for this problem is to change the first line to:<BR/><BR/><B>#!/bin/sh<BR/>#\<BR/>exec expect "$0" -f $&#123;1+"$@"&#125;</B>


*****
Comment 2008-08-28 by None

ssh-keygen support this in a more principled way without having to keep your password in plain text


*****
Comment 2008-09-04 by None

You don't need root access to get scp keys to work, you just need to be able to write to the .ssh folder of the user you are trying to log in as, which presumably you have if you have the password.<BR/><BR/>Where root access is helpful is troubleshooting if it doesn't work, since the errors are often in the syslog of the server you are trying to connect to.  They almost always have to do with permissions on the "authorized_keys" file.
