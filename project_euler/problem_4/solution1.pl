#!/usr/bin/env perl

# A palindromic number reads the same both ways. The largest palindrome made from the product of
# two 2-digit numbers is 9009 = 91 × 99.
# Find the largest palindrome made from the product of two 3-digit numbers.

use strict;
use warnings;
use Readonly;

# Change the max and min number here depening upon the number of digits;
Readonly my $MAX => 999;
Readonly my $MIN => 99;

sub is_palindrome {
    my ($str) = @_;
    if ($str eq reverse($str)) {
        return 1;
    }
    else {
        return 0;
    }
}

sub main {
    my $lgt_palindrome = 0;
    for (my $i = $MAX; $i > $MIN; $i--) {
        for (my $j = $MAX; $j > $MIN; $j--) {
            my $result = $i * $j;
            if (is_palindrome($result)) {
                if ($result > $lgt_palindrome) {
                    $lgt_palindrome = $result;
                    # breaking the inner loop early reduces the search space
                    # Since we are going in reverse order (from MAX to MIN), we would have largest palindrome here
                    # hence no need to loop theough other smaller numbers.
                    last;
                }
                elsif ($result < $lgt_palindrome) {
                    # If current product is less than the largest one, the we already have max palindrome
                    last;
                }
            }
        }
    }
    print "\nLargest Palindrome: $lgt_palindrome";  # output -> 906609
}

main;
