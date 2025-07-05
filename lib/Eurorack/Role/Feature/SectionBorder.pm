package Eurorack::Role::Feature::SectionBorder;
use Moose::Role;
use namespace::autoclean;
use Eurorack::Prelude;

with 'Eurorack::Role::Feature';

has 'width' => (
    is       => 'ro',
    isa      => 'Num',
    required => 1,
);

has 'height' => (
    is       => 'ro',
    isa      => 'Num', 
    required => 1,
);

has 'corner_radius' => (
    is      => 'ro',
    isa     => 'Num',
    default => 3,
);

has 'stroke_width' => (
    is      => 'ro',
    isa     => 'Num',
    default => 0.8,
);

has 'stroke_color' => (
    is      => 'ro',
    isa     => 'Str',
    default => 'black',
);

has 'fill' => (
    is      => 'ro',
    isa     => 'Str',
    default => 'none',
);

1;