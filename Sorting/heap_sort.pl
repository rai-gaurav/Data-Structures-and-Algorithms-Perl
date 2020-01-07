#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Heapsort

use strict;
use warnings;

# Heapify subtree rooted at index $i. $n is size of heap
sub heapify {
    my ($arr, $n, $i) = @_;

    # Consider root as the largest element
    my $largest = $i;
    my $left    = 2 * $i + 1;
    my $right   = 2 * $i + 2;

    # Find the largest child of the two child's of parent node
    # and check whether they are greater than the root node
    if ($left < $n and $arr->[$largest] < $arr->[$left]) {
        $largest = $left;
    }
    if ($right < $n and $arr->[$largest] < $arr->[$right]) {
        $largest = $right;
    }

    # Change root if one of the child is larger than it
    if ($largest != $i) {
        ($arr->[$i], $arr->[$largest]) = ($arr->[$largest], $arr->[$i]);
        heapify($arr, $n, $largest);
    }
}

sub heap_sort {
    my ($arr) = @_;
    my $size = scalar(@{$arr});

    # Build the heap of size of the unsorted array
    for (my $i = int($size / 2) - 1; $i >= 0; $i--) {
        heapify($arr, $size, $i);
    }

    # Extract element from heap one by one and
    # adjusts heap after maximum element has been removed from top of heap
    for (my $i = $size - 1; $i >= 0; $i--) {
        ($arr->[$i], $arr->[0]) = ($arr->[0], $arr->[$i]);
        heapify($arr, $i, 0);
    }
}

sub print_array {
    my ($arr) = @_;
    my $size = scalar(@{$arr});
    for my $i (0 .. $size - 1) {
        print " " . $arr->[$i];
    }
}

my @array = (5, 1, 4, 2, 8, 10, 3);

print "\nUnsorted array is: ";
print_array(\@array);

heap_sort(\@array);

print "\nSorted array is: ";
print_array(\@array);
