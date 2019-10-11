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


## Hands-on session 1: control flow statements, data types, functions

1. Write a Fortran program that writes the vaule of the factorial function to the
   screen for the number 0 through 10.  The factorial of *n* is defined as
   *n*! = 1\*2\*3\*...\*(n - 1)\*n.

1. Write a Fortan program that checks whether the numbers 1 though 40 are prime
   numbers, writing the result of each test to the screen.  A number is prime when
   it can only be divided by 1 and itself, and 1 is not prime.

1. Write a Fortran program that for all integers *n* between 1 and 20 and all integers
   *p* between 1 and 20 prints to screen the greatest common divisor of *n* and *p*.
   For instance, the greatest common divisor of 12 and 15 is 3.


## Hands-on session 2: Arrays and procedures

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

1. If you didn't already do so in the first hands-on, implement functions `factorial`
   and `is_prima` respectively,  with the obvious semantics.

1. Write a Fortran program that computes and prints the Finonacci numbers for 0
   through 20 to the screen.  The Finonacci number fib(*n*) for *n* is defined as
   fib(*n* - 1) + fib(*n* - 2), and fib(0) = 1, fib(1) = 1.

1. Write a procedure that modifies a 2D array passsed as an argument, and modifying
   it in-place.  The elments of the 2D array should be set to 0.0 if the element's
   absolute value is less than a given real number that is given as the second
   argument to the function.  Pay attention to the intent of the arguments.

1. Implement a non-recursive version of the program to compute and display the
   Finonacci numbers.

1. Write a Fortran program that factorizes the integers 1 through 50, and prints
   the factors for each number to the screen, e.g., for 12 the output would be
   2, 2 and 3 (since 2\*2\*3 = 12).


## Hands-on session 3: User-defined types, modules and object-oriented programming

1. Write a module that defines a user-defined type to represent descriptive
   statistics information.  It should have the fields `sum`, `sum2` and `n`
   representing the sum of the data, the sum of the squares of the data, and
   the number of data items respectively.  The module should also define
   a procudure that takes a variable of this type as an argument and computes
   the mean value, and another one that computes the standard deviation.

1. Write a module that defines a class to maintain statistics over a sliding
   window.  You can add as many data values to such an object, but it will
   compute descriptive statistics (mean, standard deviation and median) over
    a window of size you specify when the object is created.

1. Implement a linked list class using pointers that supports
   * appending an item to the list,
   * removing the last item from a list,
   * inserting an element in the list at a location specified by index,
   * remove an element in the list specified by its index,
   * checking whether a value occurs as an element in the list.

