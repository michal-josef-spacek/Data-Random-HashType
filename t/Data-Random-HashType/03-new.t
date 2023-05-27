use strict;
use warnings;

use Data::Random::HashType;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
my $obj = Data::Random::HashType->new;
isa_ok($obj, 'Data::Random::HashType');
