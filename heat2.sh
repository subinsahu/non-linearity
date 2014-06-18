#!/bin/bash
#########################################
for i in `seq 175 25 300`
do
    gfortran constants.f90 random.f90 heat.f90  -o $i -O3
    echo $i | ./$i
    rm $i
done

#########################################
