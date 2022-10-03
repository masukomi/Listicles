A collection of helper methods to make working with Arrays a little easier.

### method drop

```raku
method drop(
    Int $count,
    Bool :$all_or_nothing = Bool::False
) returns Array:D
```

Returns a new list without the first or last $count elements of the array depending on if count is positive or negative.

### method includes

```raku
method includes(
    $x,
    Bool :$ducktyped = Bool::False
) returns Bool
```

Tests if the array includes the item passed in. Set ducktyped to True for ducktyped matches. For example "4" will match 4 with ducktyped matches.

### method is-empty

```raku
method is-empty() returns Bool
```

Tests if the array is empty

### method split-by

```raku
method split-by(
    Int $size,
    Bool :$only_perfect_splits = Bool::False
) returns Array
```

Splits a Array into an array of arrays of the specified length (or smaller). If the array is not evenly divisble then the last array will contain the remainder. If only_perfect_splits is set to True it will throw an exception if the Array is not evenly divisible by $size.

### method take

```raku
method take(
    Int $count,
    Bool :$all_or_nothing = Bool::False
) returns Array:D
```

Take returns $count elements of the Array from the beginning or end depending on if $count is positive or negative. If there are fewer elements than $count it will return whatever is available. Set all_or_nothing to True and it will throw an exception if there are insufficient elements.

### method to-hash

```raku
method to-hash(
    :$one_based = Bool::False
) returns Hash:D
```

creates a hash with the stringified index of each element as its key. Set one_based to True to have it start the keys at 1 instead of 0. Example: ["foo", "bar"] -> {"0"=>"foo", "1"=>"bar"}

