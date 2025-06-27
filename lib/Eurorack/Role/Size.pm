package Eurorack::Role::Size;
use Moose::Role;
use namespace::autoclean;
use Eurorack::Prelude;

has width_hp => (
    is          => 'ro',
    isa         => 'Int',
    required    => 1,
);

has width_mm => (
    is          => 'ro',
    isa         => 'Num',
    lazy        => 1,
    init_arg    => undef,
    default     => sub { shift->width_hp * EURORACK_HP_MM; },
);

has height_u => (
    is          => 'ro',
    isa         => 'Int',
    lazy        => 1,
    default     => 3,
);

has height_mm => (
    is          => 'ro',
    isa         => 'Num',
    lazy        => 1,
    init_arg    => undef,
    default     => sub { return shift->height_u * EURORACK_1U_MM; },
);


1;
