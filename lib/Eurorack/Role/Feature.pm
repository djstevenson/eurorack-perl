package Eurorack::Role::Feature;
use Moose::Role;
use namespace::autoclean;
use Eurorack::Prelude;

with
  'Eurorack::Role::RelativePosition',
  'Eurorack::Role::LabelRenderer';

has 'label' => (
    is        => 'ro',
    isa       => 'Eurorack::Feature::Label',
    predicate => 'has_label',
);

requires 'render';

1;
