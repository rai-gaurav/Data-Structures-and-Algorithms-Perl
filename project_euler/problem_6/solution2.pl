#!/usr/bin/env perl

# The sum of the squares of the first ten natural numbers is,
#       1^2 + 2^2 + ... + 10^2 = 385
# The square of the sum of the first ten natural numbers is,
#       (1 + 2 + ... + 10)^2 = 552 = 3025
# Hence the difference between the sum of the squares of the first ten natural numbers and the
# square of the sum is 3025 − 385 = 2640
# Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.

use strict;
use warnings;
use Readonly;

# Change the total count of natural number here
Readonly my $N_NUMBERS => 100;

# https://en.wikipedia.org/wiki/Square_pyramidal_number
sub get_sum_of_squares {
    my ($n) = @_;
    return ((($n * ($n + 1)) * (2 * $n + 1)) / 6);
}

# https://en.wikipedia.org/wiki/Triangular_number
sub get_square_of_sum {
    my ($n) = @_;
    return (($n * ($n + 1)) / 2)**2;
}

# This is the proper mathematical solution
sub main {
    my $sum_of_squares = get_sum_of_squares($N_NUMBERS);
    my $square_of_sum  = get_square_of_sum($N_NUMBERS);

    my $diff = $square_of_sum - $sum_of_squares;

    # Output for 100 -> 25164150
    print "\nDifference between the sum of the squares of the natural number from 1 to $N_NUMBERS is : $diff";

}
main;
