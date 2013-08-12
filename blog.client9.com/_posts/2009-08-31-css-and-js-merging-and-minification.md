---
layout: post
updated: 2009-08-31
alias: /2009/08/css-and-js-merging-and-minification.html
title: CSS and JS Merging and Minification
---
<p>
We already know that minifying you javascript and css code is good.   Even better is merging all those compressed files into one, to save round trips to the server (and of course you'll also want to add appropriate caching headers too).
</p>

<p>
The <a href="http://developer.yahoo.com/yui/compressor/">YUI Compressor</a> is the best of bunch.    I dont really use Java that much, but below is a bash script that semi-automates the install of java and jars.  If you use java regularly then you probably have your own system for this.
</p>

<p>YUI Compressor only does one file at a time, which is somewhat annoying, but ok.   The script below is designed for use in environments where java is not regularly used and makes the merge/minification step more unix-y.   At the end of the day, my script is just doing:</p>

<pre>
#!/bin/sh
cat $@ | java -jar yuicompressor-2.4.2.jar --type css
</pre>


<p>Example:</p>
<pre>
$ cat junk1.css



h1 

&#123;
 background:

 blue

&#125;

$ cat junk2.css
h2    &#123;   background:  red  &#125;



$ ./cssmerge.sh junk1.css junk2.css > master.css
$ cat master.css
h1&#123;background:blue;&#125;h2&#123;background:red;&#125;$
$ 
</pre>

<p> And the source:</p>

<pre>
#!/bin/sh                                                                       
# Usage:                                                                        
#    cssmerge.sh FILE1 FILE2 > OUTFILE                                            
# PUBLIC DOMAIN -- 31-Aug-2009
# http://blog.client9.com/2009/08/css-and-js-merging-and-minification.html
# Nick Galbreath
#

# Check that java exits, and exits if missing                                   
#  This is for ubuntu.... adjust to taste   
#                                                                               
function check_java &#123;
    JAVA=`which java`
    if [ $? -ne 0 ]; then
        echo "need java -- do " >&amp;2
        # Change as needed                                                      
        echo "sudo apt-get install openjdk-6-jre wget unzip" >&amp;2
        exit 1
    fi
&#125;

# Auto--download the right jar for the YUI Compressor                           
#   http://developer.yahoo.com/yui/compressor/                                  
#   Need to make sure wget,rm,cp,unzip don't emit output                        
#   Needs java                                                                  
function check_compressor &#123;
    check_java

    COMPRESSOR=yuicompressor-2.4.2
    URLBASE="http://yuilibrary.com/downloads/yuicompressor/"

    if [ ! -f "$&#123;COMPRESSOR&#125;.jar" ]; then
        echo "$&#123;COMPRESSOR&#125; not found, downloading...." >&2
        rm -rf "$&#123;COMPRESSOR&#125;*"
        wget -q "$&#123;URLBASE&#125;/$&#123;COMPRESSOR&#125;.zip"
        unzip -qq $&#123;COMPRESSOR&#125;.zip
        cp -f $&#123;COMPRESSOR&#125;/build/$&#123;COMPRESSOR&#125;.jar .
    fi
&#125;
# OUTPUT TO STDOUT                                                              
function merge_css &#123;
    FILES=$@
    check_compressor
    cat $&#123;FILES&#125; | $&#123;JAVA&#125; -jar $&#123;COMPRESSOR&#125;.jar --type css
&#125;

# OUTPUT TO STDOUT                                                              
function merge_js &#123;
    FILES=$@
    check_compressor
    cat $&#123;FILES&#125; | $&#123;JAVA&#125; -jar $&#123;COMPRESSOR&#125;.jar --type js
&#125;

# sample                                                                        
merge_css $@

</pre>