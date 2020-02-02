#!/usr/bin/env perl

# https://en.wikipedia.org/wiki/Linked_list
#   Insertion − Adds an element at the beginning of the list
#   Deletion − Deletes an element at the beginning of the list.
#   Display − Displays the complete list.
#   Search − Searches an element using the given key.
#   Delete − Deletes an element using the given key.

package Node;
use strict;
use warnings;

sub new {
    my ($class, $data) = @_;
    my $self = bless {}, $class;
    $self->{data} = $data;
    $self->{next} = undef;
    return $self;
}

########################
########################

package main;
use strict;
use warnings;
use Storable 'dclone';

my %linked_list;

sub print_list {
    my ($list) = @_;
    my $temp = $list;
    print "\nCurrent Linked list:";
    while ($temp) {
        print "\n " . $temp->{data};
        $temp = $temp->{next};
    }
}

sub insert_beginning {
    my ($new_node) = @_;

    # Do a deep copy. 2 ways to do it:
    # 1. Using 'Storable' 'dclone' function which is part of perl core - https://metacpan.org/pod/Storable
    # 2. Using 'Clone' - https://metacpan.org/pod/Clone
    $new_node->{next} = dclone \%linked_list;
    %linked_list = %{$new_node};
}

my $head   = Node->new(1);
my $second = Node->new(2);
my $third  = Node->new(3);

$linked_list{data} = $head->{data};
$linked_list{next} = $second;
$second->{next}    = $third;

print_list(\%linked_list);

my $new_node = Node->new(10);
print "\nInserting a node to the beginning...";
insert_beginning($new_node);

print_list(\%linked_list);
