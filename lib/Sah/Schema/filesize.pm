package Sah::Schema::filesize;

# DATE
# VERSION

our $schema = ['float' => {
    summary => 'File size',
    description => <<'_',

Float, in bytes.

Can be coerced from string that contains units, e.g.:

    2KB   -> 2048      (kilobyte, 1024-based)
    2mb   -> 2097152   (megabyte, 1024-based)
    1.5K  -> 1536      (kilobyte, 1024-based)
    1.6ki -> 1600      (kibibyte, 1000-based)

_
    min => 0,
    'x.perl.coerce_rules' => ['str_suffix_filesize'],
}, {}];

1;

# ABSTRACT:
