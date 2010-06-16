package TermStream::Web::View::TT;

use strict;
use warnings;

use base 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
);

=head1 NAME

TermStream::Web::View::TT - TT View for TermStream::Web

=head1 DESCRIPTION

TT View for TermStream::Web.

=head1 SEE ALSO

L<TermStream::Web>

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
