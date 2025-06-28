package Eurorack::Module::Behringer::KobolExpander;
use Moose;
use namespace::autoclean;
use Eurorack::Prelude;

with
  'Eurorack::Role::Module';

has '+width_hp' => (default => 80);

1;
