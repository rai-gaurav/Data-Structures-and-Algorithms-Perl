#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Chinese_remainder_theorem

use strict;
use warnings;

# This is a very basic approch
sub chinese_remainder_theorem {
    my ($num, $rem) = @_;
    my $x    = 1;
    my $size = scalar(@{$num});

    # Though this looks like infinite loop, but there will always exists an x
    # that satisfies the given criteria
    while (1) {
        # Check if remainder of x/num[j] is equal to rem[j] or not
        my $j = 0;
        while ($j < $size) {
            if ($x % $num->[$j] != $rem->[$j]) {
                last;
            }
            $j += 1;
        }

        # If all remainders get matched, we have found x
        if ($j == $size) {
            return $x;
        }

        # else try with next number
        $x += 1;
    }
}

my @num = (4, 7, 11);
my @rem = (1, 5, 2);
print chinese_remainder_theorem(\@num, \@rem);      # Output - 145
