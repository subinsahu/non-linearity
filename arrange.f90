program arrange
use constants
implicit none
integer i
character(len=3)::file_num
character(len=10)::file_name
real*8::time,ep11,ep12,ep21,ep22
REAL*8,DIMENSION(N)::YN,YP,DW,VN
real*8,DIMENSION(N):: Y1_av,Y2_av,Y3_av,Y4_av, VN_av, wn_av,JN_av
real*8,DIMENSION(N):: exp_ay1_av, exp_ay2_av, exp_b_av
real*8,DIMENSION(N):: ynyl_av, ynyr_av , yn2yl_av, ynyl2_av, yn2yl2_av
open (unit=11,file='plot.dat',access='append',status='replace')
do i=0,600,25
   write(file_num, '(i3)') i
   file_name=file_num//'k.dat'
   file_name=adjustl(file_name)
   !print *, file_name
   open(unit=12,file=file_name,action='read',status='old')
   do
      read(12,*,end=20) time
   Read (12,*) y1_av
   Read (12,*) y2_av
   Read (12,*) y3_av
   Read (12,*) y4_av 
   Read (12,*) ynyl_av
   Read (12,*) ynyr_av
   Read (12,*) yn2yl_av
   Read (12,*) ynyl2_av
   Read (12,*) yn2yl2_av
   Read (12,*) exp_ay1_av
   Read (12,*) exp_ay2_av
   Read (12,*) exp_b_av
   Read (12,*) Vn_av
   Read (12,*) wn_av
   Read (12,*) Jn_av
   end do
20   close (12)
ep11=D_pb*(-a_pb**3*y3_av(50)/2+5*a_pb*4*y4_av(50)/12.0)/(Vn_av(50)+wn_av(50))
ep12=k*rho*(-alp/2.0*(y3_av(50)-yn2yl_av(50)-ynyl2_av(50)+y3_av(49))+alp**2/4.0*(y4_av(50)-2*yn2yl2_av(50)-y4_av(50)))&
 /(Vn_av(50)+wn_av(50))
ep21=D_pb*(exp_ay2_av(50)-2*exp_ay1_av(50))/(Vn_av(50)+wn_av(50))
ep22=k/2.0*rho*exp_b_av(50)/(Vn_av(50)+wn_av(50))
write(11,*) i,ep11, ep12, ep21, ep22,jn_av(50), vn_av(50),D_pb*(1+exp_ay2_av(50)-2.0*exp_ay1_av(50))
end do
close (11)
end program
