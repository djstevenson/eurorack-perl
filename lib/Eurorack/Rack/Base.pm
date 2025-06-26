package Eurorack::Rack::Base;
use Moose;
use namespace::autoclean;

use Carp qw(croak);

use utf8;
use feature qw(signatures);

use Eurorack::Constants qw(:all);
use Eurorack::Rack::Row;

extends 'Eurorack::Common::Named';

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

has rack_colour => (
    is          => 'ro',
    isa         => 'Str',
    lazy        => 1,
    default     => 'white',
);

has '+edge_colour' => (default => 'black');

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

has '+_class_regex' => (default => sub { return qr/\AEurorack::Rack::(?<brand>[^:]+)::(?<model>[^:]+)\Z/; } );

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
