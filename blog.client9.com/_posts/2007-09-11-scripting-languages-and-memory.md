---
layout: post
updated: 2007-09-14
alias: /2007/09/scripting-languages-and-memory.html
title: Scripting Languages and Memory Management
---
<p>
One of the great benefits of using a scripting language (and Java) is that memory management is done for you.  You make new objects, and magically they get zapped when they are no longer needed.
</p>

<p>Most of the time.</p>

<p>While <i>normally</i> everything works well, there are times when you scale up or have complicated data structures when the scripting language needs a little help.</p>

<p>
To aid in diagnosing memory problems, the follow is a crude description of how popular scripting languages deal with memory management.
</p>

<h2>Scripting Objects</h2>

<p>By an "object" I mean something that uses memory.  It could be a Class-Object object, or it could be an array, a string or a hash table.  Anything.</p>

<p>For just about every language besides C/C++, when you create an object, you actually create two things.  The actual raw object in memory.  You don't get to touch that directly.  The other is a reference to the object.  You do get to play with that.  You use the reference to manipulate the underlying memory.</p>

<h2>Reference Counting</h2>

<p>
Python, Perl, and PHP use <i>reference counting</i> to manage memory.  It's just what you think it is.</p>

<ul>
<li>When you create an object, it's reference count is 1.</li>
<li>When it goes out of scope the reference count is decremented.</li>
<li>If the count is 0, the object is destroyed and memory is released.</li>
<li>When another object contains or refers to your object, the reference count is increased.</li>
<li>Then an object is destroyed, all it's children get their reference count decremented.</li>
</ul> 

<p>
The good news is that it's conceptually simple to implement, and it's very clear what-is-happening-when (as compared the next method).  Memory usage is more or less predictable.
</p>

<p>
The bad news is that just about everything you do involves constantly incrementing and decrementing reference counts.  This eats CPU time.
</p>

<p>
The other bad news is that you can have circular references where two objects point to each other so their reference count never goes to 0.
</p>

<p>
More bad news: it can be hard for the low level developers to "get it right" (in the raw C/C++ code, they have to manually add those increments and decrements, so you don't have to.)
</p>

<h2> Garbage Collection </h2>

<p>
Java, Javascript/Actionscript and Ruby use a different system called "mark and sweep" to do "garbage collection".  These systems have a "root" object in the global scope where everything else is some how connected to it. The interconnections between objects creates a "graph."  Somewhere else is a list of every object allocated in the system.  
</p>

<p>To delete objects that are no longer used, the following process is used:</p>

<ul>
<li> Set a flag to 0 on <i>every object</i> in existence</li>
<li> Starting at the root node, do a depth or breadth first descent in the graph marking each object as you go</li>
<li> Scan every object and see what was not marked: these are dead objects and can be deleted</li>
</ul>

<p> While the garbage collection process sounds gross, in practice all memory management code is <i>one place</i> so it can be optimized.  In general its very fast.</p>

<p> Good news: circular references can't hide.  If an object isn't part of the main graph, it gets killed.</p>

<p> The bad news is that when garbage collection happens,
 the program pauses (although multithreaded garbage collectors do exist).
</p>

<p> Memory usage is hard to predict.  Typically GC programs can have large swings in the amount of memory used.</p>

<h2> In Practice</h2>

<p>
The above descriptions were very simple.  In practice, some use hybrids.  Some defer releasing memory in order to prevent "holes."   Some create different pools or categories of objects. Some use a different technique for strings.
</p>

<h2> What's better?</h2>

<p>Well it all depends and it's devil in the details.</p>

<p> In theory garbage collection systems have the potential for being more stable since nothing can leak and higher performance system since you aren't constantly adding and subtracting.  And since the deallocation is deferred it can in theory make smart choices to prevent memory fragmentation.  However a good collector is hard to write.
</p>

<p>
For short-lived applications, such as PHP, (where at the end of the HTTP response Apache deletes all memory PHP allocated anyways) reference counting is very fine and probably optimal.
</p>

<p>
In most cases it doesn't matter.
</p>

<h2> The Big Problem with Reference Counting</h2>

<p>You can't really measure the CPU cost of doing referencing counting since it's  embedded deeply in the code.  Either you are happy with the performance of your scripting language or not.</p>

<p>The big problem is circular references, where memory never gets released.  Normally it's not too hard to spot where the problem is, it's typically data structures that point to each other.  To fix, you can alter the datastructure or explicitly null or zero out some of it's members to break the circular chain</p>

<p> Do a search on "<i>your scripting languge</i>" with "circular reference" and you'll find plenty of tips.</p>

<h2> The Big Problem with Garbage Collection</h2>

<p>In most "normal" programs you can't even notice the garbage collection.  GC works well for a few hundred thousand <i>concurrent</i> objects.  But once you get into the millions, it can be a real problem.</p>

<p>Generating millions of object is easy to do if you are implementing a large in-memory database, caches, or in-memory data processing. In these cases, you might experience a lot of garbage collection and very little work getting done.</p>

<p>To fix that you have to be clever so you make less objects, or you might want to try using a reference-counted language (or go C/C++ where you have direct control, but that's another topic).</p>