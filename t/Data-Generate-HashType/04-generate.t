use strict;
use warnings;

use Data::Generate::HashType;
use Test::More 'tests' => 14;
use Test::NoWarnings;

# Test.
my $obj = Data::Generate::HashType->new(
	'num_generated' => 1,
	'possible_hash_types' => ['sha256'],
);
my ($ret) = $obj->generate;
is($ret->active, 1, 'Get active flag of hash type (1).');
is($ret->name, 'sha256', 'Get name of hash type (sha256).');

# Test.
$obj = Data::Generate::HashType->new(
	'mode_id' => 1,
	'num_generated' => 1,
	'possible_hash_types' => ['sha256'],
);
($ret) = $obj->generate;
isa_ok($ret, 'Data::HashType');
is($ret->active, 1, 'Get active flag of hash type (1).');
is($ret->id, 1, 'Get id of hash type (1).');
is($ret->name, 'sha256', 'Get name of hash type (sha256).');

# Test.
$obj = Data::Generate::HashType->new(
	'possible_hash_types' => ['sha256', 'sha512'],
);
my @ret = $obj->generate;
is(scalar @ret, 2, 'Number of generated hash types (2).');
isa_ok($ret[0], 'Data::HashType');
isa_ok($ret[1], 'Data::HashType');

# Test.
$obj = Data::Generate::HashType->new(
	'num_generated' => 1,
	'possible_hash_types' => ['sha256', 'sha512'],
);
@ret = $obj->generate;
is(scalar @ret, 1, 'Number of generated hash types (1).');
isa_ok($ret[0], 'Data::HashType');

# Test.
$obj = Data::Generate::HashType->new(
	'mode_id' => 1,
	'num_generated' => 1,
	'possible_hash_types' => ['sha256', 'sha512'],
);
@ret = $obj->generate;
is(scalar @ret, 1, 'Number of generated hash types (1).');
isa_ok($ret[0], 'Data::HashType');
