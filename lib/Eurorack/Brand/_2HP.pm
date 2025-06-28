package Eurorack::Brand::_2HP;
use Moose;
use namespace::autoclean;
use Eurorack::Prelude;

with
  'Eurorack::Role::Brand';

sub set_name($self) { '2HP'; }

# TODO add more stuff, like their URL etc

__PACKAGE__->meta->make_immutable;
1;
