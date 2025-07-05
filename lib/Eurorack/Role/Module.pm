package Eurorack::Role::Module;
use Moose::Role;
use namespace::autoclean;
use Eurorack::Prelude;

with
  'Eurorack::Role::Name',
  'Eurorack::Role::Size',
  'Eurorack::Role::Colour';

# sub set_fill_colour($self) { return '#e0f7fa' };
sub set_fill_colour($self) { '#d3d3d3' }

use Eurorack::Role::Feature;
has _features => (
    traits	    => ['Array'],
    is          => 'ro',
    isa         => 'ArrayRef[Eurorack::Role::Feature]',
    lazy        => 1,
    default     => sub { return []; },
    handles     => {
        n_features   => 'count',
        all_features => 'elements',
        get_feature  => 'get',
        add_feature  => 'push',
    },
);

has _sections => (
    traits	    => ['Array'],
    is          => 'ro',
    isa         => 'ArrayRef[Eurorack::Role::Feature]',
    lazy        => 1,
    default     => sub { return []; },
    handles     => {
        n_sections   => 'count',
        all_sections => 'elements',
        get_section  => 'get',
        add_section  => 'push',
    },
);

sub render($self, $x, $y) {
    my $width       = $self->width_mm;
    my $xcentre     = $x + $width / 2.0;
    my $height      = $self->height_mm;
    my $label       = $self->model;
    my $fill_colour = $self->fill_colour;
    my $edge_colour = $self->edge_colour;
    my $text_colour = $self->text_colour;
    my $font_size   = $self->width_hp > 2 ? 7 : 4;
    
    my $sections_svg = '';
    for my $section ($self->all_sections) {
        $sections_svg .= $section->render($x, $y);
    }
    
    my $features_svg = '';
    for my $feature ($self->all_features) {
        $features_svg .= $feature->render($x, $y);
    }

    return qq{
        <g>
            <rect x="${x}" y="${y}" width="${width}" height="${height}"
                fill="${fill_colour}" stroke="${edge_colour}" stroke-width="0.5"/>
            <text x="${xcentre}" y="@{[$y + 10]}" font-size="${font_size}" text-anchor="middle" dominant-baseline="hanging"
                font-family="sans-serif" fill="${text_colour}" font-weight="bold">@{[$self->brand->name]}</text>
            <text x="${xcentre}" y="@{[$y + 20]}" font-size="${font_size}" text-anchor="middle" dominant-baseline="hanging"
                font-family="sans-serif" fill="${text_colour}" font-weight="bold">${label}</text>
            ${sections_svg}${features_svg}
        </g>
    };
}

1;
