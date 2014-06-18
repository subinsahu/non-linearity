PROGRAM MAIN
USE CONSTANTS
IMPLICIT NONE

REAL*8,DIMENSION(N)::YN,YP,DW,VN,yl,yr
real*8,DIMENSION(N):: Y1_av,Y2_av,Y3_av,Y4_av, JN_av, Vn_av, Wn_av
real*8,Dimension(N):: ynyl_av, ynyr_av, yn2yl_av, ynyl2_av,yn2yl2_av
real*8,DIMENSION(N):: exp_ay1_av, exp_ay2_av,exp_b_av
REAL*8 TIME,time1,temp
INTEGER I,seed_size
CHARACTER(LEN=12)::FILE_NAME
character(len=20)::restart_file
integer,allocatable::seed(:)

READ(*,*) temp
call random_seed(size=seed_size)
allocate (seed(seed_size))

write(file_name,'(i3 ,A5)') int(temp),"k.dat"
write(restart_file,'(i3 ,A13)') int(temp),"k_restart.cor"

open(unit=10,file=adjustl(restart_file),action='read',status='old')
read (10,*) time
read (10,*) seed
read (10,*) YP
read (10,*) YN
read (10,*) y1_av
read (10,*) y2_av
read (10,*) y3_av
read (10,*) y4_av
read (10,*) ynyl_av
read (10,*) ynyr_av
read (10,*) yn2yl_av
read (10,*) ynyl2_av
read (10,*) yn2yl2_av
read (10,*) exp_ay1_av
read (10,*) exp_ay2_av
read (10,*) exp_b_av
read (10,*) Vn_av
read (10,*) Wn_av
read (10,*) Jn_av

close(10)



do while (time.le.sim_time)
   time1=0
   do while (time1.le.measure_time)

      dw(1)= k*yn(1)*(1+rho*exp(-alp*yn(1) )) -k*alp*rho/2.0*yn(1)**2*exp(-alp*yn(1))
      FORALL (I=2:100) dw(i)= k*(yn(i)-yn(i-1))*(1+rho*exp(-alp*(yn(i)+yn(i-1))))&
           -k*alp*rho/2.0*(yn(i)-yn(i-1))**2*exp(-alp*(yn(i)+yn(i-1)))
      CALL  BBK(YP,YN,VN,temp)
      yl=(/ 0.0d0 ,Yn(1:n-1)/)
      yr=(/ Yn(2:n), 0.0d0/)
      TIME1=TIME1+DT
      y1_av=(y1_av*(time+time1-dt)+YN*dt)/(time+time1)
      y2_av=(y2_av*(time+time1-dt)+YN**2*dt)/(time+time1)
      y3_av=(y3_av*(time+time1-dt)+YN**3*dt)/(time+time1)
      y4_av=(y4_av*(time+time1-dt)+YN**4*dt)/(time+time1)
      ynyl_av=(ynyl_av*(time+time1-dt)+YN*yl*dt)/(time+time1)
      ynyr_av=(ynyr_av*(time+time1-dt)+YN*yr*dt)/(time+time1)
      yn2yl_av=(yn2yl_av*(time+time1-dt)+YN**2*yl*dt)/(time+time1)
      ynyl2_av=(ynyl2_av*(time+time1-dt)+YN*yl**2*dt)/(time+time1)
      yn2yl2_av=(yn2yl2_av*(time+time1-dt)+YN**2*yl**2*dt)/(time+time1)
      exp_ay1_av=(exp_ay1_av*(time+time1-dt)+exp(-a_pb*yn)*dt)/(time+time1)
      exp_ay2_av=(exp_ay2_av*(time+time1-dt)+exp(-2.0*a_pb*yn)*dt)/(time+time1)
      exp_b_av=(exp_b_av*(time+time1-dt)+exp(-alp*(yn+yl))*(yn-yl)**2*dt)/(time+time1)
      vN_AV=(vN_AV*(TIME+TIME1-DT)+(D_pb*(exp(-a_pb*yn)-1.0)**2)* dt)/(time+time1)
      wN_AV=(wN_AV*(TIME+TIME1-DT)+(k/2.0*(1.0+rho*exp(-alp*(yn+yl)))*(YN-Yl)**2)*dt)/(time+time1)
      JN_AV=(JN_AV*(TIME+TIME1-DT)+VN*DW*dt)/(time+time1)

   end do
   time=time+time1
   OPEN (UNIT=12,FILE=ADJUSTL(FILE_NAME),ACCESS='APPEND',STATUS='unknown')   ! DATA FILE
   WRIte (12,*) time
   WRIte (12,*) y1_av
   WRIte (12,*) y2_av
   WRIte (12,*) y3_av
   WRIte (12,*) y4_av
   WRIte (12,*) ynyl_av
   WRIte (12,*) ynyr_av
   WRIte (12,*) yn2yl_av
   WRIte (12,*) ynyl2_av
   WRIte (12,*) yn2yl2_av
   WRIte (12,*) exp_ay1_av
   WRIte (12,*) exp_ay2_av
   WRIte (12,*) exp_b_av
   WRIte (12,*) Vn_av
   WRIte (12,*) wn_av
   WRIte (12,*) Jn_av
   CLOSE(12)
   
   OPEN (UNIT=13,FILE=ADJUSTL(restart_FILE),ACCESS='APPEND',STATUS='replace')   ! DATA FILE
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

END DO
END PROGRAM MAIN


SUBROUTINE BBK(YP,YN,VN,temp)
USE CONSTANTS
IMPLICIT NONE
REAL*8,DIMENSION(N)::YN,YF,YP,YL,YR,VN,force
REAL*8 ::RANDOM_NORMAL,random,temp,temp_i
INTEGER::I
  YL(1)=0; YR(N)=0                                                   ! FIXED BOUNDARY CONDITON
  FORALL (I=2:100) YL(I)=YN(I-1)
  FORALL (I=1:99) YR(I)=YN(I+1)

force  = -k*(yn-yl)*(1+rho*exp(-alp*(yn+yl))) +k*alp*rho/2.0*(yn-yl)**2*exp(-alp*(yn+yl))&
                +k*(yr-yn )*(1+rho*exp(-alp*(yr+yn )))+k*alp*rho/2.0*(yr-yn )**2*exp(-alp*(yr+yn ))&
                +2*a_pb*D_pb*(exp(-a_pb*yn )-1)*exp(-a_pb*yn)



DO I=1,Nr
   temp_i=temp
   RANDOM=SQRT(2*gamma*KB*TEMP/M/DT)*RANDOM_NORMAL()
   yf(i)=yn(i)+(1.0-gamma*DT/2.0)/(1.0+gamma*DT/2.0)*(yn(i)-yp(i))&
        +1.0/(1.0+gamma*DT/2.0)*DT**2*(force(i)/m+random)                  !bbk integrator
end do
do i=nr+1,N-nr
   random=0
   yf(i)=2*yn(i)-yp(i)+DT**2*force(i)/m
end do
DO I=n-Nr+1, N
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

