# pmmv -- perl rename as a front-end to mmv

### The Problem

The perl `rename` command found in some Linux distributions
show that perl has a great deal of expressive power,
and so it can lead people to believe that it makes for a
useful bulk rename utility.  But all that expressive power
is good planning the trasnformation of filenames, it does not
do the heavy lifting of analyzing the whole list of
from`->`to filename pairs for potential collisions,
cycles, or other problems that can make the entire move/rename
operation infeasible.

The program, `mmv`, does all those safety checks,
but its pattern matching language is pretty basic.

`pmmv` is a variant of the perl `rename` program
that is designed to work with `mmv`.  It is also
design to work with the `libmmv`-based program, `mmv-pairs`,
which can take nul-terminated lines as {from`->`to}
filename pairs, and can take other encodings
of "raw" pairs of source and destination file names.

So, we should be able to get the expressive power of perl,
combined with the safety features of `mmv`, and do all that
while still keeping with a Unix tools philosophy.

## Other improvements

#### allow pure functions

One annoyance with perl `rename`
is the inconsistent treatment of functions.
Some functions modify their subject,
while others are pure functions.

This is not something unique to `rename`;
it is a general perl annoyance
that is partly because of perl's
"there is more than one way to do it"
philosophy, and partly because of its
heritage; programs that it subsumes
are a mix of utilities that modify subject strings
and of general-purpose programming languages
that have pure functions and assignment statements.

As an experiment, `pmmv` takes purely functional
notation and translates it into an assignement
statement.

For example, the perl function, 'lc',
is just a function; it does not modify its
argument.  So, it would not make sense
to use the `rename` command with just the function name.
But, `pmmv` will notice that the given expression produces not change,
and translate the given expression into an assignement statement.

The command:

<pre>
    pmmv 'lc' TESTFILENAME
</pre>

gets translated to

<pre>
    pmmv '$_ = lc($_);' TESTFILENAME
</pre>

#### Composition of functions

`pmmv` will also translate expressions of the form:

```
    function_f `.` function_g
```

into:

```
    $_ = function_g(function_f($_));
```

#### Builtin hyphenate support

To do hyphenation properly takes
more than just `s/\s/-/g`.

So, `pmmv` has one addtional function
built-in, `hyphenate_array`.
It takes an array of words
and translates a lot of unsafe puctuation characters,
as well as white space, and then collapses
run of hyphens into one.


## Encodings

`pmmv` supports the encodings that `mmv-pairs` handles.
That includes:

  1. --null      print pairs of nul-terminated records
  2. --qp        print pairs of quoted-printable encoded lines
  3. --xnn       print pairs of xnn-encoded lines

It also supports:

  1. --shell     print shell-quoted `mv` commands
  2. --builtin   rename files directly

####

-- Guy Shaw

   gshaw@acm.org

