#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Roman_numerals
# Roman numbers used latin number for representation:
#
# Symbol |  I  |  V  |  X  |  L  |  C  |  D  |  M   |  G   |   H   |
# Value  |  1  |  5  |  10 |  50 | 100 | 500 | 1000 | 5000 | 10000 |
#
# The notations IV and IX can be read as "one less than five" (4) and "one less than ten" (9)
# Similarly, XL and XC can be read as "ten less than fifty" (40) and "ten less tahn hundred" (90)

# Implementation Logic -
# 1. Get the most significant digit (leftmost)
#       To get this we have to divide the number with divisor which is least digit number for the
#       given decimal number significant digits.
#       e.g. For 1673, the significant bits are 4(total length of numbers).
#            The least number of 4 digit is 1000. So the divisor is 1000.
# 2. The roman numeral for 1,2 and 3 have similar representations i.e. I, II, III. I multiplies the number to represent
# 3. For 4 it is "one less than five"(IV), for 40 "ten less than fifty" (XL). Concatanating divisor(1,10,100..) with 5
# 4. Roman numerals for 5,6,7,8 are just concatanation of V with I(1), II(2) or III(3)
# 5. For 9, its "one less than 10"(IX), for 90 "10 less than 100"(XC). COncatanating divisor(1,10,100..) with 10

use strict;
use warnings;

my %rom_sym_val = (
    1     => "I",
    5     => "V",
    10    => "X",
    50    => "L",
    100   => "C",
    500   => "D",
    1000  => "M",
    5000  => "G",
    10000 => "H"
);

sub integer_to_roman {
    my ($decimal_num) = @_;
    my $roman_num = "";

    my $divisor = 1;
    while ($decimal_num > $divisor) {
        $divisor *= 10;
    }
    $divisor /= 10;
    while ($decimal_num > 0) {
        my $most_sig_digit = int($decimal_num / $divisor);

        # String operators: concatenation (.), repetition (x)
        if ($most_sig_digit <= 3) {
            $roman_num .= $rom_sym_val{$divisor} x $most_sig_digit;
        }
        elsif ($most_sig_digit == 4) {
            $roman_num .= $rom_sym_val{$divisor} . $rom_sym_val{$divisor * 5};
        }
        elsif ($most_sig_digit >= 5 and $most_sig_digit <= 8) {
            $roman_num .= $rom_sym_val{$divisor * 5} . ($rom_sym_val{$divisor} x ($most_sig_digit - 5));
        }
        else {
            # For number 9
            $roman_num .= $rom_sym_val{$divisor} . ($rom_sym_val{$divisor * 10});
        }
        $decimal_num = int($decimal_num % $divisor);
        $divisor /= 10;
    }
    return $roman_num;
}

print("\n" . integer_to_roman(28));      # XXVIII
print("\n" . integer_to_roman(64));      # LXIV
print("\n" . integer_to_roman(99));      # XCIX
print("\n" . integer_to_roman(414));     # CDXIV
print("\n" . integer_to_roman(595));     # DXCV
print("\n" . integer_to_roman(1511));    # MDXI
