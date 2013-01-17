# BitArray: A simple bit array/bit field library in pure Ruby

Basic, pure Ruby bit field. Pretty fast (for what it is) and memory efficient. Works well for Bloom filters (the reason I wrote it).

Written in 2007 and not updated since then, just bringing it on to GitHub by user request. It used to be called BitField and was hosted at http://snippets.dzone.com/posts/show/4234 .. I will review the code and bring the docs up to date in due course.

## Installation

```ruby
gem install bitarray
```

## Examples

To use:

```ruby
require 'bitarray'
```

Create a bit array 1000 bits wide:

```ruby
ba = BitArray.new(1000)
```

Setting and reading bits:

```ruby
ba[100] = 1
ba[100]
#=> 1

ba[100] = 0
ba[100]
#=> 0
```

More:

```ruby
ba = BitArray.new(20)
[1,3,5,9,11,13,15].each { |i| ba[i] = 1 }
ba.to_s
#=> "01010100010101010000"
ba.total_set
#=> 7
```

## History
- v5 (added support for flags being on by default, instead of off)
- v4 (fixed bug where setting 0 bits to 0 caused a set to 1)
- v3 (supports dynamic bitwidths for array elements.. now doing 32 bit widths default)
- v2 (now uses 1 << y, rather than 2 ** y .. it's 21.8 times faster!)
- v1 (first release)

## License

MIT licensed. Copyright 2007-2013 Peter Cooper, yada yada.