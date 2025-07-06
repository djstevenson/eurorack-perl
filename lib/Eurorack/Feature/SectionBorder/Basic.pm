package Eurorack::Feature::SectionBorder::Basic;
use Moose;
use namespace::autoclean;
use Eurorack::Prelude;

with 'Eurorack::Role::Feature::SectionBorder';

sub render($self, $mx, $my) {
    my ($x, $y) = ($mx + $self->x, $my + $self->y);
    my $width = $self->width;
    my $height = $self->height;
    my $rx = $self->corner_radius;
    my $stroke_width = $self->stroke_width;
    my $stroke_color = $self->stroke_color;
    my $fill = $self->fill;
    
    return qq{<rect x="$x" y="$y" width="$width" height="$height" } .
           qq{rx="$rx" ry="$rx" } .
           qq{fill="$fill" stroke="$stroke_color" stroke-width="$stroke_width"/>};
}

__PACKAGE__->meta->make_immutable;
1;