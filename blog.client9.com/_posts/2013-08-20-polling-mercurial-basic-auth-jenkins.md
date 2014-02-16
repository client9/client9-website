---
layout: post
title: Polling, Mercurial, Basic Auth and Jenkins
---


Here's the problem (well, five problems):

* You are using Jenkins for CI
* You are using Mercurial for source control
* You are using Basic Auth to control access to the repo.
* There is no push notification from the repo
* A full clone takes over 30m due to a slow network link

This is not changeable.

Unfortunately, Jenkins doesn't work in this case.  You have to use an old style basic-auth URL, and it confuses Jenkins:

```
ERROR: Workspace reports paths.default as https://auser@ahost/your/repo
which looks different than https://auser:apassword@ahost/your/repo
so falling back to fresh clone rather than incremental update
```

The solution is:

* Spend a week (or more) to debug Jenkins
* [Create another user acccount and use the .hginit file](http://blog.siliconvalve.com/2012/03/03/configure-mercurial-pull-with-http-authentication-for-jenkins-on-windows/)
* write your own polling function

I picked option #3.  I'm certainly not an expert in Mercurial or Jenkins (and perhaps not Bash as you will see), but this appears to work.  Send me an email if you got a better solution!

enjoy

```bash
#!/bin/sh

# http://blog.client9.com/2013/08/20/polling-mercurial-basic-auth-jenkins.html
#
# Usage:  hgpoll hg-url
#   return 0 is no changes
#   return 1 if there is a change
#
hgpoll() {
    HGURL=$1

    # adjust as needed
    CHECKSUM_FILE1="`pwd`/hglog.txt"
    CHECKSUM_FILE2="`pwd`/hglog.txt-new"


    if [ ! -f "${CHECKSUM_FILE}"]; then
        echo "first time" > ${CHECKSUM_FILE}
    fi

    hg id -i -r tip ${HGURL} > ${CHECKSUM_FILE2}
    diff ${CHECKSUM_FILE1} ${CHECKSUM_FILE2}
    if [ "$?" -eq 0 ]; then
        echo "no changes..."
        # no difference
        return 0
    fi
    echo "found change!"
    cp ${CHECKSUM_FILE2} ${CHECKSUM_FILE1}
    return 1
}

hgpoll https://USERNAME:PASSWORD@HOST/PATH/TO/REPO

if [ "$?" -eq 0 ]; then
   exit 0
fi

echo "I will do a test now"
# continue, doing your build
# you are in the top level of the build now
```

