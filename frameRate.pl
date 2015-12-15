#!/usr/bin/perl
use strict;	# Enforce some good programming rules

#
# frameRate.pl
# version 0.2
# 
# created 2015-12-15
# modified 2015-12-15
#
# use command line MediaInfo to determine video frame rate of media file
# 
# requires a filename passed as first command line parameter
# requires MediaInfo CLI to be installed
# 	(checks for both of these)
# 

# input is first ARGV[]
my $input_file = $ARGV[0];

# make sure an input file was specified
if ( $input_file eq undef ) { die "frameRate.pl <filename>\n\nPlease specify an input file\n"; }

# check to see if MediaInfo CLI is installed
my $MediaInfoVersion = `mediainfo --Version`;
if ( ! ( $MediaInfoVersion =~ /MediaInfoLib/ ) ) { die "MediaInfo Command Line not detected\n"; }

# run MediaInfo, parse out the <Frame_rate> tag from the first Video track and return it
my $MediaInfoOutput = `mediainfo --Output=XML \"$input_file\"`;
$MediaInfoOutput =~ /<track type=\"Video\">.*?<Frame_rate>([0-9\.]*?) fps<\/Frame_rate.*?<\/track>/gms;
print( "$1\n" );
