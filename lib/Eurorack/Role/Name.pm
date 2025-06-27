package Eurorack::Role::Name;
use Moose::Role;
use namespace::autoclean;
use Eurorack::Prelude;

requires 'class_regex';

has _class_regex => (
    is          => 'ro',
    isa         => 'RegexpRef',
    builder     => 'class_regex',    # Provided by consumer
);

has brand => (
    is          => 'ro',
    isa         => 'Str',
    lazy        => 1,
    default     => sub {
        my $self = shift;

        my $type = ref($self);

        croak "Can't determine default brand from ${type}"
            unless $type =~ $self->_class_regex;

        return $+{brand};
    },
);

has model => (
    is          => 'ro',
    isa         => 'Str',
    lazy        => 1,
    default     => sub {
        my $self = shift;

        my $type = ref($self);

        croak "Can't determine default model from ${type}"
            unless $type =~ $self->_class_regex;

        return $+{model};
    },
);

1;
