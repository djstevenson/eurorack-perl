package Eurorack::Rack::Row;
use Moose;
use namespace::autoclean;

use Carp qw(croak);

use utf8;
use feature qw(signatures);
use Data::Dumper;

use Eurorack::Constants qw(:all);
extends 'Eurorack::Common::Base';

has width_hp => (
    is          => 'ro',
    isa         => 'Int',
    required    => 1,
);

has y_offset_mm => (
    is          => 'ro',
    isa         => 'Num',
    required    => 1,
);

has _modules => (
    traits	    => ['Array'],
    is          => 'ro',
    isa         => 'ArrayRef[Eurorack::Module::Base]',
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

    for my $module ($self->all_modules) {
        $svg .= $module->render($x_offset_mm, $y_offset_mm);
        $x_offset_mm += $module->width_mm;
    }

    return $svg;
}

1;
