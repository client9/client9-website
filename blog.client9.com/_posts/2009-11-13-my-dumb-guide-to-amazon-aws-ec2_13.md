---
layout: post
updated: 2009-11-13
alias: /2009/11/my-dumb-guide-to-amazon-aws-ec2_13.html
title: My Dumb Guide to Amazon AWS EC2 - Security Groups, Bastion Hosts, and Firewalls
---
Amazon's <a href="">Security Groups</a> provide the basic firewall and
networking security.  You can of course suppliement it with your own
host-based firewall, but this provides the core.

<p> By default, an instance has no connectivity, either internal or
external.  This is a like a firewall that starts with a "DENY ALL".
By adding security groups, you are allowing different incoming
connections.  Either from your other instances, or from the outside
world.  </p>

<p>You assigned security groups before an instance starts.  The
ordering doesn't matter.  Once the instance starts you can't change
the membership.  </p>

<p> Out of the box, every EC2 instance comes with a "Default group".
It says any TCP/UDP/ICMP request from any other machine in your
Default group is allowed.  This allows <i>internal</i> connectivity.
This security group creates your "personal" VLAN -- other instances
that aren't yours can not connect to your instances.  </p>

<p>If you don't think this is hot, let me give an example of another
cloud provider.  In the Rackspace Cloud, your instance can connect to
<i>every</i> machine they have in the cloud (unless of course the
instance is running it's own firewall).  I'm sure Rackspace knows this
is lame and is working on it.  In the mean time, this is a problem you
don't have with Amazon</p>

<p>In the AWS Management Console there is another group, "SSH/HTTP"
which allows connections on ports 22, 80, and 443 (ssh, http, and
https).  If you have a one machine site, this is probably all you
need.</p>

<p> If for some reason you needed to expose your database to outside
world (say mysql on port 5506), you could create another group for
that and assign that your instance.</p>


<h2>Bastion Hosts</h2>

<p>For more complicated systems, allowing everyone to log into any
machine is problematic for a few reasons.  You have manage updates to
SSH (the binaries, keys) on every box.  It makes running intrusion
detection systems more difficult.</p>

<p>To simplify security management, create a <i>bastion host</i>.
This is only machine that allows <i>external</i> ssh connectivity.
From the bastion host you can ssh into your other instances.  </p>

<p>In Amazon, this is a snap.  Create a security group called
"bastion" which allows TCP port 22.  Create and instance with that
group and the default.  Create a plain "http" group that does <i>not
have</i> SSH access.  Then assign new machines to either the default
group or the default group + the http group.  </p>

<p>Ok here's the fun.  Because amazon's firewall is based on <i>group
membership</i> and not raw IP addresses.  You can terminate your
bastion host anytime.  When you need to log in, fire up a new instance
that has membership of default+bastion. Ta-da.  This is actually
better than a bastion host in a datacenter -- if it dies, you need to
make a trip to the data center (or have a backup).</p>

<p>This allow means external SSH access is completely OFF when the
bastion host is off.  That may be handy if you suspect you are under
attack.</p>

<h2> Group Updates </h2>

<p>While you can't change group membership when an instance is
running, you <i>can</i> change the group's rules.  You can delete or
add rules, and the change is immediate.  This allows you to make quick
changes, although I have yet to find a real need for this.  If your
bastion host is dead and you needed to quickly log-in, you could add
port 22 to the default group and you log in.  </p>

<h2>Host-Based Firewalls</h2>

<p>This could go wrong, either in some horrible failure with Security
Group, or more likely someone was tinkering with the security groups
and opened it up too far.  As a backup it's not a bad idea to run a
host-based firewall as well.  </p>

<p>In full form, you'd have a database of every machine in your
network and be able to generate the <code>iptables</code> config and
update every machine with it.  THis is tricky.</p>

<p>A more lame version would to have the firewall reject any port that
you don't use.  Or allow from only the 10. network.  For instance:</p>

<pre>
DENY ALL
ALLOW 22/TCP FROM ALL
ALLOW 5606/TCP FROM 10.*.*.*
</pre>

<p> In other words, always allow SSH.  Allow connections to MYSQL
<i>only</i> from inside EC2.  That's not great but will prevent people
probing your MySQL from outside world.</p>

*****
Comment 2009-12-30 by None

Thanks for a very clear description of this topic! This helped me a lot.


*****
Comment 2012-01-22 by None

Thanks for writing this!
