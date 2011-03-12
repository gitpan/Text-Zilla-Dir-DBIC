package Text::Zilla::Dir::DBIC::ResultSet;
BEGIN {
  $Text::Zilla::Dir::DBIC::ResultSet::AUTHORITY = 'cpan:GETTY';
}
BEGIN {
  $Text::Zilla::Dir::DBIC::ResultSet::VERSION = '0.001';
}
# ABSTRACT: Generate a directory based on a L<DBIx::Class::ResultSet>

use Text::Zilla;
use Text::Zilla::File;
use DBIx::Class::ResultClass::HashRefInflator;
use JSON;

tzil_dir;

around BUILDARGS => sub {
	my $orig  = shift;
	my $class = shift;
	my $resultset = shift;

	die __PACKAGE__." requires a DBIx::Class::ResultSet as first parameter" if !$resultset->isa('DBIx::Class::ResultSet');

	return $class->$orig( tzil_dir_entries => $class->generate_tzil_entries($resultset) );
};

sub generate_tzil_entries {
	my ( $self, $resultset ) = @_;

	my @pri_cols = $resultset->result_source->primary_columns;
	
	my %entries;

	my $rs = $resultset->search;
	$rs->result_class('DBIx::Class::ResultClass::HashRefInflator');
	
	while (my $data = $rs->next) {
		my @pri_vals;
		for (@pri_cols) {
			push @pri_vals, $data->{$_};
		}
		my $pri_key = join('-',@pri_vals);
		$entries{$pri_key} = Text::Zilla::File->new(encode_json($data));
	}

	return \%entries;	
}

1;

__END__
=pod

=head1 NAME

Text::Zilla::Dir::DBIC::ResultSet - Generate a directory based on a L<DBIx::Class::ResultSet>

=head1 VERSION

version 0.001

=head1 AUTHOR

Torsten Raudssus <torsten@raudssus.de>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Torsten Raudssus.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

