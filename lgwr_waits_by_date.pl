#!/usr/bin/perl

# lgwr_histogram.pl
# l

use Data::Dumper;
#use Data::TreeDumper;

sub normalize($@);

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

my @lgwrTime = ();
my $lgwrGT=0;

foreach my $file (@files) {
	open F,'<',"$file" || die "cannot open $file - $!\n";
	my @x=grep (/^Warning: log write elapsed time/,<F>);
	chomp @x;
	my ($d,$time,$size);
	foreach my $line (@x) {
		($d,$d,$d,$d,$d,$time,$d,$size) = split(/\s+/,$line);
		$time =~ s/ms,//;
		$lgwrGT = $time if $time > $lgwrGT;
		push @lgwrTime , $time;
	}
	print Dumper(\@x) if $debug;	
	
}

print Dumper(\@lgwrTime) if $debug2;

print "Longest Wait: $lgwrGT\n" if $debug2;

# find first element GT longest wait and trim list
my $lastEl=0;
foreach my $i (0.. $#histoScales) {

	#print "$i\n";
	$lastEl = $i;
	last if $histoScales[$i] > $lgwrGT;
	
}

print "$lastEl\n" if $debug2;
print "$histoScales[$lastEl]\n" if $debug2;
@histoScales = @histoScales[0 .. $lastEl];

print Dumper(\@histoScales) if $debug2;

# now create the histogram hash

my %histo = map { $_ => 0 } @histoScales;

if ($debug2) {
	print "\n\%histo\n";
	print Dumper(\%histo);
}

# populate 

foreach my $time (@lgwrTime) {
	my $ntime = normalize($time,@histoScales);
	print "time: $time        ntime: $ntime\n" if $debug2;
	$histo{$ntime}++;
}

print Dumper(\%histo) if $debug2;

foreach my $time ( sort  {$a <=> $b}  keys %histo ) {
	printf  "%8s  %8d\n", $time, $histo{$time};
}

sub normalize ($@) {
	my $time = shift @_;
	my @scales = @_;
	my $ntime;
	my $lastEl;
	foreach my $i (0 .. $#scales) {
		$lastEl = $i;
		last if $scales[$i] >= $time;
	}

	$scales[$lastEl];
}



