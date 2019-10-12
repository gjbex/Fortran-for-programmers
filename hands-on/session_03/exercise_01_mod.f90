module statistics
    use, intrinsic :: iso_fortran_env, only : dp => REAL64
    implicit none

    type :: stats_type
        real(kind=dp) :: data_sum, data_sum2
        integer :: n
    end type stats_type

end module statistics
