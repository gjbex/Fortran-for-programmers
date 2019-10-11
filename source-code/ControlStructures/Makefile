FC = gfortran
FFLAGS = -O2 -g -Wall
LDFLAGS =
LDLIBS = -lm

APPL = forall_test.exe where_test.exe select_test.exe do_test.exe \
       do_while_test.exe block_test.exe associate_test.exe \
       merge_test.exe stop_test.exe

all: $(APPL)

%.exe: %.o
	$(FC) $(FFLAGS) -o $@ $< $(LDFLAGS) $(LDLIBS)

%.o: %.f90
	$(FC) $(FFLAGS) -c $<

clean:
	$(RM) $(APPL) $(wildcard *.o) $(wildcard *.mod)
