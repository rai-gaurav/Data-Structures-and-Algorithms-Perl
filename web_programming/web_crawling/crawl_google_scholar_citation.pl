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
            # For getting the title
            # https://docs.mojolicious.org/Mojo/Collection#map
            # https://docs.mojolicious.org/Mojo/Collection#join
            my $title   = $div->find('h3.gs_rt a')->map('text')->join("\n");
            if (defined $title && $title ne "") {
                my $article = {};
                $article->{"Title"} = "$title";

                my $anchor_link = $div->find('h3.gs_rt a')->map(attr => 'href')->join("\n");
                if (defined $anchor_link && $anchor_link ne "") {
                    $article->{"Link"} = "$anchor_link";
                }

                # For getting the abstract
                my $abstract = $div->find('div.gs_rs')->map('text')->join("\n");
                if (defined $abstract && $abstract ne "") {
                    $article->{"Abstract"} = "$abstract";
                }

                # For getting the journal name
                my $journal = $div->find('div.gs_a')->map('text')->map(
                    # Remove the '-' and extra space from start
                    sub {
                        my ($aut_name, $journal) = split(/-/, $_, 2);
                        $journal =~ s/^\s?//;
                        return $journal;
                    }
                )->join("\n");
                if (defined $journal && $journal ne "") {
                    $article->{"Journal"} = "$journal";
                }

                # For getting the citation
                # https://docs.mojolicious.org/Mojo/Collection#grep
                my $citation = $div->find('div.gs_fl a')->grep(
                    # It contain the string like 'Cited by 5'
                    sub { $_->text =~ /Cited by/ }
                    )
                ->map('text')
                ->join("\n");
                if (defined $citation && $citation ne "") {
                    $article->{"Citation"} = "$citation";
                }
                push(@publications, $article);
            }
        }
        return \@publications;
    }
    else {
        croak $response->message;
    }
}

sub main {
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
    # Getting all the article for a particular author
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
        'Link'     => 'https://link.springer.com/article/10.1007/s10646-019-02020-6',
        'Citation' => 'Cited by 5',
        'Title'    => 'Role of supplemental UV-B in changing the level of ozone toxicity in two cultivars of sunflower: growth, seed yield and oil quality',
        'Journal'  => 'Ecotoxicology, 2019 - Springer',
        'Abstract' =>
            "Abstract Ultraviolet-B radiation (UV-B) is inherent part of solar spectrum and tropospheric ozone (O 3) is a potent secondary air pollutant. Therefore the present study was conducted to evaluate the responses of Helianthus annuus L. cvs DRSF 108 and Sungold (sunflower)\x{a0}\x{2026}"
    },
    {
        'Link' => 'http://www.bhu.ac.in/research_pub/jsr61/_pdf_files/06.%20Ksharma%20Rai%20&%20SB%20Agrawal.pdf',
        'Title' => 'Effects of UV-B radiation on morphological, physiological and biochemical aspects of plants: an overview',
        'Citation' => 'Cited by 11',
        'Abstract' =>
            "Origin of life was never be thought without considering the role of UV radiation but once the \x{201c}boon\x{201d}, is slowly becoming \x{201c}curse\x{201d} for life. Plants are exposed to many factors but the problem of enhanced UV-B is created by the anthropogenic activities resulted in ozone layer\x{a0}\x{2026}",
        'Journal' => 'J Sci Res, 2017 - bhu.ac.in'
    },
    {
        'Journal'  => 'Physiology and Molecular Biology of Plants, 2020 - Springer',
        'Abstract' =>
            "In the present study sensitivity of a medicinal plant Eclipta alba L.(Hassk)(False daisy) was assessed under intermittent (IT) and continuous (CT) doses of elevated ultraviolet-B (eUV-B). Eclipta alba is rich in medicinally important phytochemical constituents, used against\x{a0}\x{2026}",
        'Title' => "Effect on essential oil components and wedelolactone content of a medicinal plant Eclipta alba due to modifications in the growth and morphology under different\x{a0}\x{2026}",
        'Link' => 'https://link.springer.com/content/pdf/10.1007/s12298-020-00780-8.pdf'
    },
    {
        'Link'     => 'https://www.sciencedirect.com/science/article/pii/B9780128164839000050',
        'Abstract' =>
            "Climate change is associated to how weather patterns change over decades or longer due to natural and human influences. Since the industrial revolution, humans have contributed to climate change through the emission of greenhouse gases and aerosols as well as changes\x{a0}\x{2026}",
        'Journal'  => "Climate Change and Agricultural\x{a0}\x{2026}, 2019 - Elsevier",
        'Citation' => 'Cited by 1',
        'Title'    => 'Climate Change and Secondary Metabolism in Plants: Resilience to Disruption'
    },
    {
        'Title' => 'HOST PATHOGEN INTERACTIONS BETWEEN DROSOPHILA MELANOGASTER AND BEAUVERIA BASSIANA _ A Thesis Presented to the',
        'Journal'  => '2019 - search.proquest.com',
        'Abstract' =>
            "Drosophila melanogaster is an established model organism for immunity as their immune system is similar to insect disease vectors and pests and also shares similarities with that of the mammalian innate immune system. Our study uses the entomopathogenic fungus\x{a0}\x{2026}",
        'Link' => 'http://search.proquest.com/openview/868d2826bca7969ea2c29d15273af87b/1.pdf?pq-origsite=gscholar&cbl=18750&diss=y'
    },
    {
        'Title' => 'Low weight gain as a predictor for development of retinopathy of prematurity',
        'Abstract' =>
            "Page 1. i \x{201c}LOW WEIGHT GAIN AS A PREDICTOR FOR DEVELOPMENT OF RETINOPATHY
OF PREMATURITY\x{201d} By Dr. KSHAMA RAI MBBS Dissertation Submitted to the Rajiv Gandhi
University of Health Sciences, Karnataka, Bangalore In partial fulfilment of the requirements\x{a0}\x{2026}",
        'Journal' => '2018 - 112.133.228.240',
        'Link'    => 'http://112.133.228.240/xmlui/bitstream/handle/123456789/1156/Synopsis.pdf?sequence=1'
    },
    {
        'Title' => 'Use of High Resolution Remote Sensing Data and GIS Techniques for Monitoring Of \'U\'Shaped Wetland At GB Nagar District, Uttar Pradesh',
        'Journal'  => 'gyanvihar.org',
        'Abstract' =>
            "In developing countries of the world, the ever increasing population and to fulfill its need for housing and other economic activities almost urban fringe are getting encroached and our surrounding environment and natural wetlands, water bodies and other biological cycles are\x{a0}\x{2026}",
        'Link' =>
            'https://www.gyanvihar.org/researchjournals/c3w/Chapter-2%20Use%20Of%20High%20Resolution%20Remote%20Sensing%20Data%20And%20GIS%20Techniques%20For%20Monitoring%20Of%20_U_%20Shaped%20Wetland%20At%20G.B.%20Nagar%20District,%20Uttar%20Pradesh.pdf'
    }
];

