#!/usr/bin/env perl

# https://metacpan.org/pod/Socket
# Socket a low-level module used by the IO::Socket family of modules.
# A practical program would likely use the higher-level API provided by IO::Socket
# https://metacpan.org/pod/IO::Socket

use strict;
use warnings;
use IO::Socket;

local $| = 1;                # Autoflush
my $hostname = '0.0.0.0';    # localhost
my $port     = 7171;

my $socket = IO::Socket::INET->new(
    LocalHost => $hostname,
    LocalPort => $port,
    Proto     => 'tcp',
    Listen    => 5,
    Reuse     => 1
) or die "Cannot create socket: $!";

print "Waiting for tcp connection from client on port $port\n";

while (1) {
    my $client_socket  = $socket->accept();
    my $client_address = $client_socket->peerhost;
    my $client_port    = $client_socket->peerport;

    print "$client_address $client_port has connected";

    while (1) {

        # read up to 1024 characters from the connected client
        my $data;
        $client_socket->recv($data, 1024);
        if ($data) {
            print "\nReceived data: $data";

            # write response data to the connected client
            $client_socket->send("OK " . $data);
        }
    }
}

$socket->close;
