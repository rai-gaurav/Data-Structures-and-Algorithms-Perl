#!/usr/bin/env perl
# https://metacpan.org/pod/LWP::UserAgent
# https://metacpan.org/pod/XML::LibXML

# We can use 'HTML::TreeBuilder' or 'XML::Twig' also here for parsing HTML.
# We are using 'XML::LibXML' just as an example as it can also parse HTML

use strict;
use warnings;
use Carp qw( croak );
use LWP::UserAgent ();
use XML::LibXML;

sub get_stock_price {
    my ($ua, $symbol) = @_;
    my $url      = "https://in.finance.yahoo.com/quote/" . $symbol;
    my $response = $ua->get($url);

    if ($response->is_success) {
        my $dom = XML::LibXML->load_html(
            string          => $response->decoded_content,
            recover         => 1,
            suppress_errors => 1
        );

        my $xpath = '//span[contains(@class, "Trsdu(0.3s) Fw(b) Fz(36px) Mb(-4px) D(ib)")]';
        return $dom->findvalue($xpath);
    }
    else {
        croak $response->status_line;
    }
}

sub main {
    my $ua = LWP::UserAgent->new();
    $ua->agent('Mozilla/5.0');
    my $symbol      = "AMZN";
    my $stock_price = get_stock_price($ua, $symbol);
    print "\n Current stock price for $symbol is $stock_price";
}

main();
