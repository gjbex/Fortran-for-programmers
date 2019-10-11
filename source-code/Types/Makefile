FC = gfortran
FFLAGS = -O2 -g -Wall
LDFLAGS =
LDLIBS = -lm

PART_OBJS = random_mod.o particles_mod.o particle_sim.o
RAND_TEST_OBJS = random_mod.o rand_test.o

APPS = single double particle_sim rand_test precision_test \
       select_precision_test complex_test limits_test infinity_nan_test \
	   default_type_test

all: $(APPS)

single: types_test.F90
	$(FC) $(FFLAGS) -DSINGLE_PREC -o $@ $< $(LDFLAGS) $(LDLIBS)

double: types_test.F90
	$(FC) $(FFLAGS) -o $@ $< $(LDFLAGS) $(LDLIBS)

precision_test: precision_test.o
	$(FC) $(FFLAGS) -o $@ $< $(LDFLAGS) $(LDLIBS)

select_precision_test: select_precision_test.o
	$(FC) $(FFLAGS) -o $@ $< $(LDFLAGS) $(LDLIBS)

particle_sim: $(PART_OBJS)
	$(FC) $(FFLAGS) -o $@ $(PART_OBJS) $(LDFLAGS) $(LDLIBS)

rand_test: $(RAND_TEST_OBJS)
	$(FC) $(FFLAGS) -o $@ $(RAND_TEST_OBJS) $(LDFLAGS) $(LDLIBS)

complex_test: complex_test.o
	$(FC) $(FFLAGS) -o $@ $< $(LDFLAGS) $(LDLIBS)

limits_test: limits_test.o
	$(FC) $(FFLAGS) -o $@ $< $(LDFLAGS) $(LDLIBS)

default_type_test: default_type_test.f90
	$(FC) $(FFLAGS) -cpp -o $@ $< $(LDFLAGS) $(LDLIBS)

infinity_nan_test: infinity_nan_test.f90
	$(FC) $(FFLAGS) -cpp -o $@ $< $(LDFLAGS) $(LDLIBS)

%.o: %.f90
	$(FC) $(FFLAGS) -c -o $@ $<

clean:
	$(RM) $(APPS) $(wildcard *.o) $(wildcard *.mod)
