FC = gfortran
FFLAGS = -O2 -g -Wall
LDFLAGS =
LDLIBS = -lm
CC = gcc
CFLAGS = -O2 -g -Wall

APPS = formatted_read_write_test.exe unformatted_read_write_test.exe \
       stream_read_write_test.exe read_test.exe write_stream_test.exe \
       read_stream_test.exe read_stream.exe inquire_test.exe \
       append_test.exe

all: $(APPS)

read_test.exe: read_test.c
	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS) $(LDLIBS)

read_stream.exe: read_stream.c
	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS) $(LDLIBS)

%.exe: %.o
	$(FC) $(FFLAGS) -o $@ $< $(LDFLAGS) $(LDLIBS)

%.o: %.f90
	$(FC) $(FFLAGS) -c -o $@ $<

clean:
	$(RM) $(wildcard *.o) $(wildcard *.mod) $(APPS) \
          text_file.txt bin_file.dat stream_file.dat array_file.dat \
          data.txt
