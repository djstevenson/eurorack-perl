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
    default => 8,
);

has 'label_inverted' => (
    is      => 'ro',
    isa     => 'Bool',
    default => 0,
);

has 'label' => (
    is        => 'rw',
    isa       => 'Eurorack::Feature::Label',
    predicate => 'has_label',
    init_arg  => undef,
);

# Default is no label, override this to create a 
# default label
sub _default_label_text { return; };

sub BUILD($self, $args) {
    # Use provided label_text or fall back to default
    my $text = $self->has_label_text ? $self->label_text : $self->_default_label_text;
    if (defined $text) {
        my $label = Eurorack::Feature::Label->new(
            text     => $text,
            position => $self->label_position,
            distance => $self->label_distance,
            inverted => $self->label_inverted,
        );
        $self->label($label);
    }
    
}

requires 'render';

1;
