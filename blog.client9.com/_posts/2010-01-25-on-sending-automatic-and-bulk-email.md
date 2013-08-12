---
layout: post
updated: 2010-02-05
alias: /2010/01/on-sending-automatic-and-bulk-email.html
title: On Sending Automatic and Bulk Email
---
<p>
Wow, email sure became complicated, especially from the cloud, especially from EC2.  Oh you'll need to know about BIND, reverse DNS or alternatives, SPF records, blacklists, and all sorts of other crap.
</p>

<p>But just as you have outsourced your datacenter by using the cloud, outsource your email sending as well.  Checkout <a href="http://www.authsmtp.com/">AuthSMTP</a>.  With pricing start at $24/YEAR, you might as well start using it before you get yourself into trouble.
</p>

<p>And check out Paul Dowman's great article on how to configure this: <a href="http://pauldowman.com/2008/02/17/smtp-mail-from-ec2-web-server-setup/">A rock-solid setup for sending SMTP mail from your EC2 web server</a>
</p>

<h2> More Notes</h2>

<P>
AuthSTMP let's set up a list of authorized "From" accounts that can send email. If it's not on the list, it will be rejected.  Both the <i>unix user</i> and the email <i>from:</i> must in AuthSTMP's list.  If you webserver running as "www-data" is sending email as "bobsmith@yourcompany" then you have to authorize both "www-data@..." and "bobsmith@...".
</p>

<p>You are going to want to set up a bogus "root@..." account that will be forwarded to you, and add "root@..." to the approved senders.   If a cronjob or some system process sends email, you want to make sure you get it.  As as mentioned, you'll also want to allow "www-data" (or whatever user your webserver runs as) or "nagios" to be allowed to send email too.
</p>

<p>In most cases, uou will also want to set up that bogus "noreply" email group too and add that to the approved list.</p>

<h2> Handy Postfix Commands </h2>


<p>While configuring all this, you'll like screw up and have a bunch of mail stuck in the postfix queue.  To delete them all do:
</p>

<pre>
sudo postsuper -d ALL
</pre>