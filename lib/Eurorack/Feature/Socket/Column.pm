package Eurorack::Feature::Socket::Column;
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
    # Convert flat label array to 2D array for Array feature
    my @labels_2d = map { [$_] } @{$self->labels};
    
    return Eurorack::Feature::Socket::Array->new(
        x => $self->x,
        y => $self->y,
        socket_class => $self->socket_class,
        spacing_x => 0,
        spacing_y => $self->spacing,
        columns => 1,
        rows => $self->count,
        labels => \@labels_2d,
    );
}

sub render($self, $mx, $my) {
    return $self->_array->render($mx, $my);
}

__PACKAGE__->meta->make_immutable;
1;