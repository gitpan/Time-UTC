use Test::More tests => 36*8 + 7;

BEGIN {
	use_ok "Time::UTC", qw(
		utc_start_segment utc_day_leap_seconds utc_day_seconds
	);
}

{
	no warnings "redefine";
	sub Time::UTC::Segment::_download_latest_data() { }
}

my $seg = utc_start_segment();

eval { utc_day_leap_seconds($seg->start_utc_day - 1); };
like $@, qr/\Aday \d+ precedes the start of UTC /;
eval { utc_day_seconds($seg->start_utc_day - 1); };
like $@, qr/\Aday \d+ precedes the start of UTC /;

for(my $n = 36; $n--; $seg = $seg->next) {
	ok utc_day_leap_seconds($seg->start_utc_day) == 0;
	ok utc_day_seconds($seg->start_utc_day) == 86400;
	ok utc_day_leap_seconds($seg->start_utc_day + 1) == 0;
	ok utc_day_seconds($seg->start_utc_day + 1) == 86400;
	ok utc_day_leap_seconds($seg->last_utc_day - 1) == 0;
	ok utc_day_seconds($seg->last_utc_day - 1) == 86400;
	ok utc_day_leap_seconds($seg->last_utc_day) == $seg->leap_utc_seconds;
	ok utc_day_seconds($seg->last_utc_day) == $seg->last_day_utc_seconds;
}

eval { utc_day_leap_seconds($seg->start_utc_day); };
like $@, qr/\Aday \d+ has no UTC definition yet /;
eval { utc_day_seconds($seg->start_utc_day); };
like $@, qr/\Aday \d+ has no UTC definition yet /;
eval { utc_day_leap_seconds($seg->start_utc_day + 1); };
like $@, qr/\Aday \d+ has no UTC definition yet /;
eval { utc_day_seconds($seg->start_utc_day + 1); };
like $@, qr/\Aday \d+ has no UTC definition yet /;
