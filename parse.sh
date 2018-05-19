#!/bin/bash
PARSECMD=/path/to/my/work/admin2html.pl

## in case you want to send it by mail#########
SMTPCMD=/usr/bin/email
SMTPFROMADDR="$fromaddress"
SMTPTO="$sendtoadres"
SMTPSRV="your smtp relay/server"
################################################

HEAD="<html>
 <head>
  <style>
table.parse td.statusAlert { color:red;}
table.parse td.statusChange { color:green;}
table.parse td.statusNotice { color:blue;}
table.parse { border-collapse:collapse; }
table.parse, table.parse td, table.parse th { border:1px solid black; }
table.watcher td.filename { text-align:left;}
  </style>
 </head>
 <body>"
FOOTER=" </body>
</html>"
TODAY=$(date +"%Y%m%d")

HTMLTABLE="<table class='parse'><tr>$nameoftable</tr><tr><th>Date/Time</th><th>VPN</th><th>Source</th><th>User</th><th>$Message</th></tr>"

file="your file"
filename=$(find $LOGPPDIR -name "$file-$TODAY-*")

HTMLTABLE=$HTMLTABLE$(gzip -dc $filename | $PARSECMD)

HTMLTABLE=$HTMLTABLE"</table>"
HTML="$HEAD $HTMLTABLE1 <br> $HTMLTABLE <br> $FOOTER"


## If you have several files you can use the following :
#for file1 in $file01 $file02 $file03 $file04; do
#        filename1=$(find $LOGDIR -name "$file1-$TODAY-*")
#
#        HTMLTABLE1=$HTMLTABLE1$(gzip -dc $filename1 | $PARSECMD)
#done
#        HTMLTABLE1=$HTMLTABLE1"</table>"
#
#HTML="$HEAD $HTMLTABLE1 <br> $HTMLTABLE <br> $FOOTER"
# Send Mail
echo "$HTML" | $SMTPCMD -from-addr $SMTPFROMADDR -html -subject "PulseSecureEvents $(hostname) parser $(date +"%Y-%m-%d")" -smtp-server $SMTPSRV $SMTPTO
if [ $ERR != 0 ]; then
        exit 1
fi
exit 0

