package Eurorack::Role::Feature;
use Moose::Role;
use namespace::autoclean;
use Eurorack::Prelude;

with
  'Eurorack::Role::RelativePosition',
  'Eurorack::Role::LabelRenderer';

use Eurorack::Feature::Label;

has 'label_text' => (
    is        => 'ro',
    isa       => 'Str',
    predicate => 'has_label_text',
);

has 'label_position' => (
    is      => 'ro',
    isa     => 'Str',
    default => 'north',
);

has 'label_distance' => (
    is      => 'ro',
    isa     => 'Num',
    default => 12,
);

has 'label' => (
    is        => 'ro',
    isa       => 'Eurorack::Feature::Label',
    predicate => 'has_label',
    lazy      => 1,
    builder   => '_build_label',
);

# Default is no label, override this to create a 
# default label
sub _default_label_text { return; };

sub _build_label {
    my $self = shift;
    
    # Use provided label_text or fall back to default
    my $text = $self->has_label_text ? $self->label_text : $self->_default_label_text;
    
    return unless defined $text;
    
    return Eurorack::Feature::Label->new(
        text     => $text,
        position => $self->label_position,
        distance => $self->label_distance,
    );
}

requires 'render';

1;
