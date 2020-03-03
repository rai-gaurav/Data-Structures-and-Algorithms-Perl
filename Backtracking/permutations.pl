#!/usr/bin/env perl

# https://en.wikipedia.org/wiki/Permutation
# https://itnext.io/permutations-combinations-algorithms-cheat-sheet-68c14879aba5
# Total non repetitive permutations => n!/r!(n-r)!
# n - number of options (size of array)
# r - number of slots (combo length)
# https://metacpan.org/pod/perlfaq4#How-do-I-permute-N-elements-of-a-list?

use strict;
use warnings;
use Data::Dumper;

sub permutation_with_backtracking {
    my ($arr) = @_;
    my $size = scalar(@{$arr});

}

sub permutations {
    my ($arr) = @_;
    my $size = scalar(@{$arr});
    if ($size == 0) {
        return ([]);
    }
    elsif ($size == 1) {
        return ($arr);
    }

    my @permute = ();

    for my $index (0 .. $size - 1) {
        my $m = $arr->[$index];
        my @remaining_array;
        push @remaining_array, (@{$arr}[0 .. $index - 1], @{$arr}[$index + 1 .. $size - 1]);
        print "Remaining List";
        print Dumper(\@remaining_array);

        print "Smaller Perm:";

        my ($smaller_perm) = permutations(\@remaining_array);

        #print Dumper($smaller_perm);

        foreach my $small_perm (@{$smaller_perm}) {

            print Dumper($small_perm);
            push @permute, [$m, $small_perm];
        }
    }
    print "\nPermute:";
    print Dumper(\@permute);
    return \@permute;
}

sub main {
    my @array = (1, 2, 3);
    my $perm  = permutations(\@array);

    #print Dumper($perm);
}
main;
