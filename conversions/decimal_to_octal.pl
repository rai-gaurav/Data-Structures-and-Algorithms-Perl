#!/usr/bin/env perl

use strict;
use warnings;

sub decimal_to_octal_1 {
    my ($num) = @_;
    my $octal_num;
    while ($num > 0) {
        my $remainder = $num % 8;
        if (defined $octal_num) {
            $octal_num = $remainder . $octal_num;
        }
        else {
            $octal_num = $remainder;
        }
        $num = int($num / 8);
    }
    return $octal_num;
}

# Another way to convert using sprintf
sub decimal_to_octal_2 {
    my ($num) = @_;
    my $octal_num = sprintf("%o", $num);
    return $octal_num;

}

print(decimal_to_octal_1(45));
print("\n");
print(decimal_to_octal_2(45));
