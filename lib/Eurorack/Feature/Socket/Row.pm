package Eurorack::Feature::Socket::Row;
use Moose;
use namespace::autoclean;
use Eurorack::Prelude;
use Eurorack::Feature::Label;

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

has '_sockets' => (
    is        => 'ro',
    isa       => 'ArrayRef',
    lazy      => 1,
    builder   => '_build_sockets',
    init_arg  => undef,
);

sub _build_sockets($self) {
    my @sockets;
    
    for my $i (0 .. $self->count - 1) {
        my $socket_x = $self->x + ($i * $self->spacing);
        my %socket_args = (
            x => $socket_x,
            y => $self->y,
        );
        
        # Add label if provided
        if (my $label = $self->labels->[$i]) {
            if (ref $label eq 'HASH') {
                # Hash reference - pass all args to socket constructor
                %socket_args = (%socket_args, %$label);
            } elsif (ref $label && $label->can('render')) {
                # Full label object - pass as label
                $socket_args{label} = $label;
            } else {
                # Simple string - use as label_text
                $socket_args{label_text} = $label;
            }
        }
        
        my $socket = $self->socket_class->new(%socket_args);
        push @sockets, $socket;
    }
    
    return \@sockets;
}

sub render($self, $mx, $my) {
    my $svg = '';
    
    for my $socket (@{$self->_sockets}) {
        $svg .= $socket->render($mx, $my);
    }
    
    return $svg;
}

__PACKAGE__->meta->make_immutable;
1;