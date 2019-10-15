module window_statistics
    use, intrinsic :: iso_fortran_env, only : dp => REAL64
    implicit none
    private
    type, public :: window_stats_type
        private
        real(kind=dp), dimension(:), allocatable :: window
        integer :: nr_value = 0
        integer :: curr_pos = 1
    contains
        procedure, public :: init
        procedure, public :: add_data
        procedure, public :: mean
        procedure, public :: stddev
    end type window_stats_type

contains

    subroutine init(window_stats, n)
        use, intrinsic :: iso_fortran_env, only : error_unit
        implicit none
        class(window_stats_type), intent(inout) :: window_stats
        integer, value :: n
        integer :: istat
        allocate(window_stats%window(n), stat=istat)
        if (istat /= 0) then
            write (unit=error_unit, fmt='(A)') &
                '# error: can not allocate memory'
            stop 1
        end if
        window_stats%window = 0.0_dp
    end subroutine init

    subroutine add_data(window_stats, value)
        implicit none
        class(window_stats_type), intent(inout) :: window_stats
        real(kind=dp), value :: value
        window_stats%window(window_stats%curr_pos) = value
        if (window_stats%nr_value < size(window_stats%window)) &
            window_stats%nr_value = window_stats%nr_value + 1
        if (window_stats%curr_pos < size(window_stats%window)) then
            window_stats%curr_pos = window_stats%curr_pos + 1
        else
            window_stats%curr_pos = 1
        end if
    end subroutine add_data
    
    function mean(window_stats) result(mean_value)
        use, intrinsic :: iso_fortran_env, only : error_unit
        implicit none
        class(window_stats_type), intent(in) :: window_stats
        real(kind=dp) :: mean_value
        if (window_stats%nr_value == 0) then
            write (unit=error_unit, fmt='(A)') '# error: no data'
            stop 2
        else
            mean_value = sum(window_stats%window)/window_stats%nr_value
        end if
    end function mean

    function stddev(window_stats) result(stddev_value)
        use, intrinsic :: iso_fortran_env, only : error_unit
        implicit none
        class(window_stats_type), intent(in) :: window_stats
        real(kind=dp) :: stddev_value
        real(kind=dp) :: mean_value
        if (window_stats%nr_value < 2) then
            write (unit=error_unit, fmt='(A)') '# error: not enough data'
            stop 2
        else
            mean_value = window_stats%mean()
            stddev_value = sqrt(sum(window_stats%window**2)/window_stats%nr_value - &
                                mean_value**2)
        end if
    end function stddev

end module window_statistics
