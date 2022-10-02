unit module Listicles:ver<1.0.0>:auth<masukomi (masukomi@masukomi.org)>;

use MONKEY-TYPING;

augment class Array {

	#|( Returns a new list without the first or last $count elements of the array depending
	# on if $count is positive or negative.
	# =head2 Parameters
	# * C<$count> - the number of elements to take from the beginning if positive,
	#   or from the end if negative.
	# * C<:$all_or_nothing> - Bool set this to True
	#   if you want it to throw an exception if there are insufficent elements available.
	# =head2 Returns
	# A new array containing the specified elements
	)
	method drop(Int $count, Bool :$all_or_nothing=False) returns Array:D {
		 # my $range = $count > 0
		 # 			  ?? (($count - 1)..(self.elems - 1))
		 # 			  !! ((self.elems - $count - 1)..(self.elems - 1));
		 # self[$range].Array;


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
		  ?? self[($count - 1)^..*]
		  !! self[0..(self.elems - $num_elements_needed - 1)]
		 ).Array
	}


	#|( Tests if the array includes the item passed in
	# =head2 Parameters
	# * C<$x> the item you're looking for
	# * C<:$ducktyped> Boolean indicating if ducktyped matches are acceptable.
	#   Defaults to False.
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

	#|( Splits a Array into an array of arrays of the specified length (or smaller).
	#If the array is not evenly divisble then the last array will contain the remainder
	# =head2 Parameters
	# * C<$size> the size of the sublists to return.
	# * C<:$only_perfect_splits> Boolean. Set this to true if you want it to throw
	#   an exception for lists that aren't evenly divisible by C<$size>
	#)
	method split-by(Int $size, Bool :$only_perfect_splits=False) returns Array {
		if $only_perfect_splits and ! (self.elems %% $size) {
			die("Array with " ~ self.elems ~ " elements isn't evenly divisible by $size");
		}
		return [] if self.is-empty();

		my @result = [];
		loop (my $index = 0; $index < self.elems; $index += $size ) {
			my $end = $index + ($size - 1);
			$end = self.elems - 1 if $end >= self.elems;

			@result.push(self[$index..$end].Array);
		}
		return @result;
	}


	#|( Take returns $count elements of the Array from the beginning
	# or end depending on if $count is positive or negative.
	# If there are fe
	# =head2 Parameters
	# * C<$count> - the number of elements to take
	# * C<:$all_or_nothing> - Bool set this to True
	#   if you want it to throw an exception if there are insufficent elements available.
	# =head2 Returns
	# A new array containing the specified elements
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

	#| creates a hash with the stringified index of each element as its key
	method to-hash(:$one_based=False) returns Hash:D {
		return Hash.new() if self.is-empty();
		my $range = (0..(self.elems - 1));
		(! $one_based)
		?? 	Hash.new( $range.map({ $_       , self[$_]   }))
		!! 	Hash.new( $range.map({ ($_ + 1) , self[$_]   }));
	}
}
