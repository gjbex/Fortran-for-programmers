program matrix_product_do_loop
      use, intrinsic :: iso_fortran_env, only : dp => REAL64
      implicit none
      integer, parameter :: m = 1000, n = 2000, p = 3000
      integer :: i, j, k
      real(kind=dp), dimension(m, n) :: A
      real(kind=dp), dimension(n, p) :: B
      real(kind=dp), dimension(m, p) :: C

      call random_number(A)
      call random_number(B)
    do j = 1, p
          do i = 1, m
            C(i, j) = 0.0_dp
            do k = 1, n
                C(i, j) = C(i, j) + A(i, k)*B(k, j)
            end do
        end do
    end do
    
    print *, sum(C)

end program matrix_product_do_loop
