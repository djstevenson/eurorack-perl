#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use open qw(:std :utf8);
use feature qw(signatures);

use FindBin::libs;

use Eurorack::Rack::Behringer::Go;
use Eurorack::Module::Example::VCO;
use Eurorack::Module::Example::LFO;
use Eurorack::Module::Example::VCF;
use Eurorack::Module::Example::VCA;

my $rack = Eurorack::Rack::Behringer::Go->new;

$rack->add_module(0, Eurorack::Module::Example::VCO->new);
$rack->add_module(0, Eurorack::Module::Example::LFO->new);
$rack->add_module(1, Eurorack::Module::Example::VCF->new);
$rack->add_module(1, Eurorack::Module::Example::VCA->new);

print $rack->render;
