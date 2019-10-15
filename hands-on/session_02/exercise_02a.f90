program matrix_expression_first_class
    use, intrinsic :: iso_fortran_env, only : dp => REAL64
    implicit none
    integer, parameter :: m = 20000, n = 3000
    real(kind=dp), dimension(m, n) :: A, B, C, D

    A = 1.0_dp
    B = 1.0_dp
    C = 1.0_dp
    D = 5.0_dp*A*B + C/1.5_dp + 8.0_dp

    print *, sum(D)

end program matrix_expression_first_class
