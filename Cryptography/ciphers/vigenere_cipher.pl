#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher

use strict;
use warnings;

sub vigenere_cipher {
    my ($text, $keyword, $decrypt) = @_;
    if (length($text) != length($keyword)) {

        # Make the length of text and keyword equal by repeating the keyword
        foreach my $i (0 .. (length($text) - length($keyword) - 1)) {
            $keyword = $keyword . substr($keyword, $i % length($keyword), 1);
        }
    }
    my $ciphertext;
    foreach my $i (0 .. length($text) - 1) {
        # If we want to decrypt
        if ($decrypt) {

            # #https://perldoc.perl.org/functions/ord.html
            # ord - Get the numeric value of given char
            # Decryptedtext is (encryptedtext - key + 26) mod 26
            my $offset = (ord(substr($text, $i, 1)) - ord(substr($keyword, $i, 1)) + 26) % 26;

            # https://perldoc.perl.org/functions/chr.html
            $ciphertext .= chr(ord('A') + $offset);
        }
        # We want to encrypt
        else {

            # ciphertext is (text + key) mod 26
            my $offset = (ord(substr($text, $i, 1)) + ord(substr($keyword, $i, 1))) % 26;
            $ciphertext .= chr(ord('A') + $offset);
        }
    }
    return $ciphertext;
}

sub main {
    # convert everthing to uppercase for convenience
    my $text_to_encrypt = uc("Perl - The Swiss Army chainsaw of scripting languages");
    my $keyword         = uc("Gaurav");
    my $encrypted_text  = vigenere_cipher($text_to_encrypt, $keyword);
    print "\nAfter Encryption: " . $encrypted_text;
    my $decrypted_text = vigenere_cipher($encrypted_text, $keyword, 'decrypt');
    print "\nAfter Decryption: " . $decrypted_text;
}
main;
