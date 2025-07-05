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
use Eurorack::Feature::Socket::Row;
use Eurorack::Feature::Socket::Array;
use Eurorack::Feature::Knob::Basic;

sub BUILD($self, $args) {
    $self->add_feature(Eurorack::Feature::Socket::MIDI::Din->new(x =>20, y => 20, label_text => 'MIDI In', label_inverted => 1));
    $self->add_feature(Eurorack::Feature::Socket::USB::TypeB->new(x =>50, y => 20));
    $self->add_feature(Eurorack::Feature::Socket::USB::TypeC->new(x =>50, y => 50));
    $self->add_feature(Eurorack::Feature::Socket::USB::TypeA->new(x =>50, y => 80));
    $self->add_feature(Eurorack::Feature::Socket::Row->new(
        x => 100, y => 100,
        socket_class => 'Eurorack::Feature::Socket::Jack::Mono3_5mm::HexNut',
        spacing => 20,
        count => 3,
        labels => [
            'Input',
            { label_text => 'Output', label_position => 'south' },
            { label_text => 'CV', label_inverted => 1 }
        ]
    ));
    $self->add_feature(Eurorack::Feature::Socket::Jack::Mono3_5mm::HexNut->new(x =>100, y => 120));
    $self->add_feature(Eurorack::Feature::Socket::Jack::Mono3_5mm::HexNut->new(x =>120, y => 120));
    $self->add_feature(Eurorack::Feature::Socket::Jack::Mono3_5mm::HexNut->new(x =>140, y => 120));
    $self->add_feature(Eurorack::Feature::Socket::Array->new(
        x => 200, y => 100,
        socket_class => 'Eurorack::Feature::Socket::Jack::Mono3_5mm::CircularNut',
        spacing_x => 20,
        spacing_y => 20,
        columns => 3,
        rows => 2,
        labels => [
            ['Out1', 'Out2', 'Out3'],
            ['CV1', 'CV2', 'CV3']
        ]
    ));
    $self->add_feature(Eurorack::Feature::Knob::Basic->new(x => 100, y => 20));
    $self->add_feature(Eurorack::Feature::Knob::Basic->new(x => 100, y => 50, radius => 4, min_value => 0, max_value => 4, labels => ["32'", "16'", "8'", "4'", "2'"], start_angle => 180, angle_range => 180, value => 2));
}

1;
