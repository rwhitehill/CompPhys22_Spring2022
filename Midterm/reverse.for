      program reverse
      
      implicit none
      integer :: x(6),y(6)

      x = (/ 0,1,2,3,4,5 /)
      write(*,*)x

      call flip(x,y)
      write(*,*)y
      
      end program reverse

      subroutine flip(x,y)
      integer :: x(6),y(6)
      do i = 6,1,-1
          y(i) = x(6-i+1)    
      end do
      end subroutine
