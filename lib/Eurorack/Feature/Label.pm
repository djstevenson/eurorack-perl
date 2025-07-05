package Eurorack::Feature::Label;
use Moose;
use namespace::autoclean;
use Eurorack::Prelude;

use Eurorack::Feature::Label::Position;

has 'text' => (
    is          => 'ro',
    isa         => 'Str',
    required    => 1,
);

has 'position' => (
    is          => 'ro',
    isa         => 'LabelPosition',
    required    => 1,
);

has 'distance' => (
    is          => 'ro',
    isa         => 'Num',
    required    => 1,
    documentation => 'Distance from feature center to label center in mm',
);

has 'inverted' => (
    is          => 'ro',
    isa         => 'Bool',
    default     => 0,
    documentation => 'If true, render white text on black background instead of black text on white background',
);

sub render($self, $feature_cx, $feature_cy) {
    my ($label_cx, $label_cy) = $self->_calculate_label_position($feature_cx, $feature_cy);
    
    if ($self->inverted) {
        return sprintf(
            '<g><rect x="%.2f" y="%.2f" width="%.2f" height="7" fill="black" rx="1"/>' .
            '<text x="%.2f" y="%.2f" text-anchor="middle" font-size="5" class="label" fill="white">%s</text></g>',
            $label_cx - (length($self->text) * 1.5), $label_cy - 5,
            length($self->text) * 3,
            $label_cx, $label_cy, $self->text
        );
    } else {
        return sprintf(
            '<text x="%.2f" y="%.2f" text-anchor="middle" font-size="5" class="label">%s</text>',
            $label_cx, $label_cy, $self->text
        );
    }
}

sub _calculate_label_position($self, $feature_cx, $feature_cy) {
    my $distance = $self->distance;
    my $position = $self->position;
    
    my ($dx, $dy) = (0, 0);
    
    if ($position eq 'north') {
        $dy = -$distance;
    } elsif ($position eq 'south') {
        $dy = $distance;
    } elsif ($position eq 'east') {
        $dx = $distance;
    } elsif ($position eq 'west') {
        $dx = -$distance;
    }
    
    return ($feature_cx + $dx, $feature_cy + $dy);
}

__PACKAGE__->meta->make_immutable;
1;
