---
layout: post
updated: 2007-11-21
alias: /2007/11/frequency-counting-in-python.html
title: Frequency Counting in Python
---
<p>Let's say you need to keep track of frequency count of arbitrary items.   For instance parsing a log file or doing a word count and seeing what terms come up most often.</p>

<p> Python lets you subclass the built in <code>dict</code> class (hash table).   An extension to aid in frequency counting is listed below.   It's nothing particular special, but it's simple, it works, and it's fast.  Enjoy!
</p>

<pre>
class dictcount(dict):

    def add(self, key, value=1):
        self[key] = self.get(key,0) + value

    def sum(self):
        return sum(self.itervalues())

    def sortByValue(self, reverse=True):
        return sorted(self.iteritems(),
                      key=lambda (k,v): (v,k),
                      reverse=reverse)
</pre>

<p>Sample run: </p>

<pre>
$ python
&gt;&gt;&gt; d = dictcount()
&gt;&gt;&gt; d.add('foo')
&gt;&gt;&gt; d.add('foo')
&gt;&gt;&gt; d.add('bar', 2)
&gt;&gt;&gt; d.add('bar', 3)
&gt;&gt;&gt; d.sum()
7
&gt;&gt;&gt; d.sortByValue()
[('bar', 5), ('foo', 2)]
</pre>

<p> Of course all the regular <code>dict</code> methods are available too.</p>