package Eurorack::Rack::Behringer::Go;
use Moose;
use namespace::autoclean;

use utf8;
use feature qw(signatures);

extends 'Eurorack::Rack::Base';

# Two 3U rows of 140HP

has '+rows_u'   => (default => sub { return [3, 3] });
has '+width_hp' => (default => 140);

__PACKAGE__->meta->make_immutable;
1;
