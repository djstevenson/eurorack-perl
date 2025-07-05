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
    my $outer_marker_margin1 = 0;
    my $outer_marker_margin2 = -2;
    my $inner_marker_margin = 0;
    my $angle_rad = $self->_value_to_angle_rad($value);

    my $car = cos($angle_rad);
    my $sar = sin($angle_rad);
    my $kx1 = $cx + $inner_marker_margin * $car;
    my $ky1 = $cy + $inner_marker_margin * $sar;
    my $kx2 = $cx + ($radius - $outer_marker_margin1) * $car;
    my $ky2 = $cy + ($radius - $outer_marker_margin1) * $sar;
    my $kx3 = $cx + ($radius - $outer_marker_margin2) * $car;
    my $ky3 = $cy + ($radius - $outer_marker_margin2) * $sar;
    $svg .= qq{
        <line x1="$kx1" y1="$ky1" x2="$kx3" y2="$ky3"
            stroke="black" stroke-width="0.5"/>};
    $svg .= qq{
        <line x1="$kx1" y1="$ky1" x2="$kx2" y2="$ky2"
            stroke="white" stroke-width="1.0"/>};

    # Draw labels using configurable range
    my $labels = $self->labels;
    my $range = $self->max_value - $self->min_value;

    for my $i (0 .. $#$labels) {
        my $normalized_value = $self->min_value + ($i * $range / $#$labels);
        my $label_rad = $self->_value_to_angle_rad($normalized_value);
        my $lx = $cx + $label_radius * cos($label_rad);
        my $ly = $cy + $label_radius * sin($label_rad);

        $svg .= qq{
            <text x="$lx" y="$ly"
                font-size="3" text-anchor="middle" dominant-baseline="middle"
                font-family="sans-serif" fill="black">$labels->[$i]</text>};
    }

    $svg .= "\n</g>\n";
    return $svg;
}

sub _value_to_angle_rad($self, $value) {
    my $range = $self->max_value - $self->min_value;
    my $normalized = ($value - $self->min_value) / $range;
    return ($self->start_angle + $self->angle_range * $normalized) * 3.141592653589793 / 180;
}

__PACKAGE__->meta->make_immutable;
1;
