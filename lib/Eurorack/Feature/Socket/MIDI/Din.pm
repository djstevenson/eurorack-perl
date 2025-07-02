package Eurorack::Feature::Socket::MIDI::Din;
use Moose;
use namespace::autoclean;
use Eurorack::Prelude;

with
    'Eurorack::Role::Feature';

use Eurorack::Feature::Label;

has '+label' => (
    default => sub {
        return Eurorack::Feature::Label->new(
            text     => 'MIDI In',
            position => 'north',
            distance => 12,
        )
    },
);

sub render($self, $mx, $my) {  # Module pos
    my ($cx, $cy) = ($mx+$self->x, $my+$self->y);  # center x/y in mm

    my $outer_radius = 8.0;       # 16mm diameter
    my $pin_radius   = 1.0;       # visual representation of pin holes
    my $pin_arc_r    = 5.0;       # radius of the pin arc
    my @angles_deg   = (180, 225, 270, 315, 0);  # typical 5-pin arc

    my $svg = "";

    $svg .= qq{ <!-- outer shell -->
        <circle cx="$cx" cy="$cy" r="$outer_radius"
            fill="none" stroke="black" stroke-width="1.0"/>
            <!-- pins: -->};

    # Pins
    for my $deg (@angles_deg) {
        my $rad = $deg * 3.14159265358979 / 180;
        my $px = $cx + $pin_arc_r * cos($rad);
        my $py = $cy + $pin_arc_r * sin($rad);
        $svg .= qq{
            <circle cx="$px" cy="$py" r="$pin_radius"
            fill="black" stroke="none"/>};
    }

    return <<"SVG";
        <g class="midi-din">
            ${svg}
        </g>
SVG
}

__PACKAGE__->meta->make_immutable;
1;
