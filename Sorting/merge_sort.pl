#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Merge_sort

use strict;
use warnings;

sub merge {
    my ($left, $right, $arr) = @_;
    my ($i, $j, $k) = (0, 0, 0);

    # Until we reach end of either 'left' or 'right' list, pick the largest among the elements from
    # 'left' and 'right' and place them in the correct position at 'arr'
    while ($i < scalar(@{$left}) and $j < scalar(@{$right})) {
        if ($left->[$i] < $right->[$j]) {
            $arr->[$k] = $left->[$i];
            $i++;
        }
        else {
            $arr->[$k] = $right->[$j];
            $j++;
        }
        $k++;
    }

    # When we run out of elements in either 'left' or 'right', pick up the remaining elements and
    # put in 'arr'. Just checking if any element was left
    while ($i < scalar(@{$left})) {
        $arr->[$k] = $left->[$i];
        $i++;
        $k++;
    }
    while ($j < scalar(@{$right})) {
        $arr->[$k] = $right->[$j];
        $j++;
        $k++;
    }
}

sub merge_sort {
    my ($arr) = @_;
    if (scalar(@{$arr}) > 1) {

		# Divide the array recursively into two halves until it can no more be divided,
		# each containing 1 element
        my $mid   = int(scalar(@{$arr}) / 2);
        my @left  = @{$arr}[0 .. ($mid - 1)];
        my @right = @{$arr}[$mid .. $#{$arr}];

        merge_sort(\@left);
        merge_sort(\@right);

        # merge both the smaller lists by comparing elements of both the parts
        merge(\@left, \@right, $arr);
    }
    else {
        # If there is only one element in the array it is already sorted, hence return
        return;
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

merge_sort(\@array, 0, $size - 1);

print "\nSorted array is: ";
print_array(\@array);
