#!/usr/bin/env perl
# https://metacpan.org/pod/WWW::Mechanize
# https://metacpan.org/pod/HTML::TreeBuilder

use strict;
use warnings;
use Carp qw( croak );
use WWW::Mechanize;
use HTML::TreeBuilder;

sub get_stock_price {
    my ($mech, $symbol) = @_;
    my $url      = "https://in.finance.yahoo.com/quote/" . $symbol;
    my $response = $mech->get($url);

    if ($response->is_success) {
        if ($mech->is_html()) {
            my $tree = HTML::TreeBuilder->new();
            $tree->parse($mech->content);
            my $current_stock_price = $tree->look_down(
                '_tag'  => 'span',
                'class' => 'Trsdu(0.3s) Fw(b) Fz(36px) Mb(-4px) D(ib)'
            )->as_text;
            return $current_stock_price;
        }
        else {
            print "\n Not a HTML response";
            return 0;
        }
    }
    else {
        croak $response->status_line;
    }
}

sub main {
    my $mech = WWW::Mechanize->new();
    $mech->agent_alias("Windows Mozilla");
    my $symbol      = "AMZN";
    my $stock_price = get_stock_price($mech, $symbol);
    print "\n Current stock price for $symbol is $stock_price";
}

main();
