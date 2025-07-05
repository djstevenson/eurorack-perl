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

has min_value => (
    is          => 'ro',
    isa         => 'Num',
    default     => 0,
);

has max_value => (
    is          => 'ro',
    isa         => 'Num',
    default     => 10,
);

has labels => (
    is          => 'ro',
    isa         => 'ArrayRef[Str]',
    lazy        => 1,
    builder     => '_build_labels',
);

has start_angle => (
    is          => 'ro',
    isa         => 'Num',
    default     => 135,
);

has angle_range => (
    is          => 'ro',
    isa         => 'Num',
    default     => 270,
);

sub _build_labels($self) {
    return [map { "$_" } ($self->min_value .. $self->max_value)];
}

requires 'render';

1;
