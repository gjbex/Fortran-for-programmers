FC = gfortran
FFLAGS = -g -Wall
LDLIBS = -lm

all: exercise_01.exe exercise_02.exe exercise_03.exe

%.exe: %.o
	$(FC) $(FFLAGS) -o $@ $< $(LDLIBS)

%.o: %.f90
	$(FC) $(FFLAGS) -c -o $@ $<

clean:
	$(RM) $(wildcard *.o) $(wildcard *.mod) $(wildcard *.exe)
