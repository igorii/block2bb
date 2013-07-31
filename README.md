Block2BB
========

A very simple parser for Literate Haskell files. Rather than writing the Literate Haskell file using 'Bird Beak' notation, I would prefer to use a notation similar to tex.

### Why?

Rather than: 

> main = printStr "Hello there"

One would write

```
\{code}
main = printStr "Hello there"
\{endCode}
```

This looks silly given a one line example, but for larger code blocks it could be quite useful. This allows for many advantages when maintaining larger files. Most notably, managing whitespace is much easier now that there is not an extra character hanging around in column 1.

Of course, 'Bird Beak' notation can be used together with code block notation, as long as they are mutually exclusive within the file, though I don't see why you would put a bird beak inside a code block anyway...

### How to Use

block2bb file1.lhs file2.lhs ... fileN.lhs
=> file1.bb.lhs file2.bb.lhs ... fileN.bb.lhs

The resulting files can be compiled as normal with GHC.
