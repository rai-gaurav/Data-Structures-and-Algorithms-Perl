#!/usr/bin/env perl

use strict;
use warnings;

my @stack = (1, 4, 6, 12, 3, 56);

print "\nCurrent Stack: @stack";
print "\nBottom stack item: $stack[0]";
print "\nTop stack item: $stack[-1]\n";

# Pushing an element
my $element_to_push = 100;
push @stack, $element_to_push;
print "\nElement inserted: $element_to_push";
print "\nStack after pushing: @stack \n";

# Popping an element
my $popped_element = pop @stack;
print "\nElement removed: $popped_element";
print "\nStack after popping: @stack \n";

# Pushing an array
my @array_to_push = ("abc", "xyz");
push @stack, @array_to_push;
print "\nInserted array elements: @array_to_push";
print "\nStack after pushing: @stack \n";
