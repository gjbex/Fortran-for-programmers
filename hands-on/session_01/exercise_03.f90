program greatest_common_divisor
      implicit none
      integer, parameter :: min_val = 1, max_val = 20
      integer :: n, p, a, b

      do n = min_val, max_val
        do p = min_val, max_val
            a = n
            b = p
            do while (a /= b)
                if (a < b) then
                    b = b - a
                else if (a > b) then
                    a = a - b
                end if
            end do
            print *, n, p, a
        end do
      end do
end program greatest_common_divisor
