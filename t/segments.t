use Test::More tests => 37*8 + 10;

BEGIN { use_ok "Time::UTC", qw(utc_start_segment); }

{
	no warnings "redefine";
	sub Time::UTC::Segment::_download_latest_data() { }
}

my $seg = utc_start_segment();

for(my $n = 37; $n--; $seg = $seg->next) {
	ok $seg->length_in_tai_seconds ==
		$seg->end_tai_instant - $seg->start_tai_instant;
	ok $seg->last_utc_day + 1 == $seg->end_utc_day;
	ok $seg->last_day_utc_seconds == 86400 + $seg->leap_utc_seconds;
	ok $seg->length_in_utc_seconds ==
		86400 * ($seg->last_utc_day - $seg->start_utc_day) +
			$seg->last_day_utc_seconds;
	ok $seg->length_in_tai_seconds ==
		$seg->length_in_utc_seconds * $seg->utc_second_length;
	ok $seg->next->prev == $seg;
	ok $seg->end_tai_instant == $seg->next->start_tai_instant;
	ok $seg->end_utc_day == $seg->next->start_utc_day;
}

ok $seg->utc_second_length == 1;
foreach my $method (qw(length_in_tai_seconds end_tai_instant last_utc_day
		end_utc_day leap_utc_seconds last_day_utc_seconds
		length_in_utc_seconds next)) {
	eval { $seg->$method; };
	like $@, qr/\Adata not available yet /;
}
