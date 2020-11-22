#!/usr/bin/env perl
# There are many api available to get conversion rates. Some free with limitations.
# You can use any of them but there is less chance that any of them will be real time.
# Some of them are -
#   https://www.amdoren.com/currency-api/
#   https://fixer.io/
#   https://currencylayer.com/
#   https://www.exchangerate-api.com/docs/perl-currency-api

# There are also different client lib available to perform these request in Perl.
# Current used one - https://metacpan.org/pod/LWP::UserAgent

use strict;
use warnings;
use LWP::UserAgent;
use URI;
use IO::Socket::SSL;
use JSON;
use Carp;

# This will return the fingerprint of the given hostname
sub get_fingerprint {
    my ($dst) = @_;
    my $client = IO::Socket::SSL->new(
        PeerAddr => $dst,
        PeerPort => 443,

        # certificate cannot be validated the normal way, so we need to
        # disable validation this one time in the hope that there is
        # currently no man in the middle attack
        SSL_verify_mode => 0,
    ) or croak "connect failed";
    my $fp = $client->get_fingerprint;
    return $fp;
}

sub convert_currency {
    my ($ua, $parameters) = @_;

    my $url = URI->new("https://www.amdoren.com/api/currency.php");
    $url->query_form(%{$parameters});

    my $response = $ua->get($url);
    if ($response->is_success) {
        my $message       = $response->decoded_content;
        my $json_response = from_json($message);
        print "\n"
            . $parameters->{'amount'} . " "
            . $parameters->{'from'} . " = "
            . $json_response->{'amount'} . " "
            . $parameters->{'to'};
    }
    else {
        croak $response->status_line;
    }
}

sub main {

    # This server certificate cannot be properly validated by normal means hence,
    # we are getting fingerprint and passing that in LWP options.
    # This step is not needed if we have proper server certificate.
    # Reference - https://stackoverflow.com/a/35078145/2001559
    my $fp = get_fingerprint("www.amdoren.com");
    my $ua = LWP::UserAgent->new(ssl_opts => {SSL_fingerprint => $fp});
    $ua->show_progress(1);

    # Add your API key here or in your shell environment and remove this line
    local $ENV{"AMDOREN_API_KEY"} = "";

    # Convert 10 USD to INR, API key will be taken from env variable
    convert_currency($ua,
        {"api_key" => $ENV{"AMDOREN_API_KEY"}, "from" => "USD", "to" => "INR", "amount" => 10});
}

main;
