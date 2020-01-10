#!/usr/bin/env perl

# https://en.wikipedia.org/wiki/Ternary_search

use strict;
use warnings;
$| = 1;
use Data::Dumper;

# Return the index of $key element if present in given array
# else return undef
sub ternary_search_iterative {
    my ($arr, $key) = @_;
    my ($left, $right) = (0, scalar(@{$arr}) - 1);
    while ($right >= 1) {
        my $mid1 = int($left + ($right - 1) / 3);
        my $mid2 = int($right - ($right - $left) / 3);

        if ($arr->[$mid1] == $key) {
            return $mid1;
        }
        elsif ($arr->[$mid2] == $key) {
            return $mid2;
        }
        elsif ($key < $arr->[$mid1]) {
            $right = $mid1 - 1;
        }
        elsif ($key > $arr->[$mid2]) {
            $left = $mid2 + 1;
        }
        else {
            $left  = $mid1 + 1;
            $right = $mid2 - 1;
        }
    }
}

sub ternary_search_recursive {
    my ($arr, $key) = @_;
    print Dumper($arr);
    my ($left, $right) = (0, scalar(@{$arr}) - 1);
    if ($right >= 1) {
        my $mid1 = int($left + ($right - 1) / 3);
        my $mid2 = int($right - ($right - $left) / 3);

        if ($arr->[$mid1] == $key) {
            return $mid1;
        }
        elsif ($arr->[$mid2] == $key) {
            return $mid2;
        }
        elsif ($key < $arr->[$mid1]) {

            #$right = $mid1 - 1;
            print "\n $left .. $mid1 ";
            print @{$arr}[$left .. $mid1 - 1];
            return ternary_search_recursive(\{@{$arr}[$left .. $mid1 - 1]}, $key);

        }
        elsif ($key > $arr->[$mid2]) {

            #$left = $mid2 + 1;
            return ternary_search_recursive(\@{$arr}[$mid2 + 1 .. $right], $key);

        }
        else {
            # $left  = $mid1 + 1;
            # $right = $mid2 - 1;
            return ternary_search_recursive(\@{$arr}[$mid1 + 1 .. $mid2 - 1], $key);

        }
    }
}

my @array             = (1, 3, 5, 8, 10, 12, 15, 20, 23);
my $element_to_search = 3;

my $index_itr;    #= ternary_search_iterative(\@array, $element_to_search);

my $index_rec = ternary_search_recursive(\@array, $element_to_search);

if (defined $index_itr) {
    print "\n Found $element_to_search in iterative search at index: $index_itr
";
}
else {
    print "\n Unable to find $element_to_search in the iterative search";
}

if (defined $index_rec) {
    print "\n Found $element_to_search in recursive search at index: $index_rec
";
}
else {
    print "\n Unable to find $element_to_search in the recursive search
";
}

