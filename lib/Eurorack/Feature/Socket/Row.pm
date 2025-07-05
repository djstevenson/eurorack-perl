package Eurorack::Feature::Socket::Row;
use Moose;
use namespace::autoclean;
use Eurorack::Prelude;
use Eurorack::Feature::Socket::Array;

with 'Eurorack::Role::Feature';

has 'socket_class' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

has 'spacing' => (
    is       => 'ro',
    isa      => 'Num',
    required => 1,
);

has 'count' => (
    is       => 'ro',
    isa      => 'Int',
    required => 1,
);

has 'labels' => (
    is      => 'ro',
    isa     => 'ArrayRef[Str|HashRef|Object]',
    default => sub { [] },
);

has '_array' => (
    is        => 'ro',
    isa       => 'Eurorack::Feature::Socket::Array',
    lazy      => 1,
    builder   => '_build_array',
    init_arg  => undef,
);

sub _build_array($self) {
    return Eurorack::Feature::Socket::Array->new(
        x => $self->x,
        y => $self->y,
        socket_class => $self->socket_class,
        spacing_x => $self->spacing,
        spacing_y => 0,
        columns => $self->count,
        rows => 1,
        labels => [$self->labels],
    );
}

sub render($self, $mx, $my) {
    return $self->_array->render($mx, $my);
}

__PACKAGE__->meta->make_immutable;
1;