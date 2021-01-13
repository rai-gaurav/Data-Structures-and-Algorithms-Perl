#!/usr/bin/env perl

# This script just used to test recaptcha by automating the firefox browser
# https://metacpan.org/pod/Firefox::Marionette
use strict;
use warnings;
use Firefox::Marionette;

sub main {
    my $url           = "http://localhost:3000/";
    my $firefox       = Firefox::Marionette->new(visible => 1);
    my $window_handle = $firefox->new_window(type => 'window', focus => 1, private => 1);
    $firefox->switch_to_window($window_handle);
    $firefox->go($url);

    my $element = $firefox->find_name('username');
    $firefox->clear($element);
    $firefox->type($element, "admin");

    $element = $firefox->find_name('password');
    $firefox->clear($element);
    $firefox->type($element, "admin");

    sleep 5;

    $firefox->find_id('submit')->click();

    sleep 10;
}

main();
