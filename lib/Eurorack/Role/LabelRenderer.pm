package Eurorack::Role::LabelRenderer;
use Moose::Role;
use namespace::autoclean;
use Eurorack::Prelude;

around 'render' => sub {
    my ($orig, $self, $mx, $my) = @_;
    
    # Get the original feature SVG
    my $feature_svg = $self->$orig($mx, $my);
    
    # Add label if present
    if ($self->has_label) {
        # Calculate feature center coordinates
        my ($cx, $cy) = ($mx + $self->x, $my + $self->y);
        $feature_svg .= $self->label->render($cx, $cy);
    }
    
    return $feature_svg;
};

1;