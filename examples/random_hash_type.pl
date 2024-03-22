#!/usr/bin/env perl

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

# Output like:
# [
#     [0] Data::HashType  {
#             parents: Mo::Object
#             public methods (7):
#                 BUILD
#                 Error::Pure:
#                     err
#                 Mo::utils:
#                     check_bool, check_isa, check_length, check_number, check_required
#             private methods (0)
#             internals: {
#                 active       1,
#                 id           1,
#                 name         "SHA-256",
#                 valid_from   2023-04-04T00:00:00 (DateTime)
#             }
#         },
#     [1] Data::HashType  {
#             parents: Mo::Object
#             public methods (7):
#                 BUILD
#                 Error::Pure:
#                     err
#                 Mo::utils:
#                     check_bool, check_isa, check_length, check_number, check_required
#             private methods (0)
#             internals: {
#                 active       1,
#                 id           2,
#                 name         "SHA-384",
#                 valid_from   2023-09-03T00:00:00 (DateTime)
#             }
#         }
# ]