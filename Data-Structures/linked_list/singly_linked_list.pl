#!/usr/bin/env perl

# https://en.wikipedia.org/wiki/Linked_list
# Insertion − Adds an element at the beginning of the list
#    Deletion − Deletes an element at the beginning of the list.
#    Display − Displays the complete list.
#    Search − Searches an element using the given key.
#    Delete − Deletes an element using the given key.
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
use Data::Dumper;
my %linked_list;
sub print_list {
	my ($list) = @_;
	my $temp = $list;
	while($temp) {
		print "\n".$temp->{data};
		$temp = $temp->{next};
	}
}

sub insert_beginning {
	my ($new_node) = @_;
	$new_node->{next} = \%linked_list;
	$linked_list{data} = $new_node;
}

my $head = Node->new(1);
my $second = Node->new(2);
my $third = Node->new(3);

$linked_list{data} = $head->{data};
$linked_list{next} = $second;
$second->{next} = $third;

print Dumper(\%linked_list);
my $new_node = Node->new(10);
insert_beginning($new_node);
print_list(\%linked_list);
print Dumper(\%linked_list);
