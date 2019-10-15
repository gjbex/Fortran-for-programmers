program moving_window_stats
    use, intrinsic :: iso_fortran_env, only : dp => REAL64
    use :: window_statistics
    implicit none
    type(window_stats_type) :: window_stats
    real(kind=dp), parameter :: x_min = 0.0, x_max = 20.0, x_incr = 0.5
    real(kind=dp) :: x

    call window_stats%init(5)
    x = x_min
    do while (x <= x_max)
        call window_stats%add_data(x)
        print *, x, window_stats%mean()
        x = x + x_incr
    end do

end program moving_window_stats
