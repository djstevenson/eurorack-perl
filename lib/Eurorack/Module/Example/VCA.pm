package Eurorack::Module::Example::VCA;
use Moose;
use namespace::autoclean;

extends 'Eurorack::Module::Base';

has '+width_hp' => (default => 12);

1;
