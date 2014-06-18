set autoscale
set logscale y
unset label
set title 'heat current'
set xlabel 'Temp (k)'
set ylabel 'log j(pw)'
#set yrange [-2:7]
set term jpeg
set output 'log-pb.jpg'
   plot 'plot.dat' using 1:(160*$2)  with linespoint title "2 site pb  model"