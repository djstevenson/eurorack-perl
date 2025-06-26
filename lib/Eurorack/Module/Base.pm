package Eurorack::Module::Base;
use Moose;
use namespace::autoclean;

use Carp qw(croak);

use utf8;
use feature qw(signatures);

use Eurorack::Constants qw(:all);

extends 'Eurorack::Common::Named';

has height_u => (
    is          => 'ro',
    isa         => 'Int',
    lazy        => 1,
    default     => 3,
);

has height_mm => (
    is          => 'ro',
    isa         => 'Num',
    lazy        => 1,
    default     => sub { return shift->height_u * EURORACK_1U_MM; },
);

has panel_colour => (
    is          => 'ro',
    isa         => 'Str',
    lazy        => 1,
    default     => '#e0f7fa',
);

has '+edge_colour' => (default => 'blue');

has '+_class_regex' => (default => sub { return qr/\AEurorack::Module::(?<brand>[^:]+)::(?<model>[^:]+)\Z/; } );

sub render($self, $x, $y) {
    my $width  = $self->width_mm;
    my $height = $self->height_mm;
    my $label  = $self->model;

    return qq{
        <g>
            <rect x="$x" y="$y" width="$width" height="$height"
                fill="#e0f7fa" stroke="blue" stroke-width="0.5"/>
            <text x="@{[$x + 2]}" y="@{[$y + 10]}" font-size="6"
                font-family="sans-serif" fill="black">$label</text>
        </g>
    };
}

1;
