#!/usr/bin/env perl

# https://projecteuler.net/problem=1
# Problem Statement:
#  If we list all the natural numbers below 10 that are multiples of 3 or 5,
#  we get 3,5,6 and 9. The sum of these multiples is 23.
#  Find the sum of all the multiples of 3 or 5 below 1000(or any N).

use strict;
use warnings;
use Readonly;
Readonly my $MAX_NUM => 1000;

sub main {
    my $sum = 0;
    for my $number (1 .. $MAX_NUM - 1) {
        if ($number % 3 == 0 or $number % 5 == 0) {
            $sum = $sum + $number;
        }
    }
    print $sum;
}

main;
