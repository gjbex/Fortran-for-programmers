program prime_number_function
    implicit none
    integer, parameter :: n_min = 1, n_max = 40
    integer :: n

    do n = n_min, n_max
        if (is_prime(n)) then
            print *, n, 'prime'
        else
            print *, n, 'not prime'
        end if
      end do

contains

    logical function is_prime(n)
        implicit none
        integer, intent(in) :: n
        integer :: divisor

        if (n == 1) then
            is_prime = .false.
        else
            is_prime = .true.
            do divisor = 2, n/2
                if (mod(n, divisor) == 0) then
                    is_prime = .false.
                    exit
                end if
            end do
        end if
    end function is_prime

end program prime_number_function
