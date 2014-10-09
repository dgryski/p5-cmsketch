package CountMin;

use 5.014002;
use strict;
use warnings;
use Carp;

require Exporter;
use AutoLoader;

our @ISA = qw(Exporter);

our %EXPORT_TAGS = ( 'all' => [ qw(
    bfilter_add
    bfilter_clone
    bfilter_compress
    bfilter_exists
    bfilter_merge
    bfilter_new
    sketch_add
    sketch_clone
    sketch_compress
    sketch_count
    sketch_merge
    sketch_new
    sketch_values
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our $VERSION = '0.01';

require XSLoader;
XSLoader::load('CountMin', $VERSION);

1;
__END__

=head1 NAME

CountMin - Perl interface for libcmsketch

=head1 SYNOPSIS

=head1 DESCRIPTION

=head2 EXPORT

=head1 SEE ALSO

=head1 AUTHOR

Damian Gryski, E<lt>dgryski@E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2014 by Damian Gryski

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.14.2 or,
at your option, any later version of Perl 5 you may have available.

=cut
