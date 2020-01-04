#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Quicksort

use strict;
use warnings;

sub get_pivot {
    my ($arr, $low, $high) = @_;

    # There are many ways to choose pivot
    # 1. The first element of array (worst-case behaviour if array is already sorted)
    #return $arr->[$low];

    # 2. The last element of array
    #return $arr->[$high]

    # 3. The middle element in the array (Better)
    #return $arr->[$low + ($high - $low) / 2];

    # 4. Choosing the median (Best)
    my $mid = ($low + $high) / 2;
    if ($arr->[$mid] < $arr->[$low]) {
        ($arr->[$low], $arr->[$mid]) = ($arr->[$mid], $arr->[$low]);
    }
    if ($arr->[$high] < $arr->[$low]) {
        ($arr->[$low], $arr->[$high]) = ($arr->[$high], $arr->[$low]);
    }
    if ($arr->[$mid] < $arr->[$high]) {
        ($arr->[$high], $arr->[$mid]) = ($arr->[$mid], $arr->[$high]);
    }
    return $arr->[$high];
}

sub partition {
    my ($arr, $low, $high) = @_;

    my $pivot = get_pivot($arr, $low, $high);
    my $i     = $low - 1;
    for my $j ($low .. $high - 1) {
        if ($arr->[$j] < $pivot) {
            $i++;

            # Can also be written as -
            #@$array[$i, $j] = @$array[$j, $i];
            ($arr->[$i], $arr->[$j]) = ($arr->[$j], $arr->[$i]);
        }
    }
    $i++;

    # Can also be written as -
    #@$array[$i, $high] = @$array[$high, $i];
    ($arr->[$i], $arr->[$high]) = ($arr->[$high], $arr->[$i]);
    return $i;
}

sub quick_sort {
    my ($arr, $low, $high) = @_;
    if ($low < $high) {
        my $part_index = partition($arr, $low, $high);
        quick_sort($arr, $low,            $part_index - 1);
        quick_sort($arr, $part_index + 1, $high);
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

quick_sort(\@array, 0, $size - 1);

print "\nSorted array is: ";
print_array(\@array);
