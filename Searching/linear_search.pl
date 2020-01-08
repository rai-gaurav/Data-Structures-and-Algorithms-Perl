#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Linear_search

use strict;
use warnings;

# Return the index of $key element if present in given array
# else return undef
sub linear_search {
    my ($arr, $key) = @_;
    my $size = scalar(@{$arr}) - 1;

    for my $index (0 .. $size) {
        if ($arr->[$index] == $key) {
            return $index;
        }
    }
    return;
}

my @array             = (5, 3, 2, 18, 10);
my $element_to_search = 18;

my $index = linear_search(\@array, $element_to_search);
if (defined $index) {
    print "\n Found $element_to_search at index: $index";
}
else {
    print "\n Unable to find $element_to_search in the given array";
}
