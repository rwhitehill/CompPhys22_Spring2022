      program test
      real :: x,y,r
      
      write(*,*)'Enter x and y coordinate positions'
      read(*,*)x,y

      r = radius(x,y)
11    format('The distance from the origin to (',F5.3,',',F5.3,
     &') is ',F5.3)
      write(*,11)x,y,r
      
      open(10,file='result.txt',action='write')
      write(10,11)x,y,r

      end program test

      function radius(x,y)
      real :: x,y,radius
      radius = sqrt(x**2 + y**2)
      end function
