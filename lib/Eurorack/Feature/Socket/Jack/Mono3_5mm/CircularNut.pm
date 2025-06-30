package Eurorack::Feature::Socket::Jack::Mono3_5mm::CircularNut;
use Moose;
use namespace::autoclean;
use Eurorack::Prelude;

with
    'Eurorack::Role::Feature';

sub render($self, $mx, $my) {  # Module pos
    my ($cx, $cy) = ($mx+$self->x, $my+$self->y);  # center x/y in mm

    my $hole_radius = 3.25;  # 6.5mm panel hole
    my $nut_radius  = 5.2;   # ~10.4mm across flats or diameter

    my $svg = qq{
        <g class="jack-socket">
            <!-- Panel hole -->
            <circle cx="$cx" cy="$cy" r="$hole_radius"
                    fill="white" stroke="black" stroke-width="0.4"/>
    };

    $svg .= qq{
        <!-- Round knurled nut -->
        <circle cx="$cx" cy="$cy" r="$nut_radius"
            fill="none" stroke="black" stroke-width="0.4" stroke-dasharray="0.6,0.6"/>
    };

    $svg .= "  </g>\n";
    return $svg;
}

__PACKAGE__->meta->make_immutable;
1;
