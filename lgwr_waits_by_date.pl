#!/usr/bin/perl

# lgwr_histogram.pl
# l

use Data::Dumper;
#use Data::TreeDumper;


my $debug = 0;
my $debug2 = 0;

my @files=@ARGV;

# scale in milliseconds
# add to this if needed, but hopefully not needed
# or adjust the values as you like, just keep them in ascending order
my @histoScales=(500,1000,2000,3000,4000,5000,6000,7000,8000,9000,10000,11000,12000,13000,14000,15000,16000,20000,30000,40000,50000,100_000,150_000,160_000,170_000,180_000,190_000);

print Dumper(\@files) if $debug;

foreach my $file (@files) {
	-r $file || die "File $file cannot be accessed - $!\n";
}

my %lgwrTime = ();
my $lgwrGT=0;

foreach my $file (@files) {

	# ugly hack here, but in a hurry
	#open F,'-|',"/bin/grep -B1 '^Warning: log write elapsed time' $file | grep -v -- '^--' " || die "cannot open grep - $!\n";
	open F,'-|',"/bin/grep -E -B1 '^Warning: log write (elapsed|broadcast wait) time' $file | grep -v -- '^--' " || die "cannot open grep - $!\n";
	my ($d,$time,$size,$date);
	my $isDate=1;
	my ($dateLine,$elapsedMsg);

	while (<F>) { 

		chomp;
		my $line=$_;

		if ($isDate) {
			$isDate = 0;
			$dateLine = $line;
			($d,$date) = split(/\s+/,$dateLine);

			# full date format with TZ, etc
			if ($date =~ /^[[:digit:]]{4}-[[:digit:]]{2}-[[:digit:]]{2}T/) {
				$date =~ s/^([[:digit:]]{4}-[[:digit:]]{2}-[[:digit:]]{2})(T[[:digit:]]{2}:[[:digit:]]{2}:[[:digit:]]{2})(.*)$/$1/e;
				$date =~ s/T/ /;
			} 
			#print "Date: $date\n";
		} else {
			$isDate = 1;
			$elapsedMsg = $line;
			if ( $elapsedMsg =~ /broadcast/ ) {
				($d,$d,$d,$d,$d,$d,$time,$d,$size) = split(/\s+/,$elapsedMsg);
			} else {
				($d,$d,$d,$d,$d,$time,$d,$size) = split(/\s+/,$elapsedMsg);
			}	
			$time =~ s/ms,//;
			$lgwrGT = $time if $time > $lgwrGT;
			#print "elapsed: $time\n\n";
			$lgwrTime{$date} += $time;
		}

	}

}


print "Longest Wait: $lgwrGT\n";


foreach my $date (sort keys %lgwrTime) {
	print "$date  $lgwrTime{$date}\n";
}




