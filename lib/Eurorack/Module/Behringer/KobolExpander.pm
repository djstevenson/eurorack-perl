package Eurorack::Module::Behringer::KobolExpander;
use Moose;
use namespace::autoclean;
use Eurorack::Prelude;

with
  'Eurorack::Role::Module';

sub set_fill_colour { '#0c0c0c'; }
sub set_text_colour { 'white'; }

has '+width_hp' => (default => 80);

1;
