---
layout: post
updated: 2008-04-09
alias: /2008/04/getting-started-with-ec2.html
title: Getting Started with EC2
---
<p>
Wow is EC2 fussy.  You know this already.  Such is life when using public-key encryption.  if you are just getting started, the following greatly simplifies the situation.  It won't handle multiple accounts or multiple instances, but sometimes one is all you need.
</p>

<p>
First, go through the stock EC2 tutorial.  And then compile all the keys and stuff into one spot like so:
</p>

<pre>
export S3_PUBLIC='your s3 public key'
export S3_PRIVATE='your s3/private key'
export EC2_PRIVATE_KEY='./pk-YOURCERT.pem'  # somewhere
export EC2_CERT='./cert-YOURCERT.pem'  # somewhere

export EC2_HOME='./ec2-api-tools-1.3-19403'  # OR SOMETHING
export PATH=$EC2_HOME/bin:$PATH

export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.5.0/home

export AMI='ami-226e8b4b'   # or something

export EC2_SSH_KEY=yourname-keypair
</pre>


<p>
Ok, now the following functions make it simple to start stop and login
</p>

<pre>

# VERSION 3 -- now with ec2do
# VERSION 2 -- now with push/pull

function ec2start &#123;
    ec2-run-instances $AMI -k $EC2_SSH_KEY
&#125;

function ec2list &#123;
    ec2-describe-instances
&#125;

function ec2host &#123;
   # it's one line below
    ec2-describe-instances | grep INSTANCE | grep amazonaws.com | head -n 1 | awk '&#123;print $4&#125;'
&#125;

function ec2id &#123;
   # it's one line below
    ec2-describe-instances | grep INSTANCE | grep amazonaws.com | head -n 1 | awk '&#123;print $2&#125;'
&#125;

function ec2stop &#123;
    echo "Stopping..."
    ec2-terminate-instances `ec2id`
&#125;

function ec2login &#123;
    ssh -i id_rsa-$EC2_SSH_KEY root@`ec2host`
&#125;

function ec2push &#123;
    scp -i id_rsa-$EC2_SSH_KEY $1 root@`ec2host`:~/
&#125;

function ec2pull &#123;
    scp -i id_rsa-$EC2_SSH_KEY root@`ec2host`:$1 .
&#125;

function ec2do &#123;
       ssh -i id_rsa-$EC2_SSH_KEY root@`ec2host` $@
&#125;

function ec2help &#123;
    echo "haha"
    echo ""
    echo "ec2list  -- alias for ec2-describe-instances"
    echo "ec2start -- starts one instance"
    echo "ec2stop  -- stops an instance"
    echo "ec2id    -- lists the reservation id of a running instance"
    echo "ec2host  -- lists the host of a running instance"
    echo "ec2login -- log in to running instance"
    echo "ec2push localfile  -- push a file to remote homedir"
    echo "ec2pull remote -- pull a remote file to local current dir"
    echo "ec2do cmds -- execute a command remotely"
&#125;
</pre>

<p>
Put all of that into your profile, and you'll be all set.  Enjoy..
</p>