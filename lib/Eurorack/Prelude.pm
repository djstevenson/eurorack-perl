package Eurorack::Prelude;

use v5.40;

use strict;
use warnings;
use utf8;
use feature qw(signatures say);
no warnings qw(experimental::signatures);

use Carp qw(croak);

use Eurorack::Constants ();

use Import::Into;

sub import {
    my $target = caller;

    strict->import::into($target);
    warnings->import::into($target);
    utf8->import::into($target);
    feature->import::into($target, qw(signatures say));
    warnings->unimport::out_of($target, 'experimental::signatures');
    Carp->import::into($target, 'croak');

    Eurorack::Constants->import::into($target, qw(:all));
}

1;
