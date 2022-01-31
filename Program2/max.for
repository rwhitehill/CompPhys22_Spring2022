       program max
       
       ! set to identify variable types explicitly
       implicit none
       ! declare variables
       integer, parameter :: dim = 5
       integer, dimension(dim) :: k
       integer, dimension(dim) :: x, y
       integer :: i,j,temp,idx,max_idx,maximum
       
       ! prompt user to input five numbers
       write(*,*)'Enter five real numbers: '
       read *, x(1)
       read *, x(2)
       read *, x(3)
       read *, x(4)
       read *, x(5)
       
       ! set sort index to 1 and stored indices to 0
       idx = 1
       k = (/ 0,0,0,0,0 /)
       ! loop through input values
       do i = 5,1,-1
           ! ask if sort index stored, increment if yes
           !if (ANY(idx == k)) then
           !    idx = idx + 1
           !end if

           ! set max to value at sort index and max index to sort index
           !maximum = x(idx)
           !max_idx = idx
            
           ! loop over values for comparison
           do j = 1,5
               ! ask if loop value bigger than sort value or if loop index 
               ! not yet stored, if yes --> set new maximum and index
               if (x(i) > x(j)) then
                   temp = x(j)
                   max_idx = j
               end if
           end do

           ! after comparison set next maximum and index of value
           y(i) = maximum
           k(i) = max_idx

       end do

       ! write values in decreasing order
       do i = 5,1,-1
           write(*,*)y(i)
       end do

       end program max
