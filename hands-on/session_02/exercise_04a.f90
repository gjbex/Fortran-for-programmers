program fibonacci_recursive
    integer, parameter :: n_min = 0, n_max = 20
    integer :: n

    do n = n_min, n_max
        print *, n, fibonacci(n)
    end do

contains

    recursive function fibonacci(n) result(fib)
        implicit none
        integer, intent(in) :: n
        integer :: fib
        if (n == 0 .or. n == 1) then
            fib = 1
        else
            fib = fibonacci(n - 1) + fibonacci(n - 2)
        end if
    end function fibonacci
end program fibonacci_recursive
