package Eurorack::Module::Example::VCO;
use Moose;
use namespace::autoclean;

extends 'Eurorack::Module::Base';

has '+width_hp' => (default => 10);

1;
