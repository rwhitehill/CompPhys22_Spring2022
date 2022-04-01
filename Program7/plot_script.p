set terminal png size 1000,800 enhanced font "Helvetica,20"
set output 'output.png'

set xlabel "t (days)"
set ylabel "N (sperm count)"
set xrange [0:3]

plot "ODE_data.dat" with lines title 'half-life: 5 days', \
     "ODE_data.dat" using 1:3 with lines title 'half-life: 2 days', \
     "ODE_data.dat" using 1:4 with lines title 'half-life: 8 hours', \
