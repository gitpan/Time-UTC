use Test::More tests => 24;

BEGIN { use_ok "Time::UTC", qw(utc_secs_to_hms utc_hms_to_secs); }

use Math::BigRat;

sub br(@) { Math::BigRat->new(@_) }

eval { utc_secs_to_hms(br("-0.1")); };
like $@, qr/\Acan't have negative seconds in a day /;

foreach my $hr (br(-1), br(24), br("0.5")) {
	eval { utc_hms_to_secs($hr, br(0), br(0)); };
	like $@, qr/\Ainvalid hour number /;
}
foreach my $mi (br(-1), br(60), br("0.5")) {
	eval { utc_hms_to_secs(br(0), $mi, br(0)); };
	like $@, qr/\Ainvalid minute number /;
	eval { utc_hms_to_secs(br(23), $mi, br(0)); };
	like $@, qr/\Ainvalid minute number /;
}
foreach my $sc (br(-1), br(60)) {
	eval { utc_hms_to_secs(br(0), br(0), $sc); };
	like $@, qr/\Ainvalid second number /;
}
eval { utc_hms_to_secs(br(23), br(59), br(-1)); };
like $@, qr/\Ainvalid second number /;

sub check($$$$) {
	my($secs, $hr, $mi, $sc) = @_;
	is_deeply [ utc_secs_to_hms($secs) ], [ $hr, $mi, $sc ];
	is utc_hms_to_secs($hr, $mi, $sc), $secs;
}

check(br(0), br(0), br(0), br(0));
check(br("3723.4"), br(1), br(2), br("3.4"));
check(br("86399.9"), br(23), br(59), br("59.9"));
check(br(86400), br(23), br(59), br(60));
check(br("86400.1"), br(23), br(59), br("60.1"));
