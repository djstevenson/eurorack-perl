package Eurorack::Feature::Socket::Type;
use Moose;
use namespace::autoclean;
use Eurorack::Prelude;

use Moose::Util::TypeConstraints;

enum SocketType => [qw(input output)];

coerce SocketType =>
    from 'Str',
    via {
        return {
            i => 'input',
            o => 'output',
            in => 'input',
            out => 'output',
        }
        ->{$_} || $_;
    };

__PACKAGE__->meta->make_immutable;
1;