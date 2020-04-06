#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Morse_code

use strict;
use warnings;

my %morse_code = (
    "A" => ".-",
    "B" => "-...",
    "C" => "-.-.",
    "D" => "-..",
    "E" => ".",
    "F" => "..-.",
    "G" => "--.",
    "H" => "....",
    "I" => "..",
    "J" => ".---",
    "K" => "-.-",
    "L" => ".-..",
    "M" => "--",
    "N" => "-.",
    "O" => "---",
    "P" => ".--.",
    "Q" => "--.-",
    "R" => ".-.",
    "S" => "...",
    "T" => "-",
    "U" => "..-",
    "V" => "...-",
    "W" => ".--",
    "X" => "-..-",
    "Y" => "-.--",
    "Z" => "--..",
    "1" => ".----",
    "2" => "..---",
    "3" => "...--",
    "4" => "....-",
    "5" => ".....",
    "6" => "-....",
    "7" => "--...",
    "8" => "---..",
    "9" => "----.",
    "0" => "-----",
    ", " => "--..--",
    "."  => ".-.-.-",
    "?"  => "..--..",
    "/"  => "-..-.",
    "-"  => "-....-",
    "("  => "-.--.",
    ")"  => "-.--.-"
);

my %reverse_morse_code = reverse %morse_code;

sub convert_to_morse {
    my ($message)  = @_;
    my @characters = split(//, $message);
    my $result     = "";
    foreach my $character (@characters) {
        if ($character ne " ") {
            if ($morse_code{$character}) {
                $result .= $morse_code{$character} . " ";
            }
            else {
                print "\nUnknow character: " . $character;
            }
        }
        else {
            $result .= " ";
        }
    }
    return $result;
}

sub convert_from_morse {
    my ($message)  = @_;
	# We will have space seperated encrypted message 
    my @characters = split(/ /, $message);
    my $result     = "";
    foreach my $character (@characters) {
        if ($reverse_morse_code{$character}) {
            $result .= $reverse_morse_code{$character};
        }

        # Since we splited on space,
        # If there was a space it will be converted to empty value
        elsif ($character eq "") {
            $result .= " ";
        }
        else {
            print "\nUnknow character: " . $character;
        }
    }
    return $result;
}

sub main {
    my $message              = "Perl - The Swiss Army chainsaw of scripting languages";
	# There is no distinction between upper and lower case letters in morse code. 
	# Hence, converting all to uppercase
    my $encrypted_morse_code = convert_to_morse(uc($message));
    print "\nEncrypted: " . $encrypted_morse_code;
    my $decrypted_morse_code = convert_from_morse($encrypted_morse_code);
    print "\nDecrypted: " . $decrypted_morse_code;
}

main();
