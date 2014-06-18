set autoscale
unset log
unset label
set title 'resistivity vs temperature'
set xlabel 'Temp (k)'
set ylabel 'log(resistivity)/log(epsilon)'
   set logscale y
   set logscale x
#set yrange [-2:7]
set term jpeg
set output 'non_lineality.jpg'
   plot  './plot.dat'  using 1:2  every ::0::13 with linespoint title "ep1", './plot.dat' using 1:3 every ::13  with linespoint title "ep2", './plot.dat' using 1:(1/$4/1000) with linespoint title "resistivity"
