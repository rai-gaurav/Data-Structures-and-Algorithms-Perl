#!/usr/bin/env perl
# Search imdb top list of movies based on advance search - https://www.imdb.com/search/title/
# User will provide how many top movies he want to see
# Output will contain ll details about the movies

# https://metacpan.org/pod/Mojo::UserAgent
# https://metacpan.org/pod/Mojo::DOM
# https://metacpan.org/pod/Mojo::Util

use strict;
use warnings;
use Carp qw( croak );
use Mojo::UserAgent;
use Mojo::Util qw( trim );
use Data::Dumper;

sub crawl_results {
    my ($ua, $url) = @_;
    my $response = $ua->get($url)->result;
    if ($response->is_success) {

        # https://docs.mojolicious.org/Mojo/DOM#find
        my $movies_list = $response->dom->find('div.lister-item-content');
        my @top_movies_info;
        for my $div ($movies_list->each) {
            my %movie_info;
            my $movie_name   = $div->find('h3.lister-item-header a')->map('text')->join("\n");
            my $release_year = $div->find('h3.lister-item-header span.lister-item-year')->map('text')->join("\n");
            $release_year =~ s/^\(|\)$//g;
            $movie_info{$movie_name}{"Released Year"} = $release_year;

            # Explicitly converting to string
            $movie_info{$movie_name}{"Certificate"} = "" . $div->find('p span.certificate')->map('text')->join("\n");
            $movie_info{$movie_name}{"Runtime"}     = "" . $div->find('p span.runtime')->map('text')->join("\n");
            $movie_info{$movie_name}{"Genre"}       = trim $div->find('p span.genre')->map('text')->join("\n");

            $movie_info{$movie_name}{"Rating"}
                = "" . $div->find('div.inline-block.ratings-imdb-rating strong')->map('text')->join("\n");
            $movie_info{$movie_name}{"Metascore"}
                = trim $div->find('div.inline-block.ratings-metascore span.metascore')->map('text')->join("\n");

            $movie_info{$movie_name}{"Abstract"} = trim $div->find('p.text-muted')->map('text')->join("\n");

            # Both 'votes' and 'gross' are contain inside 'span' having same 'name'. First is votes the gross
            # https://metacpan.org/pod/Mojo::DOM::CSS#SELECTORS
            $movie_info{$movie_name}{"Votes"}
                = "" . $div->find('p.sort-num_votes-visible span[name="nv"]')->map('text')->[0];
            $movie_info{$movie_name}{"Gross"}
                = "" . $div->find('p.sort-num_votes-visible span[name="nv"]')->map('text')->[1];

            push @top_movies_info, \%movie_info;
        }
        print Dumper(\@top_movies_info);
    }
    else {
        croak $response->message;
    }
}

sub main {
    print "\nHow many top movies you want to see: ";
    my $top_movies = <ARGV>;
    chomp($top_movies);
    my $url = "https://www.imdb.com/search/title/?title_type=feature&sort=num_votes,desc&count=" . $top_movies;
    my $ua  = Mojo::UserAgent->new;
    $ua->transactor->name('Mozilla/5.0 (Windows NT 6.1; WOW64; rv:77.0) Gecko/20190101 Firefox/77.0');

    crawl_results($ua, $url);
}

main();

__END__

Output:

How many top movies you want to see: 3
$VAR1 = [
          {
            'The Shawshank Redemption' => {
                                            'Gross' => '$28.34M',
                                            'Certificate' => 'A',
                                            'Runtime' => '142 min',
                                            'Rating' => '9.3',
                                            'Metascore' => '80',
                                            'Votes' => '2,334,720',
                                            'Genre' => 'Drama',
                                            'Released Year' => '1994',
                                            'Abstract' => 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.'
                                          }
          },
          {
            'The Dark Knight' => {
                                   'Released Year' => '2008',
                                   'Votes' => '2,295,724',
                                   'Genre' => 'Action, Crime, Drama',
                                   'Abstract' => 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.',
                                   'Rating' => '9.0',
                                   'Runtime' => '152 min',
                                   'Gross' => '$534.86M',
                                   'Certificate' => 'UA',
                                   'Metascore' => '84'
                                 }
          },
          {
            'Inception' => {
                             'Metascore' => '74',
                             'Gross' => '$292.58M',
                             'Certificate' => 'UA',
                             'Rating' => '8.8',
                             'Runtime' => '148 min',
                             'Abstract' => 'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.',
                             'Votes' => '2,059,688',
                             'Genre' => 'Action, Adventure, Sci-Fi',
                             'Released Year' => '2010'
                           }
          }
        ];