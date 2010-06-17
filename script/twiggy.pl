#!/usr/bin/env perl
package TermStream::Server;
use Moose;
use Twiggy::Server;

use lib 'lib';
use TermStream::Web;

my $server = Twiggy::Server->new( port => 3000);

TermStream::Web->setup_engine('PSGI');
my $app = sub { TermStream::Web->run(@_) };

$server->register_service($app);

my $timer = AE::timer 0, 10, sub { warn "foo" };
AE::cv->recv;
