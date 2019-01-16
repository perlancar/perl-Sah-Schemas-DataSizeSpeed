package Data::Sah::Coerce::perl::float::str_suffix_filesize;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

use Data::Size::Suffix::Filesize;
use Data::Dmp;

sub meta {
    +{
        v => 3,
        enable_by_default => 0,
        prio => 50,
        precludes => [qr/\Astr_suffix_(\w+)\z/],
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
        "[undef, \$1 * \$Data::Size::Suffix::Filesize::suffixes{(lc \$2)}]",
    );

    $res;
}

1;
# ABSTRACT: Parse number from string containing size suffixes

=for Pod::Coverage ^(meta|coerce)$

=head1 DESCRIPTION

This rule accepts strings containing number with size suffixes, and return a
number with the number multiplied by the suffix multiplier, e.g.:

 2KB    -> 20248
 3.5mb  -> 3670016
 3.5Mib -> 3500000

The rule is not enabled by default. You can enable it in a schema using e.g.:

 ["float", "x.perl.coerce_rules"=>["str_suffix_filesize"]]

=cut
