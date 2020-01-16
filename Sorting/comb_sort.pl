#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Comb_sort

#   Comb sort is an enhancement over bubble sort. The basic idea is to eliminate turtles,
#   or small values near the end of the list, since in a bubble sort these slow the sorting down tremendously.
#   Rabbits, large values around the beginning of the list, do not pose a problem in bubble sort.

use strict;
use warnings;

sub comb_sort {
    my ($arr) = @_;
    my $size = scalar(@{$arr});

    # Initialize gap size as size of array
    my $gap = $size;

    # 1.3 has been suggested as an ideal shrink factor by the authors
    my $shrink = 1.3;
    my $sorted = 0;

    while ($sorted == 0) {

        # Minimize gap by shrink factor
        $gap = int($gap / $shrink);
        if ($gap <= 1) {

            # At this point, comb sort continues using a gap of 1 until the list is fully sorted.
            # This is the final stage of the sort and is equivalent to a bubble sort
            $gap = 1;

            # If no swaps happend in next loop then we are done.
            $sorted = 1;
        }

        my $i = 0;
        while ($i + $gap < $size) {
            if ($arr->[$i] > $arr->[$i + $gap]) {
                ($arr->[$i], $arr->[$i + $gap]) = ($arr->[$i + $gap], $arr->[$i]);

                # If this assignment never happens within the loop,
                # then there have been no swaps and the list is sorted.
                $sorted = 0;
            }
            $i++;
        }
    }
}

sub print_array {
    my ($arr) = @_;
    my $size = scalar(@{$arr});
    for my $i (0 .. $size - 1) {
        print " " . $arr->[$i];
    }
}

my @array = (5, 1, 4, 2, 8, 3, 10);

print "\nUnsorted array is: ";
print_array(\@array);

comb_sort(\@array);

print "\nSorted array is: ";
print_array(\@array);
