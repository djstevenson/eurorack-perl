package Eurorack::Module::Behringer::ModelD;
use Moose;
use namespace::autoclean;
use Eurorack::Prelude;

with
  'Eurorack::Role::Module';

has '+width_hp' => (default => 70);

use Eurorack::Feature::Socket::MIDI::Din;
use Eurorack::Feature::Socket::USB::TypeA;
use Eurorack::Feature::Socket::USB::TypeB;
use Eurorack::Feature::Socket::USB::TypeC;
use Eurorack::Feature::Socket::Jack::Mono3_5mm::HexNut;
use Eurorack::Feature::Socket::Jack::Mono3_5mm::CircularNut;

sub BUILD($self, $args) {
    $self->add_feature(Eurorack::Feature::Socket::MIDI::Din->new(x =>20, y => 20, label_text => 'MIDI In', label_inverted => 1));
    $self->add_feature(Eurorack::Feature::Socket::USB::TypeB->new(x =>50, y => 20));
    $self->add_feature(Eurorack::Feature::Socket::USB::TypeC->new(x =>50, y => 50));
    $self->add_feature(Eurorack::Feature::Socket::USB::TypeA->new(x =>50, y => 80));
    $self->add_feature(Eurorack::Feature::Socket::Jack::Mono3_5mm::HexNut->new(x =>100, y => 100));
    $self->add_feature(Eurorack::Feature::Socket::Jack::Mono3_5mm::HexNut->new(x =>120, y => 100));
    $self->add_feature(Eurorack::Feature::Socket::Jack::Mono3_5mm::HexNut->new(x =>140, y => 100));
    $self->add_feature(Eurorack::Feature::Socket::Jack::Mono3_5mm::HexNut->new(x =>100, y => 120));
    $self->add_feature(Eurorack::Feature::Socket::Jack::Mono3_5mm::HexNut->new(x =>120, y => 120));
    $self->add_feature(Eurorack::Feature::Socket::Jack::Mono3_5mm::HexNut->new(x =>140, y => 120));
    $self->add_feature(Eurorack::Feature::Socket::Jack::Mono3_5mm::CircularNut->new(x =>200, y => 100));
    $self->add_feature(Eurorack::Feature::Socket::Jack::Mono3_5mm::CircularNut->new(x =>220, y => 100));
    $self->add_feature(Eurorack::Feature::Socket::Jack::Mono3_5mm::CircularNut->new(x =>240, y => 100));
    $self->add_feature(Eurorack::Feature::Socket::Jack::Mono3_5mm::CircularNut->new(x =>200, y => 120));
    $self->add_feature(Eurorack::Feature::Socket::Jack::Mono3_5mm::CircularNut->new(x =>220, y => 120));
    $self->add_feature(Eurorack::Feature::Socket::Jack::Mono3_5mm::CircularNut->new(x =>240, y => 120));
}

1;
