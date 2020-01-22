#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Breadth-first_search
# BFS starts at the tree root(or some arbitrary node of a graph), and explores all of the neighbor
# nodes at the present depth prior to moving on to the nodes at the next depth level.

package Graph;
use strict;
use warnings;

sub new {
    my ($class) = @_;
    my $self = bless {}, $class;
    $self->{graph} = [];
    return $self;
}

# add edges to the graph
sub add_edge {
    my ($self, $source, $destination) = @_;
    push @{$self->{graph}[$source]}, $destination;
}

sub print_edge {
    my ($self) = @_;
    my $index = 0;
    foreach my $childs (@{$self->{graph}}) {
        if (defined $childs and @{$childs} != 0) {
            print "\nNode $index has neighbours: @$childs";
        }
        $index++;
    }
}

sub breadth_first_search {
    my ($self, $source_vertex) = @_;
    my @visited = (0) x scalar(@{$self->{graph}});

    my @queue = ();
    push @queue, $source_vertex;
    $visited[$source_vertex] = 1;

    while (scalar(@queue) > 0) {
        my $current_vertex = shift @queue;

        print "\n$current_vertex ";

        for my $neighbour (@{$self->{graph}[$current_vertex]}) {
            if (defined $visited[$neighbour] and $visited[$neighbour] == 0) {
                push @queue, $neighbour;
                $visited[$neighbour] = 1;
            }
        }
    }
}

package main;

my $graph = Graph->new();
$graph->add_edge(0, 1);
$graph->add_edge(0, 2);
$graph->add_edge(0, 3);
$graph->add_edge(1, 4);
$graph->add_edge(2, 4);
$graph->add_edge(3, 3);
$graph->add_edge(4, 4);

$graph->print_edge();

print "\nBFS traversal staring from vertex 0: ";
$graph->breadth_first_search(0);
