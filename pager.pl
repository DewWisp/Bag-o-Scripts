#!/usr/bin/perl
use strict;
use warnings;
use POSIX;
use Term::Cap;
use Term::ANSIColor;

my $termios = new POSIX::Termios;
$termios->getattr;
my $ospeed = $termios->getospeed;
my $terminal = Term::Cap->Tgetent({ TERM => undef, OSPEED => $ospeed });
$terminal->Trequire("cl");
my $clear = $terminal->Tputs("cl");
my $count = 0;
my $file = $ARGV[0];

print $clear;
open(my $handle, "<:encoding(UTF-8)", $file);
while (my $line = <$handle>) {
    $count+=1;
    chomp $line;
    print colored("$line", 'green'), "\n";
    if ($count == 24) {
        $count = 0;
        print colored("Press Any Key to Continue...", 'yellow');
        <STDIN>;
        print $clear;
    }
}

print colored("EOF", 'red');
<STDIN>;
print $clear;
