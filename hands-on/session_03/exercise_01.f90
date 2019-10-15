program compute_statistics
    use, intrinsic :: iso_fortran_env, only : dp => REAL64
    use :: statistics, only : stats_type, init_stats, add_stats, &
                              mean_stats, stddev_stats
    implicit none
    real(kind=dp), parameter :: x_min = 1.0, x_max = 20.0, x_incr = 0.5
    type(stats_type) :: stats
    real(kind=dp) :: x

    call init_stats(stats)
    x = x_min
    do while (x <= x_max)
        call add_stats(stats, x)
        x = x + x_incr
    end do
    print *, 'mean =', mean_stats(stats)
    print *, 'stddev =', stddev_stats(stats)
    print *, 'n =', stats%n

end program compute_statistics
