#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Radix_sort

use strict;
use warnings;
use List::Util qw(max);

sub counting_sort {
    my ($arr, $exp) = @_;
    my $size = scalar(@{$arr});

    # Find out the maximum element from the given array
    my $maximum = max(@{$arr});

    # The output character array which will contain sorted array
    my @output = (0) x $size;

    # Initialize an array to store the count of the elements of original array($arr) with
    # length max+1 having all elements 0
    my @count = (0) x ($maximum + 1);

    # Store the count of each element at their respective index in count array
    for my $index (0 .. $size - 1) {
        ++$count[int($arr->[$index] / $exp) % 10];
    }

    # Store cumulative sum of the elements of the count array.
    for my $index (1 .. $maximum) {
        $count[$index] += $count[$index - 1];
    }

    # Find the index of each element of the original array in count array.
    # Place the element at the index calculated and decrease count by 1
    my $index = $size - 1;
    while ($index >= 0) {
        my $reminder = int($arr->[$index] / $exp) % 10;
        $output[$count[$reminder] - 1] = $arr->[$index];
        --$count[$reminder];
        $index--;
    }
    for my $index (0 .. $size - 1) {
        $arr->[$index] = $output[$index];
    }
    return;
}

sub radix_sort {
    my ($arr) = @_;
    my $max_length = 0;
    for my $element (@{$arr}) {
        if (length $element > $max_length) {
            $max_length = length $element;
        }
    }
    my $divisor = 1;
    while ($max_length / $divisor > 0) {
        counting_sort($arr, $divisor);
        $divisor *= 10;
    }
}

sub print_array {
    my ($arr) = @_;
    my $size = scalar(@{$arr});
    for my $i (0 .. $size - 1) {
        print " " . $arr->[$i];
    }
}

my @array = (51, 145, 4, 12, 456, 133, 10);

print "\nUnsorted array is: ";
print_array(\@array);

radix_sort(\@array);

print "\nSorted array is: ";
print_array(\@array);
