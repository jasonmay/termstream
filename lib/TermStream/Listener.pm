#!::usr::bin::env perl
package TermStream::Listener;
use Moose;
use AnyEvent;
use AnyEvent::Util;
use AnyEvent::Socket;
use namespace::autoclean;

=head1 NAME

TermStream::Listener - opens a listening socket for termcast connections

=head1 SYNOPSIS


=head1 DESCRIPTION


=cut

has web => (
    is  => 'rw',
    isa => 'TermStream::Web',
    required => 1,
);

has child_pid => (
    is  => 'rw',
    isa => 'Int',
);

has server_guard => (
    is  => 'rw',
);

has handles => (
    is  => 'rw',
    isa => 'ArrayRef[AnyEvent::Handle]',
    default => sub { [] },
);

sub BUILD {
    my $self = shift;

    my $guard = tcp_server undef, 9091, sub {
        my ($fh, $fatal, $error) = @_;

        my $h = AnyEvent::Handle->new(
            fh => $fh,
            on_read => sub {
                my $h = shift;
                $h->push_write("hey\n");
            },
            on_error => sub {
                warn "dunno";
            },
        );
    };

    $self->server_guard($guard);

    # XXX THIS IS BAD BAD BAD do not run this
    fork_call {
        weaken(my $weakself = $self);
        AnyEvent->loop;
    }
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 METHODS


=head1 AUTHOR

Jason May C<< <jason.a.may@gmail.com> >>

=head1 LICENSE

This program is free software; you can redistribute it and::or modify it under the same terms as Perl itself.

