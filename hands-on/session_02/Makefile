FC = gfortran
FFLAGS = -g -Wall
LDLIBS = -lm

all: exercise_01a.exe exercise_01b.exe \
	 exercise_02a.exe exercise_02b.exe exercise_02c.exe \
	 exercise_03a.exe exercise_03b.exe exercise_03c.exe

%.exe: %.o
	$(FC) $(FFLAGS) -o $@ $< $(LDLIBS)

%.o: %.f90
	$(FC) $(FFLAGS) -c -o $@ $<

clean:
	$(RM) $(wildcard *.o) $(wildcard *.mod) $(wildcard *.exe)
