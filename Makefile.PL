use 5.014002;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME            => 'CountMin',
    VERSION_FROM    => 'lib/CountMin.pm',
    PREREQ_PM       => {},
    ABSTRACT_FROM   => 'lib/CountMin.pm',
    AUTHOR          => 'Damian Gryski <dgryski@>',
    #LIBS           => ['-L../libcmsketch -lcmsketch'], # e.g., '-lm'
    DEFINE          => '', # e.g., '-DHAVE_SOMETHING'
    INC             => '-I.', # e.g., '-I. -I/usr/include/other'
    # this is supposing that libcmsketch has been built in ../libcmsketch
    # (see <https://github.com/dgryski/libcmsketch>)
    OBJECT          => 'CountMin.o ../libcmsketch/bf.o ../libcmsketch/cm.o ../libcmsketch/hash.o',
);
