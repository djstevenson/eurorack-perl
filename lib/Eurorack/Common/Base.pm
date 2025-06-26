package Eurorack::Common::Base;
use Moose;
use namespace::autoclean;

use Carp qw(croak);

use utf8;
use feature qw(signatures);
use Readonly;
use Carp qw(croak);

use Eurorack::Constants qw(:all);

has width_hp => (
    is          => 'ro',
    isa         => 'Int',
    required    => 1,
);

has width_mm => (
    is          => 'ro',
    isa         => 'Num',
    lazy        => 1,
    default     => sub {
        return shift->width_hp * EURORACK_HP_MM;
    },
);

# TODO Only for classes that have brand/model
#      Make those a separate subclass then we
#      require it where appropriate
has _class_regex => (
    is          => 'ro',
    isa         => 'RegexpRef',
    lazy        => 1,
    default     => sub { croak 'Did not specify _class_regex where needed'; },
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

has edge_colour => (
    is          => 'ro',
    isa         => 'Str',
    lazy        => 1,
    default     => 'black',
);

1;
