package CPANDB::Generator::GetIndex;

# This support class generates the CPAN::SQLite database into a particular
# directory. We need to do it outside the main process because it takes a
# bunch of locks (on Windows) which it doesn't release till the end of the
# process.

use strict;
use Carp                      ();
use Process::Delegatable 0.26 ();
use Process::Storable    0.26 ();
use Process              0.26 ();
use CPAN::SQLite        0.197 ();

use vars qw{$VERSION @ISA @DELEGATE};
BEGIN {
	$VERSION  = '0.01';
	@ISA      = qw{
		Process::Delegatable
		Process::Storable
		Process
	};
	@DELEGATE = ();

	# Automatically handle delegation within the test suite
	if ( $ENV{HARNESS_ACTIVE} ) {
		require Probe::Perl;
		@DELEGATE = (
			Probe::Perl->find_perl_interpreter, '-Mblib',
		);
	}
}






#####################################################################
# Constructor and Accessors

sub new {
	my $class = shift;
	my $self  = bless { @_ }, $class;
	return $self;
}

sub cpan {
	$_[0]->{cpan};
}

sub run {
	my $self = shift;

	local $SIG{__WARN__} = sub { };
	CPAN::SQLite->new(
		CPAN   => $self->cpan,
		db_dir => $self->cpan,
	)->index( setup => 1 );

	return 1;
}

sub delegate {
	my $self = shift;
	unless ( $self->{delegated} ) {
		$self->SUPER::delegate( @DELEGATE );
		$self->{delegated} = 1;
	}
	return 1;
}

sub delegated {
	$_[0]->{delegated};
}

1;
