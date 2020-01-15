#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Fibonacci_number

# In Fibonaci number each number is sum of previous 2 numbers staring from 0 and 1. i.e.
# f(0) = 0, f(1) = 1 and
# f(n) = f(n-1) + f(n-2)
# This the beginning of sequence is: 0, 1, 1, 2, 3, 5, 8, 13, 21, 34 ......

use strict;
use warnings;

# Fibonacci number using recursion approch
# Will return the element at the given index number
sub fibonacci_recursive {
    my ($n) = @_;
    if ($n <= 1) {
        return $n;
    }
    else {
        return fibonacci_recursive($n - 1) + fibonacci_recursive($n - 2);
    }
}

# Fibonacci number using iterative approch
sub fibonacci_iterative {
    my ($n)      = @_;
    my $previous = 0;
    my $current  = 1;

    # Loop start from2 because 1 and 1 are already covered
    for my $i (2 .. $n) {
        ($previous, $current) = ($current, $previous + $current);
    }
    return $current;
}

sub main {
    print "\n Enter the limit: ";
    my $number = <ARGV>;
    print "\n Output from recursive implementation: " . fibonacci_recursive($number);
    print "\n Output from iterative implementation: " . fibonacci_iterative($number);
    return;
}

main;
