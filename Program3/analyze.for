       program analyze

       implicit none

       integer,allocatable :: date(:)
       integer,allocatable :: odometer(:)
       real,allocatable :: fuel(:)
       integer :: i,io,x,y
       real :: z

       open(1,file='car.dat')
       
       i = 0
       allocate(date(0))
       allocate(odometer(0))
       allocate(fuel(0))
       do
           read(1,*,iostat=io)x,y,z
           if (io == 0) then
               i = i + 1
               date = [date,x]
               odometer = [odometer,y]
               fuel = [fuel,z]
           else
               write(*,*) 'End of loop: ', i, 'iterations'
               exit
           end if
       end do
       close(1)
       do i = 1,size(date)
           write(*,*)date(i),odometer(i),fuel(i)
       end do

       avg(date)

       integer avg(arr)
           write(*,*)size(arr)
       return

       end program analyze
