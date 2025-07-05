package Eurorack::Feature::Knob::Basic;
use Moose;
use namespace::autoclean;
use Eurorack::Prelude;

with
    'Eurorack::Role::Feature::Knob';

sub render($self, $mx, $my) {  # Module pos
    my ($cx, $cy) = ($mx+$self->x, $my+$self->y);  # center x/y in mm
    my $radius    = $self->radius;
    my $value     = $self->value;

    my $base_radius = $radius + 1;
    my $label_radius = $radius + 4;

    my $svg = qq{<g class="synth-knob">\n};

    # Draw base
    $svg .= qq{
        <circle cx="$cx" cy="$cy" r="$base_radius"
            fill="#ccc" stroke="black" stroke-width="0.5"/>};

    # Draw knob top
    $svg .= qq{
        <circle cx="$cx" cy="$cy" r="$radius"
            fill="black" stroke="black" stroke-width="0.4"/>};

    # Draw marker for current value
    my $outer_marker_margin = 1;
    my $inner_marker_margin = 2;
    my $angle_rad = $self->_value_to_angle_rad($value);

    my $kx1 = $cx + $inner_marker_margin * cos($angle_rad);
    my $ky1 = $cy + $inner_marker_margin * sin($angle_rad);
    # my $kx2 = $cx + $outer_marker_margin * cos($angle_rad);
    # my $ky2 = $cy + $outer_marker_margin * sin($angle_rad);
    my $kx2 = $cx + ($radius - $outer_marker_margin) * cos($angle_rad);
    my $ky2 = $cy + ($radius - $outer_marker_margin) * sin($angle_rad);
    $svg .= qq{
        <line x1="$kx1" y1="$ky1" x2="$kx2" y2="$ky2"
            stroke="white" stroke-width="1.0"/>};

    # Draw labels 0..10
    for my $i (0 .. 10) {
        my $label_rad = $self->_value_to_angle_rad($i);
        my $lx = $cx + $label_radius * cos($label_rad);
        my $ly = $cy + $label_radius * sin($label_rad);

        $svg .= qq{
            <text x="$lx" y="$ly"
                font-size="3" text-anchor="middle" dominant-baseline="middle"
                font-family="sans-serif" fill="black">$i</text>};
    }

    $svg .= "\n</g>\n";
    return $svg;
}

sub _value_to_angle_rad($self, $value) {
    return (135 + 270 * $value / 10) * 3.141592653589793 / 180;
}

__PACKAGE__->meta->make_immutable;
1;
