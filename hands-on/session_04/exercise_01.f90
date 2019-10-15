program file_statistics
    use, intrinsic :: iso_fortran_env, only : dp => REAL64, error_unit
    use :: statistics
    implicit none
    integer, parameter :: file_unit = 20
    character(len=1024) :: file_name, msg
    integer :: istat      
    type(stats_type) :: stats
    real(kind=dp) :: data_value  
    
    if (command_argument_count() < 1) then
        write (unit=error_unit, fmt='(A)') '# error: no file given'
        stop 1
    end if
    call get_command_argument(1, file_name)
    open(unit=file_unit, file=trim(file_name), access='sequential', action='read', &
         status='old', form='formatted', iostat=istat, iomsg=msg)
    if (istat /= 0) then
        write (unit=error_unit, fmt='(2A)') '# error: ', msg
        stop istat
    end if
    call init_stats(stats)
    do while (.true.)
        read (unit=file_unit, fmt='(E25.0)', iostat=istat, iomsg=msg) data_value
        if (is_iostat_end(istat)) exit
        if (istat /= 0) then
            write (unit=error_unit, fmt='(2A)') '# error: ', msg
            stop istat
        end if
        print '(A, E15.4)', 'read ', data_value
        call add_stats(stats, data_value)
    end do
    close(unit=file_unit)
    if (nr_stats(stats) > 0) then
        print '(A, E10.4)', 'mean   = ', mean_stats(stats)
        print '(A, E10.4)', 'stddev = ', stddev_stats(stats)
    end if 

end program file_statistics
