# Copyright (c) 2011, Edd Barrett <vext01@gmail.com>
# Copyright (c) 2011, Robert Bronsdon <reashlin@gmail.com>
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

use strict;

use Irssi;

use vars qw($VERSION %IRSSI);

$VERSION = "0.1";
%IRSSI = (
        authors     => 'Edd Barrett, Robert Bronsdon',
        contact     => 'vext01@gmail.com',
        name        => 'gunthirssi',
        description => 'Control a HGD from your existing IRC session',
        license     => 'ISC'
);

my %cmds = (
        "pause" => \&hgd_pause,
);

# Usage: /hgd pause|ls|vo
sub cmd_hgd {
        #global %cmds;
        # data - parameters
        # server - active server
        # witem - active window
        my ($args, $server, $win) = @_;

        my @data = split(' ', $args);
        Irssi::print($args);

        if (!$server) {
                Irssi::print("No server");
                return;
        }

        if (!@data) {
                Irssi::print("Bad usage");
                return;
        }

        foreach (keys %cmds) {
                Irssi::print($_);
                if ($_ eq @data[0]) {
                        $cmds{$_}($server, $win);
                        return 0;
                }
        }

        hgd_msg($win, "command not found");
}

sub hgd_pause {
        my ($server, $win) = @_;
        #$server->command("EXEC hgd-admin pause");
        hgd_msg($win, "toggle paused");
}

sub hgd_msg {
        my ($win, $msg) = @_;

        if ($win) {
                $win->print("HGD >> " . $msg);
        } else {
                Irssi::print("HGD >> " . $msg);
        }
}

Irssi::command_bind('hgd', 'cmd_hgd');
