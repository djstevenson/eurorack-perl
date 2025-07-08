package Eurorack::Feature::Array;
use Moose;
use namespace::autoclean;
use Eurorack::Prelude;
use Eurorack::Feature::Label;

with 'Eurorack::Role::Feature';

has 'feature_class' => (
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

has '_features' => (
    is        => 'ro',
    isa       => 'ArrayRef[ArrayRef]',
    lazy      => 1,
    builder   => '_build_features',
    init_arg  => undef,
);

sub _build_features($self) {
    my @feature_grid;
    
    for my $row (0 .. $self->rows - 1) {
        my @feature_row;
        
        for my $col (0 .. $self->columns - 1) {
            my $feature_x = $self->x + ($col * $self->spacing_x);
            my $feature_y = $self->y + ($row * $self->spacing_y);
            my %feature_args = (
                x => $feature_x,
                y => $feature_y,
            );
            
            # Add label if provided
            if (my $row_labels = $self->labels->[$row]) {
                if (my $label = $row_labels->[$col]) {
                    if (ref $label eq 'HASH') {
                        # Hash reference - pass all args to feature constructor
                        %feature_args = (%feature_args, %$label);
                    } elsif (ref $label && $label->can('render')) {
                        # Full label object - pass as label
                        $feature_args{label} = $label;
                    } else {
                        # Simple string - use as label_text
                        $feature_args{label_text} = $label;
                    }
                }
            }
            
            my $feature = $self->feature_class->new(%feature_args);
            push @feature_row, $feature;
        }
        
        push @feature_grid, \@feature_row;
    }
    
    return \@feature_grid;
}

sub render($self, $mx, $my) {
    my $svg = '';
    
    for my $row (@{$self->_features}) {
        for my $feature (@$row) {
            $svg .= $feature->render($mx, $my);
        }
    }
    
    return $svg;
}

__PACKAGE__->meta->make_immutable;
1;