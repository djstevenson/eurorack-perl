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
use Eurorack::Feature::Switch::Rocker::Array;
use Eurorack::Feature::Switch::Rocker::Row;
use Eurorack::Feature::Switch::Rocker::Column;
use Eurorack::Feature::SectionBorder::Basic;
use Eurorack::Feature::Text::Basic;

sub BUILD($self, $args) {
    # Add text markings first (rendered behind everything)
    $self->add_text(Eurorack::Feature::Text::Basic->new(
        x => 37, y => 58, text => 'CONTROL', font_size => 5, font_weight => 'bold'
    ));
    # $self->add_text(Eurorack::Feature::Text::Basic->new(
    #     x => 220, y => 95, text => 'OUTPUTS', font_size => 5, font_weight => 'bold'
    # ));
    $self->add_text(Eurorack::Feature::Text::Basic->new(
        x => 280, y => 90, text => 'CV', font_size => 5, font_weight => 'bold'
    ));
    
    # Add section borders next (rendered before features)
    $self->add_section(Eurorack::Feature::SectionBorder::Basic->new(
        x => 8, y => 3, width => 55, height => 60
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
    
    $self->add_feature(Eurorack::Feature::Socket::MIDI::Din->new(x => 20, y => 20, label_text => 'MIDI In', label_distance => 10));
    $self->add_feature(Eurorack::Feature::Socket::USB::TypeB->new(x =>50, y => 20));
    $self->add_feature(Eurorack::Feature::Socket::USB::TypeC->new(x =>50, y => 50));
    $self->add_feature(Eurorack::Feature::Socket::USB::TypeA->new(x =>20, y => 50));
    $self->add_feature(Eurorack::Feature::Socket::Row->new(
        x => 100, y => 100,
        socket_class => 'Eurorack::Feature::Socket::Jack::Mono3_5mm::HexNut',
        spacing => 20,
        count => 3,
        labels => [
            'Input',
            { label_text => 'Output', socket_type => 'output' },
            'CV'
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
            [
                { label_text => 'Out1', socket_type => 'output' },
                { label_text => 'Out2', socket_type => 'output' },
                { label_text => 'Out3', socket_type => 'output' }
            ],
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
    
    # Examples of rocker switch arrays
    $self->add_feature(Eurorack::Feature::Switch::Rocker::Row->new(
        x => 300, y => 20,
        spacing => 15,
        count => 3,
        labels => [
            { label_text => 'A', state => 'on' },
            { label_text => 'B', state => 'off' },
            { label_text => 'C', state => 'on' }
        ]
    ));
    
    $self->add_feature(Eurorack::Feature::Switch::Rocker::Column->new(
        x => 320, y => 40,
        spacing => 15,
        count => 2,
        labels => [
            { label_text => 'Mode 1', state => 'on', orientation => 'vertical' },
            { label_text => 'Mode 2', state => 'off', orientation => 'vertical' }
        ]
    ));
    
    $self->add_feature(Eurorack::Feature::Switch::Rocker::Array->new(
        x => 300, y => 80,
        spacing_x => 15,
        spacing_y => 15,
        columns => 2,
        rows => 2,
        labels => [
            [
                { label_text => 'SW1', state => 'on' },
                { label_text => 'SW2', state => 'off' }
            ],
            [
                { label_text => 'SW3', state => 'off' },
                { label_text => 'SW4', state => 'on' }
            ]
        ]
    ));
}

1;
