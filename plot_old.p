set autoscale
unset log
unset label
set title 'absolute thermal resistance and nonlinearity'
set xlabel 'Temp (k)'
set ylabel 'epsilon, resistance(k/pw)'
   set logscale y
#   set logscale x
#set yrange [-2:7]
set term jpeg
set output 'non_lineality_new.jpg'
   set arrow from 150,.01 to 150,10000 nohead 
   plot  './plot.dat'  using 1:(abs($2))  every ::0::6 with linespoint title "ep11", './plot.dat' using 1:(abs($3)) every ::0::6  with linespoint title "ep12", './plot.dat'  using 1:(abs($4))  every ::6 with linespoint title "ep21", './plot.dat' using 1:(abs($5)) every ::6  with linespoint title "ep22", './plot.dat' using 1:(9.3/$6/160) with linespoint title "thermal resistance",  './plot.dat'  using 1:(abs($2)+abs($3))  every ::0::6 with linespoint title "ep1", './plot.dat' using 1:(abs($4)+abs($5)) every ::6  with linespoint title "ep2",
