#!/usr/bin/env perl
use strict;
use warnings;
use AnyEvent;
use AnyEvent::FCGI;
use AnyEvent::Socket;
use AnyEvent::Handle;
use HTML::FromANSI;
use JSON;

#use FindBin;
#use lib '$FindBin::Bin/../lib';
#use Termcast::Web;

my $rw;

my $hfa = HTML::FromANSI->new(
    cols => 80,
    rows => 24,
    tt   => 0,
    wrap => 1,
    show_cursor => 1,
    font_face => 'monaco, consolas, lucida console, monospace',
    style => 'padding: 0; margin: 0;letter-spacing: 0; font-size: 80%;',
);

my $server = tcp_server undef, 9091, sub {
    my ($fh) = @_;

    if ($rw) {
        close $fh;
        return;
    }

    $rw = AnyEvent::Handle->new(
        fh => $fh,
        on_read => sub {
            my ($h) = @_;
            $h->push_read(
                chunk => 1, sub {
                    my ($h, $message) = @_;
                    $hfa->add_text($message);
                }
            );
        },
        on_error => sub {
            my ($h, $fatal, $error) = @_;
            $h->destroy if $fatal;
        }
    );

    $rw->unshift_read(
        line => sub {
            # do nothing yet...
            warn "$_[1] GO?";
        }
    );
};

my $fcgi = AnyEvent::FCGI->new(
    port => 8082,
    on_request => sub {
        my $request = shift;

        if (!$rw) {
            $request->respond(
                format_jsonp('<h1 style="color:white">(Nobody is currently broadcasting. Please check back later)</h1>'),
                'Content-Type' => 'text/html',
            );
            return;
        }

        $request->respond(
            format_jsonp($hfa->html),
            'Content-Type' => 'text/json',
        );
    },
);

sub format_jsonp {
    my $html = shift;
    return sprintf(
        q[%s(%s);],
        'termcast_cb',
        to_json({html => $html})
    );
}

AnyEvent->loop;
