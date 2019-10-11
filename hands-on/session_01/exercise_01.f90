program factorial
      implicit none
      integer, parameter :: n_min = 0, n_max = 10
      integer :: n, factor, product

      do n = n_min, n_max
        product = 1
        do factor = 2, n
            product = product*factor
        end do
        print *, n, product
      end do

end program factorial
