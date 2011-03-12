package # trick 17
	Test1Schema::Result::Table1;
use base qw/DBIx::Class::Core/;
__PACKAGE__->table('table1');
__PACKAGE__->add_columns(qw/ id /);
__PACKAGE__->set_primary_key('id');

1;