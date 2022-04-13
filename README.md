# BitArray: Pure Ruby bit-array/bitfield library

A simple, pure-Ruby 'bit field' object. Works well for Bloom filters (the use case for which I originally wrote it, although there are numerous good libraries for that task now).

Despite its age, BitArray has been updated to work within a typical, modern Ruby environment, but is only 'mildly' maintained.

## Installation

```ruby
bundle add bitarray
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

Initializing `BitArray` with a custom field value:

```ruby
ba = BitArray.new(16, ["0000111111110000"].pack('B*'))
ba.to_s # "1111000000001111"
```

`BitArray` by default stores the bits in reverse order for each byte. If for example, you are initializing `BitArray` with Redis raw value manipulated with `setbit` / `getbit` operations, you will need to tell `BitArray` to not reverse the bits in each byte using the `reverse_byte: false` option:

```ruby
ba = BitArray.new(16, ["0000111111110000"].pack('B*'), reverse_byte: false)
ba.to_s # "0000111111110000"
```

Saving and loading `BitArray`:

```ruby
ba = BitArray.new(16, ["0000111111110000"].pack('B*'))
ba.dump(File.new("bitarray.dat", "w"))
#=> #<File:bitarray.dat>
ba = BitArray.load(File.open("bitarray.dat"))
ba.to_s # "1111000000001111"
```

Read-only access without loading it into memory:

```ruby
ba = BitArray.new(16, ["0000111111110000"].pack('B*'))
ba.dump(File.new("bitarray.dat", "w"))
ba_ro = BitArrayFile.new(filename: "bitarray.dat")
ba_ro[0] # 1
ba_ro[4] # 0
```

## History
- 1.4 in 2022 (cleanups, add unions, dump/load, and BitArrayFile)
- 1.3 in 2022 (cleanups and a minor perf tweak)
- 1.2 in 2018 (Added option to skip reverse the bits for each byte by @dalibor)
- 1.1 in 2018 (fixed a significant bug)
- 1.0 in 2017 (updated for modern Ruby, more efficient storage, and 10th birthday)
- 0.0.1 in 2012 (original v5 released on GitHub)
- v5 (added support for flags being on by default, instead of off)
- v4 (fixed bug where setting 0 bits to 0 caused a set to 1)
- v3 (supports dynamic bitwidths for array elements.. now doing 32 bit widths default)
- v2 (now uses 1 << y, rather than 2 ** y .. it's 21.8 times faster!)
- v1 (first release)

## Thanks

Thanks to Michael Slade for encouraging me to update this library on its 10th birthday and for suggesting finally using String's getbyte and setbyte methods now that we're all on 1.9+ compatible implementations.

Further thanks to @tdeo, @JoshuaSP, @dalibor, @yegct and @m1lt0n for pull requests.

## License

MIT licensed. Copyright 2007-2022 Peter Cooper.
