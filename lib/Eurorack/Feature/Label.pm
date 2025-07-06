package Eurorack::Feature::Label;
use Moose;
use namespace::autoclean;
use Eurorack::Prelude;

use Eurorack::Feature::Label::Position;
use Eurorack::Feature::Socket::Type;

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

has 'socket_type' => (
    is          => 'ro',
    isa         => 'SocketType',
    coerce      => 1,
    default     => 'input',
    documentation => 'Type of socket: input or output. Used for directional arrows.',
);

sub render($self, $feature_cx, $feature_cy) {
    my ($label_cx, $label_cy) = $self->_calculate_label_position($feature_cx, $feature_cy);
    my $triangle_svg = $self->_render_direction_triangle($label_cx, $label_cy);
    
    if ($self->inverted) {
        return sprintf(
            '<g><rect x="%.2f" y="%.2f" width="%.2f" height="7" fill="black" rx="1"/>' .
            '<text x="%.2f" y="%.2f" text-anchor="middle" font-size="5" class="label" fill="white">%s</text>%s</g>',
            $label_cx - (length($self->text) * 1.5), $label_cy - 5,
            length($self->text) * 3,
            $label_cx, $label_cy, $self->text, $triangle_svg
        );
    } else {
        return sprintf(
            '<g><text x="%.2f" y="%.2f" text-anchor="middle" font-size="5" class="label">%s</text>%s</g>',
            $label_cx, $label_cy, $self->text, $triangle_svg
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

sub _render_direction_triangle($self, $label_cx, $label_cy) {
    # Only render triangles for input/output sockets
    return '' unless $self->socket_type eq 'input' || $self->socket_type eq 'output';
    
    # Calculate triangle position (to the right of text)
    my $text_width = length($self->text) * 1.5; # Approximate text width
    my $triangle_x = $label_cx + ($text_width / 2) + 4; # 4mm spacing from text
    my $triangle_y = $label_cy - 1.5; # Move up 1.5mm to center vertically with text
    
    # Triangle dimensions (small equilateral triangle)
    my $size = 1.5; # 1.5mm height
    my $half_width = $size * 0.866; # cos(30°) * size for equilateral triangle
    
    my $points;
    if ($self->socket_type eq 'input') {
        # Apex pointing south (downward triangle)
        $points = sprintf("%.2f,%.2f %.2f,%.2f %.2f,%.2f",
            $triangle_x, $triangle_y + $size,           # apex (bottom)
            $triangle_x - $half_width, $triangle_y - ($size/2),  # top left
            $triangle_x + $half_width, $triangle_y - ($size/2)   # top right
        );
    } else {
        # Apex pointing north (upward triangle) 
        $points = sprintf("%.2f,%.2f %.2f,%.2f %.2f,%.2f",
            $triangle_x, $triangle_y - $size,           # apex (top)
            $triangle_x - $half_width, $triangle_y + ($size/2),  # bottom left
            $triangle_x + $half_width, $triangle_y + ($size/2)   # bottom right
        );
    }
    
    return sprintf('<polygon points="%s" fill="black"/>', $points);
}

__PACKAGE__->meta->make_immutable;
1;
