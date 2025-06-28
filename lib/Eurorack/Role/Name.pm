package Eurorack::Role::Name;
use Moose::Role;
use namespace::autoclean;
use Eurorack::Prelude;

use Class::Load qw(load_class);
use lib 'lib';
use Try::Tiny;

use Eurorack::Role::Brand;

has brand => (
    is          => 'ro',
    isa         => 'Eurorack::Role::Brand',
    lazy        => 1,
    builder     => 'set_brand',
);

# Default implementation gets the brand from the class name.
# you probably don't need to override this
sub set_brand($self) {
    my $type = ref($self);

    croak "Can't determine default brand from ${type}"
        unless $type =~ qr/\AEurorack::(?:Module|Rack)::(?<brand>[^:]+)::(?<model>[^:]+)\Z/;

    my $brand_name = $+{brand};
    my $brand_class = "Eurorack::Brand::${brand_name}";
    try{
        Class::Load::load_class($brand_class);
    }
    catch{
            # Log and re-throw
            my $e = shift;
            say "EXCP Error loading $brand_class  Exception: $e";
            die $e;
    };

    return $brand_class->new;
}

has model => (
    is          => 'ro',
    isa         => 'Str',
    lazy        => 1,
    default     => sub ($self) {
        my $type = ref($self);

        croak "Can't determine default model from ${type}"
            unless $type =~ qr/\AEurorack::(?:Module|Rack)::(?<brand>[^:]+)::(?<model>[^:]+)\Z/;

        return $+{model};
    },
);

sub BUILD($self, $args) {
    $self->brand;
}

1;
