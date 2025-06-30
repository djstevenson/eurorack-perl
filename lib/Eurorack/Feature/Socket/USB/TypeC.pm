package Eurorack::Feature::Socket::USB::TypeC;
use Moose;
use namespace::autoclean;
use Eurorack::Prelude;

with
    'Eurorack::Role::Feature';

sub render($self, $mx, $my) {  # Module pos
    my ($cx, $cy) = ($mx+$self->x, $my+$self->y);  # center x/y in mm

    # Outer panel cutout
    my $cutout_w = 8.9;
    my $cutout_h = 3.2;
    my $corner_radius = 0.8;

    # Internal tongue
    my $tongue_w = 6.0;
    my $tongue_h = 2.0;

    # Compute positions
    my $cutout_x = $cx - $cutout_w / 2;
    my $cutout_y = $cy - $cutout_h / 2;

    my $tongue_x = $cx - $tongue_w / 2;
    my $tongue_y = $cy - $tongue_h / 2;

    return <<"SVG";
        <g class="usb-type-c">
            <!-- Outer cutout -->
            <rect x="$cutout_x" y="$cutout_y"
                    width="$cutout_w" height="$cutout_h"
                    rx="$corner_radius" ry="$corner_radius"
                    fill="none" stroke="black" stroke-width="0.4"/>

            <!-- Plastic tongue -->
            <rect x="$tongue_x" y="$tongue_y"
                    width="$tongue_w" height="$tongue_h"
                    fill="black"/>
        </g>
SVG
}

__PACKAGE__->meta->make_immutable;
1;
