set terminal postscript portrait color solid enhanced 'Bold-Times-Roman'
set encoding iso_8859_1

set output "res.eps"

set xrange [10.0:40.0]
set yrange [-5.0:5.0]
set size 1.0,0.5

set title "Residuals" font "Bold-Times-Roman,20"
set xlabel "Yearly Rainfall (cm)" font "Bold-Times-Roman,18"
set ylabel "Residual Tree ring size (mm)" font "Bold-Times-Roman,18"

f(x) = a+b*x
a = 1.8503574173712602
b = 0.13311555213937956

plot \
    'tree.dat' using 1:($2 - f($1)), \
    0 dashtype 2
