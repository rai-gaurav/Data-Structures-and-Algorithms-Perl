#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Roman_numerals
# Roman numbers used latin number for representation:
#
# Symbol |  I  |  V  |  X  |  L  |  C  |  D  |  M   |
# Value  |  1  |  5  |  10 |  50 | 100 | 500 | 1000 |
#
# The notations IV and IX can be read as "one less than five" (4) and "one less than ten" (9)
# Similarly, XL and XC can be read as "ten less than fifty" (40) and "ten less tahn hundred" (90)

use strict;
use warnings;

my %rom_sym_val = ("I" => 1, "V" => 5, "X" => 10, "L" => 50, "C" => 100, "D" => 500, "M" => 1000);

sub roman_to_decimal {
    my ($roman_num) = @_;
    my $index       = 0;
    my $decimal_num = 0;

    # Splitting the roman string into roman characters can use "" or // as delimiter
    my @chars = split("", $roman_num);
    while ($index < scalar(@chars)) {

        # Get the decimal value of given roman character
        my $current_char = $rom_sym_val{$chars[$index]};
        if ($index + 1 < scalar(@chars)) {
            my $next_char = $rom_sym_val{$chars[$index + 1]};

            if ($current_char >= $next_char) {
				# If current value of character is greater than or equal to the value of next character,
				# then add this value to the running total. e.g. we got MD or DL or VI or LI etc
                $decimal_num = $decimal_num + $current_char;
                $index++;
            }
            else {
				# If current value of character is less than the value of next character, then subtract this
				# value by adding the value of next symbol to the running total. e.g. we got CM or IV or XD or CD etc
                $decimal_num = $decimal_num + $next_char - $current_char;
                $index       = $index + 2;
            }
        }
        else {
            # For last character in string
            $decimal_num = $decimal_num + $current_char;
            $index++;
        }
    }
    return $decimal_num;
}

print("\n" . roman_to_decimal("XXVIII"));    # 28

print("\n" . roman_to_decimal("LXIV"));      # 64
print("\n" . roman_to_decimal("XCIX"));      # 99
print("\n" . roman_to_decimal("CDXIV"));     # 414
print("\n" . roman_to_decimal("DXCV"));      # 595
print("\n" . roman_to_decimal("MDXI"));      # 1511


