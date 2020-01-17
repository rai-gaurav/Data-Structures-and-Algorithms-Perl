#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Circular_buffer

use strict;
use warnings;
use Readonly;
Readonly my $MAX_ELEMENTS => 10;

my @cqueue = ();
my $front  = -1;
my $rear   = -1;

#enqueue operation
sub insert_element {
    my ($item) = @_;

    # Checking whether the queue is full
    if (($rear + 1) % $MAX_ELEMENTS == $front) {
        print "\nQueue Overflow";
        return;
    }

    # Checking whether the queue is empty
    elsif ($front == -1) {
        $front         = 0;
        $rear          = 0;
        $cqueue[$rear] = $item;
    }
    else {
        $rear = ($rear + 1) % $MAX_ELEMENTS;
        $cqueue[$rear] = $item;
    }
    return 1;
}

#dequeue operation
sub delete_element {

    # Checking whether the queue is empty
    if ($front == -1) {
        print "\nQueue Underflown";
        return;
    }

    # Checking whether the queue contains only one element/item
    elsif ($front == $rear) {
        my $item = $cqueue[$front];

        # _ is just a place holder to show empty space in array
        $cqueue[$front] = "_";
        $front          = -1;
        $rear           = -1;
        return $item;
    }
    else {
        my $item = $cqueue[$front];
        $cqueue[$front] = "_";
        $front = ($front + 1) % $MAX_ELEMENTS;
        return $item;
    }
}

sub main() {

    # Just insert some numbers into queue
    for my $number (1 .. 20) {
        if (!defined insert_element($number)) {
            last;
        }
        else {
            print "\n  Element inserted into Queue-->" . $number;
        }
    }
    print "\nQueue after insertion: @cqueue";

    # Deleting the inserted numbers previously into queue
    for my $number (1 .. 5) {
        my $element = delete_element;
        if (!defined $element) {
            last;
        }
        else {
            print "\n  Element deleted from Queue-->" . $element;
        }
    }
    print "\nQueue after deletion: @cqueue";

    # Again trying to insert some other numbers
    for my $number (20 .. 40) {
        if (!defined insert_element($number)) {
            last;
        }
        else {
            print "\n  Element inserted into Queue-->" . $number;
        }
    }
    print "\nQueue after insertion: @cqueue";
}

main;
