module statistics
    use, intrinsic :: iso_fortran_env, only : dp => REAL64
    implicit none

    private
    type, public :: stats_type
        real(kind=dp) :: data_sum, data_sum2
        integer :: n
    end type stats_type
    public :: init_stats, add_stats, mean_stats, stddev_stats

contains

    subroutine init_stats(stats)
        implicit none
        type(stats_type), intent(inout) :: stats
        stats%data_sum = 0.0_dp
        stats%data_sum2 = 0.0_dp
        stats%n = 0
    end subroutine init_stats

    subroutine add_stats(stats, value)
        implicit none
        type(stats_type), intent(inout) :: stats
        real(kind=dp), intent(in) :: value
        stats%data_sum = stats%data_sum + value
        stats%data_sum2 = stats%data_sum2 + value**2
        stats%n = stats%n + 1
    end subroutine add_stats

    real(kind=dp) function mean_stats(stats)
        implicit none
        type(stats_type), intent(in) :: stats
        mean_stats = stats%data_sum/stats%n
    end function mean_stats

    real(kind=dp) function stddev_stats(stats)
        implicit none
        type(stats_type), intent(in) :: stats
        real(Kind=dp) :: mean_value
        mean_value = mean_stats(stats)
        stddev_stats = sqrt(stats%data_sum2/stats%n - mean_value*mean_value)
    end function stddev_stats

end module statistics
