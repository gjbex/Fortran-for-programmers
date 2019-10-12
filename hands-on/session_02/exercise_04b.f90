program fibonacci_iterative
    integer, parameter :: n_min = 0, n_max = 20
    integer :: n

    do n = n_min, n_max
        print *, n, fibonacci(n)
    end do

contains

    integer function fibonacci(n)
        implicit none
        integer, intent(in) :: n
        integer :: fib_n_1, tmp, i
        fib_n_1 = 1
        fibonacci = 1
        do i = 2, n
            tmp = fibonacci
            fibonacci = fibonacci + fib_n_1
            fib_n_1 = tmp
        end do
    end function fibonacci
    
end program fibonacci_iterative
