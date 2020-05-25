
#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/RSA_(cryptosystem)
# https://simple.wikipedia.org/wiki/RSA_algorithm

use strict;
use warnings;
use Scalar::Util qw(looks_like_number);
use Data::Dumper;

# Two different random prime numbers.
# To make RSA difficule to break, the prime numbers should be large.
my $p = 3;
my $q = 7;

# n is the modulus for the public key and the private keys
my $n = $p * $q;

# https://simple.wikipedia.org/wiki/Euler%27s_totient_function
# totient or phi -> Φ(n)
my $totient = ($p - 1) * ($q - 1);

# Choose e such that 1 < e < Φ(n), and e is co-prime to Φ(n) i.e. e and Φ(n) share no factors other than 1
# This will be taken care in 'check_co_prime' function
#my $e = int (1 + rand($totient));
my $e = 2;

# https://en.wikipedia.org/wiki/Euclidean_algorithm
# Many ways to get gcd, one is recursive way.
sub get_gcd {
    my ($num1, $num2) = @_;
    if ($num2 == 0) {
        return $num1;
    }
    else {
        return get_gcd($num2, $num1 % $num2);
    }
}

sub check_co_prime {
    # e must be co-prime to totient and smaller than it.
    while ($e < $totient) {
        if (get_gcd($e, $totient) == 1) {
            return 1;
        }
        else {
            $e++;
        }
    }
    return 0;
}

sub get_inverse {
    # k can be any arbitrary value
    my $k = 2;

    # Compute d to satisfy the congruence relation
    # https://simple.wikipedia.org/wiki/Modular_arithmetic#The_congruence_relation
    # choosing d (decrypt) such that (d * e) = (1 + (k * totient))
    my $x = 1 + $k * $totient;
    my $d = int($x / $e);
    return $d;
}

sub rsa_encrypt {
    my ($msg) = @_;

    # EncryptedData = (msg ^ e) % n
    my $enc_data = ($msg**$e) % $n;
    return $enc_data;
}

sub rsa_decrypt {
    my ($enc_data) = @_;
    my $d = get_inverse();

    # DecryptedData = (enc_data ^ d) % n
    my $decr_data = ($enc_data**$d) % $n;
    return $decr_data;
}

sub get_ascii_num {
    my ($word) = @_;
    my @chars = split("", $word);
    my @nums;
    foreach my $char (@chars) {
        my $num = ord($char);
        push(@nums, $num);
    }
    return join("", @nums);
}

sub main {

    # Data to encrypt
    my $message = 11;

    # currently not working for String. ONly for numbers
    if (!looks_like_number($message)) {
        # $message = get_ascii_num($message);
    }
    check_co_prime();
    print "\n p => $p";
    print "\n q => $q";
    print "\n n (p*q) => $n";
    print "\n totient/phi ((p-1)*(q-1)) => $totient";
    print "\n e => $e";
    print "\n Data to encrypt => $message";
    my $enc_data = rsa_encrypt($message);
    print "\n\n Encrypted data : $enc_data";
    my $decr_data = rsa_decrypt($enc_data);
    print "\n\n Decrypted data : $decr_data";
}

main;
