#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Base64
# https://metacpan.org/pod/MIME::Base64

use strict;
use warnings;
use MIME::Base64;

sub main {
    my ($data) = @_;
    my $base64_encoded = encode_base64($data);
    print "\nBase64 encoded is: " . $base64_encoded;

    my $base64_decoded = decode_base64($base64_encoded);
    print "\nBase64 decoded is: " . $base64_decoded;
}

main(45);
main("Hello there!");
