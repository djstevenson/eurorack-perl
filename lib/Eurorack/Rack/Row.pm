package Eurorack::Rack::Row;
use Moose;
use namespace::autoclean;
use Eurorack::Prelude;

use Eurorack::Role::Module;

with 'Eurorack::Role::Size';

has y_offset_mm => (
    is          => 'ro',
    isa         => 'Num',
    required    => 1,
);

has _modules => (
    traits	    => ['Array'],
    is          => 'ro',
    isa         => 'ArrayRef[Eurorack::Role::Module]',
    lazy        => 1,
    default     => sub { return []; },
    handles     => {
        n_modules   => 'count',
        all_modules => 'elements',
        get_module  => 'get',
        add_module  => 'push',
    },
);

sub render($self) {
    my $svg = '';

    my $x_offset_mm = 0;
    my $y_offset_mm = $self->y_offset_mm;
    my $width_mm    = $self->width_mm; 

    if ($y_offset_mm > 0.1) {
        # Divider
        $svg .= qq{    <line x1="0" y1="${y_offset_mm}" x2="${width_mm}" y2="${y_offset_mm}"
            stroke="black" stroke-width="0.5"/>\n};
    }


    for my $module ($self->all_modules) {
        $svg .= $module->render($x_offset_mm, $y_offset_mm);
        $x_offset_mm += $module->width_mm;
    }

    return $svg;
}

1;
