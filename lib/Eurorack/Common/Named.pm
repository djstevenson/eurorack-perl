package Eurorack::Common::Named;
use Moose;
use namespace::autoclean;

use Carp qw(croak);

use utf8;
use feature qw(signatures);
use Readonly;
use Carp qw(croak);

use Eurorack::Constants qw(:all);

extends 'Eurorack::Common::Base';

has _class_regex => (
    is          => 'ro',
    isa         => 'RegexpRef',
    required    => 1,
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
