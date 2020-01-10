#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Interpolation_search

use strict;
use warnings;

# Return the index of $key element if present in given array
# else return undef
sub interpolation_search {
    my ($arr, $key) = @_;
    my $size = scalar(@{$arr});
    my $low  = 0;
    my $high = $size - 1;

    while (($arr->[$high] != $arr->[$low]) and
            ($key >= $arr->[$low]) and
            ($key <= $arr->[$high])) {
        # calcucate the the probe position using formula
        # low + (key - f(low)) * (high - low) / (f(high) - f(low))
        my $mid = int($low + (($key - $arr->[$low]) * ($high - $low) / ($arr->[$high] - $arr->[$low])));
        if ($arr->[$mid] < $key) {
            $low = $mid + 1;
        }
        elsif ($key < $arr->[$mid]) {
            $high = $mid - 1;
        }
        else {
            return $mid;
        }
    }
    if ($key == $arr->[$low]) {
        return $low;
    }
    else {
        return;
    }
    return;
}

my @array             = (1, 3, 5, 8, 10);
my $element_to_search = 5;

my $index = interpolation_search(\@array, $element_to_search);
if (defined $index) {
    print "\n Found $element_to_search at index: $index";
}
else {
    print "\n Unable to find $element_to_search in the given array";
}
