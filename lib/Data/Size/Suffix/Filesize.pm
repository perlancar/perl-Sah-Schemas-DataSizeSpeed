package Data::Size::Suffix::Filesize;

# DATE
# VERSION

our %suffixes = (
    b => 1,

    k => 1024,
    kb => 1024,
    ki => 1000,
    kib => 1000,

    m => 1024*1024,
    mb => 1024*1024,
    mi => 1e6,
    mib => 1e6,

    g => 1024^3,
    gb => 1024^3,
    gi => 1e9,
    gib => 1e9,

    t => 1024^4,
    tb => 1024^4,
    ti => 1e12,
    tib => 1e12,

    p => 1024^5,
    pb => 1024^5,
    pi => 1e15,
    pib => 1e15,

    #e => 1024^6, # clashes with scientific notation
    eb => 1024^6,
    ei => 1e18,
    eib => 1e18,
);

1;
# ABSTRACT: Filesize suffixes
