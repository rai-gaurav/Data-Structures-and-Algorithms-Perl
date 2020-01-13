#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Exponential_search
# The algorithm consists of two stages.
# 1. The first stage determines a range in which the search key would reside if it were in the list.
# 2. In the second stage, a binary search is performed on this range.

use strict;
use warnings;
use List::Util qw(min);
use Data::Dumper;

sub binary_search {
    my ($arr, $low, $high, $key) = @_;
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

sub exponential_search {
    my ($arr, $key) = @_;
    my $size = scalar(@{$arr});
    if ($arr->[0] == $key) {
        return 0;
    }
    my $i = 1;
    while ($i < $size and $arr->[$i] < $key) {
        $i = $i * 2;
    }

    # Call binary search for the found range
    return binary_search($arr, $i / 2, min($i, $size - 1), $key);
}

my @array             = (1, 3, 5, 8, 10, 15);
my $element_to_search = 8;

my $index = exponential_search(\@array, $element_to_search);
if (defined $index) {
    print "\n Found $element_to_search at index: $index";
}
else {
    print "\n Unable to find $element_to_search in the given array";
}
