set terminal postscript portrait color solid enhanced 'Bold-Times-Roman'
set encoding iso_8859_1

set output "fit.eps"

set xrange [10.0:40.0]
set yrange [0.0:10.0]
set size 1.0,0.5

set title "Best fit line" font "Bold-Times-Roman,20"
set xlabel "Yearly Rainfall (cm)" font "Bold-Times-Roman,18"
set ylabel "Tree ring size (mm)" font "Bold-Times-Roman,18"

f(x) = a+b*x
a = 1.8503574173712602
b = 0.13311555213937956

plot 'tree.dat',\
 f(x)
