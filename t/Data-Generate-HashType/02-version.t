use strict;
use warnings;

use Data::Generate::HashType;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($Data::Generate::HashType::VERSION, 0.01, 'Version.');
