#!/usr/bin/env perl

# 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
# What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
# In other words, we have to find LCM (Least common multiple)

use strict;
use warnings;
use Readonly;

# Change the max and min number here depening upon the range of number
Readonly my $MAX => 20;
Readonly my $MIN => 1;

# https://en.wikipedia.org/wiki/Euclidean_algorithm
# Many ways to get gcd, one is recursive way.
sub get_gcd {
    my ($num1, $num2) = @_;
    if ($num2 == 0) {
        return $num1;
    }
    else {
        return get_gcd($num2, $num1 % $num2);
    }
}

sub get_lcm {
    my ($num1, $num2) = @_;

    # (LCM * GCD) of two numbers = product of those two number (num1 * num2)
    return ($num1 * $num2) / get_gcd($num1, $num2);
}

sub main {
    my $lcm = 1;
    for my $i ($MIN .. $MAX) {
        $lcm = get_lcm($lcm, $i);
    }
    print "\n$lcm";                 # Output -> 232792560 for (1 to 20)

}

main;
