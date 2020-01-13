#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Ternary_search

use strict;
use warnings;

# Return the index of $key element if present in given array
# else return undef
# Ternary search iterative implementation
sub ternary_search_iterative {
    my ($arr, $left, $right, $key) = @_;
    while ($right >= 1 and $left <= $right) {
        my $mid1 = int($left + ($right - $left) / 3);
        my $mid2 = int($right - ($right - $left) / 3);

        if ($arr->[$mid1] == $key) {
            return $mid1;
        }
        elsif ($arr->[$mid2] == $key) {
            return $mid2;
        }
        elsif ($key < $arr->[$mid1]) {
            $right = $mid1 - 1;
        }
        elsif ($key > $arr->[$mid2]) {
            $left = $mid2 + 1;
        }
        else {
            $left  = $mid1 + 1;
            $right = $mid2 - 1;
        }
    }
    return;
}

# Ternary search by recursion
sub ternary_search_recursive {
    my ($arr, $left, $right, $key) = @_;

    if ($right >= 1 and $left <= $right) {
        my $mid1 = int($left + ($right - $left) / 3);
        my $mid2 = int($right - ($right - $left) / 3);
        if ($arr->[$mid1] == $key) {
            return $mid1;
        }
        elsif ($arr->[$mid2] == $key) {
            return $mid2;
        }
        elsif ($key < $arr->[$mid1]) {
            return ternary_search_recursive($arr, $left, $mid1 - 1, $key);
        }
        elsif ($key > $arr->[$mid2]) {
            return ternary_search_recursive($arr, $mid2 + 1, $right, $key);
        }
        else {
            return ternary_search_recursive($arr, $mid1 + 1, $mid2 - 1, $key);
        }
    }
    return;
}

# Main program starts here

my @array             = (1, 3, 5, 8, 10, 12, 15, 20, 23);
my $element_to_search = 3;

my ($left, $right) = (0, scalar(@array) - 1);
my $index_itr = ternary_search_iterative(\@array, $left, $right, $element_to_search);

my $index_rec = ternary_search_recursive(\@array, $left, $right, $element_to_search);

if (defined $index_itr) {
    print "\n Found $element_to_search in iterative search at index: $index_itr";
}
else {
    print "\n Unable to find $element_to_search in the iterative search";
}

if (defined $index_rec) {
    print "\n Found $element_to_search in recursive search at index: $index_rec";
}
else {
    print "\n Unable to find $element_to_search in the recursive search";
}

