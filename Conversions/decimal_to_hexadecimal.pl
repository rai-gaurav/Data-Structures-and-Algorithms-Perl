#!/usr/bin/env perl

use strict;
use warnings;

sub decimal_to_hexa_1 {
    my ($num) = @_;
    my $hex_num = '';
    while ($num > 0) {
        my $remainder = $num % 16;
        if ($remainder < 10) {
            $hex_num = chr($remainder + 48) . $hex_num;
        }
        else {
            $hex_num = chr($remainder + 55) . $hex_num;
        }
        $num = int($num / 16);
    }
    return $hex_num;
}

# Another way to convert using sprintf
sub decimal_to_hexa_2 {
    my ($num) = @_;
    my $hex_num = sprintf("%X", $num);
    return $hex_num;

}

print(decimal_to_hexa_1(45));
print("\n");
print(decimal_to_hexa_2(45));
