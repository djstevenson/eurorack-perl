package Eurorack::Role::Feature;
use Moose::Role;
use namespace::autoclean;
use Eurorack::Prelude;

with
  'Eurorack::Role::RelativePosition';

requires 'render';

1;
