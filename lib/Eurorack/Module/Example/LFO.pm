package Eurorack::Module::Example::LFO;
use Moose;
use namespace::autoclean;
use Eurorack::Prelude;

with
  'Eurorack::Role::Module';

has '+width_hp' => (default => 6);

1;
