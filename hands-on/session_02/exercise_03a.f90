program factorial_function
    use, intrinsic :: iso_fortran_env, only : i8 => INT64
    implicit none
    integer(kind=i8), parameter :: n_min = 0_i8, n_max = 10_i8
    integer(kind=i8) :: n

    do n = n_min, n_max
        print *, n, factorial(n)
    end do

contains

    integer(kind=i8) function factorial(n)
        use, intrinsic :: iso_fortran_env, only : i8 => INT64
        implicit none
        integer(kind=i8), intent(in) :: n
        integer(kind=i8) :: factor
        factorial  = 1_i8
        do factor = 2_i8, n
            factorial = factorial*factor
        end do
    end function factorial

end program factorial_function
