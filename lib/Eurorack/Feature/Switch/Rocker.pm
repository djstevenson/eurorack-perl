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
    
    # Active side indicator with state label in white text
    if ($orientation eq 'horizontal') {
        if ($state eq 'on') {
            # Fill right side for 'on'
            my $fill_x = $cx;
            my $text_x = $cx + $w/4;  # Center of right half
            $svg .= qq{
    <!-- Active side -->
    <rect x="$fill_x" y="$body_y" width="} . ($w/2) . qq{" height="$h"
        fill="black"/>
    <!-- State label -->
    <text x="$text_x" y="$cy" text-anchor="middle" font-size="2.5" class="label" 
        dominant-baseline="middle" fill="white">} . uc($self->on_label) . qq{</text>};
        } else {
            # Fill left side for 'off'
            my $text_x = $cx - $w/4;  # Center of left half
            $svg .= qq{
    <!-- Active side -->
    <rect x="$body_x" y="$body_y" width="} . ($w/2) . qq{" height="$h"
        fill="black"/>
    <!-- State label -->
    <text x="$text_x" y="$cy" text-anchor="middle" font-size="2.5" class="label" 
        dominant-baseline="middle" fill="white">} . uc($self->off_label) . qq{</text>};
        }
    } else { # vertical
        if ($state eq 'on') {
            # Fill top side for 'on'
            my $text_y = $cy - $h/4;  # Center of top half
            $svg .= qq{
    <!-- Active side -->
    <rect x="$body_x" y="$body_y" width="$w" height="} . ($h/2) . qq{"
        fill="black"/>
    <!-- State label -->
    <text x="$cx" y="$text_y" text-anchor="middle" font-size="2.5" class="label" 
        dominant-baseline="middle" fill="white">} . uc($self->on_label) . qq{</text>};
        } else {
            # Fill bottom side for 'off'
            my $fill_y = $cy;
            my $text_y = $cy + $h/4;  # Center of bottom half
            $svg .= qq{
    <!-- Active side -->
    <rect x="$body_x" y="$fill_y" width="$w" height="} . ($h/2) . qq{"
        fill="black"/>
    <!-- State label -->
    <text x="$cx" y="$text_y" text-anchor="middle" font-size="2.5" class="label" 
        dominant-baseline="middle" fill="white">} . uc($self->off_label) . qq{</text>};
        }
    }
    
    $svg .= "\n</g>";
    
    return $svg;
}

__PACKAGE__->meta->make_immutable;
1;
