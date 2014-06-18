PROGRAM MAIN
USE CONSTANTS
IMPLICIT NONE

REAL*8,DIMENSION(N)::YN,YP,VN
real*8,DIMENSION(N):: Y1_av,Y2_av,Y3_av,Y4_av, JN_av, Vn_av, Wn_av
real*8,Dimension(N):: ynyl_av, ynyr_av, yn2yl_av, ynyl2_av, yn2yl2_av
real*8,DIMENSION(N):: exp_ay1_av, exp_ay2_av, exp_b_av
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

time=0; Yp=0; yn=0; y1_av=0; Y2_av=0; y3_av=0; y4_av=0
exp_ay1_av=0; exp_ay2_av=0; exp_b_av=0; jn_av=0
ynyl_av=0; ynyr_av=0;yn2yl_av=0; ynyl2_av=0; yn2yl2_av=0
 vn_av=0; wn_av=0

do while (time.le.heat_time)
      CALL  BBK(YP,YN,VN,temp)
      TIME=TIME+DT
END DO

OPEN (UNIT=13,FILE=ADJUSTL(restart_FILE),ACCESS='APPEND',STATUS='replace')   ! DATA FILE
time =0.0
   call random_seed (get=seed)
write (13,*) time
write (13,*) seed
write (13,*) YP
write (13,*) YN
write (13,*) y1_av
write (13,*) y2_av
write (13,*) y3_av
write (13,*) y4_av
write (13,*) ynyl_av
write (13,*) ynyr_av
write (13,*) yn2yl_av
write (13,*) ynyl2_av
write (13,*) yn2yl2_av
write (13,*) exp_ay1_av
write (13,*) exp_ay2_av
write (13,*) exp_b_av
write (13,*) Vn_av
write (13,*) Wn_av
write (13,*) Jn_av
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


  force  = -k*(yn-yl)*(1+rho*exp(-alp*(yn+yl))) +k*alp*rho/2.0*(yn-yl)**2*exp(-alp*(yn+yl))&
                +k*(yr-yn )*(1+rho*exp(-alp*(yr+yn )))+k*alp*rho/2.0*(yr-yn )**2*exp(-alp*(yr+yn ))&
                +2*a_pb*D_pb*(exp(-a_pb*yn )-1)*exp(-a_pb*yn)



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
