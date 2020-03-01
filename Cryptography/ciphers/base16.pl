#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Hexadecimal
# Mentioned in - https://github.com/sudo-batman/Data-Structures-and-Algorithms-Perl/blob/master/conversions/decimal_to_hexadecimal.pl

use strict;
use warnings;

sub main {
    my ($num) = @_;
    my $hex_num = sprintf("%X", $num);
    print "\nBase16 encoded is: " . $hex_num;

    my $dec_num = hex($hex_num);
    print "\nBase16 decoded is: " . $dec_num;
}

main(45);
