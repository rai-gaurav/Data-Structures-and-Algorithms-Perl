#!/usr/bin/env perl
# Search google with a keyword and get all the anchor links and text in search results.

# https://metacpan.org/pod/LWP::UserAgent
# https://metacpan.org/pod/HTML::TreeBuilder

use strict;
use warnings;
use Carp qw( croak );
use LWP::UserAgent ();
use HTML::TreeBuilder;

sub crawl_results {
    my ($ua, $url) = @_;
    my $response = $ua->get($url);

    if ($response->is_success) {
        my $tree = HTML::TreeBuilder->new();
        $tree->parse($response->decoded_content);

        # https://metacpan.org/pod/HTML::Element#look_down
        # We will be getting the 'anchor' tag which is inside the 'div' tag having class 'kCrYT'
        my @anchor_tags = $tree->look_down(
            '_tag' => 'a',
            sub {
                $_[0]->look_up('_tag' => 'div', 'class' => 'kCrYT');
            }
        );
        for my $anchor (@anchor_tags) {
            my $anchor_text
                = $anchor->look_down('_tag' => 'div', 'class' => 'BNeawe vvjwJb AP7Wnd');
            if (defined $anchor_text) {
                print $anchor_text->as_text() . "\n        " . $anchor->attr('href') . "\n";
            }
            else {
                $anchor_text
                    = $anchor->look_down('_tag' => 'span', 'class' => 'XLloXe AP7Wnd');
                print "    " . $anchor_text->as_text() . "\n        " . $anchor->attr('href') . "\n";
            }

        }
    }
    else {
        croak $response->status_line;
    }
}

sub main {
    my $search_text = "Perl";
    my $url         = "https://www.google.com/search?q=" . $search_text;

    my $ua = LWP::UserAgent->new();
    $ua->show_progress(1);

    $ua->agent('Mozilla/5.0');

    crawl_results($ua, $url);
}

main();


__END__

Output-

The Perl Programming Language - www.perl.org
        /url?q=https://www.perl.org/&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQFjAAegQIBRAB&usg=AOvVaw3y3nT09Oz2w6kikznVIuMh
    Perl Download
        /url?q=https://www.perl.org/get.html&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQ0gIwAHoECAUQAg&usg=AOvVaw2gBE2LhG8ygDrly05ICUdw
    About
        /url?q=https://www.perl.org/about.html&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQ0gIwAHoECAUQAw&usg=AOvVaw24DsGYNiDr06YOm3I0ZMZK
    Learn Perl
        /url?q=https://www.perl.org/learn.html&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQ0gIwAHoECAUQBA&usg=AOvVaw3oJC7A0q1L2bBbAuV2vtLH
    Perl Blogs
        /url?q=http://blogs.perl.org/&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQ0gIwAHoECAUQBQ&usg=AOvVaw0NG5PstdaQ-LXgQF1xO527
    Wikipedia
        /url?q=https://en.wikipedia.org/wiki/Perl&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQmhMwEnoECBUQDg&usg=AOvVaw1Sj3QfRNbZWdksIJMDVpRQ
Perl.com - programming news, code and culture
        /url?q=https://www.perl.com/&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQFjAcegQIBhAB&usg=AOvVaw1oMYhe_vApCBfMeull0wuW
