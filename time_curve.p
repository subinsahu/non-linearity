set autoscale
unset log
unset label
set title 'time curve PBD model'
set xlabel 'time (micro seconds)'
set ylabel 'j(pw)'
#set yrange [0:]
f(x)=0
set term jpeg
set output out_file
   plot  in_file using (160*$50) every 16::15 with linespoints title "cumulative average current"#,f(x)
