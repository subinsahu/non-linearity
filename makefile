plot:
	gfortran arrange.f90 -o arrange
	./arrange
	gnuplot plot.p

time_0k:
	gnuplot -e "in_file='0k.dat'; out_file='time_0k.jpg'" time_curve.p
time_100k:
	gnuplot -e "in_file='100k.dat'; out_file='time_100k.jpg'" time_curve.p
time_200k:
	gnuplot -e "in_file='200k.dat'; out_file='time_200k.jpg'" time_curve.p
time_300k:
	gnuplot -e "in_file='300k.dat'; out_file='time_300k.jpg'" time_curve.p
time_400k:
	gnuplot -e "in_file='400k.dat'; out_file='time_400k.jpg'" time_curve.p
time_500k:
	gnuplot -e "in_file='500k.dat'; out_file='time_500k.jpg'" time_curve.p
time_600k:
	gnuplot -e "in_file='600k.dat'; out_file='time_600k.jpg'" time_curve.p


time_all:
	gnuplot -e "in_file='0k.dat'; out_file='time_0k.jpg'" time_curve.p
	gnuplot -e "in_file='25k.dat'; out_file='time_25k.jpg'" time_curve.p
	gnuplot -e "in_file='50k.dat'; out_file='time_50k.jpg'" time_curve.p
	gnuplot -e "in_file='75k.dat'; out_file='time_75k.jpg'" time_curve.p
	gnuplot -e "in_file='100k.dat'; out_file='time_100k.jpg'" time_curve.p
	gnuplot -e "in_file='125k.dat'; out_file='time_125k.jpg'" time_curve.p
	gnuplot -e "in_file='150k.dat'; out_file='time_150k.jpg'" time_curve.p
	gnuplot -e "in_file='175k.dat'; out_file='time_175k.jpg'" time_curve.p
	gnuplot -e "in_file='200k.dat'; out_file='time_200k.jpg'" time_curve.p
	gnuplot -e "in_file='225k.dat'; out_file='time_225k.jpg'" time_curve.p
	gnuplot -e "in_file='250k.dat'; out_file='time_250k.jpg'" time_curve.p
	gnuplot -e "in_file='275k.dat'; out_file='time_275k.jpg'" time_curve.p
	gnuplot -e "in_file='300k.dat'; out_file='time_300k.jpg'" time_curve.p
	gnuplot -e "in_file='325k.dat'; out_file='time_325k.jpg'" time_curve.p
	gnuplot -e "in_file='350k.dat'; out_file='time_350k.jpg'" time_curve.p
	gnuplot -e "in_file='375k.dat'; out_file='time_375k.jpg'" time_curve.p
	gnuplot -e "in_file='400k.dat'; out_file='time_400k.jpg'" time_curve.p
	gnuplot -e "in_file='425k.dat'; out_file='time_425k.jpg'" time_curve.p
	gnuplot -e "in_file='450k.dat'; out_file='time_450k.jpg'" time_curve.p
	gnuplot -e "in_file='475k.dat'; out_file='time_475k.jpg'" time_curve.p
	gnuplot -e "in_file='500k.dat'; out_file='time_500k.jpg'" time_curve.p
	gnuplot -e "in_file='525k.dat'; out_file='time_525k.jpg'" time_curve.p
	gnuplot -e "in_file='550k.dat'; out_file='time_550k.jpg'" time_curve.p
	gnuplot -e "in_file='575k.dat'; out_file='time_575k.jpg'" time_curve.p
	gnuplot -e "in_file='600k.dat'; out_file='time_600k.jpg'" time_curve.p

