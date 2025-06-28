package Eurorack::Role::Colour;
use Moose::Role;
use namespace::autoclean;
use Eurorack::Prelude;

has edge_colour => (
    is          => 'ro',
    isa         => 'Str',
    lazy        => 1,
    builder     => 'set_edge_colour',
);

sub set_edge_colour($self) { '#444' }

has fill_colour => (
    is          => 'ro',
    isa         => 'Str',
    lazy        => 1,
    builder     => 'set_fill_colour',
);

sub set_fill_colour($self) { 'white' }

has text_colour => (
    is          => 'ro',
    isa         => 'Str',
    lazy        => 1,
    builder     => 'set_text_colour',
);

sub set_text_colour($self) { 'black' }

1;
