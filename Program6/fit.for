      program fit
      
      implicit none
      double precision :: x(8),y(8)
      double precision :: a,b
      double precision :: X2,sigma,sigma_a,sigma_b
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
      
      sigma = sqrt(sum((y-(a+b*x))**2)/(N-2))
      sigma_a = sigma*sqrt(sum(x)/D)
      sigma_b = sigma*sqrt(N/D)
        
      write(*,*)a,b
      write(*,*)sigma,sigma_a,sigma_b

      end program fit
