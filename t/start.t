use Test::More tests => 3;

BEGIN {
	use_ok "Time::UTC", qw(
		utc_start_segment utc_start_tai_instant utc_start_utc_day
	);
}

ok utc_start_tai_instant() == utc_start_segment()->start_tai_instant;
ok utc_start_utc_day() == utc_start_segment()->start_utc_day;
