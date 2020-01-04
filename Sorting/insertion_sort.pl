#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Insertion_sort

use strict;
use warnings;

sub insertion_sort {
    my ($arr) = @_;

    # Multiple way to get size of array in Perl
    # 1. scalar( @{$arr} )  => Standard way
    # 2. $#$arr + 1  => $#arr will return the last index of array, hence adding 1 to get the actual size
    my $size = scalar(@{$arr});

    # Perl range operator - https://perldoc.perl.org/perlop.html#Range-Operators
    for my $i (1 .. $size - 1) {
        my $key = $arr->[$i];
        my $j   = $i - 1;
        while ($j >= 0 and $arr->[$j] > $key) {
            $arr->[$j + 1] = $arr->[$j];
            $j = $j - 1;
        }
        $arr->[$j + 1] = $key;
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

insertion_sort(\@array);

print "\nSorted array is: ";
print_array(\@array);
