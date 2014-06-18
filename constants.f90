module constants
 real*8, parameter::  k=0.04, kb=8.617e-5,a_pb=4.45,D_pb=0.04, rho=0.5, alp=0.35
real*8,parameter:: m=312e-10,temp_grad=9.3, gamma =2000
real*8,parameter:: dt=10e-6,sim_time=5e3, heat_time=1e2, measure_time=1e2
integer,parameter::n=100,nr=20
end module constants

!!      Discriptions    constants
!!!!!!    k=     coupling constant
!!!!!!    Da=  onsite force constant
!!!!!!    sim_time= Actual simulation time
!!!!!!    heat_time=pre heating time
!!!!!!    n= number of lattice point
!!!!!    m= mass
!!!!!    kb= boltzman constant
