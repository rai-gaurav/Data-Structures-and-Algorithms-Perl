#!/usr/bin/env perl
use strict;
use warnings;
use IO::Socket;

local $| = 1;                   # Autoflush
my $hostname = 'localhost';     # localhost
my $port     = 7171;

my $socket = IO::Socket::INET->new(
    PeerAddr => $hostname,
    PeerPort => $port,
    Proto => 'tcp',
    Timeout => 1
) or die "Could not connect: $!";

while (1) {
    print "\nEnter the data to send: ";
    # Take user inout
    my $send_data = <>;
    chomp($send_data);
    if ($send_data) {
        my $size = $socket->send($send_data);
        print "\nSent data of length: $size";

        my $buffer;
        $socket->recv($buffer, 1024);
        print "\nGot back $buffer\n";
    }
}
$socket->close();
