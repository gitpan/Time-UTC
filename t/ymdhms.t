use Test::More tests => 3;

BEGIN { use_ok "Time::UTC", qw(utc_instant_to_ymdhms utc_ymdhms_to_instant); }

use Math::BigRat;

sub br(@) { Math::BigRat->new(@_) }

is_deeply [ utc_instant_to_ymdhms(br(33), br("14706.7")) ],
		[ br(1958), br(2), br(3), br(4), br(5), br("6.7") ];
is_deeply [ utc_ymdhms_to_instant(br(1958), br(2), br(3),
					br(4), br(5), br("6.7")) ],
		[ br(33), br("14706.7") ];
