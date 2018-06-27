#!/usr/bin/perl
use strict;
use warnings;
use Term::ANSIColor;

my $n = $ARGV[0];
exit 0 if (not(defined $n));
my $origin = $n;
my @seq;
my $count;
until ($n == "1") {
    if (($n % 2) == 0) {
        $n=$n/2;
    } else {
        $n=(3*$n)+1;
    }
    push(@seq, $n);
    $count+=1;
}
if (($origin % 2) == 0) {
    print "Start: ", colored("$origin", 'green'), "\n";
} else {
    print "Start: ", colored("$origin", 'red'), "\n";
}
foreach my $term (@seq) {
    if (($term % 2) == 0) {
        print colored("$term", 'green'), "\n";
    } elsif ($term == 1) {
        print colored("$term", 'yellow'), "\n";
    } else {
        print colored("$term", 'red'), "\n";
    }
}
print "Steps until 1: ", colored("$count", 'yellow'), "\n";
