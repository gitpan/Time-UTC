use ExtUtils::MakeMaker;

WriteMakefile(
	NAME => "Time::UTC",
	VERSION_FROM => "lib/Time/UTC.pm",
	PREREQ_PM => {
		LWP => "5.5394",
		LWP::UserAgent => 0,
		Math::BigRat => "0.08",
		Time::Unix => "1.02",
	},
);
