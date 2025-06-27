package Eurorack::Role::Colour;
use Moose::Role;
use namespace::autoclean;
use Eurorack::Prelude;

has edge_colour => (
    is          => 'ro',
    isa         => 'Str',
    required    => 1,
    default     => 'black',
);

has fill_colour => (
    is          => 'ro',
    isa         => 'Str',
    lazy        => 1,
    builder     => 'set_fill_colour',
);

sub set_fill_colour($self) { 'white' }

1;
