package Eurorack::Feature::Text::Basic;
use Moose;
use namespace::autoclean;
use Eurorack::Prelude;

with 'Eurorack::Role::Feature';

has 'text' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

has 'font_size' => (
    is      => 'ro',
    isa     => 'Num',
    default => 4,
);

has 'font_weight' => (
    is      => 'ro',
    isa     => 'Str',
    default => 'normal',
);

has 'text_anchor' => (
    is      => 'ro',
    isa     => 'Str',
    default => 'middle',
);

has 'text_color' => (
    is      => 'ro',
    isa     => 'Str',
    default => 'black',
);

has 'rotation' => (
    is      => 'ro',
    isa     => 'Num',
    default => 0,
);

sub render($self, $mx, $my) {
    my ($x, $y) = ($mx + $self->x, $my + $self->y);
    my $text = $self->text;
    my $font_size = $self->font_size;
    my $font_weight = $self->font_weight;
    my $text_anchor = $self->text_anchor;
    my $text_color = $self->text_color;
    my $rotation = $self->rotation;
    
    my $transform = $rotation != 0 ? qq{ transform="rotate($rotation $x $y)"} : '';
    
    return qq{<text x="$x" y="$y" font-size="$font_size" text-anchor="$text_anchor" } .
           qq{dominant-baseline="middle" font-family="sans-serif" } .
           qq{fill="$text_color" font-weight="$font_weight"$transform>$text</text>};
}

__PACKAGE__->meta->make_immutable;
1;