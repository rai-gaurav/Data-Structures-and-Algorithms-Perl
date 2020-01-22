#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Depth-first_search
# DFS algorithm starts at the root node (selecting some arbitrary node as the root node in the case of a graph)
# and explores as far as possible along each branch before backtracking. 

package Graph;
use strict;
use warnings;

sub new {
    my ($class) = @_;
    my $self = bless {}, $class;
    $self->{graph} = [];
    return $self;
}

sub add_edge {
    my ($self, $u, $v) = @_;
    push @{$self->{graph}[$u]}, $v;
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

sub dfs_recursive {
    my ($self, $source, $visited) = @_;
    $visited->[$source] = 1;
    print "\n $source ";
    for my $neighbour (@{$self->{graph}[$source]}) {
        if ($visited->[$neighbour] == 0) {
            $self->dfs_recursive($neighbour, $visited);
        }
    }
}

sub depth_first_search {
    my ($self, $source) = @_;
    my @visited = (0) x scalar(@{$self->{graph}});
    $self->dfs_recursive($source, \@visited);
}

package main;
# Creating the object of Graph class
my $graph = Graph->new();
$graph->add_edge(0, 1);
$graph->add_edge(0, 2);
$graph->add_edge(0, 3);
$graph->add_edge(1, 4);
$graph->add_edge(2, 4);
$graph->add_edge(3, 3);
$graph->add_edge(4, 4);

$graph->print_edge();

print "\nDFS traversal staring from vertex 2: ";
$graph->depth_first_search(0);
