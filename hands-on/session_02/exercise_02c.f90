program matrix_expression_do_loop
    use, intrinsic :: iso_fortran_env, only : dp => REAL64
    implicit none
    integer, parameter :: m = 20000, n = 3000
    integer :: i, j
    real(kind=dp), dimension(m, n) :: A, B, C, D

    A = 1.0_dp
    B = 1.0_dp
    C = 1.0_dp
    do j = 1, n
        do i = 1, m
            D(i, j) = 5.0_dp*A(i, j)*B(i, j) + C(i, j)/1.5_dp + 8.0_dp
          end do
    end do

    print *, sum(D)

end program matrix_expression_do_loop
