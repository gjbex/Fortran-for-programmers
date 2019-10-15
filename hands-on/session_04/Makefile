FC = gfortran
FFLAGS = -g -Wall
LDLIBS = -lm

all: exercise_01.exe exercise_02.exe

exercise_02.exe: exercise_02.o
	$(FC) $(FFLAGS) -o $@ $^ $(LDLIBS)

%.exe: %_mod.o %.o
	$(FC) $(FFLAGS) -o $@ $^ $(LDLIBS)

%.o: %.f90
	$(FC) $(FFLAGS) -c -o $@ $<

clean:
	$(RM) $(wildcard *.o) $(wildcard *.mod) $(wildcard *.exe)
