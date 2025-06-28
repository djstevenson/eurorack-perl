package Eurorack::Module::Behringer::ModelD;
use Moose;
use namespace::autoclean;
use Eurorack::Prelude;

with
  'Eurorack::Role::Module';

has '+width_hp' => (default => 70);

1;
