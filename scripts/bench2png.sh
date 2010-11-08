#!/bin/sh
#
# My modifications to bench2graph which is distributed as part of the autobench library.
#
# Original script written by Samuel Dupas <samuel.dupas@synaptique.co.uk>
#
# This script was made more portable by prefering usage of printf over echo -n which apparently
# didn't work on osx. Also, to support gnuplot 4.4.0,
#   s/data style linespoints/style data linespoints/
# The script also generates a png image file as opposed to a postscript (ps) file
#
# - Doug Tangren (softprops)

if [ $# -lt 2 ] ; then
    echo "Usage          : bench2graph PARAM_1 PARAM_2 [ PARAM_3 ... PARAM_N ]"
    echo "Parameter 1    : autobench results file"
    echo "Parameter 2    : name of the postscript output file"
    echo "Parameter 3..N : [optional] columns to display in the graphic"
    exit 1
fi

if [ ! -f $1 ] ; then
    echo "Incorrect file format"
    exit 2
fi

if [ -f ${2} ] ; then
    echo "File ${2} already exist"
    exit 3
fi

input=$1
shift

output=$1
if [ `echo $output |cut -c 1` != '/' ] ; then
	output=`pwd`/$output
fi
shift

while [ $# -ne 0 ] ; do
    liste="$liste,$1,"
    shift
done


printf "Enter the title : "
read title

if [ ! -d /tmp/graph_script ] ; then
    mkdir /tmp/graph_script
fi
mkdir /tmp/graph_script/$$

cp $input /tmp/graph_script/$$/results.tsv
cd /tmp/graph_script/$$

nblines=`cat results.tsv | wc -l`
nblines=`expr $nblines - 1`


legend=`head -1 results.tsv`
i=1
for col in $legend ; do
    if [ $i -ne 1 ] ; then
	if [ `echo -n $liste | wc -c` -eq 0 ] ; then
	    tail -$nblines results.tsv | gawk '{print $1 " " $line}' line=$i > $col
	    files="$files $col" 
	elif `echo $liste | grep ",${i}," > /dev/null` ; then
	    tail -$nblines results.tsv | gawk '{print $1 " " $line}' line=$i > $col
	    files="$files $col"
	fi
    fi
    i=`expr $i + 1`
done

echo set terminal png xffffff > gnuplot.cmd
echo set key outside below >> gnuplot.cmd
echo set key box >> gnuplot.cmd
echo set grid >> gnuplot.cmd
echo set output \"${output}\" >> gnuplot.cmd
echo set style data linespoints >> gnuplot.cmd
echo set title \"$title\" >> gnuplot.cmd
printf plot >> gnuplot.cmd
j=0
for col in $files ; do
    if [ $j -ne 0 ] ; then
	printf "," >> gnuplot.cmd
    fi
    printf " \"${col}\"" >> gnuplot.cmd
    j=`expr $j + 1`
done
echo >> gnuplot.cmd
cat gnuplot.cmd
gnuplot  gnuplot.cmd


rm -rf /tmp/graph_script/$$