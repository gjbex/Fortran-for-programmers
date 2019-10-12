program compute_statistics
    use, intrinsic :: iso_fortran_env, only : dp => REAL64
    use :: statistics, only : stats_type
    implicit none
    real(kind=dp), parameter :: x_min = 1.0, x_max = 20.0, x_incr = 0.5
    type(stats_type) :: stats
    real(kind=dp) :: x, data_mean, data_std_dev

    stats%data_sum = 0.0_dp
    stats%data_sum2 = 0.0_dp
    stats%n = 0
    x = x_min
    do while (x <= x_max)
        stats%data_sum = stats%data_sum + x
        stats%data_sum2 = stats%data_sum2 + x**2
        stats%n = stats%n + 1
        x = x + x_incr
    end do
    data_mean = stats%data_sum/stats%n
    data_std_dev = sqrt(stats%data_sum2/stats%n - data_mean**2)
    print *, 'mean =', data_mean
    print *, 'stddev =', data_std_dev
    print *, 'n =', stats%n
end program compute_statistics
