package Eurorack::Feature::Label::Position;
use Moose;
use namespace::autoclean;
use Eurorack::Prelude;

use Moose::Util::TypeConstraints;

enum 'LabelPosition' => [qw(north south east west)];

__PACKAGE__->meta->make_immutable;
1;
