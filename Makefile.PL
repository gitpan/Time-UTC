use ExtUtils::MakeMaker;

WriteMakefile(
	NAME => "Time::UTC",
	VERSION_FROM => "lib/Time/UTC.pm",
	PREREQ_PM => {
		"LWP" => "5.53_94",
		"LWP::UserAgent" => undef,
		"Math::BigRat" => "0.08",
		"Time::Unix" => "1.02",
	},
);
