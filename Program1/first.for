       program first
       integer x,y,z,u
       x = 5
       y = 2
       z = x/y
11     format(' This is my first Fortran program.')
       write(6,11)
       write(6,12)z
12     format(" x/y =",i6)
       u = mod(x,y)
13     format(" remainder = ",i6)
       write(6,13)u
       stop
       end
