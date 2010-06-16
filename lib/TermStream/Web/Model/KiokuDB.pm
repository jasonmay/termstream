package TermStream::Web::Model::KiokuDB;
use Moose;
use TermStream::Model::KiokuDB;

BEGIN { extends qw(Catalyst::Model::KiokuDB) }

has '+model_class' => (
    default => 'TermStream::Model::KiokuDB',
);

=head1 NAME

TermStream::Web::Model::KiokuDB - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
