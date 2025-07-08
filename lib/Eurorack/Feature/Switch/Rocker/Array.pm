package Eurorack::Feature::Switch::Rocker::Array;
use Moose;
use namespace::autoclean;
use Eurorack::Prelude;
use Eurorack::Feature::Array;

with 'Eurorack::Role::Feature';

has 'switch_class' => (
    is       => 'ro',
    isa      => 'Str',
    default  => 'Eurorack::Feature::Switch::Rocker',
);

has 'spacing_x' => (
    is       => 'ro',
    isa      => 'Num',
    required => 1,
);

has 'spacing_y' => (
    is       => 'ro',
    isa      => 'Num',
    required => 1,
);

has 'columns' => (
    is       => 'ro',
    isa      => 'Int',
    required => 1,
);

has 'rows' => (
    is       => 'ro',
    isa      => 'Int',
    required => 1,
);

has 'labels' => (
    is      => 'ro',
    isa     => 'ArrayRef[ArrayRef[Str|HashRef|Object]]',
    default => sub { [] },
);

has '_array' => (
    is        => 'ro',
    isa       => 'Eurorack::Feature::Array',
    lazy      => 1,
    builder   => '_build_array',
    init_arg  => undef,
);

sub _build_array($self) {
    return Eurorack::Feature::Array->new(
        x => $self->x,
        y => $self->y,
        feature_class => $self->switch_class,
        spacing_x => $self->spacing_x,
        spacing_y => $self->spacing_y,
        columns => $self->columns,
        rows => $self->rows,
        labels => $self->labels,
    );
}

sub render($self, $mx, $my) {
    return $self->_array->render($mx, $my);
}

__PACKAGE__->meta->make_immutable;
1;