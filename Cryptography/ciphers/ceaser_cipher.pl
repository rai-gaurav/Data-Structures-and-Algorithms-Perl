#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Caesar_cipher

use strict;
use warnings;

sub ceaser_cipher {
    my ($text, $shift, $decrypt) = @_;
    if ($decrypt) {
        $shift = 26 - $shift;
    }
    my @characters = split(//, $text);
    my $result     = "";
    foreach my $character (@characters) {

        #https://perldoc.perl.org/functions/ord.html
        # Get the numeric value of given char
        my $asciinum = ord($character);

        # Check for uppercase char. If you have unicode character
        # write it as -> $str =~ /\p{Uppercase}/
        # https://perldoc.perl.org/functions/chr.html
        if ($character =~ /[A-Z]/) {
            $result = $result . chr(($asciinum + $shift - 65) % 26 + 65);
        }
        else {
            $result = $result . chr(($asciinum + $shift - 97) % 26 + 97);
        }
    }
    return $result;
}

sub main {
    my $text_to_encrypt = "XTEADCKSTZNQX";
    my $shift           = 4;
    my $encrypted_text  = ceaser_cipher($text_to_encrypt, $shift);
    print "\nAfter Encryption: " . $encrypted_text;
    my $decrypted_text = ceaser_cipher($encrypted_text, $shift, 'decrypt');
    print "\nAfter Decryption: " . $decrypted_text;
}

main();
