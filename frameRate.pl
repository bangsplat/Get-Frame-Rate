#!/usr/bin/perl
use strict;	# Enforce some good programming rules

#
# frameRate.pl
# version 1.0
# 
# created 2015-12-15
# modified 2015-12-15
# 
# created by Theron Trowbridge
#
# use command line MediaInfo to determine video frame rate of media file
# 
# requires a filename passed as first command line parameter
# requires MediaInfo CLI to be installed
# 	(checks for both of these)
# 

# input is first command line parameter
# make sure an input file was specified
my $input_file = $ARGV[0];
if ( $input_file eq undef ) { die "frameRate.pl <filename>\n\nPlease specify an input file\n"; }

# check to see if MediaInfo CLI is installed
my $MediaInfoVersion = `mediainfo --Version`;
if ( ! ( $MediaInfoVersion =~ /MediaInfoLib/ ) ) { die "MediaInfo Command Line not detected\n"; }

# run MediaInfo, parse out the <Frame_rate> tag from the first Video track and return it
my $MediaInfoOutput = `mediainfo --Output=XML \"$input_file\"`;
$MediaInfoOutput =~ /<track type=\"Video\">.*?<Frame_rate>([0-9\.]*?) fps<\/Frame_rate.*?<\/track>/gms;
print( "$1\n" );
