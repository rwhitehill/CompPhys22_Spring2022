       program analyze

       implicit none
       integer,allocatable :: date(:)
       integer,allocatable :: odometer(:)
       real,allocatable :: fuel(:)
       integer :: i,io,x,y
       real :: z

       double precision :: avg,average,stdev
       integer :: get_year

       open(10,file='car.dat')

       i = 0
       allocate(date(0))
       allocate(odometer(0))
       allocate(fuel(0))
       do
           read(10,*,iostat=io)x,y,z
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
       close(10)
       average = avg(fuel,size(fuel))
1      format(f6.3,A,f6.3)
       write(*,'(A)')'average fuel inserted: '
       write(*,'(f6.3,A,f5.3)')average,' +- ',stdev(fuel,size(fuel))
       do i = 1,size(date)
           write(*,*)get_year(date(i))!,odometer(i),fuel(i)
       end do

       end program analyze

!====================

       function avg(arr,arr_size)
           implicit none
           integer :: arr_size
           real :: arr(arr_size)
           double precision :: avg
           avg = sum(arr)/arr_size
       end function

       function stdev(arr,arr_size)
           implicit none
           integer :: arr_size
           real :: arr(arr_size)
           double precision :: avg,stdev
           stdev = sqrt(sum((arr-avg(arr,arr_size))**2)/(arr_size-1))
       end function

       function get_year(date)
           implicit none
           integer :: date
           integer :: get_year
           get_year = date/1e4
       end function
