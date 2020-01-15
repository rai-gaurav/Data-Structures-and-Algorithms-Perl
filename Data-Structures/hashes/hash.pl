#!/usr/bin/env perl
# More info - https://perlmaven.com/perl-hashes

use strict;
use warnings;
use Data::Dumper;

my %persons_age = ("John" => 40, "Jane" => 35, "Johnny" => 10, "Donald" => undef);

print "Current Hash : " . Dumper(\%persons_age);

# Multiple ways to access keys
print "\nAge of John: " . $persons_age{John};
print "\nAge of Jane: " . $persons_age{'Jane'};
print "\nAge of Johnny: " . $persons_age{"Johnny"};

my @keys   = keys %persons_age;
my @values = values %persons_age;
my $size   = @keys;                 # or scalar(@keys)
print "\nSize of Hash: " . $size;
print "\nKeys of Hash: @keys";
print "\nValues of Hash: @values";


# Adding an element to the hash
$persons_age{'Doe'} = 55;
print "\nUpdated Hash after addition: " . Dumper(\%persons_age);

# Remove an element from hash
delete $persons_age{'Doe'};
print "\nUpdated Hash after deletion: " . Dumper(\%persons_age);

# Checking for existence of a key and defined value
if (exists($persons_age{'Johnny'}) and defined($persons_age{'Johnny'})) {
    print "\nJohnny exist in Hash and his age is " . $persons_age{'Johnny'};
}

if (exists($persons_age{'Donald'})) {
    print "\nDonald exist in Hash.";
    if (defined($persons_age{'Donald'})) {
        print "Donald age is " . $persons_age{'Donald'};
    }
    else {
        print "Unable to find Donald age";
    }
}
