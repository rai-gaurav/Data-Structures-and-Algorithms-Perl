#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Jump_search

use strict;
use warnings;
use List::Util qw(min);

# Return the index of $key element if present in given array
# else return undef
sub jump_search {
    my ($arr, $key) = @_;
    my $size = scalar(@{$arr});
    my $step = int(sqrt($size));
    my $prev = 0;
    while ($arr->[min($step, $size) - 1] < $key) {
        $prev = $step;
        $step = $step + int(sqrt($size));
        if ($prev >= $size) {
            return;
        }
    }

    while ($arr->[$prev] < $key) {
        $prev++;
        if ($prev == min($step, $size)) {
            return;
        }
    }

    if ($arr->[$prev] == $key) {
        return $prev;
    }
    return;
}

my @array             = (1, 3, 5, 8, 10);
my $element_to_search = 10;

my $index = jump_search(\@array, $element_to_search);
if (defined $index) {
    print "\n Found $element_to_search at index: $index";
}
else {
    print "\n Unable to find $element_to_search in the given array";
}
