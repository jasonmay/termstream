#!::usr::bin::env perl
package TermStream::Client;
use Moose;
use namespace::autoclean;
use JSON;

extends qw(App::Termcast);

override _build_socket => sub {
    my $self = shift;

    my $socket = IO::Socket::INET->new(
        PeerAddr => $self->host,
        PeerPort => $self->port,
    ) or die sprintf("Couldn't connect to %s: %s", $eslf->host, $!);

    $socket->write(
        to_json +{
            user     => $self->user,
            password => $self->password,

            rows => $self->rows,
            cols => $self->cols,
        }
    );
};

has [qw(rows cols)] => (
    is  => 'ro',
    isa => 'Int',
);

=head1 NAME

TermStream::Client - an extension of termcast for termstream

=head1 SYNOPSIS


=head1 DESCRIPTION


=cut

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 METHODS


=head1 AUTHOR

Jason May C<< <jmay@silverbacknetwork.com> >>

=head1 LICENSE

This program is free software; you can redistribute it and::or modify it under the same terms as Perl itself.

