package Eurorack::Module::Behringer::KobolExpander;
use Moose;
use namespace::autoclean;
use Eurorack::Prelude;

with
  'Eurorack::Role::Module';

has '+width_hp' => (default => 80);

sub BUILD($self, $args) {
  $self->add_feature(Eurorack::Feature::Socket::MIDI::Din->new(x =>20, y => 20));
}

1;
