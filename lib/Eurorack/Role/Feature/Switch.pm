package Eurorack::Role::Feature::Switch;
use Moose::Role;
use namespace::autoclean;
use Eurorack::Prelude;

with
  'Eurorack::Role::Feature';

has 'width' => (
    is      => 'ro',
    isa     => 'Num',
    default => 12,
);

has 'height' => (
    is      => 'ro',
    isa     => 'Num',
    default => 6,
);

has 'orientation' => (
    is      => 'ro',
    isa     => 'Str',
    default => 'horizontal',
);

has 'state' => (
    is      => 'ro',
    isa     => 'Str',
    default => 'off',
);

has 'on_label' => (
    is      => 'ro',
    isa     => 'Str',
    default => 'on',
);

has 'off_label' => (
    is      => 'ro',
    isa     => 'Str',
    default => 'off',
);

requires 'render';

1;