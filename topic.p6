#!/usr/bin/env perl6

use v6;


sub MAIN(Str $fileName){
    my $fh = open $fileName,:rw;
    dealWith(slurp $fh)
}

sub dealWith(Str $c){
    say $c;
}
