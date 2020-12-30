#!/usr/bin/env perl
# https://metacpan.org/pod/Mojo::UserAgent
# https://metacpan.org/pod/Mojo::DOM

use strict;
use warnings;
use Carp qw( croak );
use Mojo::UserAgent;

sub get_stock_price {
    my ($ua, $symbol) = @_;
    my $url      = "https://in.finance.yahoo.com/quote/" . $symbol;
    my $response = $ua->get($url)->result;

    if ($response->is_success) {

        # https://docs.mojolicious.org/Mojo/DOM#find
        my $current_stock_price
            = $response->dom->find('span.Trsdu(0\.3s).Fw(b).Fz(36px).Mb(-4px).D(ib)')->map('text')
            ->join("\n");

        return $current_stock_price;
    }
    else {
        croak $response->message;
    }
}

sub main {
    my $ua = Mojo::UserAgent->new;
    $ua->transactor->name('Mozilla/5.0');
    $ua = $ua->connect_timeout(25);
    my $symbol      = "AMZN";
    my $stock_price = get_stock_price($ua, $symbol);
    print "\n Current stock price for $symbol is $stock_price";
}

main();
