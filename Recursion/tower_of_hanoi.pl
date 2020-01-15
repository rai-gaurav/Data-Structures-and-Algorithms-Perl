#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Tower_of_Hanoi

# The objective of the puzzle is to move the entire stack to another rod, obeying the following simple rules:
# 1. Only one disk can be moved at a time.
# 2. Each move consists of taking the upper disk from one of the stacks and placing it on top of another stack or on an empty rod.
# 3. No larger disk may be placed on top of a smaller disk.
# The minimal number of moves required to solve a Tower of Hanoi puzzle is 2n − 1, where n is the number of disks.

use strict;
use warnings;

sub tower_of_hanoi {
    my ($disk_count, $source, $destination, $auxiliary) = @_;
    if ($disk_count == 1) {
        print "\n Move disk 1 from source: " . $source . " to destination: " . $destination;
    }
    else {
        tower_of_hanoi($disk_count - 1, $source, $auxiliary, $destination);
        print "\n Move disk "
            . $disk_count
            . " from source: "
            . $source
            . " to destination: "
            . $destination;
        tower_of_hanoi($disk_count - 1, $auxiliary, $destination, $source);
    }
    return;
}

sub main {
    my $number_of_disk = 5;
    print "\n****Tower of Hanoi ****";
    print "\n Number of disks used: " . $number_of_disk . "\n";

    # A, B, C are the names of the disk
    tower_of_hanoi($number_of_disk, 'A', 'C', 'B');
    return;
}

main;
