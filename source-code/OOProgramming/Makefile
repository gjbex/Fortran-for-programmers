FC = gfortran
FFLAGS = -O2 -g -Wall -Wextra
LDLIBS = -lm

TREE_TEST_OBJS = node_mod.o random_mod.o tree_test.o
ID_TREE_TEST_OBJS = node_mod.o id_node_mod.o random_mod.o id_tree_test.o
AVG_PATH_TEST_OBJS = node_mod.o random_mod.o avg_path_test.o
RAT_OBJS = rationals_mod.o rationals.o
STATS_OBJS = stats_mod.o stats.o

APPS = tree_test.exe avg_path_test.exe id_tree_test.exe rationals.exe \
       stats.exe

all: $(APPS)

tree_test.exe: $(TREE_TEST_OBJS)
	$(FC) $(FFLAGS) -o $@ $(TREE_TEST_OBJS) $(LDLIBS)

avg_path_test.exe: $(AVG_PATH_TEST_OBJS)
	$(FC) $(FFLAGS) -o $@ $(AVG_PATH_TEST_OBJS) $(LDLIBS)

id_tree_test.exe: $(ID_TREE_TEST_OBJS)
	$(FC) $(FFLAGS) -o $@ $(ID_TREE_TEST_OBJS) $(LDLIBS)

rationals.exe: $(RAT_OBJS)
	$(FC) $(FFLAGS) -o $@ $(RAT_OBJS) $(LDLIBS)

stats.exe: $(STATS_OBJS)
	$(FC) $(FFLAGS) -o $@ $(STATS_OBJS) $(LDLIBS)

%.o: %.f90
	$(FC) $(FFLAGS) $(FPPFLAGS) -c $<

clean:
	$(RM) $(wildcard *.mod) $(wildcard *.o) $(APPS)
