program prime_number
      implicit none
      integer, parameter :: n_min = 1, n_max = 40
      integer :: n, divisor
      logical :: is_prime

      do n = n_min, n_max
        if (n == 1) then
            print *, n, 'not prime'
        else
            is_prime = .true.
            do divisor = 2, n/2
                if (mod(n, divisor) == 0) then
                    print *, n, 'not prime'
                    is_prime = .false.
                    exit
                end if
            end do
            if (is_prime) then
                print *, n, 'prime'
            end if
        end if
      end do

end program prime_number
