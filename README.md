A collection of helper methods to make working with Arrays a little easier.

### method all

```raku
method all(
    &truthy_function
) returns Bool
```

Returns True if the function passed in returns true for all items. Function must take a single paramater and return True or False Ex. to see if all numbers are even $my_array.all(-> $x {$x mod 2 == 0})

### method any

```raku
method any(
    &truthy_function
) returns Bool
```

Returns True if the function passed in returns true for any item. Function must take a single paramater and return True or False Ex. to see if all numbers are even $my_array.any(-> $x {$x mod 2 == 0})

### method car

```raku
method car() returns Mu
```

Returns the first element of the Array. Throws an exception if the array is empty. Intended to satisfy lisp people.

### method cdr

```raku
method cdr() returns Array
```

Returns everything but the first element of the array. Throws an exception if the array is empty. Intended to satisfy lisp people.

### method drop

```raku
method drop(
    Int $count,
    Bool :$all_or_nothing = Bool::False
) returns Array:D
```

Returns a new list without the first or last $count elements of the array depending on if count is positive or negative.

### method flatten

```raku
method flatten() returns Seq:D
```

Fully, and deeply flattens a list, and returns it as a Seq (like flat).

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

### method rest

```raku
method rest() returns Array
```

Returns a new array with everything but the first element. If the array is empty, or only has one element, it will return an empty array.

### method split-by

```raku
method split-by(
    Int $size,
    Bool :$only_perfect_splits = Bool::False
) returns Array:D
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

### method all

```raku
method all(
    &truthy_function
) returns Bool
```

Returns True if the function passed in returns true for all items. Function must take a single paramater and return True or False Ex. to see if all numbers are even $my_seq.all(-> $x {$x mod 2 == 0})

### method any

```raku
method any(
    &truthy_function
) returns Bool
```

Returns True if the function passed in returns true for any item. Function must take a single paramater and return True or False Ex. to see if all numbers are even $my_seq.any(-> $x {$x mod 2 == 0})

### method flatten

```raku
method flatten() returns Seq:D
```

Fully, and deeply flattens a list, and returns it as a Seq.

### method is-empty

```raku
method is-empty() returns Bool
```

Tests if the Seq is empty

### method all

```raku
method all(
    &truthy_function
) returns Bool
```

Returns True if the function passed in returns true for all items. Function must take a single paramater and return True or False Ex. to see if all numbers are even $my_list.all(-> $x {$x mod 2 == 0})

### method any

```raku
method any(
    &truthy_function
) returns Bool
```

Returns True if the function passed in returns true for any item. Function must take a single paramater and return True or False Ex. to see if all numbers are even $my_list.any(-> $x {$x mod 2 == 0})

### method flatten

```raku
method flatten() returns Seq:D
```

Fully, and deeply flattens a list, and returns it as a Seq.

### method is-empty

```raku
method is-empty() returns Bool
```

Tests if the List is empty

