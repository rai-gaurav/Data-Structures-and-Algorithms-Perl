#!/usr/bin/env perl

use strict;
use warnings;

sub decimal_to_binary_1 {
    my ($num) = @_;
    my $bin_num;
    while ($num > 0) {
        my $remainder = $num % 2;
        if (defined $bin_num) {
            $bin_num = $remainder . $bin_num;
        }
        else {
            $bin_num = $remainder;
        }
        $num = int($num / 2);
    }
    return $bin_num;
}

# Another way to convert using sprintf
sub decimal_to_binary_2 {
    my ($num) = @_;
    my $bin_num = sprintf("%b", $num);
    return $bin_num;

}

print(decimal_to_binary_1(9));         # 1001
print("\n");
print(decimal_to_binary_2(9));         # 1001
