package Text::Zilla::Dir::DBIC;
BEGIN {
  $Text::Zilla::Dir::DBIC::AUTHORITY = 'cpan:GETTY';
}
BEGIN {
  $Text::Zilla::Dir::DBIC::VERSION = '0.002';
}
# ABSTRACT: Generate a directory based on a L<DBIx::Class::Schema>

use Text::Zilla;
use Text::Zilla::Dir::DBIC::ResultSet;

tzil_dir;

around BUILDARGS => sub {
	my $orig  = shift;
	my $class = shift;
	my $schema = shift;

	use Data::Dumper;
	
	die __PACKAGE__." requires a DBIx::Class::Schema as first parameter" if !$schema->isa('DBIx::Class::Schema');

	return $class->$orig( tzil_dir_entries => $class->generate_tzil_entries($schema) );
};

sub generate_tzil_entries {
	my ( $self, $schema ) = @_;
	
	my @source_names = $schema->sources;

	my %entries;
	for (@source_names) {
		$entries{$_} = Text::Zilla::Dir::DBIC::ResultSet->new($schema->resultset($_));
	}

	return \%entries;
}

1;

__END__
=pod

=head1 NAME

Text::Zilla::Dir::DBIC - Generate a directory based on a L<DBIx::Class::Schema>

=head1 VERSION

version 0.002

=head1 AUTHOR

Torsten Raudssus <torsten@raudssus.de>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Torsten Raudssus.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

