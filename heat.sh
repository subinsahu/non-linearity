# !/bin/bash
for i in `seq 0 25 600`
do
gfortran constants.f90 random.f90 heat.f90  -o $i
echo $i | ./$i
rm $i
done

