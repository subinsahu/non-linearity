PROGRAM MAIN
USE CONSTANTS
IMPLICIT NONE

REAL*8,DIMENSION(N)::YN,YP,J_N,DW,VN
REAL*8 TIME,temp
INTEGER I,seed_size,seed1
character(len=20)::restart_file
integer,allocatable::seed(:)

READ(*,*) temp

!!!!! seeding!!!!!!!!!!!!!!!!!
call random_seed()
call random_seed(size=seed_size)
allocate (seed(seed_size))
seed=int(temp)
call random_seed(put=seed)
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

write(restart_file,'(i3 ,A13)') int(temp),"k_restart.cor"

time=0; Yp=0; yn=0; j_n=0

do while (time.le.heat_time)
      dw(1)=  k*yn(1)
      FORALL (I=2:100) dw(i)=k*(yn(i)-yn(i-1))
      CALL  BBK(YP,YN,VN,temp)
      J_N=J_N+VN*DW*DT
      TIME=TIME+DT
END DO

OPEN (UNIT=13,FILE=ADJUSTL(restart_FILE),ACCESS='APPEND',STATUS='replace')   ! DATA FILE
time =0.0
call random_seed (get=seed)
WRIte (13,*) time
WRIte (13,*) seed
WRIte (13,*) YP
WRIte (13,*) YN
WRITE (13,*) J_N
CLOSE(13)

END PROGRAM MAIN


SUBROUTINE BBK(YP,YN,VN,temp)
USE CONSTANTS
IMPLICIT NONE
REAL*8,DIMENSION(N)::YN,YF,YP,YL,YR,VN,force
REAL*8 ::RANDOM_NORMAL,RANDOM,temp,temp_i
INTEGER::I

  YL(1)=0; YR(N)=0                                                   ! FIXED BOUNDARY CONDITON
  FORALL (I=2:100) YL(I)=YN(I-1)
  FORALL (I=1:99) YR(I)=YN(I+1)


  force  =-k*(yn -yl) +k*(yr-yn )+2*a_pb*D_pb*(exp(-a_pb*yn )-1)*exp(-a_pb*yn )

DO I=1,nr
   temp_i=temp
   RANDOM=SQRT(2*gamma*KB*TEMP_i/M/DT)*RANDOM_NORMAL()
   yf(i)=yn(i)+(1.0-gamma*DT/2.0)/(1.0+gamma*DT/2.0)*(yn(i)-yp(i))&
        +1.0/(1.0+gamma*DT/2.0)*DT**2*(force(i)/m+random)                  !bbk integrator
end do

DO I=nr+1,N-nr
   TEMP_i=TEMP+(I-Nr)*TEMP_GRAD/real(N-2*Nr+1)
   RANDOM=SQRT(2*gamma*KB*TEMP_i/M/DT)*RANDOM_NORMAL()
   yf(i)=yn(i)+(1.0-gamma*DT/2.0)/(1.0+gamma*DT/2.0)*(yn(i)-yp(i))&
        +1.0/(1.0+gamma*DT/2.0)*DT**2*(force(i)/m+random)                  !bbk integrator
end do

DO I=n-nr+1,n
   temp_i=temp+temp_grad
   RANDOM=SQRT(2*gamma*KB*TEMP_i/M/DT)*RANDOM_NORMAL()
   yf(i)=yn(i)+(1.0-gamma*DT/2.0)/(1.0+gamma*DT/2.0)*(yn(i)-yp(i))&
        +1.0/(1.0+gamma*DT/2.0)*DT**2*(force(i)/m+random)                  !bbk integrator
end do


vn=(yf-yp)/(2*DT)
yp=yn
yn=yf
return
end subroutine bbk
