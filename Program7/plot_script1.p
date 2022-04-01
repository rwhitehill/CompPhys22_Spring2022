set terminal png size 1000,800 enhanced font "Helvetica,20"
set output 'output1.png'

set xlabel "t (days)"
set ylabel "N (sperm count)"
set xrange [0:3]

plot "ODE_data.dat" with lines title 'rate: 1500/second', \
     "ODE_data.dat" using 1:3 with lines title 'rate: 500/second', \
     "ODE_data.dat" using 1:4 with lines title 'rate: 100/second', \
