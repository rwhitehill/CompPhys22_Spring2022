       program max
       
       ! set to identify variable types explicitly
       implicit none

       ! declare variables
       integer, parameter :: dim = 5
       integer, dimension(dim) :: x
       integer :: i,j,idx,temp
       
       ! prompt user to input five numbers
       write(*,*)'Enter five real numbers: '
       read *, x(1)
       read *, x(2)
       read *, x(3)
       read *, x(4)
       read *, x(5)
       
       ! loop through input values
       do i = 5,1,-1
           idx = 1

           ! loop over values for comparison
           do j = 2,i
               ! compare values at current index and next index
               ! if current value larger --> switch places
               if (x(idx) > x(j)) then
                   temp = x(j)
                   x(j) = x(idx)
                   x(idx) = temp
               end if
               ! increment current index
               idx = idx + 1
           end do

       end do

       ! write values in decreasing order
       do i = 1,5
           write(*,*)x(i)
       end do

       end program max
