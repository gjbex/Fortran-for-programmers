FC = gfortran
FFLAGS = -O2 -g
LDFLAGS =
LDLIBS = -lm

APPL = free_source_form_test.exe cli_test.exe env_test.exe

all: $(APPL)

%.exe: %.o
	$(FC) $(FFLAGS) -o $@ $< $(LDFLAGS) $(LDLIBS)

%.o: %.f90
	$(FC) $(FFLAGS) -c -o $@ $<

clean:
	$(RM) $(APPL) $(wildcard *.o) $(wildcard *.mod)
