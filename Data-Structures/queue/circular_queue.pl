#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Circular_buffer

use strict;
use warnings;
use Readonly;
Readonly my $MAX_ELEMENTS => 10;

# Declare and Initialize array.
# '_' is just a place holder to show empty space in array, it can be replaced with anything
my @cqueue = ('_') x $MAX_ELEMENTS;
my $front  = -1;
my $rear   = -1;

# Checking whether the queue is full
sub is_queue_full {
    if (($rear + 1) % $MAX_ELEMENTS == $front) {
        print "\n===> Queue Overflow";
        return 1;
    }
    else {
        return 0;
    }
}

# Checking whether the queue is empty
sub is_queue_empty {
    if ($front == -1) {
        print "\n===> Queue Underflow";
        return 1;
    }
    else {
        return 0;
    }
}

#enqueue operation
sub insert_element {
    my ($item) = @_;
    if (is_queue_full) {
        return;
    }
    if (is_queue_empty) {
        $front = 0;
        $rear  = 0;
    }
    else {
        $rear = ($rear + 1) % $MAX_ELEMENTS;
    }
    $cqueue[$rear] = $item;
    return 1;
}

#dequeue operation
sub delete_element {
    if (is_queue_empty) {
        return;
    }

    # This element will be deleted
    my $item = $cqueue[$front];

    # _ is just a place holder to show empty space in array
    $cqueue[$front] = "_";
    if ($front == $rear) {
        $front = -1;
        $rear  = -1;
    }
    else {
        $front = ($front + 1) % $MAX_ELEMENTS;
    }
    return $item;
}

sub main() {

    # Just insert some numbers into queue
    for my $number (1 .. 8) {
        if (!defined insert_element($number)) {
            last;
        }
        else {
            print "\n  Element inserted into Circular Queue-->" . $number;
        }
    }
    print "\nQueue after insertion: @cqueue";
    print "\nFront: $front Rear: $rear";

    # Deleting the inserted numbers previously into queue
    for my $number (1 .. 5) {
        my $element = delete_element;
        if (!defined $element) {
            last;
        }
        else {
            print "\n  Element deleted from Circular Queue-->" . $element;
        }
    }
    print "\nQueue after deletion: @cqueue";
    print "\nFront: $front Rear: $rear";

    # Again trying to insert some other numbers
    for my $number (20 .. 40) {
        if (!defined insert_element($number)) {
            last;
        }
        else {
            print "\n  Element inserted into Circular Queue-->" . $number;
        }
    }
    print "\nQueue after insertion: @cqueue";
    print "\nFront: $front Rear: $rear";
}

main;
