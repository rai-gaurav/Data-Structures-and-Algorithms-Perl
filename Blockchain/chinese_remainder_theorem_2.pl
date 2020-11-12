#!/usr/bin/env perl
# https://en.wikipedia.org/wiki/Chinese_remainder_theorem
# https://metacpan.org/pod/Math::Prime::Util#chinese

use strict;
use warnings;
use Math::Prime::Util qw(chinese);

print chinese([14, 643], [254, 419], [87, 733]);    # OUTPUT - 87041638

