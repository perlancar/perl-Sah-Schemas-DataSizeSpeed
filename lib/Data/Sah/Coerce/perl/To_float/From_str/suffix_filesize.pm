package Data::Sah::Coerce::perl::To_float::From_str::suffix_filesize;

# AUTHOR
# DATE
# DIST
# VERSION

use 5.010001;
use strict;
use warnings;

use Data::Size::Suffix::Filesize;
use Data::Dmp;

sub meta {
    +{
        v => 4,
        summary => 'Parse number from string containing size suffixes',
        prio => 50,
        precludes => [qr/\AFrom_str::suffix_(\w+)\z/],
    };
}

my $re = '(\+?[0-9]+(?:\.[0-9]+)?)\s*('.join("|", sort {length($b)<=>length($a)} sort keys %Data::Size::Suffix::Filesize::suffixes).')'; $re = qr/\A$re\z/i;

sub coerce {
    my %args = @_;

    my $dt = $args{data_term};

    my $res = {};

    $res->{expr_match} = "$dt =~ ".dmp($re);
    $res->{modules}{"Data::Size::Suffix::Filesize"} = 0;
    $res->{expr_coerce} = join(
        "",
        "\$1 * \$Data::Size::Suffix::Filesize::suffixes{(lc \$2)}",
    );

    $res;
}

1;
# ABSTRACT:

=for Pod::Coverage ^(meta|coerce)$

=head1 DESCRIPTION

This rule accepts strings containing number with size suffixes, and return a
number with the number multiplied by the suffix multiplier, e.g.:

 2KB    -> 20248
 3.5mb  -> 3670016
 3.5Mib -> 3500000

=cut
