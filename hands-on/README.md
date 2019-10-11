# Hands-on

These are some exercises for you to try.

Fortran code can be writting using any text editor.  A Fortran file, e.g.,
`my_program.f90` can be compiled using
```bash
$ gfortran  -Wall  -g  -o my_program.exe  my_program.f90
```
If there are not compilation or linking errors, you can run the application as
```bash
$ ./my_program.exe
```

Note:
* on VSC infrastructure, load the `foss` module,
* on your Linux laptop, make sure you installed `gfortran` using `apt`, `yum` or
  whichever package manager is appropriate for your system.
* on your Windows laptop, you can likely use either Cygwin, or, on Windows 10,
  use the Linux Subsystem for Windows (LWS).


## Basics: control flow statements, data types, functions

1. Write a Fortran program that writes the vaule of the factorial function to the
   screen for the number 0 through 10.  The factorial of *n* is defined as
   *n*! = 1\*2\*3\*...\*(n - 1)\*n.

1. Write a Fortan program that checks whether the numbers 1 though 40 are prime
   numbers, writing the result of each test to the screen.  A number is prime when
   it can only be divided by 1 and itself, and 1 is not prime.

1. If you didn't already do so, implement the previous two programs defining a
   function `factorial` and `is_prima` respectively,  with the obvious semantics.

1. Write a Fortran program that computes and prints the Finonacci numbers for 0
   through 20 to the screen.  The Finonacci number fib(*n*) for *n* is defined as
   fib(*n* - 1) + fib(*n* - 2), and fib(0) = 1, fib(1) = 1.

1. Implement a non-recursive version of the program to compute and display the
   Finonacci numbers.


## Arrays



