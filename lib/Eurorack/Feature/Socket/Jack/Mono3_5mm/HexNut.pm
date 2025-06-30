package Eurorack::Feature::Socket::Jack::Mono3_5mm::HexNut;
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

    # Draw a regular hexagon around the jack hole
    my $r = $nut_radius;
    my @points;
    for my $i (0 .. 5) {
        my $angle = 3.14159 / 3 * $i - 3.14159 / 6;  # Start flat at top
        my $x = $cx + $r * cos($angle);
        my $y = $cy + $r * sin($angle);
        push @points, "$x,$y";
    }
    my $points_str = join ' ', @points;
    $svg .= qq{
        <!-- Hex nut -->
        <polygon points="$points_str"
                fill="none" stroke="black" stroke-width="0.4"/>
    };

    $svg .= "  </g>\n";
    return $svg;
}

__PACKAGE__->meta->make_immutable;
1;
