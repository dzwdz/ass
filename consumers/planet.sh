#!/bin/sh
# a simple planet-like assgregator

FEEDS="https://elly.town/recent.txt https://tilde.town/~opfez/blog_ass.ass"

echo "<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>planet assgregator</title>
</head>
<body>
<ul>"

curl --no-progress-meter $FEEDS | grep -v ^# | sort -ur \
 | awk -F"\t" '{print "<li>", $1, "<a href=\"", $2, "\">", $2, "</a>"; $1=$2=""; print $3, "</li>"}'

echo "</ul><hr /><pre>"

# prints the source
cat $0 | sed -e 's/&/\&amp;/g' | sed -e 's/</\&lt;/g' | sed -e 's/>/\&gt;/g'
