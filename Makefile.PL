
use strict;
use warnings;



use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'Generate a directory based on a L<DBIx::Class::Schema>',
  'AUTHOR' => 'Torsten Raudssus <torsten@raudssus.de>',
  'BUILD_REQUIRES' => {
    'DBD::SQLite' => '1.31',
    'File::Temp' => '0.22',
    'Test::Dirs' => '0.03',
    'Test::More' => '0.96'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.31'
  },
  'DISTNAME' => 'Text-Zilla-Dir-DBIC',
  'EXE_FILES' => [],
  'LICENSE' => 'perl',
  'NAME' => 'Text::Zilla::Dir::DBIC',
  'PREREQ_PM' => {
    'DBIx::Class' => '0.08127',
    'JSON' => '2.51',
    'Text::Zilla' => '0.002'
  },
  'VERSION' => '0.001',
  'test' => {
    'TESTS' => 't/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



