      program fit
      
      implicit none
      double precision :: x(8),y(8)
      double precision :: a,b
      double precision :: X2,sigma,sigma_a,sigma_b
      double precision :: Del1,Del2,N
      integer :: i

      open(10,file='tree.dat')
      do i = 1,8
          read(10,*)x(i),y(i)
      end do
      close(10)
      
      N = 8.0
      Del1 = N*sum(x*y) - sum(x)*sum(y)
      a = (sum(x**2)*sum(y) - sum(x)*sum(x*y))/Del1
      b = (N*sum(x*y) - sum(x)*sum(y))/Del1
        
      X2 = sum((y-(a+b*x))**2)
      sigma = sqrt(X2/(N-2))

      Del2 = N*sum(x**2) - sum(x)**2
      sigma_a = sigma**2*sum(x)/Del2
      sigma_b = N*sigma**2/Del2

      write(*,*)a,b,sigma,sigma_a,sigma_b

      end program fit
