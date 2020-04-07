#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Octal#Octal_to_decimal_conversion
# The bits of the octal number are used one by one, starting with the least significant (rightmost) bit.
# Extract the rightmost bit(remainder), multiply with proper base(power of 8)(because octal base is 8 ( 0 .. 7))
# and add it to decimal value. Next iteration will be performed on the remaining bits.
# e.g. Decimal equivalent of -> 3751
# 3*(8^3) + 7*(8^2) + 5*(8^1) + 1*(8^0) = 2025

use strict;
use warnings;

sub octal_to_decimal_1 {
    my ($num) = @_;
    my $dec_num;
    my $base = 0;
    while ($num > 0) {
        my $remainder = $num % 10;
        $dec_num += $remainder * (8**$base);
        $base++;
        $num = int($num / 10);
    }
    return $dec_num;
}

# Another way to convert using 'oct' inbuild fuction
sub octal_to_decimal_2 {
    my ($num) = @_;

    # https://perldoc.perl.org/functions/oct.html
    # oct - interprets EXPR as an octal string and returns the corresponding value.
    #       If EXPR happens to start off with 0x, interprets it as a hex string.
    #       If EXPR starts off with 0b, it is interpreted as a binary string.
    #       Leading whitespace is ignored in all three cases.
    my $dec_num = oct($num);
    return $dec_num;
}

print(octal_to_decimal_1(55));    # 45
print("\n");
print(octal_to_decimal_2(55));    # 45
