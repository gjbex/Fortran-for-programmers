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

1. Initialize two 2D arrays with double precision numbers from a uniform random
   distribution between 0 and 1.  The first array is 1000 by 2000, the second
   2000 by 3000.  Write two versions of this program
   * one that implements the dot-product of two matrices as three nested iterations, i.e.,
   `C(i, j) = A(i, 1)*B(1, j) + A(i, 2)*B(2, j) + ... + A(i, 2000)*B(2000, j)` for
   all `i` between 1 and 1000, and all `j` between 1 and 3000.
   * one that used Fortran's `dot` function.

   Compare the performance of these two programs.

1. Initialize three 2D 2000 by 3000 arrays with double precision numbers from a
   uniform random distribution between 0 and 1.  Write three applications to
   compute `D = 5.0*A*B + C/1.5 + 8.0`.
   * the first uses the given array expression,
   * the second uses `FORALL` (can you use this statement here?),
   * the third has explicit `DO` loops over the array indices.

   Compare the performance of these three programs.
