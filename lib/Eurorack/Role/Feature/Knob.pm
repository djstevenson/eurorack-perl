package Eurorack::Role::Feature::Knob;
use Moose::Role;
use namespace::autoclean;
use Eurorack::Prelude;

with
  'Eurorack::Role::Feature';

has radius => (
    is          => 'ro',
    isa         => 'Num',
    default     => 10.0,
);

has value => (
    is          => 'ro',
    isa         => 'Num',
    default     => 6.5,
);

requires 'render';

1;
