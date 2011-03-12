use strict;
use warnings;
use Test::More;
use Test::Dirs;
use FindBin qw($Bin);
use lib "$Bin/lib";

use Test1Schema;
use DBIx::Class::ResultClass::HashRefInflator;
use Text::Zilla::Dir::DBIC;

my $dbdir = File::Temp->newdir();

my $schema = Test1Schema->connection('dbi:SQLite:'.$dbdir.'/01-simpleschema.db', '', '', { sqlite_unicode => 1});

$schema->deploy;

for (1..20) {
	$schema->populate('Table1', [
		[qw/id/],
		[$_],
	]);
}

my $dir = File::Temp->newdir();

my $root = Text::Zilla::Dir::DBIC->new($schema);
$root->tzil_to($dir);

is_dir($dir, "$Bin/result-01", 'Checking resulting directory', [], 'verbose' );

done_testing;
