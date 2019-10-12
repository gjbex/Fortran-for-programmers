program matrix_clip_zero
    use, intrinsic :: iso_fortran_env, only : dp => REAL64
    implicit none
    integer, parameter :: m = 3, n = 3
    real(kind=dp), dimension(m, n) :: A = reshape([  3.0,  1.0,  4.0, &
                                                    -3.0, -0.5, -2.0, &
                                                    -0.5,  2.0, -1.0 ], [m, n])
    integer :: i

    do i = 1, m
        print *, A(i, :)
    end do
    call clip_zeros(A, 1.0_dp)
    print *, 'clipped'
    do i = 1, m
        print *, A(i, :)
    end do

contains

    subroutine clip_zeros(A, epsilon)
        use, intrinsic :: iso_fortran_env, only : dp => REAL64
        implicit none
        real(kind=dp), dimension(:, :), intent(inout) :: A
        real(kind=dp), intent(in) :: epsilon
        where (abs(A) < epsilon)
            A = 0.0_dp
        end where
    end subroutine clip_zeros

end program matrix_clip_zero
