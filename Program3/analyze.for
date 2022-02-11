      program analyze
       
      implicit none
      integer :: opt,i
      character(len=100) :: file_name
      integer :: num_lines
      integer :: logical_unit
      integer,allocatable :: date(:),odometer(:)
      real,allocatable :: fuel(:)
      real :: avg_fuel,stdev_fuel
      integer :: year,month,day
      integer :: cyear,cmonth
      integer :: start,last,temp1,temp2,quit

      real :: avg,stdev
      logical :: valid

      logical_unit = 10
       
      write(*,'(a)')'Car information log analyzer program start'
      write(*,'(a)')'Please enter name of file:'
      do
          read(*,*)file_name
          open(logical_unit,file=file_name,action='read',err=25)
          exit
25        write(*,'(a)')'Error during file read -- enter file name'//
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

42        format(a,1x,i4)
43        format(a,1x,i6)
45        format(a,2x,f4.1,1x,a,1x,f3.1)
44        format(a,1x,f4.1)

          if (.not. valid(opt,1,3)) then
              go to 35

          else if (opt == 1) then
              write(*,43)'Miles Driven:',odometer(size(odometer))
     &-odometer(1)
              call get_mileage((odometer - [0,
     &odometer(:size(odometer)-1)])/fuel,num_lines,avg_fuel,stdev_fuel)
              write(*,45)'Mileage:',avg_fuel,'+-',stdev_fuel

          else if (opt == 2) then
              write(*,'(a)')'Which yearly analysis would you like?'
58            write(*,'(a)')'(1) Compare | (2) Isolate'
              read(*,*)opt
              if (.not. valid(opt,1,2)) then
                  go to 58
              else if (opt == 1) then
                  call split_date(date(1),year,month,day)
                  cyear = year
                  start = 1
                  do i = 1,size(date)
                      call split_date(date(i),year,month,day) 
                      if (year /= cyear .or. i == size(date)) then
                          write(*,42)'Year:',cyear
                          write(*,43)'Miles driven:',
     &odometer(i-1)-odometer(start)
                          write(*,44)'Mileage:',(odometer(i-1)
     &-odometer(start))/sum(fuel(start:i-1))
                          write(*,*)
                          cyear = year
                          start = i
                      end if
                  end do
              else if (opt == 2) then
                  write(*,'(a)')'Enter a year:'
                  read(*,*)cyear
                  start = 0
                  last  = 0
                  do i = 1,size(date)
                      call split_date(date(i),year,month,day)
                      if (year == cyear .and. start == 0) then
                          start = i
                      else if (year /= cyear .and. last < start) then
                          last = i-1
                      end if
                  end do
                  write(*,43)'Miles driven:',odometer(last)-
     &odometer(start)
                  write(*,44)'Mileage:',(odometer(last)
     &-odometer(start))/sum(fuel(start:last))
                  cmonth = 1
                  temp1 = start
                  do i = start,last
                      call split_date(date(i),year,month,day)
                      if (month == cmonth) then
                          temp2 = i
                      else if (month /= cmonth) then
                          write(*,42)'Month:',cmonth
                          write(*,43)'Miles driven:',odometer(temp2)-
     &odometer(temp1)
                          write(*,44)'Mileage:',(odometer(temp2)
     &-odometer(temp1))/sum(fuel(temp1:temp2))
                          write(*,*)
                          cmonth = cmonth + 1
                          temp1 = temp2 + 1
                      end if
                  end do
              end if
              
          else if (opt == 3) then
              write(*,'(a)')'Enter the number corresponding to the'//
     &' month you would like to analyze.'
120           read(*,*)cmonth
              if (.not. valid(cmonth,1,12)) then
                  go to 120
              end if
              call split_date(date(1),year,month,day)
              cyear = year
              start = 1
              do i = 1,size(date)
                  call split_date(date(i),year,month,day)
                  if (month /= cmonth .or. i == size(date)) then
                      if (year /= cyear .or. i == size(date)) then
                          if (i > start) then
                              write(*,42)'Year:',cyear
                              write(*,43)'Miles Driven:',
     &odometer(i-1)-odometer(start)
                              write(*,44)'Mileage:',(odometer(i-1)
     &-odometer(start))/sum(fuel(start:i-1))
                              write(*,*)
                          end if
                      cyear = cyear + 1
                      end if
                      start = start + 1
                  end if
              end do
               
          end if
          
          write(*,'(a)')'End of program: restart analysis (1)'//
     &' or quit (2)'
149       read(*,*)quit
          if (.not. valid(quit,1,2)) then
              go to 149
          else if (quit == 1) then
              go to 32
          end if

          exit
      end do

       
      end program analyze

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

      subroutine get_mileage(arr,arr_size,average,standard_dev)
          implicit none
          integer :: arr_size
          real :: arr(arr_size)
          real :: average,standard_dev
          real :: avg,stdev
          average = avg(arr,arr_size)
          standard_dev = stdev(arr,arr_size)
      end subroutine

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
