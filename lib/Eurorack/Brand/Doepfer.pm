package Eurorack::Brand::Doepfer;
use Moose;
use namespace::autoclean;
use Eurorack::Prelude;

with
  'Eurorack::Role::Brand';

# TODO add more stuff, like their URL etc

__PACKAGE__->meta->make_immutable;
1;
