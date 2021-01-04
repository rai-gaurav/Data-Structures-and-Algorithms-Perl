#!/usr/bin/env perl
# Get the title, description , journal name and citation from google scholar for a particular author

# https://metacpan.org/pod/Mojo::UserAgent
# https://metacpan.org/pod/Mojo::DOM
# https://metacpan.org/pod/Mojo::Collection

use strict;
use warnings;
use Carp qw( croak );
use Mojo::UserAgent;
use Data::Dumper;

# The output sometimes contains unicode character.
# Hence, tells the Perl parser to allow UTF-8 in the program text
use open ':std', ':encoding(UTF-8)';

sub crawl_results {
    my ($ua, $url) = @_;
    my $response = $ua->get($url)->result;

    if ($response->is_success) {

        # https://docs.mojolicious.org/Mojo/DOM#find
        my $divs = $response->dom->find('div.gs_ri');
        my @publications;
        for my $div ($divs->each) {
            my $article = {};
            my $title   = $div->find('h3.gs_rt a')->map('text')->join("\n");
            if (defined $title && $title ne "") {
                $article->{"Title"} = "$title";
            }
            my $abstract = $div->find('div.gs_rs')->map('text')->join("\n");
            if (defined $abstract && $abstract ne "") {
                $article->{"Abstract"} = "$abstract";
            }
            my $journal = $div->find('div.gs_a')->map('text')->map(
                sub {
                    my ($aut_name, $journal) = split(/-/, $_, 2);
                    $journal =~ s/^\s?//;
                    return $journal;
                }
            )->join("\n");
            if (defined $journal && $journal ne "") {
                $article->{"Journal"} = "$journal";
            }

            # https://docs.mojolicious.org/Mojo/Collection
            my $citation
                = $div->find('div.gs_fl a')->grep(sub { $_->text =~ /Cited by/ })->map('text')
                ->join("\n");
            if (defined $citation && $citation ne "") {
                $article->{"Citation"} = "$citation";
            }
            push(@publications, $article);
        }
        return \@publications;
    }
    else {
        croak $response->message;
    }
}

sub main {
    my $search_text = "Perl";
    my $base_url    = "https://scholar.google.com/scholar";
    my $url         = Mojo::URL->new($base_url);

    # You can use multiple elements for your search.
    # {
    #     "as_ylo"          => <Lowest year in year range>,
    #     "as_yhi"          => <Highest year in year range>,
    #     "as_vis"          => <Include citations(0|1) (Doesn't include citation is 1)>,
    #     "as_sdt"          => <Include Patent(0|1) (Doesn't include patent is 1)>,
    #     "scisbd"          => <Sort by date(0|1)>
    #     "as_publication"  => <Journal/Source name>
    #     "hl"              => <Language of the result/output, "en" means english>,
    #     "as_q"            => "<Title of the article to search> author:<name>"
    # }
    # Getting all the article for a paricular author
    $url = $url->query({"as_q" => "author:\"kshama Rai\"", "hl" => "en"});

    my $ua = Mojo::UserAgent->new;
    $ua->transactor->name('Mozilla/5.0');
    my $output = crawl_results($ua, $url);
    print Dumper($output);
}

main();

__END__

Output -

[
    {
        'Title' => 'Role of supplemental UV-B in changing the level of ozone toxicity in two cultivars of sunflower: growth, seed yield and oil quality',
        'Journal' => 'Ecotoxicology, 2019 - Springer',
        'Abstract' => "Abstract Ultraviolet-B radiation (UV-B) is inherent part of solar spectrum and tropospheric ozone (O 3) is a potent secondary air pollutant. Therefore the present study was conducted to evaluate the responses of Helianthus annuus L. cvs DRSF 108 and Sungold (sunflower)\x{a0}\x{2026}",
        'Citation' => 'Cited by 5'
    },
    {
        'Title' => 'Effects of UV-B radiation on morphological, physiological and biochemical aspects of plants: an overview',
        'Journal'  => 'J Sci Res, 2017 - bhu.ac.in',
        'Citation' => 'Cited by 10',
        'Abstract' => "Origin of life was never be thought without considering the role of UV radiation but once the \x{201c}boon\x{201d}, is 
slowly becoming \x{201c}curse\x{201d} for life. Plants are exposed to many factors but the problem of enhanced UV-B is created by the anthropogenic activities resulted in ozone layer\x{a0}\x{2026}"
    },
    {
        'Abstract' => "In the present study sensitivity of a medicinal plant Eclipta alba L.(Hassk)(False daisy) was assessed under intermittent (IT) and continuous (CT) doses of elevated ultraviolet-B (eUV-B). Eclipta alba is rich in medicinally important phytochemical constituents, used against\x{a0}\x{2026}",
        'Journal' => 'Physiology and Molecular Biology of Plants, 2020 - Springer',
        'Title' => "Effect on essential oil components and wedelolactone content of a medicinal plant Eclipta alba due to modifications in the growth and morphology under different\x{a0}\x{2026}"
    },
    {
        'Citation' => 'Cited by 1',
        'Abstract' => "Climate change is associated to how weather patterns change over decades or longer due to natural and human influences. Since the industrial revolution, humans have contributed to climate change through the emission of greenhouse gases and aerosols as well as changes\x{a0}\x{2026}",
        'Title'   => 'Climate Change and Secondary Metabolism in Plants: Resilience to Disruption',
        'Journal' => "Climate Change and Agricultural\x{a0}\x{2026}, 2019 - Elsevier"
    },
    {
        'Title' => 'HOST PATHOGEN INTERACTIONS BETWEEN DROSOPHILA MELANOGASTER AND BEAUVERIA BASSIANA _ A Thesis Presented to the',
        'Journal' => '2019 - search.proquest.com',
        'Abstract' => "Drosophila melanogaster is an established model organism for immunity as their immune system is similar to insect disease vectors and pests and also shares similarities with that of the mammalian innate immune system. Our study uses the entomopathogenic fungus\x{a0}\x{2026}"
    },
    {
        'Abstract' => "Page 1. i \x{201c}LOW WEIGHT GAIN AS A PREDICTOR FOR DEVELOPMENT OF RETINOPATHY
OF PREMATURITY\x{201d} By Dr. KSHAMA RAI MBBS Dissertation Submitted to the Rajiv Gandhi
University of Health Sciences, Karnataka, Bangalore In partial fulfilment of the requirements\x{a0}\x{2026}",
        'Title'   => 'Low weight gain as a predictor for development of retinopathy of prematurity',
        'Journal' => '2018 - 112.133.228.240'
    },
    {
        'Journal' => 'gyanvihar.org',
        'Title' => 'Use of High Resolution Remote Sensing Data and GIS Techniques for Monitoring Of \'U\'Shaped Wetland At GB Nagar District, 
Uttar Pradesh',
        'Abstract' => "In developing countries of the world, the ever increasing population and to fulfill its need for housing and other economic activities almost urban fringe are getting encroached and our surrounding environment and natural wetlands, water bodies and other biological cycles are\x{a0}\x{2026}"
    }
]
