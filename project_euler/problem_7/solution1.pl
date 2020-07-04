#!/usr/bin/env perl

# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
# What is the 10 001st prime number?

use strict;
use warnings;
use Readonly;

# Change the total count of natural number here
Readonly my $NTH_PRIME_NUM => 10_001;

sub is_prime {
    my ($num) = @_;
    if ($num == 2) {
        return 1;
    }
    elsif ($num % 2 == 0) {
        return 0;
    }
    my $square_root = int(sqrt($num));
    for (my $i = 3; $i <= $square_root; $i = $i + 2) {
        if ($num % $i == 0) {
            return 0;
        }
    }
    return 1;
}

sub main {
    my $prime_count = 1;
    my $i           = 1;
    while ($prime_count < $NTH_PRIME_NUM) {
        $i += 2;
        if (is_prime($i)) {
            $prime_count++;
        }
    }
    print "\n$NTH_PRIME_NUM prime number is: $i";
    return 1;
}

main;
