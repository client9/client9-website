---
layout: post
title: Polling, Mercurial, Basic Auth and Jenkins
---


Here's the problem (well, five problems).

* You are using Jenkins for CI
* You are using Mercurial for source control
* You are using Basic Auth to control access to the repo.
* There is no push notification from the repo
* A full clone takes over 30m due to a slow network link

This is not changeable.

Unfortunately, Jenkins doesn't work in this case.  You have to use an
old style basic-auth URL, and it confuses Jenkins:

```
ERROR: Workspace reports paths.default as https://auser@ahost/your/repo
which looks different than https://auser:apassword@ahost/your/repo
so falling back to fresh clone rather than incremental update
```

The solution is:

* Spend a week (or more) to debug Jenkins
* [Create another user acccount and use the .hginit file](http://blog.siliconvalve.com/2012/03/03/configure-mercurial-pull-with-http-authentication-for-jenkins-on-windows/)
* write your own polling function

I picked option #3.  I'm certainly not an expert in Mercurial or
Jenkins (and perhaps not Bash as you will see), but this appears to
work.  Send me an email if you got a better solution!

enjoy

```bash
#!/bin/sh

#
# Usage:  hgpoll directory hg-url
#   return 0 is no changes
#   return 1 if there is a change
#
# note: hg log -l 1 -b .
#  is the last change on current branch
#
hgpoll() {
    TARGET=$1
    HGURL=$2

    # linux uses md5sum, bsd/mac uses md5
    MD5=`which md5sum || which md5`

    # adjust as needed
    CHECKSUM_FILE1="`pwd`/hglog-md5"
    CHECKSUM_FILE2="`pwd`/hglog-md5-new"

    if [ ! -f "${CHECKSUM_FILE1}" ]; then
        echo "first time" > ${CHECKSUM_FILE1}
    fi

    if [ ! -d "${TARGET}" ]; then
        hg clone ${HGURL} ${TARGET}
        cd ${TARGET}
        hg log -l 1 -b . | ${MD5} > ${CHECKSUM_FILE1}
    else
        cd ${TARGET}
        hg pull ${HGURL} && hg update
        hg log -l 1 -b . | ${MD5} > ${CHECKSUM_FILE2}
        diff ${CHECKSUM_FILE1} ${CHECKSUM_FILE2}
        if [ "$?" -eq 0 ]; then
            # no difference
            return 0
        fi
        cp ${CHECKSUM_FILE2} ${CHECKSUM_FILE1}
    fi
    return 1
}

# NAME is a directory to checkout to
hgpoll NAME https://USERNAME:PASSWORD@HOST/PATH/TO/REPO

if [ "$?" -eq 0 ]; then
   exit 0
fi

echo "I will do a test now"
# continue, doing your build
# you are in the top level of the build now
```

