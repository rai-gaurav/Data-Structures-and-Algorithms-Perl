#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Fibonacci_search_technique

use strict;
use warnings;
use List::Util qw(min);

# Return the index of $key element if present in given array
# else return undef
sub fibonacci_search {
    my ($arr, $key) = @_;
    my $size = scalar(@{$arr});

    # (m-2)'th Fibonacci number
    my $fibM2 = 0;

    # (m-1)'th Fibonacci number
    my $fibM1 = 1;

    # m'th Fibonacci number
    my $fibM = $fibM2 + $fibM1;

    # first find the smallest Fibonacci number($fibM) that is
    # greater than or equal to the length of given array
    while ($fibM < $size) {
        $fibM2 = $fibM1;
        $fibM1 = $fibM;
        $fibM  = $fibM2 + $fibM1;
    }

    # Marks the eliminated range from front
    my $offset = -1;

    # while there are elements to be inspected. Note that we compare
    # $arr->[$fibM2] with $key. When fibM becomes 1, fibM2 becomes 0

    while ($fibM > 1) {

        # Check if fibM2 is a valid location
        my $index = min($offset + $fibM2, $size - 1);

        # If $key is greater than the value at index fibM2,
        # cut the subarray array from offset to $index (array on the right side)
        if ($arr->[$index] < $key) {
            $fibM   = $fibM1;
            $fibM1  = $fibM2;
            $fibM2  = $fibM - $fibM1;
            $offset = $index;
        }

        # If $key is less than the value at index $fibM2,
        # cut the subarray after $index + 1 (array on the left side)
        elsif ($arr->[$index] > $key) {
            $fibM  = $fibM2;
            $fibM1 = $fibM1 - $fibM2;
            $fibM2 = $fibM - $fibM1;
        }

        # element found
        else {
            return $index;
        }
    }

    # comparing the last element with $key
    if ($fibM1 and $arr->[$offset + 1] == $key) {
        return $offset + 1;
    }
    return;
}


my @array             = (1, 3, 5, 8, 10, 12);
my $element_to_search = 1;

my $index = fibonacci_search(\@array, $element_to_search);
if (defined $index) {
    print "\n Found $element_to_search at index: $index";
}
else {
    print "\n Unable to find $element_to_search in the given array";
}
