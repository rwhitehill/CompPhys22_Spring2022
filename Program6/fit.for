      program fit
      
      implicit none
      double precision :: x(8),y(8),res(8)
      double precision :: a,b
      double precision :: X2,avg,sig,goodness,sigma,sigma_a,sigma_b
      double precision :: D,N
      integer :: i

      open(10,file='tree.dat')
      do i = 1,8
          read(10,*)x(i),y(i)
      end do
      close(10)
      
      N = 8.0
      D = N*sum(x**2) - sum(x)**2
      a = (sum(x**2)*sum(y) - sum(x)*sum(x*y))/D
      b = (N*sum(x*y) - sum(x)*sum(y))/D
      
      res = y - (a+b*x)
      
      avg = sum(y)/N
      sig = sqrt(sum((y-avg)**2)/(N-1))
      X2 = sum(res**2/sig)
      goodness = X2/(N-2)
 
      sigma = sqrt(sum(res**2)/(N-2))
      sigma_a = sigma*sqrt(sum(x)/D)
      sigma_b = sigma*sqrt(N/D)

      write(*,*)'a = ',a,sigma_a
      write(*,*)'b = ',b,sigma_b
      write(*,*)'sigma = ',sigma
      write(*,*)'chisq = ',X2
      write(*,*)'goodness of fit: ',goodness

      end program fit
