program matrix_expression_forall
    use, intrinsic :: iso_fortran_env, only : dp => REAL64
    implicit none
    integer, parameter :: m = 20000, n = 3000
    integer :: i, j
    real(kind=dp), dimension(m, n) :: A, B, C, D

    A = 1.0_dp
    B = 1.0_dp
    C = 1.0_dp
    forall (i = 1:m, j = 1:n)
        D(i, j) = 5.0_dp*A(i, j)*B(i, j) + C(i, j)/1.5_dp + 8.0_dp
    end forall

    print *, sum(D)

end program matrix_expression_forall
