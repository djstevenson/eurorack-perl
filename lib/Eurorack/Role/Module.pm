package Eurorack::Role::Module;
use Moose::Role;
use namespace::autoclean;
use Eurorack::Prelude;

with
  'Eurorack::Role::Name',
  'Eurorack::Role::Size',
  'Eurorack::Role::Colour';

sub class_regex($self) {
     return qr/\AEurorack::Module::(?<brand>[^:]+)::(?<model>[^:]+)\Z/;
}

sub set_fill_colour($self) { return '#e0f7fa' };

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
