#!/bin/perl
use strict;
use Switch;
use HTML::Entities;

my $line=0;
my @fields;
my %codes= (
        "ADM20466" => 2, # Turn on tcpdump
        "ADM22668" => 0, # Login succeeded for
        "ADM23573" => 0, # Admin TACACS logged out
        "ARC22058" => 0, # Archive Admin Access log
        "AUT30684" => 0, # authentication successful
        "ADM24223" => 1, # web profile modified
        "ADM22671" => 0, # Logout from
        "ADM20664" => 0, # Session timed out for
        "ADM22862" => 0, # User Accounts modified. Removed
        "ADM20716" => 0, # User Accounts modified. Added
        "ADM10265" => 1, # Extra Action in Policy modified
        "ADM10259" => 1, # Resources in Policy modified
        "ADM10257" => 1, # Policy deleted
        "ADM22818" => 0, # MAX session timeout
        "AUT30616" => 0, # Source IP realm restrictions successfully passed for
        "ADM22668" => 0, # Login suceeded
        "ADM20599" => 1, # policy tracing log cleared
        "PTR10241" => 1, # policy tracing turned off
        "PTR10240" => 1, # policy tracing turned on
        "ADM10256" => 1, # policy created
        "ADM20296" => 0, # radius
        "ADM20301" => 0, # radius
        "ADM20447" => 1, # configuration exported
        "ADM20456" => 1, # configuration imported
        "ADM20640" => 2, # server shutdown requested
        "ADM22901" => 1, # system status changed
        "ADM22907" => 1, # pushed configuration installed
        "ADM23534" => 1, # forcing off user
        "ADM24385" => 1, # warning required template variable
        "ADM24397" => 0, # package version
        "ADM24401" => 1, # added job
        "ADM24405" => 1, # starting push of entire configuration
        "ADM24406" => 1, # push of entire configuration status
        "ADM31113" => 1, # entire configuration received
        "ADM31218" => 1, # updated
        "ARC22057" => 1, # admin saved new archive
        "AUT23458" => 0, # Login failed
        "DAS31035" => 1, # dashboard reporting enabled
);

sub formatstring {
        my $str = shift;

        if ($str=~/^"/) {
                $str=~s/^.(.*).$/$1/;
        }
        return encode_entities($str);
}

while (<STDIN>) {
        if ($line==0) {
                my @header=m[([^ =]+)=("[^"]*"|\S*)]g;
        }

        my %record = m[([^ =]+)=("[^"]*"|\S*)]g;


if (exists $codes{$record{'id'}}) {

        switch ($codes{$record{'id'}}) {

                case 2 {
                        print "<tr bgcolor='#E9967A'><td>".formatstring($record{'time'})."</td><td>$record{vpn}</td><td>$record{src}</td><td>$record{user}</td><td>".formatstring($record{'msg'})."</td></tr>\n";
                }

                case 1 {
                        print "<tr bgcolor='#00FFFF'><td>".formatstring($record{'time'})."</td><td>$record{vpn}</td><td>$record{src}</td><td>$record{user}</td><td>".formatstring($record{'msg'})."</td></tr>\n";
                }

                case 0 {
                        print "<tr bgcolor='#F5F5DC'><td>".formatstring($record{'time'})."</td><td>$record{vpn}</td><td>$record{src}</td><td>$record{user}</td><td>".formatstring($record{'msg'})."</td></tr>\n";
                }

        }


        }

        $line++;
