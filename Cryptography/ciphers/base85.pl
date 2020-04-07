#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Ascii85

# Couple of ways to acheive this in perl -
# 1. https://metacpan.org/pod/Convert::Base85
# 2. https://metacpan.org/pod/Math::Base85  -> For number only

use strict;
use warnings;
use Convert::Base85 qw(base85_encode base85_decode);

sub main {
    my ($data) = @_;
    my $base85_encoded = base85_encode($data);
    print "\nBase64 encoded is: " . $base85_encoded;

    my $base85_decoded = base85_decode($base85_encoded);
    print "\nBase64 decoded is: " . $base85_decoded;
}

main("45");
main("Hello World!");
