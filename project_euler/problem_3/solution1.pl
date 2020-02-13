#!/usr/bin/env perl

# https://projecteuler.net/problem=3
# Problem Statement:
#  The prime factors of 13195 are 5, 7, 13 and 29.
#  What is the largest prime factor of the number 600851475143 ?

use strict;
use warnings;

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
    my ($num) = @_;
    my $max_prime_factor = 0;
    if (is_prime($num)) {
        return $num;
    }
    else {
        while ($num % 2 == 0) {
            $num = $num / 2;
        }
        if (is_prime($num)) {
            $max_prime_factor = $num;
        }
        else {
            my $square_root = int(sqrt($num));
            for (my $i = 3; $i <= $square_root; $i = $i + 2) {
                if ($num % $i == 0) {
                    if (is_prime($num / $i)) {
                        $max_prime_factor = $num / $i;
                        last;
                    }
                    elsif (is_prime($i)) {
                        $max_prime_factor = $i;
                    }
                }
            }
        }
    }
    print "\nLargest prime factor of the number " . $num . " is: " . $max_prime_factor;
    return $max_prime_factor;
}

# Long numbers can also be written as 600_851_475_143
main(600851475143);    # Output - 6857
