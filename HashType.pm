package Data::Random::HashType;

use strict;
use warnings;

use Class::Utils qw(set_params);
use Data::HashType;
use Readonly;

Readonly::Array our @OBSOLETE_HASH_TYPES => qw(md5 sha1);
Readonly::Array our @DEFAULT_HASH_TYPES => qw(sha256 sha384 sha512);
Readonly::Array our @ALL_HASH_TYPES => (@OBSOLETE_HASH_TYPES, @DEFAULT_HASH_TYPES);

our $VERSION = 0.01;

sub new {
	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	# Add id or not.
	$self->{'mode_id'} = 0;

	# Number of hash types.
	$self->{'num_generated'} = undef;

	# Hash types.
	$self->{'possible_hash_types'} = \@DEFAULT_HASH_TYPES;

	# Process parameters.
	set_params($self, @params);

	# TODO Check mode_id.
	# TODO Check num_generated.
	# TODO Check possible hash types.

	return $self;
}

sub random {
	my $self = shift;

	my @ret;
	if (defined $self->{'num_generated'}
		&& $self->{'num_generated'} < @{$self->{'possible_hash_types'}}) {

		my @list = @{$self->{'possible_hash_types'}};
		foreach my $id (1 .. $self->{'num_generated'}) {
			my $rand = int(rand(scalar @list - 1));
			my $hash_type = splice @list, $rand, 1;
			push @ret, Data::HashType->new(
				$self->{'mode_id'} ? ('id' => $id) : (),
				'active' => 1,
				'name' => $hash_type,
			);
		}
	} else {
		my $i = 1;
		foreach my $hash_type (@{$self->{'possible_hash_types'}}) {
			push @ret, Data::HashType->new(
				$self->{'mode_id'} ? ('id' => $i) : (),
				'active' => 1,
				'name' => $hash_type,
			);
			$i++;
		}
	}

	return @ret;
}

1;

__END__
