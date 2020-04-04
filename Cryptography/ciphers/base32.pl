#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Base32
# https://metacpan.org/pod/MIME::Base32

use strict;
use warnings;
use MIME::Base32;

sub main {
    my ($data) = @_;
    my $base32_encoded = encode_base32($data);
    print "\nBase32 encoded is: " . $base32_encoded;

    my $base32_decoded = decode_base32($base32_encoded);
    print "\nBase32 decoded is: " . $base32_decoded;
}

main(45);
main("Hello there!");
