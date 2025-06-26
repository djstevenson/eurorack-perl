package Eurorack::Module::Example::VCF;
use Moose;
use namespace::autoclean;

extends 'Eurorack::Module::Base';

has '+width_hp' => (default => 8);

1;
