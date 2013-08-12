---
layout: post
updated: 2007-09-14
alias: /2007/09/processing-fixed-length-records.html
title: Processing Fixed-Length Records
---
<p>
Here's a trick to save memory when reading very large files of fixed-length-records into memory when using a scripting language. Especially those that use garbage collection.  For an overview of how scripting language use memory, see <a href="http://blog.modp.com/2007/09/scripting-languages-and-memory.html">my last post</a>
</p>

<p>For an example, we'll use the most excellent <a href="http://www.openstreetmap.org/">OpenStreetMap</a> project to <a href="http://wiki.openstreetmap.org/index.php/TIGER">convert US Census TIGER data</a></p>

<p>In this case they have to read several different fix-length-format files into memory and index them (meaning, everything stays in memory).  For the Tiger RT1 file, each line is 230 characters containing 45 fields!  The current converter is in ruby.  The code snippet below is the string offset (+1) and the length of the field.  Eeeck.
</p>

<pre>
    RT1_fields = &#123;
      :rs => [1,1],
      :version => [2,5],
      :tlid => [6, 10],
      :side1 => [16, 1],
      :source => [17, 1],
      :fedirp => [18, 2],
      :fename => [20, 30],
      :fetype => [50, 4],
      :fedirs => [54, 2],
      :cfcc => [56, 3],
      :fraddl => [59, 11],
      :toaddl => [70, 11],
      :fraddr => [81, 11],
      :toaddr => [92, 11],
      :friaddl => [103, 1],
      :toaiddl => [104, 1],
      :friaddr => [105, 1],
      :toiaddr => [106, 1],
      :zipl => [107, 5],
      :zipr => [112, 5],
      :aianhhfpl => [117, 5],
      :aianhhfpr => [122, 5],
      :aihhtlil => [127, 1],
      :aihhtlir => [128, 1],
      :census1 => [129, 1],
      :census2 => [130, 1],
      :statel => [131, 2],
      :stater => [133, 2],
      :countyl => [135, 3],
      :countyr => [138, 3],
      :cousubl => [141, 5],
      :cousubr => [146, 5],
      :submcdl => [141, 5],
      :submcdr => [151, 5],
      :placel => [161, 5],
      :placer => [166, 5],
      :tractl => [171, 6],
      :tractr => [177, 6],
      :blockl => [183, 4],
      :blockr => [187, 4],
      :frlong => [191, 10],
      :frlat => [201, 9],
      :tolong => [210, 10],
      :tolat => [220, 9]
    &#125;
</pre>


<h2>Immediate Lookup</h2>

<p>
To read an entire file of this and index by the <code>:tlid</code> you could do something like this where you chop up each line and put into a hash table immediately:
</p>

<pre>
class RT1
    def initialize(line)
      RT1_fields.each |key, slice|
         start = slice[0] -1
         len = slice[1]
         @data[key] = line[start, len] 
    end

    def [] key
      @data[key]
    end
end

# ...
fp.each_line do |line|
  record = RT1.new(line)
  id = record[:tlid]
  @database[id] = record
end

</pre>

<p>
Uhhh, I'm sure there is a more elegant way to do this in ruby by using object properties, but you get the idea.
</p>

<p>There is nothing wrong this this approach.  It only becomes a problem when you run out of memory and start swapping</p>

<p>The issue here is that each record causes 45 objects to be created.  With a large file, you'll be creating zillions of objects.  No matter what scripting language you use, the overhead is going to be pretty large.  I don't know the exact value, but I'm sure each object has at least 4 bytes of book keeping.  In our case that's almost as large as the actual data!
</p>

<p>And in a garbage collected language such as ruby, java, or javascript, it's going to have pause, and touch every one of these objects to figure out if they can deleted or not.  That means <i>slow</i>.</p>

<p>(NOTE: This is just an example.  The OSM project actually used a more sophicated version of this.)</p>

<h2>Deferred Lookup</h2>

<p>
The trick to save memory is to be lazy and just store the raw string, and extract the right field <i>when requested</i>.
</p>

<pre>
class RT1
    def initialize(line)
        @line = line
    end

    def [] key
      sliceval = RT1_fields[key]
      # minus one since the s
      @line[sliceval[0]-1, sliceval[1]]
    end
end

# ...
fp.each_line do |line|
  record = RT1.new(line)

  # lazy lookup of id
  id = record[:tlid]

  @database[id] = record
end
</pre>

<p>The cost of doing a single hash lookup and string slice is pretty close to 0, so performance shouldn't be much of an issue.   It will be a bit slower, but the big benefit is we dropped the number of long-lived objects per record from 46 to 2.  That's going to make the garbage collect much happer, and since we have fewer objects, we have less overhead, which means we use less memory.
</p>

<p>For large TIGER datasets, this technique drops memory usage by hundreds of megabytes!</p>