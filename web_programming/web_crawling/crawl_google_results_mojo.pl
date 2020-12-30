#!/usr/bin/env perl
# Search google with a keyword and get all the anchor links and text in search results.

# https://metacpan.org/pod/Mojo::UserAgent
# https://metacpan.org/pod/Mojo::DOM

use strict;
use warnings;
use Carp qw( croak );
use Mojo::UserAgent;

sub crawl_results {
    my ($ua, $url) = @_;
    my $response = $ua->get($url)->result;

    if ($response->is_success) {

        # https://docs.mojolicious.org/Mojo/DOM#find
        my $anchor_tags  = $response->dom->find('div.kCrYT a');
        my $anchor_hrefs = $anchor_tags->map(attr => 'href');
        my $i            = 0;
        for my $anchor ($anchor_tags->each) {
            my $parent_anchor_text = $anchor->find('div.BNeawe.vvjwJb.AP7Wnd')->map('text')->join("\n");
            my $child_anchor_text  = $anchor->find('span.XLloXe.AP7Wnd')->map('text')->join("\n");
            if (defined $parent_anchor_text && $parent_anchor_text ne "") {
                print $parent_anchor_text . "\n";
            }
            else {
                print "    " . $child_anchor_text . "\n";
            }
            print "        " . $anchor_hrefs->[$i] . "\n";
            $i++;
        }
    }
    else {
        croak $response->message;
    }
}

sub main {
    my $search_text = "Perl";
    my $url         = "https://www.google.com/search?q=" . $search_text;
    my $ua          = Mojo::UserAgent->new;

    $ua->transactor->name('Mozilla/5.0');
    $ua->insecure(1);

    crawl_results ($ua, $url);
}

main();


__END__

Output-

The Perl Programming Language - www.perl.org
        /url?q=https://www.perl.org/&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQFjAAegQIBhAB&usg=AOvVaw1isbCIIVJVM-UWzr84aM6s
    Perl Download
        /url?q=https://www.perl.org/get.html&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQ0gIwAHoECAYQAg&usg=AOvVaw1lu1-3zx6zsjHu7MkxT0Zf
    About
        /url?q=https://www.perl.org/about.html&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQ0gIwAHoECAYQAw&usg=AOvVaw3o5Q-68_gEZ7js1v9bm3D8
    Learn Perl
        /url?q=https://www.perl.org/learn.html&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQ0gIwAHoECAYQBA&usg=AOvVaw11edW8Ds7l2jb2vvca7RQE
    Perl Blogs
        /url?q=http://blogs.perl.org/&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQ0gIwAHoECAYQBQ&usg=AOvVaw3opWhdIdw41ilTT63-FaqJ
    Wikipedia
        /url?q=https://en.wikipedia.org/wiki/Perl&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQmhMwEnoECBUQDg&usg=AOvVaw0CvOCw80_ooV5y15ATthrB
Perl.com - programming news, code and culture
        /url?q=https://www.perl.com/&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQFjAcegQICxAB&usg=AOvVaw26g4cqX7RdeYfJB3BCutO3
