package Eurorack::Rack::Behringer::Go;
use Moose;
use namespace::autoclean;
use Eurorack::Prelude;

with
  'Eurorack::Role::Rack';

# Two 3U rows of 140HP
has '+rows_u'   => (default => sub { return [3, 3] });
has '+width_hp' => (default => 94);

__PACKAGE__->meta->make_immutable;
1;
