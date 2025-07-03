package Eurorack::Feature::Socket::USB::TypeA;
use Moose;
use namespace::autoclean;
use Eurorack::Prelude;

with
    'Eurorack::Role::Feature';

sub render($self, $mx, $my) {  # Module pos
    my ($cx, $cy) = ($mx+$self->x, $my+$self->y);  # center x/y in mm

    # Cutout dimensions
    my $cutout_w = 12.0;
    my $cutout_h = 6.0;
    my $corner_radius = 1.0;

    # Tongue dimensions
    my $tongue_w = 10.0;
    my $tongue_h = 2.2;
    my $tongue_offset_y = 0.5;  # from top of cutout

    # Cutout position (top-left corner)
    my $cutout_x = $cx - $cutout_w / 2;
    my $cutout_y = $cy - $cutout_h / 2;

    # Tongue position (top-left inside cutout)
    my $tongue_x = $cx - $tongue_w / 2;
    my $tongue_y = $cutout_y + $tongue_offset_y;

    return <<"SVG";
        <g class="usb-type-a">
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

sub _default_label_text {
    return 'USB';
}

__PACKAGE__->meta->make_immutable;
1;
