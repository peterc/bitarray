# BitArray: A simple bit array/bit field library in pure Ruby

Basic, pure Ruby bit field. Pretty fast (for what it is) and memory efficient. Works well for Bloom filters (the reason I wrote it).

Written in 2007 and not updated since then, just bringing it on to GitHub by user request. It used to be called Bitfield and was hosted at http://snippets.dzone.com/posts/show/4234

## Examples

Create a bit field 1000 bits wide
    bf = BitField.new(1000)

Setting and reading bits
    bf[100] = 1
    bf[100]    .. => 1
    bf[100] = 0

More
    bf.to_s = "10101000101010101"  (example)
    bf.total_set         .. => 10  (example - 10 bits are set to "1")

## License

MIT licensed. Copyright 2007-2012 Peter Cooper, yada yada.