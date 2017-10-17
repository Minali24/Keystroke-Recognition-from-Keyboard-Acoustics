#!/usr/bin/env perl

$in_list = $ARGV[0];

open IL, $in_list;

while ($l = <IL>)
{
	chomp($l);
	$l =~ s/\.wav//;
	$trans = $l;
	#$trans =~ s/0/NO/g;
	#$trans =~ s/1/YES/g;
	#$trans =~ s/\_/ /g;
	#$trans =~ 's/.*_\(.*\)/\1/g'
	$trans =~ s/y.*/y/g;
	$trans =~ s/a[^ce]*\.wav/a/g;
	$trans =~ s/l.*/l/g;
	$trans =~ s/space.*/space/g;
	print "$l $trans\n";
}
