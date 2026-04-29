Fortran is used a lot in the context of HPC. For many, it has a
reputation of being an old and ugly programming language. However,
modern Fortran is a far cry from Fortran 77 that its detractors have
in mind. Fortran 2003/2008 is a language that is well tailored
towards scientific computing. This training introduces the language
and its features.


## Learning outcomes

When you complete this training you will be able to

  * read and understand well-written Fortran code;
  * write small to medium Fortran programs in an idiomatic style;
  * use arrays, procedures, modules, and user-defined types effectively;
  * recognize some best practices and common pitfalls for Fortran programmers;
  * have a solid foundation for follow-up work in scientific and high-performance
    Fortran programming.


## Schedule

Total duration: 7 hours, split over two sessions.

### Session one

Total duration session 1: 3.5 hours

  | Subject                                     | Duration |
  |---------------------------------------------|----------|
  | introduction and motivation                 |  5 min.  |
  | basics: control flow statements, data types | 85 min.  |
  | hands-on session 1                          | 20 min.  |
  | coffee break                                | 10 min.  |
  | arrays and pointers                         | 30 min.  |
  | user defined types                          | 10 min.  |
  | procedures                                  | 30 min.  |
  | hands-on session 2                          | 20 min.  |

### Session two

Total duration, session 2: 3.5 hours

  | Subject                                                            | Duration |
  |--------------------------------------------------------------------|----------|
  | modules and object oriented programming                            | 70 min.  |
  | hands-on session 3                                                 | 20 min.  |
  | coffee break                                                       | 10 min.  |
  | file I/O                                                           | 50 min.  |
  | interacting with the environment                                   | 10 min.  |
  | hands-on session 4                                                 | 20 min.  |
  | discussion of more advanced topics (e.g., using BLAS/Lapack, HDF5) | 20 min.  |
  | wrap up                                                            | 10 min.  |


## Training materials

Slides are available in the
 [GitHub repository](https://github.com/gjbex/Fortran-for-programmers),
as well as example code and hands-on material. The exercises for the
[hands-on sessions are on the website](hands-on/README.md).


## Target audience

This training is for you if you already know how to program in another
language and want to learn modern Fortran for scientific applications.


## Prerequisites

You will need experience programming in another programming language.
This is not a training that starts from scratch.

If you plan to do Fortran programming in a Linux or HPC environment you should
be familiar with these as well.

More concretely, participants should already be comfortable with the following:

* variables, expressions, control flow, and writing functions or procedures in
  some other programming language;
* basic data structures such as arrays/lists and records/struct-like types;
* reading short programs and understanding how data flows through them;
* basic problem decomposition into helper functions, procedures, or modules;
* compiling or running programs from the command line at a basic level;
* working in a shell environment well enough to edit files, run commands, and
  inspect output.

You do not need prior experience with Fortran itself, modules, array syntax,
derived types, Fortran object-oriented programming, BLAS/LAPACK, or HDF5.
Those are part of the training itself.

### Quick self-assessment

If you can do most of the tasks below in some programming language, you are
likely ready for this training.

* write a function that computes the average of a list or array of numbers;
* loop over data and compute a derived result such as a sum, maximum, or count;
* use `if`/`else` or a `switch`-like construct to classify values into cases;
* split a program into a few helper functions or files;
* read data from a text file and print a simple summary;
* read a short program and explain what it does;
* compile or run a small program from the command line;
* make a small change to an existing program and run it again.

If several of these items still feel difficult, the training will probably move
too fast. In that case, it is better to first take a short introductory
programming course.

### Software and access requirements

For following along hands-on, you need
* laptop or desktop with internet access;
* a Fortran compiler, either
  * on a system set up so you can connect to an HPC system, an account on an HPC
    system (e.g., VSC, CECI, ...), compute credits if that is required to run
    jobs on the HPC system if you want to use an HPC system, or
  * on your own system.


## Level of the Material

For participants who already have programming experience in another language,
the material in this training is approximately

* Introductory: 45 %
* Intermediate: 40 %
* Advanced: 15 %

These percentages describe the level of the Fortran and scientific-computing
topics covered in the training, not the participants' general programming
background.


## Trainer(s)

  * Geert Jan Bex ([geertjan.bex@uhasselt.be](mailto:geertjan.bex@uhasselt.be))
