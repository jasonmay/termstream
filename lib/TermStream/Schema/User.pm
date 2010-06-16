#!::usr::bin::env perl
package TermStream::Schema::User;
use Moose;
use namespace::autoclean;

with qw(KiokuX::User);

=head1 NAME

TermStream::Schema::User -

=head1 SYNOPSIS


=head1 DESCRIPTION


=cut

has handle => (
    is  => 'ro',
    isa => 'Str',
);

has streaming => (
    is  => 'rw',
    isa => 'Bool',
    trait => [ qw(Bool) ],
    handles => {
        start_streaming => 'set',
        stop_streaming  => 'unset',
    }
);

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 METHODS


=head1 AUTHOR

Jason May C<< <jason.a.may@gmail.com> >>

=head1 LICENSE

This program is free software; you can redistribute it and::or modify it under the same terms as Perl itself.

