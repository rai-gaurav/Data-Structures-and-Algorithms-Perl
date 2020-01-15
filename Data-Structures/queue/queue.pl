#!/usr/bin/env perl

use strict;
use warnings;

my @queue = (1, 4, 6, 12, 3, 56);

print "\nCurrent queue: @queue";
print "\nFront queue item: $queue[0]";
print "\nRear queue item: $queue[-1]\n";

# Pushing an element to rear(enqueue)
my $element_to_push = 100;
push @queue, $element_to_push;
print "\nElement inserted: $element_to_push";
print "\nQueue after pushing: @queue \n";

# Popping an element from front(dequeue)
my $popped_element = shift @queue;
print "\nElement removed: $popped_element";
print "\nQueue after popping: @queue \n";

# Pushing an array to rear
my @array_to_push = ("abc", "xyz");
push @queue, @array_to_push;
print "\nInserted array elements: @array_to_push";
print "\nqueue after pushing: @queue \n";
