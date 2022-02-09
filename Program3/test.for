      program test
       
      implicit none
      integer :: opt,i
      character(len=100) :: file_name
      integer :: num_lines
      integer :: logical_unit
      integer,allocatable :: date(:),odometer(:)
      real,allocatable :: fuel(:)
      integer :: year,month,day
      integer :: cyear,cmonth
      integer :: start,last

      real :: avg,stdev
      logical :: valid

      logical_unit = 10
       
      write(*,'(a)')'Car information log analyzer program start'
      write(*,'(a)')'Please enter name of file:'
      do
          read(*,*)file_name
          open(logical_unit,file=file_name,action='read',err=20)
          exit
20        write(*,'(a)')'Error during file read -- enter file name'//
     &              ' again'
      end do

      write(*,'(a)')'File opened successfuly'
      call get_num_lines(logical_unit,num_lines)
      allocate(date(num_lines))
      allocate(odometer(num_lines))
      allocate(fuel(num_lines))
      call get_car_info(logical_unit,num_lines,date,odometer,fuel)
      
      do
32        write(*,'(a)')'What analysis would you like'//
     &' (Enter number corresponding to desired option)?'
          write(*,'(a)')'(1) Total | (2) Year | (3) Month'
35        read(*,*)opt

          if (.not. valid(opt,1,3)) then
              write(*,*)'Invalid choice -- Please select again'
              go to 35

          else if (opt == 1) then
40            format(a,1x,i6)
41            format(a,2x,f4.1,1x,a,1x,f3.1)
              write(*,40)'Miles Driven:',odometer(size(odometer))
     &-odometer(1)
              write(*,41)'Mileage:',avg(fuel,size(fuel)),'+-',
     &stdev(fuel,size(fuel))

          else if (opt == 2) then
              write(*,'(a)')'Which yearly analysis would you like?'
51            write(*,'(a)')'(1) Compare | (2) Isolate'
              read(*,*)opt
              if (.not. valid(opt,1,2)) then
                  go to 51
              else if (opt == 1) then
                  call split_date(date(1),year,month,day)
                  cyear = year
                  start = 1
                  do i = 1,size(date)
                      call split_date(date(i),year,month,day) 
                      if (year /= cyear) then
66                        format(a,1x,i4)
67                        format(a,1x,i6)
68                        format(a,1x,f4.1,1x,a,1x,f3.1)
                          write(*,66)'Year:',cyear
                          write(*,67)'Miles drive:',
     &odometer(i-1)-odometer(start)
                          write(*,68)'Mileage:',
     &avg(fuel(:i-1),size(fuel(:i-1))),'+-',stdev(fuel(:i-1),
     &size(fuel(:i-1)))
                          write(*,*)
                          cyear = year
                      end if
                  end do
              else if (opt == 2) then
                  write(*,'(a)')'Enter a year:'
                  read(*,*)cyear
                  !do i = 1,size(date)
                  !    call split_date(date(i),year,month,day)
                  !    if (year == cyear)
                  !        last = i
                  !    else if (year /= cyear)
                  !        start = i
                  !    end if
                  !end do
                  !write(*,*)cyear
                  !write(*,*)start,last
              end if
              
          else if (opt == 3) then
              write(*,*)'Month'

          end if

          exit
      end do

      call split_date(date(1),year,month,day)
       
      end program test

!========================================================
       
      subroutine get_num_lines(logical_unit,num_lines) 
          implicit none
          integer :: logical_unit
          integer :: num_lines
          num_lines = 0
          do
              read(logical_unit,*,err=1,end=1)
              num_lines = num_lines + 1
          end do
1         rewind(logical_unit)
      end subroutine

      subroutine get_car_info(logical_unit,num_lines,arr1,arr2,arr3)
          implicit none
          integer :: i,logical_unit,num_lines
          integer :: arr1(num_lines),arr2(num_lines)
          real :: arr3(num_lines)
          
          do i = 1,num_lines
              read(logical_unit,*)arr1(i),arr2(i),arr3(i)
          end do

      end subroutine

      subroutine split_date(date,year,month,day) 
          implicit none
          integer :: date,year,month,day
          year = date/1e4
          month = (date - year*1e4)/1e2
          day = (date - year*1e4 - month*1e2)
      end subroutine

      function avg(arr,arr_size)
          implicit none
          integer :: arr_size
          real :: arr(arr_size)
          real :: avg
          avg = sum(arr)/arr_size
      end function

      function stdev(arr,arr_size)
          implicit none
          integer :: arr_size
          real :: arr(arr_size)
          real :: avg,stdev
          stdev = sqrt(sum((arr-avg(arr,arr_size))**2)/(arr_size-1))
      end function

      function valid(input,minimum,maximum)
          implicit none
          integer :: input,minimum,maximum
          logical :: valid
          if (input < minimum .or. input > maximum) then
              write(*,'(a)')'Invalid choice -- Please select again'
              valid = .false.
          else 
              valid = .true.
          end if
      end function
