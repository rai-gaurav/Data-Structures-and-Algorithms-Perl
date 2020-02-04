#!/usr/bin/env perl

# https://en.wikipedia.org/wiki/Combination
# https://itnext.io/permutations-combinations-algorithms-cheat-sheet-68c14879aba5
# Total non repetitive combinations => n!/r!(n-r)!
# n - number of options (size of array)
# r - number of slots (combo length)

use strict;
use warnings;

sub combinations {
    my ($arr, $combo_length) = @_;
    my $size = scalar(@{$arr});
    if ($combo_length > $size) {
        print "\nList size is less than the combination length";
    }
    elsif ($combo_length <= 1) {
        return [map {$_} @{$arr}];
    }
    my @combos;

    for my $index (0 .. $size - $combo_length) {
        my $current_value   = $arr->[$index];
        my @remaining_value = @{$arr}[$index + 1 .. $size - 1];
        my $smaller_combos  = combinations(\@remaining_value, $combo_length - 1);
        foreach my $smaller_combo (@{$smaller_combos}) {
            push @combos, [$current_value, $smaller_combo];
        }
    }
    return \@combos;
}

sub main {
    my @array        = (1, 2, 3, 4, 5, 6);
    my $combo_length = 2;
    my $combos       = combinations(\@array, $combo_length);
    my $total_combos = scalar(@{$combos});
    print "\nTotal combination for " . $combo_length . " slots: " . $total_combos . "\n";
    foreach my $i (0 .. $total_combos - 1) {
        foreach my $j (0 .. $combo_length - 1) {
            print $combos->[$i]->[$j] . " ";
        }
        print "\n";
    }
}

main;
