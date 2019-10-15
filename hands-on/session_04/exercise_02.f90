program scale_matrix
    use, intrinsic :: iso_fortran_env, only : dp => REAL64, error_unit
    implicit none
    real(kind=dp), dimension(:, :), allocatable :: matrix
    real(kind=dp) :: scale_factor
    character(len=1024) :: in_file_name, out_file_name, msg
    
    call parse_command_arguments(in_file_name, scale_factor, out_file_name)
    call read_matrix(in_file_name, matrix)
    matrix = scale_factor*matrix
    call write_matrix(out_file_name, matrix)

contains

    subroutine parse_command_arguments(in_file_name, scale_factor, out_file_name)
        use, intrinsic :: iso_fortran_env, only : error_unit
        use, intrinsic :: iso_fortran_env, only : dp => REAL64, error_unit
        character(len=*), intent(out) :: in_file_name, out_file_name
        real(kind=dp), intent(out) :: scale_factor
        integer :: istat
        character(len=1024) :: arg_str, msg
        if (command_argument_count() /= 3) then
            write (unit=error_unit, fmt='(A)') &
                '# error: expecting 3 arguments'
            stop 1
        end if
        call get_command_argument(1, in_file_name)
        call get_command_argument(2, arg_str)
        read (arg_str, fmt='(E15.4)', iostat=istat, iomsg=msg) scale_factor
        if (istat /= 0) then
            write (unit=error_unit, fmt='(2A)') '# error: ', msg
            stop istat
        end if
        call get_command_argument(3, out_file_name)
    end subroutine parse_command_arguments

    subroutine read_matrix(file_name, matrix)
        use, intrinsic :: iso_fortran_env, only : error_unit
        implicit none
        character(len=*), intent(in) :: file_name
        real(kind=dp), dimension(:, :), allocatable, intent(inout) :: matrix
        integer, parameter :: file_unit = 20
        integer :: i, nr_rows, nr_cols, istat
        character(len=128) :: fmt_str
        open(unit=file_unit, file=trim(file_name), access='sequential', action='read', &
             status='old', form='formatted', iostat=istat, iomsg=msg)
        if (istat /= 0) then
            write (unit=error_unit, fmt='(2A)') '# error: ', msg
            stop istat
        end if
        read (unit=file_unit, fmt='(2I10)', iostat=istat, iomsg=msg) nr_rows, nr_cols
        print *, nr_rows, nr_cols
        if (istat /= 0) then
            write (unit=error_unit, fmt='(2A)') '# error: ', msg
            stop istat
        end if
        allocate(matrix(nr_rows, nr_cols), stat=istat)
        if (istat /= 0) then
            write (unit=error_unit, fmt='(A, I0, "x", I0, A)') &
                '# error: can not allocate ', nr_rows, nr_cols, ' array'
            stop 1
        end if
        write (fmt_str, fmt="('(', I0, 'F15.4)')") nr_cols
        do i = 1, nr_rows
            read (unit=file_unit, fmt=fmt_str) matrix(i, :)
        end do
    end subroutine read_matrix

    subroutine write_matrix(file_name, matrix)
        use, intrinsic :: iso_fortran_env, only : error_unit
        implicit none
        character(len=*), intent(in) :: file_name
        real(kind=dp), dimension(:, :), intent(in) :: matrix
        integer, parameter :: file_unit = 20
        integer :: i, istat
        character(len=128) :: fmt_str
        open(unit=file_unit, file=trim(file_name), access='sequential', action='write', &
             status='replace', form='formatted', iostat=istat, iomsg=msg)
        if (istat /= 0) then
            write (unit=error_unit, fmt='(2A)') '# error: ', msg
            stop istat
        end if
        write (unit=file_unit, fmt='(2I10)', iostat=istat, iomsg=msg) &
            size(matrix, 1), size(matrix, 2)
        if (istat /= 0) then
            write (unit=error_unit, fmt='(2A)') '# error: ', msg
            stop istat
        end if
        write (fmt_str, fmt="('(', I0, 'F15.4)')") size(matrix, 2)
        do i = 1, size(matrix, 1)
            write (unit=file_unit, fmt=fmt_str) matrix(i, :)
        end do
    end subroutine write_matrix

end program scale_matrix
