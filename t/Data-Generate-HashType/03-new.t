use strict;
use warnings;

use Data::Generate::HashType;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
my $obj = Data::Generate::HashType->new;
isa_ok($obj, 'Data::Generate::HashType');
