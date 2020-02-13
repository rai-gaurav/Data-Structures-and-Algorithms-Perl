#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Binary_number#Decimal
# The bits of the binary number are used one by one, starting with the least significant (rightmost) bit.
# Extract the rightmost bit(remainder), multiply with proper base(power of 2)(because binary base is 2 ( 0 and 1 only))
# and add it to decimal value. Next iteration will be performed on the remaining bits.
# e.g. Decimal equivalent of -> 101011
# 1*(2^5) + 0*(2^4) + 1*(2^3) + 0*(2^2) + 1*(2^1) + 1*(2^0) = 43

use strict;
use warnings;

sub binary_to_decimal_1 {
    my ($num) = @_;
    my $dec_num;
    my $base = 0;
    while ($num > 0) {
        my $remainder = $num % 10;
        $dec_num += $remainder * (2**$base);
        $base++;
        $num = int($num / 10);
    }
    return $dec_num;
}

# Another way to convert using 'oct' inbuild fuction
sub binary_to_decimal_2 {
    my ($num) = @_;

    # https://perldoc.perl.org/functions/oct.html
    # oct - interprets EXPR as an octal string and returns the corresponding value.
    #       If EXPR happens to start off with 0x, interprets it as a hex string.
    #       If EXPR starts off with 0b, it is interpreted as a binary string.
    #       Leading whitespace is ignored in all three cases.
    my $dec_num = oct('0b' . $num);
    return $dec_num;

}

print(binary_to_decimal_1(1001));
print("\n");
print(binary_to_decimal_2(1001));
