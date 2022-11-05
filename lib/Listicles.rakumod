unit module Listicles:ver<1.2.0>:auth<masukomi (masukomi@masukomi.org)>;

=begin pod
A collection of helper methods to make working with Arrays a little easier.

=end pod

use MONKEY-TYPING;

augment class Array {

	#|( Returns the first element of the Array.
	Throws an exception if the array is empty. Intended to satisfy lisp people.
	)
	method car(){
		die("Array is empty") if self.is-empty();
		self[0];
	}

	#|( Returns everything but the first element of the array.
	Throws an exception if the array is empty.
	Intended to satisfy lisp people.
	)
	method cdr() returns Array {
		die("Array is empty") if self.is-empty();
		self.drop(1);
	}

	#|( Returns a new list without the first or last $count elements of the array depending on if count is positive or negative.
	)
	method drop(Int $count, Bool :$all_or_nothing=False) returns Array:D {

		 if $all_or_nothing {
			my $invalid = $count > 0
				?? ($count > self.elems)
				!! (($count * -1) > self.elems);
			die("Array doesn't have $count elements") if $invalid;
		 }
		 my $num_elements_needed = $count > 0 ?? $count !! $count * -1;
		 # return a copy
		 if $count == 0 {
			 return self.clone;
		 } elsif $num_elements_needed > self.elems {
			 return [];
		 }
		 # we know it's a subset now.

		 ($count > 0
		  ?? self.skip($count)
		  !! self[0..(self.elems - $num_elements_needed - 1)]
		 ).Array
	}

	#| Fully, and deeply flattens a list, and returns it as a Seq (like flat).
	method flatten returns Seq:D {
		gather self.deepmap( *.take )
	}

	#|( Tests if the array includes the item passed in.
	 Set ducktyped to True for ducktyped matches.
	 For example "4" will match 4 with ducktyped matches.
	)
	method includes(Any $x, Bool :$ducktyped = False) returns Bool:D {
		return False if self.is-empty();
		if ! $x.isa(Nil) {
			my $y = self.first: * ~~ $x;
			return False if $y.isa(Nil);
			return (! $ducktyped) ?? $y.WHAT ~~ $x.WHAT !! True ;
		} else {
			loop (my $index = 0; $index < self.elems; $index++) {
				return True if self[$index].isa(Nil);
			}
		}
		False;
	}

	#| Tests if the array is empty
    method is-empty() returns Bool:D {
		self.elems == 0;
    }

	#| Returns a new array with everything but the first element. If the array is empty, or only has one element, it will return an empty array.
	method rest() returns Array {
		self.skip(1).Array;
	}

	#|( Splits a Array into an array of arrays of the specified length (or smaller).
	If the array is not evenly divisble then the last array will contain the remainder.
	If only_perfect_splits is set to True it will throw an exception if the Array is not
	evenly divisible by $size.
	)
	method split-by(Int $size, Bool :$only_perfect_splits=False) returns Array:D {
		if $only_perfect_splits and ! (self.elems %% $size) {
			die("Array with " ~ self.elems ~ " elements isn't evenly divisible by $size");
		}
		return [] if self.is-empty();
		self.batch($size).map({.Array}).Array;
	}


	#|( Take returns $count elements of the Array from the beginning
	or end depending on if $count is positive or negative. If there are fewer elements
	than $count it will return whatever is available. Set all_or_nothing to True
	and it will throw an exception if there are insufficient elements.
	)
	method take(Int $count, Bool :$all_or_nothing=False) returns Array:D {
		 if $all_or_nothing {
			my $invalid = $count > 0
				?? ($count > self.elems)
				!! (($count * -1) > self.elems);
			die("Array doesn't have $count elements.") if $invalid;
		 }
		 my $num_elements_needed = $count > 0 ?? $count !! $count * -1;
		 # return a copy
		 if $count == 0 or $num_elements_needed > self.elems {
			 return self.clone;
		 }

		 # we know it's a subset now.
		 ($count > 0
		  ?? self[0..^$num_elements_needed]
		  !! self[(self.elems - $num_elements_needed )..(self.elems - 1)]
		 ).Array
	}

	#|( creates a hash with the stringified index of each element as its key. Set one_based to True to have it start the keys at 1 instead of 0.
	Example: ["foo", "bar"] -> {"0"=>"foo", "1"=>"bar"}
	)
	method to-hash(:$one_based=False) returns Hash:D {
		return Hash.new() if self.is-empty();
		my $range = (0..(self.elems - 1));
		(! $one_based)
		?? 	Hash.new( $range.map({ $_       , self[$_]   }))
		!! 	Hash.new( $range.map({ ($_ + 1) , self[$_]   }));
	}
}
