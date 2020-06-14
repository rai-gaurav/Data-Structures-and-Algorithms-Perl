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

sub get_square {
    my ($number) = @_;
    return $number**2;
}

# This is the brute force solution
sub main {
    my $sum_of_squares = 0;
    my $square_of_sum  = 0;
    my $sum_of_num     = 0;
    for my $num (1 .. $N_NUMBERS) {
        my $num_square = get_square($num);
        $sum_of_squares += $num_square;
        $sum_of_num     += $num;
    }
    $square_of_sum = $sum_of_num**2;

    my $diff = $square_of_sum - $sum_of_squares;

    # Output for 100 -> 25164150
    print "\nDifference between the sum of the squares of the natural number from 1 to $N_NUMBERS is : $diff";

}
main;
