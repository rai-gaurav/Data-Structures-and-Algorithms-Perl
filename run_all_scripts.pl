#!/usr/bin/env perl
# This script just run all the scripts present in this repo and check its working or not.
# This script will be run from github workflow.

use strict;
use warnings;
use File::Find::Rule;

my @root_directories = (
    "Backtracking", "Blockchain",      "Compression", "Conversions",
    "Cryptography", "Data-Structures", "Graphs",      "Recursion",
    "Searching",    "Sorting",         "Tree",        "project_euler",
    "web_programming"
);
my @files = File::Find::Rule->new->file()->name(qr /\.pl/)->in(@root_directories);

foreach my $file (@files) {
    print "\n===> Running $file...";
    my $output = `perl $file`;
    print "\nOutput: $output\n";
}
