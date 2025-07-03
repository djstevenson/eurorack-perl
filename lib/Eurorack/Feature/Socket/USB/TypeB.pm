package Eurorack::Feature::Socket::USB::TypeB;
use Moose;
use namespace::autoclean;
use Eurorack::Prelude;

with
    'Eurorack::Role::Feature';

sub render($self, $mx, $my) {  # Module pos
    my ($cx, $cy) = ($mx+$self->x, $my+$self->y);  # center x/y in mm

    my $w = 10.3;
    my $h = 12.0;
    my $cut = 1.5;

    my $x0 = $cx - $w / 2;
    my $y0 = $cy - $h / 2;

    my $x1 = $x0 + $cut;
    my $x2 = $x0 + $w - $cut;
    my $y1 = $y0;
    my $y2 = $y0 + $cut;
    my $y3 = $y0 + $h;

    my $tongue_w = 5.0;
    my $tongue_h = 4.0;
    my $tongue_x = $cx - $tongue_w / 2;
    my $tongue_y = $cy - $tongue_h / 2;

    return <<"SVG";
        <g class="usb-type-b">
            <!-- Outer shell -->
            <path d="
            M $x1 $y1
            L $x2 $y1
            L @{[$x0 + $w]} $y2
            L @{[$x0 + $w]} $y3
            L $x0 $y3
            L $x0 $y2
            Z"
            fill="none" stroke="black" stroke-width="1"/>

            <!-- Internal tongue -->
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
