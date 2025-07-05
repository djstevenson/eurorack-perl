package Eurorack::Feature::Socket::Array;
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

has '_sockets' => (
    is        => 'ro',
    isa       => 'ArrayRef[ArrayRef]',
    lazy      => 1,
    builder   => '_build_sockets',
    init_arg  => undef,
);

sub _build_sockets($self) {
    my @socket_grid;
    
    for my $row (0 .. $self->rows - 1) {
        my @socket_row;
        
        for my $col (0 .. $self->columns - 1) {
            my $socket_x = $self->x + ($col * $self->spacing_x);
            my $socket_y = $self->y + ($row * $self->spacing_y);
            my %socket_args = (
                x => $socket_x,
                y => $socket_y,
            );
            
            # Add label if provided
            if (my $row_labels = $self->labels->[$row]) {
                if (my $label = $row_labels->[$col]) {
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
            }
            
            my $socket = $self->socket_class->new(%socket_args);
            push @socket_row, $socket;
        }
        
        push @socket_grid, \@socket_row;
    }
    
    return \@socket_grid;
}

sub render($self, $mx, $my) {
    my $svg = '';
    
    for my $row (@{$self->_sockets}) {
        for my $socket (@$row) {
            $svg .= $socket->render($mx, $my);
        }
    }
    
    return $svg;
}

__PACKAGE__->meta->make_immutable;
1;