Perl - Wikipedia
        /url?q=https://en.wikipedia.org/wiki/Perl&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQFjAdegQICxAB&usg=AOvVaw1hl5JKfzPLO2SiuBF-1JjD
    History
        /url?q=https://en.wikipedia.org/wiki/Perl%23History&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQ0gIwHXoECAsQAg&usg=AOvVaw3TwYV8Wu_P33aqJ3zAfQxJ
    Overview
        /url?q=https://en.wikipedia.org/wiki/Perl%23Overview&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQ0gIwHXoECAsQAw&usg=AOvVaw22fnsL-FL2s9paSxHBL46G        
    Database interfaces
        /url?q=https://en.wikipedia.org/wiki/Perl%23Database_interfaces&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQ0gIwHXoECAsQBA&usg=AOvVaw14s-sSUPwFEW6psKWbyUKF
    Larry Wall
        /url?q=https://en.wikipedia.org/wiki/Larry_Wall&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQs2YwHXoECAsQBw&usg=AOvVaw2cTISw6jscTZdSuSwsu0zO
    GNU General Public License
        /url?q=https://en.wikipedia.org/wiki/GNU_General_Public_License&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQs2YwHXoECAsQCQ&usg=AOvVaw22kEPvsqGJ-vhq4kl2ceZs
    Multi-paradigm
        /url?q=https://en.wikipedia.org/wiki/Multi-paradigm&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQs2YwHXoECAsQCw&usg=AOvVaw11J9SG-p_azhwtEbdSSfM4
    functional
        /url?q=https://en.wikipedia.org/wiki/Functional_programming&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQs2YwHXoECAsQDA&usg=AOvVaw3JtcSXpqWhgQGdra95zHeY
    imperative
        /url?q=https://en.wikipedia.org/wiki/Imperative_programming&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQs2YwHXoECAsQDQ&usg=AOvVaw0sYvOP4Klk4lgYTga4uAtM 
    object-oriented
        /url?q=https://en.wikipedia.org/wiki/Object-oriented_programming&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQs2YwHXoECAsQDg&usg=AOvVaw06tbttIjQ5dAgMezRUf4XB
    class-based
        /url?q=https://en.wikipedia.org/wiki/Class-based_programming&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQs2YwHXoECAsQDw&usg=AOvVaw0KRak58-NGipywvgYlBAQX
    reflective
        /url?q=https://en.wikipedia.org/wiki/Reflective_programming&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQs2YwHXoECAsQEA&usg=AOvVaw14Tc5tx4Hy50wDmKq4CgQT 
Perl Tutorial - Tutorialspoint
        /url?q=https://www.tutorialspoint.com/perl/index.htm&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQFjAeegQICBAB&usg=AOvVaw0I4QvcKPi7pfpwWWsU1_B0
    Perl - Introduction
        /url?q=https://www.tutorialspoint.com/perl/perl_introduction.htm&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQ0gIwHnoECAgQAg&usg=AOvVaw0YWOpaHqZHQA07OLuwe_Tr
    Perl - Arrays
        /url?q=https://www.tutorialspoint.com/perl/perl_arrays.htm&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQ0gIwHnoECAgQAw&usg=AOvVaw0MC522KylwTVJc3RuiqG-f  
    Perl - Environment
        /url?q=https://www.tutorialspoint.com/perl/perl_environment.htm&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQ0gIwHnoECAgQBA&usg=AOvVaw2vLcHLWFy4L3sg5Qh6sGmF
    Perl - Variables
        /url?q=https://www.tutorialspoint.com/perl/perl_variables.htm&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQ0gIwHnoECAgQBQ&usg=AOvVaw3oaQXhbe_qQuI_OFvhJ6W4
Perl - Introduction - Tutorialspoint
        /url?q=https://www.tutorialspoint.com/perl/perl_introduction.htm&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQFjAfegQIChAB&usg=AOvVaw0rU8BKx99oTDNj6-guNTfa
Perl Tutorial for Beginners: Learn in 1 Day - Guru99
        /url?q=https://www.guru99.com/perl-tutorials.html&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQFjAkegQIARAB&usg=AOvVaw2hhKV98I8svSTwlpoMPe6r
Perl Programming Language - GeeksforGeeks
        /url?q=https://www.geeksforgeeks.org/perl-programming-language/&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQFjAlegQIABAB&usg=AOvVaw3C6q2gA836AhZ34l_evZKL
Introduction to Perl - GeeksforGeeks
        /url?q=https://www.geeksforgeeks.org/introduction-to-perl/&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQFjAmegQIAxAB&usg=AOvVaw1--1qHvlQqS_SatxPjJwZt    
The Top 10 Programming Tasks That Perl Is Used For | By ActiveState
        /url?q=https://www.activestate.com/blog/top-10-programming-tasks-that-perl-is-used-for/&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQFjAnegQIDBAB&usg=AOvVaw1fO1A3eh2DrU5r0PcjjH_g
Perl Tutorial
        /url?q=https://www.perltutorial.org/&sa=U&ved=2ahUKEwjnosLT6PXtAhW6yjgGHVOqAlcQFjAoegQIBxAB&usg=AOvVaw0rDSo8UlL65M1D3GGHpNrk
