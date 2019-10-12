program factorial_recursive_function
    use, intrinsic :: iso_fortran_env, only : i8 => INT64
    implicit none
    integer(kind=i8), parameter :: n_min = 0_i8, n_max = 10_i8
    integer(kind=i8) :: n

    do n = n_min, n_max
        print *, n, factorial(n)
    end do

contains

    recursive function factorial(n) result(fac)
        use, intrinsic :: iso_fortran_env, only : i8 => INT64
        implicit none
        integer(kind=i8), intent(in) :: n
        integer(kind=i8) :: fac
        if (n == 0) then
            fac  = 1_i8
        else
            fac = n*factorial(n - 1)
        end if
    end function factorial

end program factorial_recursive_function