Perl - Wikipedia
        /url?q=https://en.wikipedia.org/wiki/Perl&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQFjAdegQICRAB&usg=AOvVaw2op26ZZPgDAYHd58X2bQr0
    History
        /url?q=https://en.wikipedia.org/wiki/Perl%23History&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQ0gIwHXoECAkQAg&usg=AOvVaw3qZ5G2DDfa1KZyv3efcF37
    Overview
        /url?q=https://en.wikipedia.org/wiki/Perl%23Overview&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQ0gIwHXoECAkQAw&usg=AOvVaw0hWKZuhUv90C3yI2l6LgOM
    Perl 5
        /url?q=https://en.wikipedia.org/wiki/Perl%23Perl_5&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQ0gIwHXoECAkQBA&usg=AOvVaw3busoJwzxZ_PvqFzhImLER
    Raku (Perl 6)
        /url?q=https://en.wikipedia.org/wiki/Perl%23Raku_(Perl_6)&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQ0gIwHXoECAkQBQ&usg=AOvVaw0sIQUHQnf7r8pML8SB5R3p   
    Larry Wall
        /url?q=https://en.wikipedia.org/wiki/Larry_Wall&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQs2YwHXoECAkQCA&usg=AOvVaw1X-51UKDnnCV6EpWV65Wz1
    GNU General Public License
        /url?q=https://en.wikipedia.org/wiki/GNU_General_Public_License&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQs2YwHXoECAkQCg&usg=AOvVaw2ruYZmCzQ4Js1Mj1DObefF
    Multi-paradigm
        /url?q=https://en.wikipedia.org/wiki/Multi-paradigm&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQs2YwHXoECAkQDA&usg=AOvVaw04zd7pCr75X-yZtFCyxV-p
    functional
        /url?q=https://en.wikipedia.org/wiki/Functional_programming&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQs2YwHXoECAkQDQ&usg=AOvVaw2inPQhkKY8lFFmAkOoJYR6 
    imperative
        /url?q=https://en.wikipedia.org/wiki/Imperative_programming&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQs2YwHXoECAkQDg&usg=AOvVaw12rYVsNSLXwgtbyyfw8RpC
    object-oriented
        /url?q=https://en.wikipedia.org/wiki/Object-oriented_programming&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQs2YwHXoECAkQDw&usg=AOvVaw1LQ3NwKr_Hfrbr5GGkqD1e
    class-based
        /url?q=https://en.wikipedia.org/wiki/Class-based_programming&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQs2YwHXoECAkQEA&usg=AOvVaw1hHmmh8YeuNvD26Os6tqxH
    reflective
        /url?q=https://en.wikipedia.org/wiki/Reflective_programming&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQs2YwHXoECAkQEQ&usg=AOvVaw2JvxBufHA8_MvglqLI4xeG 
Perl - Introduction - Tutorialspoint
        /url?q=https://www.tutorialspoint.com/perl/perl_introduction.htm&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQFjAeegQIChAB&usg=AOvVaw28_jv8jG9jRhAlqMNVwc6o
Perl Tutorial - Tutorialspoint
        /url?q=https://www.tutorialspoint.com/perl/index.htm&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQFjAfegQIBxAB&usg=AOvVaw2-bSusbAe1rP3H7tVSATCy
    Perl - Introduction
        /url?q=https://www.tutorialspoint.com/perl/perl_introduction.htm&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQ0gIwH3oECAcQAg&usg=AOvVaw1QU4xuohw5iLt4q8VqPqQx
    Perl - File I/O
        /url?q=https://www.tutorialspoint.com/perl/perl_files.htm&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQ0gIwH3oECAcQAw&usg=AOvVaw2TlJACGWpdYO2OuZXtjGdj   
    Perl - Environment
        /url?q=https://www.tutorialspoint.com/perl/perl_environment.htm&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQ0gIwH3oECAcQBA&usg=AOvVaw308KTV7gH4sjuXJn-LfpMM
    Perl - Arrays
        /url?q=https://www.tutorialspoint.com/perl/perl_arrays.htm&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQ0gIwH3oECAcQBQ&usg=AOvVaw0c6dQaXAED-kbU2BrRz6HR  
Perl Tutorial for Beginners: Learn in 1 Day - Guru99
        /url?q=https://www.guru99.com/perl-tutorials.html&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQFjAkegQIAxAB&usg=AOvVaw2T0Yc7vPd92QgQ4AFy1ecF
Perl Programming Language - GeeksforGeeks
        /url?q=https://www.geeksforgeeks.org/perl-programming-language/&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQFjAlegQIARAB&usg=AOvVaw1iWUVGrPuyCbgXN0J4P2l3
Introduction to Perl - GeeksforGeeks
        /url?q=https://www.geeksforgeeks.org/introduction-to-perl/&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQFjAmegQIABAB&usg=AOvVaw0kthF5nIvr-fY_jW9GoPwJ    
The Top 10 Programming Tasks That Perl Is Used For | By ActiveState
        /url?q=https://www.activestate.com/blog/top-10-programming-tasks-that-perl-is-used-for/&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQFjAnegQICBAB&usg=AOvVaw0x_Pm__ZgAHVtYOplaaqQO
Perl Tutorial
        /url?q=https://www.perltutorial.org/&sa=U&ved=2ahUKEwjn6JKcw_PtAhXUXSsKHUGFBvkQFjAoegQIBRAB&usg=AOvVaw02gYtL03ThK4quN1C1KG3G