#!/usr/bin/env perl

# The bits of the hexadecimal number are used one by one, starting with the least significant (rightmost) bit.
# Extract the rightmost bit, multiply with proper base(power of 16)(because hexadecimalbase base is 16 ( 0..9 & A..F))
# and add it to decimal value. Next iteration will be performed on the next bit.
# e.g. Decimal equivalent of -> 1B6F
# 1*(16^3) + 11*(16^2) + 6*(16^1) + 15*(16^0) = 7023

use strict;
use warnings;

my %hex_sym_val = ("A" => 10, "B" => 11, "C" => 12, "D" => 13, "E" => 14, "F" => 15);

sub hexa_to_decimal_1 {
    my ($num) = @_;
    my $dec_num;
    my $base = 0;

    # Splitting the hex string into hex characters, can use "" or // as delimiter
    # Also we will start with the rightmost bit hence reverse to start from it.
    my @chars = reverse(split("", $num));
    while ($base < scalar(@chars)) {
        my $temp_dec;

        if ($chars[$base] ge "A" and $chars[$base] le "F") {

            # if the bit is between 'A' and 'F' get the equivalent decimal number
            $temp_dec = $hex_sym_val{$chars[$base]};
        }
        else {
            # else the bit is less than or equal to 9 which is same in decimal
            $temp_dec = $chars[$base];
        }
        $dec_num += $temp_dec * (16**$base);
        $base++;
    }
    return $dec_num;
}

# Another way to convert using 'oct' inbuild fuction
sub hexa_to_decimal_2 {
    my ($num) = @_;

    # https://perldoc.perl.org/functions/oct.html
    # oct - interprets EXPR as an octal string and returns the corresponding value.
    #       If EXPR happens to start off with 0x, interprets it as a hex string.
    #       If EXPR starts off with 0b, it is interpreted as a binary string.
    #       Leading whitespace is ignored in all three cases.
    my $dec_num = oct("0x" . $num);
    return $dec_num;
}

# Another way to convert using 'hex' inbuild fuction
sub hexa_to_decimal_3 {
    my ($num) = @_;

    # https://perldoc.perl.org/functions/hex.html
    # Interprets EXPR as a hex string and returns the corresponding decimal value
    my $dec_num = hex($num);    # or hex('0x' . $num)
    return $dec_num;
}

print(hexa_to_decimal_1("2D"));    # 45
print("\n");
print(hexa_to_decimal_2("2D"));    # 45
print("\n");
print(hexa_to_decimal_3("2D"));    # 45
