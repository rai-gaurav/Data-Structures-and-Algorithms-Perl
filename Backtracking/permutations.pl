#!/usr/bin/env perl

# https://en.wikipedia.org/wiki/Permutation
# https://itnext.io/permutations-combinations-algorithms-cheat-sheet-68c14879aba5
# Total non repetitive permutations => n!
# n - number of options (size of array)
# https://metacpan.org/pod/perlfaq4#How-do-I-permute-N-elements-of-a-list?

use strict;
use warnings;
use Data::Dumper;

my @permute = ();

sub permutations {
    my ($arr, $start, $end) = @_;

    if ($start == $end) {
        # Make a deep copy
        my @smaller_arr = @{$arr};
        push @permute, \@smaller_arr;
    }

    for my $index ($start .. $end) {
        ($arr->[$start], $arr->[$index]) = ($arr->[$index], $arr->[$start]);
        permutations($arr, $start + 1, $end);
        ($arr->[$start], $arr->[$index]) = ($arr->[$index], $arr->[$start]);
    }
}

sub main {
    my @array = (1, 2, 3);
    my $size  = scalar(@array);
    permutations(\@array, 0, $size - 1);
    my $total_perm = scalar(@permute);
    print "\nTotal permutations " . $total_perm . "\n";
    print Dumper(\@permute);
}

main;
