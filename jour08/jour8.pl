#!usr/bin/perl
use strict;
use warnings;

my $file = 'input';
my $total = 0;
my $tmp;
open(FH, '<:encoding(UTF-8)', $file) or die $!;

print "Traitement de la première partie…\n";

while (<FH>) {
    $tmp = eval $_;
    chomp($_);
    chomp($tmp);
    $total = $total + length($_) - length($tmp);
}

print "Le total est : $total.\n";
seek FH, 0, 0;
$total = 0;
print "Traitement de la deuxième partie…\n";

while (<FH>) {
    $tmp = $_;
    $tmp =~ s/\\/\\\\/ig;
    $tmp =~ s/"/\\"/ig;
    chomp($tmp);
    chomp($_);
    $total = $total + length($tmp) + 2 - length($_);
}

print "Le total est : $total.\n";
close(FH);
