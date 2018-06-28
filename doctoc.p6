#!/usr/bin/env perl6

use v6;

my @toc;
my $tmpFile = "/tmp/test.md.tmp";

sub MAIN($fileName) {

## 遍历文件找到标题
    for $fileName.IO.lines {
        push @toc,"$_" if $_ ~~ /^\#+ /;
    }

    @toc = trans(@toc);
#    say @toc;
## 拷贝文件到临时文件中，当遇到目录标志，将标题拷贝到文件中。
    my $tmp_h = open($tmpFile,:rw);
    for $fileName.IO.lines {
        $tmp_h.put: $_;
        if $_ ~~ /^\<\!\-\-.*start\-\-\>$/ {
            for @toc -> $i {
                $tmp_h.put: $i;
            }
            $tmp_h.seek(0,SeekType::SeekFromCurrent);
        }
    }
    shell("cp $tmpFile $fileName");
}


sub trans(@a) {
    my $n = @a.elems;

    while $n != 0 {
        my $i = @a.shift;
        given $i {
            when $i ~~ /^\# ** {4}\s+ (.*)/ { @a.push: "           - [$0](####$0)";}
            when $i ~~ /^\# ** {3}\s+ (.*)/ { @a.push: "       - [$0](###$0)"}
            when $i ~~ /^\# ** {2}\s+ (.*)/ { @a.push: "   - [$0](##$0)"}
            when $i ~~ /^\#?\s+ (.*)/ { @a.push: "- [$0](#$0)"}
        }
        $n--;
    }
    return @a;
}
