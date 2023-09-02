package Data::Random::HashType;

use strict;
use warnings;

use Class::Utils qw(set_params);
use Data::HashType;
use Error::Pure qw(err);
use Readonly;

Readonly::Array our @OBSOLETE_HASH_TYPES => qw(MD4 MD5 SHA1);
Readonly::Array our @DEFAULT_HASH_TYPES => qw(SHA-256 SHA-384 SHA-512);
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
	if (! defined $self->{'num_generated'}) {
		err "Parameter 'num_generated' is required.";
	}
	if (ref $self->{'possible_hash_types'} ne 'ARRAY') {
		err "Parameter 'possible_hash_types' must be a reference to array.";
	}
	if (! @{$self->{'possible_hash_types'}}) {
		err "Parameter 'possible_hash_types' must contain at least one hash type name.";
	}

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

=pod

=encoding utf8

=head1 NAME

Data::Random::HashType - Random hash type objects.

=head1 SYNOPSIS

 use Data::Random::HashType;

 my $obj = Data::Random::HashType->new(%params);
 my @hash_types = $obj->random;

=head1 METHODS

=head2 C<new>

 my $obj = Data::Random::HashType->new(%params);

Constructor.

=over 8

=item * C<mode_id>

Boolean value if we are generating id in hash type object.

Default value is 0.

=item * C<num_generated>

Number of generated hash types.

Default value is 1.

=item * C<possible_hash_types>

Possible hash type names for result.

Default value is list (SHA-256 SHA-384 SHA-512).

=back

Returns instance of object.

=head2 C<random>

 my @hash_types = $obj->random;

Get random hash type object.

Returns instance of L<Data::HashType>.

=head1 ERRORS

 new():
         Parameter 'num_generated' is required.
         Parameter 'possible_hash_types' must be a reference to array.
         Parameter 'possible_hash_types' must contain at least one hash type name.

=head1 EXAMPLE

=for comment filename=random_hash_type.pl

 use strict;
 use warnings;

 use Data::Printer;
 use Data::Random::HashType;

 my $obj = Data::Random::HashType->new(
         'mode_id' => 1,
         'num_generated' => 2,
 );

 my @hash_types = $obj->random;

 # Dump hash types to out.
 p @hash_types;

 # Output:
 # [
 #     [0] Data::HashType  {
 #             parents: Mo::Object
 #             public methods (5):
 #                 BUILD
 #                 Mo::utils:
 #                     check_bool, check_length, check_number, check_required
 #             private methods (0)
 #             internals: {
 #                 active   1,
 #                 id       1,
 #                 name     "SHA-256"
 #             }
 #         },
 #     [1] Data::HashType  {
 #             parents: Mo::Object
 #             public methods (5):
 #                 BUILD
 #                 Mo::utils:
 #                     check_bool, check_length, check_number, check_required
 #             private methods (0)
 #             internals: {
 #                 active   1,
 #                 id       2,
 #                 name     "SHA-384"
 #             }
 #         }
 # ]

=head1 DEPENDENCIES

L<Class::Utils>,
L<Data::HashType>,
L<Error::Pure>,
L<Readonly>.

=head1 REPOSITORY

L<https://github.com/michal-josef-spacek/Data-Random-HashType>

=head1 AUTHOR

Michal Josef Špaček L<mailto:skim@cpan.org>

L<http://skim.cz>

=head1 LICENSE AND COPYRIGHT

© 2023 Michal Josef Špaček

BSD 2-Clause License

=head1 VERSION

0.01

=cut
