package Eurorack::Constants;
use base Exporter;
use strict;
use warnings;

# Dimensions in mm
use constant EURORACK_HP_MM =>  5.08;
use constant EURORACK_1U_MM => 44.45;

our %EXPORT_TAGS = (
    all => [qw( EURORACK_HP_MM EURORACK_1U_MM )]
);

our @EXPORT=();
our @EXPORT_OK = @{$EXPORT_TAGS{all}};

1;
