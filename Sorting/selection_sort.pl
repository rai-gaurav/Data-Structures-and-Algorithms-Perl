#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Selection_sort

use strict;
use warnings;

sub selection_sort {
    my ($arr) = @_;
    my $size = scalar(@{$arr});
    for my $i (0 .. $size-1) {

        # assume the minimum is the first element.
        # Find the minimum element in remaining unsorted array 
        my $min_index = $i;
        for my $j ($i + 1 .. $size-1) {
            # if this element is less, then it is the new minimum
            if ($arr->[$min_index] > $arr->[$j]) {
                $min_index = $j;
            }
        }
        # Swap the found minimum element with the first element 
        ($arr->[$i], $arr->[$min_index]) = ($arr->[$min_index], $arr->[$i]);
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
my $size  = scalar(@array);
print "\nUnsorted array is: ";
print_array(\@array);

selection_sort(\@array);

print "\nSorted array is: ";
print_array(\@array);
