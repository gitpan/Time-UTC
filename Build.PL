use warnings;
use strict;
no strict "subs";

use Module::Build;

Module::Build->new(
	module_name => "Time::UTC",
	license => "perl",
	build_requires => {
		Math::BigRat => 0.04,
		Module::Build => 0,
		Test::More => 0,
		perl => "5.006",
		strict => 0,
		warnings => 0,
	},
	requires => {
		Carp => 0,
		Digest::SHA1 => 0,
		Exporter => 0,
		LWP => "5.5394",
		LWP::UserAgent => 0,
		Math::BigRat => "0.08",
		Time::Unix => "1.02",
		base => 0,
		constant => 0,
		integer => 0,
		perl => "5.006",
		strict => 0,
		warnings => 0,
	},
	dynamic_config => 0,
	meta_add => { distribution_type => "module" },
	create_makefile_pl => "passthrough",
	sign => 1,
)->create_build_script;

exit 0;
