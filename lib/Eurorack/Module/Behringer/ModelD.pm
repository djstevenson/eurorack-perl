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
use Eurorack::Feature::Socket::Column;
use Eurorack::Feature::Knob::Basic;
use Eurorack::Feature::Switch::Rocker;
use Eurorack::Feature::SectionBorder::Basic;
use Eurorack::Feature::Text::Basic;

sub BUILD($self, $args) {
    # Add text markings first (rendered behind everything)
    $self->add_text(Eurorack::Feature::Text::Basic->new(
        x => 50, y => 95, text => 'INPUTS', font_size => 5, font_weight => 'bold'
    ));
    $self->add_text(Eurorack::Feature::Text::Basic->new(
        x => 220, y => 95, text => 'OUTPUTS', font_size => 5, font_weight => 'bold'
    ));
    $self->add_text(Eurorack::Feature::Text::Basic->new(
        x => 280, y => 90, text => 'CV', font_size => 5, font_weight => 'bold'
    ));
    
    # Add section borders next (rendered before features)
    $self->add_section(Eurorack::Feature::SectionBorder::Basic->new(
        x => 15, y => 35, width => 70, height => 50
    ));
    $self->add_section(Eurorack::Feature::SectionBorder::Basic->new(
        x => 90, y => 85, width => 60, height => 45
    ));
    $self->add_section(Eurorack::Feature::SectionBorder::Basic->new(
        x => 190, y => 85, width => 60, height => 45
    ));
    $self->add_section(Eurorack::Feature::SectionBorder::Basic->new(
        x => 268, y => 5, width => 25, height => 65
    ));
    
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
    $self->add_feature(Eurorack::Feature::Socket::Column->new(
        x => 280, y => 20,
        socket_class => 'Eurorack::Feature::Socket::Jack::Mono3_5mm::CircularNut',
        spacing => 20,
        count => 3,
        labels => ['Gate', 'Trig', 'Sync']
    ));
    $self->add_feature(Eurorack::Feature::Knob::Basic->new(x => 100, y => 20));
    $self->add_feature(Eurorack::Feature::Knob::Basic->new(x => 100, y => 50, radius => 4, min_value => 0, max_value => 4, labels => ["32'", "16'", "8'", "4'", "2'"], start_angle => 180, angle_range => 180, value => 2));
    $self->add_feature(Eurorack::Feature::Switch::Rocker->new(x => 160, y => 40, state => 'on', label_text => 'Filter'));
    $self->add_feature(Eurorack::Feature::Switch::Rocker->new(x => 160, y => 60, state => 'off', orientation => 'horizontal'));
    $self->add_feature(Eurorack::Feature::Switch::Rocker->new(x => 180, y => 60, state => 'on', orientation => 'vertical', on_label => 'Hi', off_label => 'Lo'));
}

1;
