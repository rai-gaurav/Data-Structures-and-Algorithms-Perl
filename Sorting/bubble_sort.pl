#!/usr/bin/env perl 
# https://en.wikipedia.org/wiki/Bubble_sort
# Bubble sort complexity is O(n^2) if we use 2 loops, iterating over each and every element even if
# the array is sorted. It can be optimized by stopping the algorithm if inner loop didn’t cause any swap.

use strict;
use warnings;

sub bubble_sort {
    my ($arr) = @_;

    # Multiple way to get size of array in Perl
    # 1. scalar(@{$arr})
    # 2. $#$arr + 1  => $#arr will return the last index of array, hence adding 1 to get the actual size
    my $size    = scalar( @{$arr} );
    my $swapped = 1;

    while ($swapped) {
        $swapped = 0;
        for my $i ( 1 .. $size - 1 ) {
            # Check whether is pair is out of order
            # If yes, swapped them and remember something changed
            if ( $arr->[ $i - 1 ] > $arr->[$i] ) {
                ( $arr->[ $i - 1 ], $arr->[$i] ) =
                  ( $arr->[$i], $arr->[ $i - 1 ] );
                $swapped = 1;
            }
        }
        # The bubble sort algorithm can be easily optimized by observing that the n-th pass finds the
        # n-th largest element and puts it into its final place. So, the inner loop can avoid looking
        # at the last n − 1 items when running for the n-th time
        $size = $size - 1;
    }
}

sub print_array {
    my ($arr) = @_;
    my $size = scalar( @{$arr} );
    for my $i ( 0 .. $size - 1 ) {
        print " " . $arr->[$i];
    }
}

my @array = ( 5, 1, 4, 2, 8, 3, 10 );

print "\nUnsorted array is: ";
print_array( \@array );

bubble_sort( \@array );

print "\nSorted array is: ";
print_array( \@array );
