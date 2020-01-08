#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Binary_search_algorithm
# Binary search works on sorted array

use strict;
use warnings;

# Return the index of $key element if present in given array
# else return undef
sub binary_search {
    my ($arr, $key) = @_;
    my ($low, $high) = (0, scalar(@{$arr}) - 1);
    while ($low <= $high) {
        my $mid = int(($low + $high) / 2);
        if ($arr->[$mid] < $key) {
            $low = $mid + 1;
        }
        elsif ($arr->[$mid] > $key) {
            $high = $mid - 1;
        }
        else {
            return $mid;
        }
    }
    return;
}

my @array             = (1, 3, 5, 8, 10);
my $element_to_search = 3;

my $index = binary_search(\@array, $element_to_search);
if (defined $index) {
    print "\n Found $element_to_search at index: $index";
}
else {
    print "\n Unable to find $element_to_search in the given array";
}
