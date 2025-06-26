package Eurorack::Common::Base;
use Moose;
use namespace::autoclean;

use Carp qw(croak);

use utf8;
use feature qw(signatures);
use Readonly;
use Carp qw(croak);

use Eurorack::Constants qw(:all);

has width_hp => (
    is          => 'ro',
    isa         => 'Int',
    required    => 1,
);

has width_mm => (
    is          => 'ro',
    isa         => 'Num',
    lazy        => 1,
    default     => sub {
        return shift->width_hp * EURORACK_HP_MM;
    },
);

has edge_colour => (
    is          => 'ro',
    isa         => 'Str',
    lazy        => 1,
    default     => 'black',
);

1;
