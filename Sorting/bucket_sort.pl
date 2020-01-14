#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Bucket_sort
use strict;
use warnings;
use Readonly;
Readonly my $BUCKET_SIZE => 10;

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

sub bucket_sort {
    my ($arr)     = @_;
    my $size      = scalar(@{$arr});
    my $min_value = $arr->[0];
    my $max_value = $arr->[0];

    # Getting the minimum and maximum value
    for my $index (0 .. $size - 1) {
        if ($arr->[$index] < $min_value) {
            $min_value = $arr->[$index];
        }
        elsif ($arr->[$index] > $max_value) {
            $max_value = $arr->[$index];
        }
    }

    my $buckets_count = int(($max_value - $min_value) / $BUCKET_SIZE);
    my @buckets       = ();

    # Initialize each bucket
    for my $i (0 .. $buckets_count) {
        push @buckets, [];
    }

    # Fill the bucket with each element from unsorted array into proper bucket
    for my $index (0 .. $size - 1) {
        my $index_bkt = int(($arr->[$index] - $min_value) / $BUCKET_SIZE);
        push @{$buckets[$index_bkt]}, $arr->[$index];
    }

    # Sort each of the bucket using a simple algorithm, e.g. Insertion Sort
    for my $i (0 .. scalar(@buckets) - 1) {
        insertion_sort($buckets[$i]);
    }

    # Merge/Concatenate each of the bucket and insert into the original array
    my $k = 0;
    for my $i (0 .. scalar(@buckets) - 1) {
        for my $j (0 .. scalar(@{$buckets[$i]}) - 1) {
            $arr->[$k] = $buckets[$i][$j];
            $k++;
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

my @array = (5, 1, 4, 2, 8, 3, 10, 45, 22, 36);

print "\nUnsorted array is: ";
print_array(\@array);

bucket_sort(\@array);

print "\nSorted array is: ";
print_array(\@array);
