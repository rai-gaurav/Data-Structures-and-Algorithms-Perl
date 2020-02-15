#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Bitonic_sorter

use strict;
use warnings;

# This fuction will return as sorted sequence of integers.
# 'up' if true(1) will sort in ascending order otherwise descending(0)
sub bitonic_sort {
    my ($arr, $up) = @_;

    $up = $up // 0;
    my $size = scalar(@{$arr});
    if ($size <= 1) {
        return $arr;
    }
    else {
        # Creating a bitonic sequence from 2 slices of array 
		# one of them will be in ascending, other will be descending
        my $first  = bitonic_sort([@{$arr}[0 .. int($size / 2) - 1]], 1);
        my $second = bitonic_sort([@{$arr}[int($size / 2) .. $size - 1]], 0);
        
        # Merge two bitonic sequence slices
        return bitonic_merge([@{$first}, @{$second}], $up);
    }
}

sub bitonic_merge {
    my ($arr, $up) = @_;
    my $size = scalar(@{$arr});

    # Assume input array is bitonic, and sorted list is returned
    if ($size == 1) {
        return $arr;
    }
    else {
        bitonic_compare($arr, $up);
        my $first  = bitonic_merge([@{$arr}[0 .. int($size / 2) - 1]], $up);
        my $second = bitonic_merge([@{$arr}[int($size / 2) .. $size - 1]], $up);
        return ([@{$first}, @{$second}]);
    }
}

sub bitonic_compare {
    my ($arr, $up) = @_;
    my $dist = int(scalar(@{$arr}) / 2);
    for my $i (0 .. $dist - 1) {
        # Compare first half of array with other one
        # Swap the elements if any element in the second half is smaller.
        if (($arr->[$i] > $arr->[$i + $dist]) == $up) {
            ($arr->[$i], $arr->[$i + $dist]) = ($arr->[$i + $dist], $arr->[$i]);
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

my @array = (5, 1, 4, 2, 8, 3, 10, 7);

print "\nUnsorted array is: ";
print_array(\@array);

my $sorted_array_ref = bitonic_sort(\@array, 1);

print "\nSorted array in ascending order is: ";
print_array($sorted_array_ref);

$sorted_array_ref = bitonic_sort(\@array, 0);

print "\nSorted array in descending order is: ";
print_array($sorted_array_ref);
