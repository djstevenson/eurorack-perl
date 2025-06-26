package Eurorack::Module::Example::LFO;
use Moose;
use namespace::autoclean;

extends 'Eurorack::Module::Base';

has '+width_hp' => (default => 6);

1;
