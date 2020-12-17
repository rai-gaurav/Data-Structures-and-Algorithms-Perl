#!/usr/bin/env perl
# We are using https://openweathermap.org/api for our purpose.

use strict;
use warnings;
use Mojo::UserAgent;
use Carp;
use Readonly;

Readonly my $BASE_URL => "https://api.openweathermap.org/data/2.5/";

# Add your APP ID here or in your shell environment and remove this line
local $ENV{"APP_ID"} = "";

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

sub get_data {
    my ($ua, $url, $parameters) = @_;
    my $response = $ua->get($url => form => $parameters)->result;
    if ($response->is_success) {
        return $response->body;
    }
    else {
        croak $response->status_line;
    }
}

sub get_current_weather_data {
    my ($ua, $parameters) = @_;
    my $url = $BASE_URL . "weather";
    print get_data($ua, $url, $parameters);
}

sub get_five_days_per_three_hour_forecast {
    my ($ua, $parameters) = @_;
    my $url = $BASE_URL . "forecast";
    print get_data($ua, $url, $parameters);
}

sub get_weather_by_one_call {
    my ($ua, $parameters) = @_;
    my $url = $BASE_URL . "onecall";
    print get_data($ua, $url, $parameters);
}

sub main {
    my $ua = Mojo::UserAgent->new();

    # This server certificate cannot be properly validated by normal means hence,
    # we are disabling TLS certificate verification.
    # There are other ways also like this - https://stackoverflow.com/a/35208289/2001559
    $ua->insecure(1);

    print "\n-->> Getting current weather data...\n";
    get_current_weather_data($ua,
        {"q" => "New Delhi", "units" => "metric", "appid" => $ENV{"APP_ID"}});

    print "\n-->> Getting 5 days/3 hr forecast...\n";
    get_five_days_per_three_hour_forecast($ua, {"q" => "New Delhi", "appid" => $ENV{"APP_ID"}});

    print "\n-->> Getting all weather data by one call api...\n";
    get_weather_by_one_call(
        $ua,
        {
            "lat"     => "28.6139",
            "lon"     => "77.2090",
            "exclude" => "hourly,daily",
            "appid"   => $ENV{"APP_ID"}
        }
    );
}

main;
