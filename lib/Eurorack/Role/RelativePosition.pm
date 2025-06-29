package Eurorack::Role::RelativePosition;
use Moose::Role;
use namespace::autoclean;
use Eurorack::Prelude;

has x => (
    is          => 'ro',
    isa         => 'Num',
    required    => 1,
);

has y => (
    is          => 'ro',
    isa         => 'Num',
    required    => 1,
);

1;
