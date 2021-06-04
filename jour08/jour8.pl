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

close(FH);

print "Le total est : $total.\n";
