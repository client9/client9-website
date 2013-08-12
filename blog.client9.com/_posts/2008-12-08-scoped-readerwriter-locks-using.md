---
layout: post
updated: 2008-12-22
alias: /2008/12/scoped-readerwriter-locks-using.html
title: Scoped Reader/Writer locks using Boost::thread
---
<p>
The good news: <a href="http://www.boost.org/doc/libs/1_37_0/doc/html/thread.html">boost::thread 1.37</a> has native reader/writer lock (they call them <code>shared_mutex</code>).  The bad news: there is no scoped version of these, so you have to "manually" <code>lock_shared</code>, <code>unlock_shared</code>.     Here's "scoped" versions of these
</p>

<pre>
// this code is in public domain
// http://blog.modp.com/2008/12/scoped-readerwriter-locks-using.html

#include &lt;boost/thread/shared_mutex.hpp&gt;

class scoped_read_lock
&#123;
private:
  boost::shared_mutex&  rwlock;
public:
  scoped_read_lock(boost::shared_mutex& lock)
    : rwlock(lock) &#123; rwlock.lock_shared(); &#125;
  ~scoped_read_lock() &#123; rwlock.unlock_shared(); &#125;  
&#125;;

class scoped_write_lock &#123;
private:
  boost::shared_mutex& rwlock;
public:
  scoped_write_lock(boost::shared_mutex& lock)
    : rwlock(lock) &#123; rwlock.lock(); &#125;
  ~scoped_write_lock() &#123; rwlock.unlock(); &#125;
&#125;;
</pre>

Usage:
<pre>
boost::shared_mutex mylock.
...
...
&#123; 
  scoped_reader_lock reader_lock(mylock);
   // stuff...
   // stuff...
&#125; // unlocked automatically
</pre>

*****
Comment 2008-12-11 by None

Funny that you wrote about this cos I'm just hacking away at this on you know what.  :)


*****
Comment 2010-01-02 by None

Boost 1.35 and later have scoped versions of these as well... (see http://www.boost.org/doc/libs/1_40_0/doc/html/thread/synchronization.html#thread.synchronization.locks.shared_lock)<br /><br />Code:<br />--------<br /><br />/* The shared mutex */<br />boost::shared_mutex rwlock;<br /><br />/* Acquire shared ownership. */<br />boost::shared_lock lock(rwlock);<br /><br />/* Now holding shared ownership of rwlock. */<br /><br />--------
