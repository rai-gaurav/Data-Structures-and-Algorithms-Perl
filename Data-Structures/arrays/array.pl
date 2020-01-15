#!/usr/bin/env perl
# More info - https://perlmaven.com/perl-arrays

use strict;
use warnings;

my @names = ("John", "Jane", "Johnny");

# Another way to initialize array
#my @names = qw/John Jane/;

print "\nElement at index 0: " . $names[0];
print "\nElement at index 1: " . $names[1];
print "\nSize of array: " . scalar(@names);
print "\nMaximun Index of array: " . $#names;

# Adding an element to the end of array
push @names, "Doe";
print "\nCurrent array elements after push operation: @names";

# Adding an element to the start of array
unshift @names, "Joe";
print "\nCurrent array elements after unshift operation: @names";

# Removing an element to the end of array
pop @names;
print "\nCurrent array elements after pop operation: @names";

# Removing an element to the start of array
shift @names;
print "\nCurrent array elements after shift operation: @names";

# Slicing array elements, remember index starts at 0
print "\nSlicing first 2 elements from array: @names[0, 1]";

# Another way - Using range operator
print "\nSlicing first 2 elements from array using range operator: @names[0 .. 1]";
