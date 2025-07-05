package Eurorack::Feature::Switch::Rocker;
use Moose;
use namespace::autoclean;
use Eurorack::Prelude;

with 'Eurorack::Role::Feature::Switch';

sub render($self, $mx, $my) {
    my ($cx, $cy) = ($mx + $self->x, $my + $self->y);
    my $width = $self->width;
    my $height = $self->height;
    my $orientation = $self->orientation;
    my $state = $self->state;
    
    # Adjust dimensions based on orientation
    my ($w, $h) = $orientation eq 'vertical' ? ($height, $width) : ($width, $height);
    
    my $svg = qq{<g class="rocker-switch">\n};
    
    # Switch body outline
    my $body_x = $cx - $w/2;
    my $body_y = $cy - $h/2;
    $svg .= qq{    <!-- Switch body -->
    <rect x="$body_x" y="$body_y" width="$w" height="$h"
        fill="white" stroke="black" stroke-width="0.4"/>};
    
    # Active side indicator (filled rectangle on the pressed side)
    if ($orientation eq 'horizontal') {
        if ($state eq 'on') {
            # Fill right side for 'on'
            my $fill_x = $cx;
            $svg .= qq{
    <!-- Active side -->
    <rect x="$fill_x" y="$body_y" width="} . ($w/2) . qq{" height="$h"
        fill="black"/>};
        } else {
            # Fill left side for 'off'
            $svg .= qq{
    <!-- Active side -->
    <rect x="$body_x" y="$body_y" width="} . ($w/2) . qq{" height="$h"
        fill="black"/>};
        }
    } else { # vertical
        if ($state eq 'on') {
            # Fill top side for 'on'
            $svg .= qq{
    <!-- Active side -->
    <rect x="$body_x" y="$body_y" width="$w" height="} . ($h/2) . qq{"
        fill="black"/>};
        } else {
            # Fill bottom side for 'off'
            my $fill_y = $cy;
            $svg .= qq{
    <!-- Active side -->
    <rect x="$body_x" y="$fill_y" width="$w" height="} . ($h/2) . qq{"
        fill="black"/>};
        }
    }
    
    
    # Add state labels for on/off positions (when no custom label is provided)
    if (!$self->has_label_text) {
        my $label_distance = 3;
        if ($orientation eq 'horizontal') {
            my $on_x = $cx + $w/2 + $label_distance;
            my $off_x = $cx - $w/2 - $label_distance;
            $svg .= qq{
    <!-- Position labels -->
    <text x="$on_x" y="$cy" text-anchor="start" font-size="3" class="label" 
        dominant-baseline="middle">} . $self->on_label . qq{</text>
    <text x="$off_x" y="$cy" text-anchor="end" font-size="3" class="label" 
        dominant-baseline="middle">} . $self->off_label . qq{</text>};
        } else { # vertical
            my $on_y = $cy - $h/2 - $label_distance;
            my $off_y = $cy + $h/2 + $label_distance;
            $svg .= qq{
    <!-- Position labels -->
    <text x="$cx" y="$on_y" text-anchor="middle" font-size="3" class="label" 
        dominant-baseline="middle">} . $self->on_label . qq{</text>
    <text x="$cx" y="$off_y" text-anchor="middle" font-size="3" class="label" 
        dominant-baseline="middle">} . $self->off_label . qq{</text>};
        }
    }
    
    $svg .= "\n</g>";
    
    return $svg;
}

__PACKAGE__->meta->make_immutable;
1;