#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Double-ended_queue

use strict;
use warnings;
use Readonly;
Readonly my $MAX_ELEMENTS => 10;

# Declare and Initialize array.
# '_' is just a place holder to show empty space in array, it can be replaced with anything
my @deque = ('_') x $MAX_ELEMENTS;
my $front = -1;
my $rear  = -1;

# Checking whether the queue is full
sub is_queue_full {
    if (($front == 0 and $rear == $MAX_ELEMENTS - 1) || $front == $rear + 1) {
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

#enqueue operation at front
sub insert_element_front {
    my ($item) = @_;

    if (is_queue_full()) {
        return;
    }
    elsif (is_queue_empty()) {
        $front = 0;
        $rear  = 0;
    }
    elsif ($front == 0) {
        $front = $MAX_ELEMENTS - 1;
    }
    else {
        $front--;
    }
    $deque[$front] = $item;
    return 1;
}

#enqueue operation at rear
sub insert_element_rear {
    my ($item) = @_;

    if (is_queue_full()) {
        return;
    }
    elsif (is_queue_empty()) {
        $front = 0;
        $rear  = 0;
    }
    elsif ($rear == $MAX_ELEMENTS - 1) {
        $rear = 0;
    }
    else {
        $rear++;
    }
    $deque[$rear] = $item;
    return 1;
}

# dequeue operation at front
sub delete_element_front {
    if (is_queue_empty()) {
        return;
    }

    # This will be the element to delete
    my $item = $deque[$front];

    # '_' is just a place holder to show empty space in array
    $deque[$front] = "_";
    if ($front == $rear) {
        $front = -1;
        $rear  = -1;
    }
    elsif ($front == $MAX_ELEMENTS - 1) {
        $front = 0;
    }
    else {
        $front++;
    }
    return $item;
}

# dequeue operation at rear
sub delete_element_rear {
    if (is_queue_empty()) {
        return;
    }

    # This will be the element to delete
    my $item = $deque[$rear];
    $deque[$rear] = "_";

    if ($front == $rear) {
        $front = -1;
        $rear  = -1;
    }
    elsif ($rear == 0) {
        $rear = $MAX_ELEMENTS - 1;
    }
    else {
        --$rear;
    }
    return $item;
}

sub main() {

    # Just insert some numbers into queue from front
    for my $number (1 .. 5) {
        if (!defined insert_element_front($number)) {
            last;
        }
        else {
            print "\n  Element inserted into front of Queue-->" . $number;
        }
    }
    print "\nQueue after insertion: @deque";
    print "\nFront: $front Rear: $rear";

    # Just insert some numbers into queue from rear
    for my $number (6 .. 12) {
        if (!defined insert_element_rear($number)) {
            last;
        }
        else {
            print "\n  Element inserted into rear of Queue-->" . $number;
        }
    }
    print "\nQueue after insertion: @deque";
    print "\nFront: $front Rear: $rear";

    # Deleting the inserted numbers previously into queue from front
    for my $number (1 .. 4) {
        my $element = delete_element_front;
        if (!defined $element) {
            last;
        }
        else {
            print "\n  Element deleted from front of Queue-->" . $element;
        }
    }
    print "\nQueue after deletion: @deque";
    print "\nFront: $front Rear: $rear";

    # Deleting the inserted numbers previously into queue from rear
    for my $number (6 .. 10) {
        my $element = delete_element_rear;
        if (!defined $element) {
            last;
        }
        else {
            print "\n  Element deleted from rear of Queue-->" . $element;
        }
    }
    print "\nQueue after deletion: @deque";
    print "\nFront: $front Rear: $rear";

    # Again trying to insert some other numbers from front
    for my $number (20 .. 30) {
        if (!defined insert_element_front($number)) {
            last;
        }
        else {
            print "\n  Element inserted into front of Queue-->" . $number;
        }
    }
    print "\nQueue after insertion: @deque";
    print "\nFront: $front Rear: $rear";
    return 1;
}

main;
