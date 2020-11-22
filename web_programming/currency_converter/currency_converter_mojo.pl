#!/usr/bin/env perl
# There are many api available to get conversion rates. Some free with limitations.
# You can use any of them but there is less chance that any of them will be real time.
# Some of them are -
#   https://www.amdoren.com/currency-api/
#   https://fixer.io/
#   https://currencylayer.com/
#   https://www.exchangerate-api.com/docs/perl-currency-api

# There are also different client lib available to perform these request in Perl.
# Current used one - https://metacpan.org/pod/Mojo::UserAgent

use strict;
use warnings;
use Mojo::UserAgent;

sub convert_currency {
    my ($ua, $parameters) = @_;

    my $url = "https://www.amdoren.com/api/currency.php";

    # This server certificate cannot be properly validated by normal means hence,
    # we are disabling TLS certificate verification.
    # There are other ways also like this - https://stackoverflow.com/a/35208289/2001559
    $ua->insecure(1);

    my $response = $ua->get($url => form => $parameters)->result;
    if ($response->is_success) {
        my $message = $response->json;
        print "\n"
            . $parameters->{'amount'} . " "
            . $parameters->{'from'} . " = "
            . $message->{'amount'} . " "
            . $parameters->{'to'};
    }
    elsif ($response->is_error) {
        print $response->message;
    }
}

sub main {
    my $ua = Mojo::UserAgent->new();

    # Add your API key here or in your shell environment and remove this line
    local $ENV{"AMDOREN_API_KEY"} = "";

    # Convert 10 USD to INR, API key will be taken from env variable
    convert_currency($ua,
        {"api_key" => $ENV{"AMDOREN_API_KEY"}, "from" => "USD", "to" => "INR", "amount" => 10});
}

main;
