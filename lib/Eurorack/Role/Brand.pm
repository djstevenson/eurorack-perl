package Eurorack::Role::Brand;
use Moose::Role;
use namespace::autoclean;
use Eurorack::Prelude;

has name => (
    is          => 'ro',
    isa         => 'Str',
    lazy        => 1,
    builder     => 'set_name',
);

# Default is last part of class name. Override it if required
# e.g. for the brand 2HP which isn't a valid Perl identifier, so
# we had to call the class _2HP
sub set_name($self) {
    my @parts = split(/::/, ref($self));
    return $parts[-1];
}

1;
