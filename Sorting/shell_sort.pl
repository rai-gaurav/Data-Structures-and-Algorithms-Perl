
#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Shellsort

#   Shell sort is a generalization of insertion sort that allows the exchange of items that are far apart .
#   The idea is to sort elements at specific interval(gap). This interval is gradually decreased to 1
#   which leave a sorted list in the end.

use strict;
use warnings;

sub shell_sort {
    my ($arr) = @_;
    my $size = scalar(@{$arr});

    # Start with the largest gap and work down to a gap of 1
    # Initialize gap to be half of the size of array
    my $gap = int($size / 2);
    while ($gap > 0) {

        # Do a gapped insertion sort for this gap size.
        for my $i ($gap .. $size - 1) {

            # save $arr->[i] in temp in case needed for swapping
            my $temp = $arr->[$i];
            my $j    = $i;

            # shift earlier gap-sorted elements up until the correct location for a[i] is found
            while ($j >= $gap and $arr->[$j - $gap] > $temp) {

                $arr->[$j] = $arr->[$j - $gap];
                $j -= $gap;
            }

            # put temp (the original a[i]) in its correct location
            $arr->[$j] = $temp;
        }
        $gap = int($gap / 2);
    }
}

sub print_array {
    my ($arr) = @_;
    my $size = scalar(@{$arr});
    for my $i (0 .. $size - 1) {
        print " " . $arr->[$i];
    }
}

my @array = (5, 1, 4, 2, 8, 3, 10);

print "\nUnsorted array is: ";
print_array(\@array);

shell_sort(\@array);

print "\nSorted array is: ";
print_array(\@array);
