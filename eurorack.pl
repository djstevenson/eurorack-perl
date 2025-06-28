#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use open qw(:std :utf8);
use feature qw(signatures);

use FindBin::libs;

use Eurorack::Rack::Behringer::Go;
use Eurorack::Module::Behringer::ModelD;
use Eurorack::Module::_2HP::Mix;
use Eurorack::Module::_2HP::Pluck;
use Eurorack::Module::_2HP::Sine;
use Eurorack::Module::Behringer::Victor;
use Eurorack::Module::Behringer::KobolExpander;

my $rack = Eurorack::Rack::Behringer::Go->new;

$rack->add_module(0, Eurorack::Module::Behringer::ModelD->new);
$rack->add_module(0, Eurorack::Module::_2HP::Mix->new);
$rack->add_module(0, Eurorack::Module::_2HP::Pluck->new);
$rack->add_module(0, Eurorack::Module::_2HP::Sine->new);
$rack->add_module(1, Eurorack::Module::Behringer::Victor->new);
$rack->add_module(1, Eurorack::Module::Behringer::KobolExpander->new);

print $rack->render;
