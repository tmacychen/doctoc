#!/usr/bin/env perl6

use v6;


sub MAIN(Str $fileName){
    my $fh = open $fileName,:rw;
    dealWith($fh);
}

sub dealWith(IO::Handle $fh){
    for $fh.lines {
        say $_;

    }
}
