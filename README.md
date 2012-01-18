# BitArray: A fast(ish), pure Ruby bit field "type"

This is a simple rubygem wrapper for the class written by Peter Cooper and posted to dzone.

## History
- v5 (added support for flags being on by default, instead of off)
- v4 (fixed bug where setting 0 bits to 0 caused a set to 1)
- v3 (supports dynamic bitwidths for array elements.. now doing 32 bit widths default)
- v2 (now uses 1 << y, rather than 2 ** y .. it's 21.8 times faster!)
- v1 (first release)

## Description
Basic, pure Ruby bit array. Pretty fast (for what it is) and memory efficient.
Works well for Bloom filters (the reason I wrote it).

Create a bit array 1000 bits wide
```ruby
 ba = BitArray.new(1000)
```

Setting and reading bits
```ruby
ba[100] = 1
ba[100]    .. => 1
ba[100] = 0
```

More
```ruby
ba = BitArray.new(20)
[1,3,5,9,11,13,15].each { |i| ba[i] = 1 }
ba.to_s
#=> "01010100010101010000"
ba.total_set
#=> 7
```