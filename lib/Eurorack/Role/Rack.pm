package Eurorack::Role::Rack;
use Moose::Role;
use namespace::autoclean;
use Eurorack::Prelude;

with
  'Eurorack::Role::Name',
  'Eurorack::Role::Size',
  'Eurorack::Role::Colour';

use Eurorack::Rack::Row;

sub class_regex($self) {
     return qr/\AEurorack::Rack::(?<brand>[^:]+)::(?<model>[^:]+)\Z/;
}

has rows_u => (
    is          => 'ro',
    isa         => 'ArrayRef[Int]',
    lazy        => 1,
    default     => sub { return [3] },
);

has height_mm => (
    is          => 'ro',
    isa         => 'Num',
    lazy        => 1,
    default     => sub {
        my @rows = @{ shift->rows_u };

        my $height = 0.0;

        for my $row_u (@rows) {
            $height += $row_u * EURORACK_1U_MM;
        }
        return $height;
    },
);

has _rack_rows => (
    traits	    => ['Array'],
    is          => 'ro',
    isa         => 'ArrayRef[Eurorack::Rack::Row]',
    lazy        => 1,
    default     => sub {
        my $self = shift;

        my @rows;

        my $y_offset_mm = 0.0;
        for my $row (@{ $self->rows_u }) {
            push @rows, Eurorack::Rack::Row->new(
                width_hp => $self->width_hp,
                y_offset_mm => $y_offset_mm,
            );
            $y_offset_mm += $row * EURORACK_1U_MM;

        }
        return \@rows;
    },
    handles     => {
        n_rows     => 'count',
        all_rows   => 'elements',
        get_row    => 'get',
    },
);

sub render($self) {
    my $rack_width  = $self->width_mm;
    my $rack_height = $self->height_mm;

    my $svg = <<"SVG";
        <svg xmlns="http://www.w3.org/2000/svg"
            width="${rack_width}mm" height="${rack_height}mm"
            viewBox="0 0 ${rack_width} ${rack_height}">
        <rect x="0" y="0" width="${rack_width}" height="${rack_height}"
                fill="white" stroke="black" stroke-width="1"/>
SVG

    for my $row ($self->all_rows) {
        $svg .= $row->render;
    }
    $svg .= "</svg>\n";

    return $svg;
}

sub add_module($self, $row, $module) {
    return $self->get_row($row)->add_module($module);
}

1;
